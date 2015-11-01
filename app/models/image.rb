#
# @author  Bala Subrahmanyam
#
# Image Model
class Image < ActiveRecord::Base
  belongs_to :parent, polymorphic: true

  has_attached_file :image,
                    styles: { small: '150x150>' },
                    url: '/uploads/images/:id/:style/:basename.:extension',
                    path: ':rails_root/public/uploads/images/:id/:style/:basename.:extension'

  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png']
end
