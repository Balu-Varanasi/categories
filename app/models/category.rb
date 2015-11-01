#
# @author  Bala Subrahmanyam
#
# Category Model
class Category < ActiveRecord::Base
  belongs_to :parent, class_name: 'Category'

  has_many :products
  has_many :images, as: :parent, dependent: :destroy
  has_many :sub_categories, class_name: 'Category', foreign_key: 'parent_id'

  accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :name
end
