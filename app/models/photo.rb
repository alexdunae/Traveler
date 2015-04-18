class Photo < ActiveRecord::Base
  belongs_to :trip
  has_many :comments, as: :commentable

  has_attached_file :image, styles: { :big => "1000x1000>", :thumb => "250", :marker => "64" }, :default_url => ":style/missing-image.jpg"
  validates :image, :attachment_presence => true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, presence: true
  validates :description, length: { maximum: 200, too_long: "%{count} characters is the maximum allowed" }

  geocoded_by :name
  after_validation :geocode, :if => :name_changed?
end