class Photo < ActiveRecord::Base
  belongs_to :trip
  has_many :comments, as: :commentable

  has_attached_file :image, styles: { :big => "1000x1000>", :thumb => "250" }
  validates :image, :attachment_presence => true
  validates_attachment_content_type :photo_image, :content_type => /\Aimage\/.*\Z/
end