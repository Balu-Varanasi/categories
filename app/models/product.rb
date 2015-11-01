#
# @author  Bala Subrahmanyam
#
# Product Model
class Product < ActiveRecord::Base
  belongs_to :category
  has_many :images, as: :parent
end
