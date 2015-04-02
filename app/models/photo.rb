class Photo < ActiveRecord::Base
  belongs_to :place

  has_attached_file :photo_image, :styles => { :big => "1000x1000>", :thumb => "250" }
  validates_attachment_content_type :photo_image, :content_type => /\Aimage\/.*\Z/
end