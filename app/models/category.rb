#
# @author  Bala Subrahmanyam
#
# Category Model
class Category < ActiveRecord::Base
  has_many :products
  has_many :images, as: :parent, dependent: :destroy
  has_many :sub_categories, class_name: 'Category', foreign_key: 'parent_id'

  accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true
end
