class App < ApplicationRecord
  has_attached_file :avatar, styles: { thumb: "175x175>" }, default_url: "/images/:style/missing_avatar.png"
  has_attached_file :background, styles: { cover: "322x538>" }, default_url: "/images/:style/missing_background.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  scope :featured, -> { where({featured: true}).first }
  scope :not_featured, -> { where({featured: false})}
end
