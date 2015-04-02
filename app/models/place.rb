class Place < ActiveRecord::Base
  belongs_to :trip

  validates :name, :latitude, :longitud, presence: true
  validates :description, length: { maximum: 300, too_long: "%{count} characters is the maximum allowed" }
end
