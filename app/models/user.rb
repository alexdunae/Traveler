class User < ActiveRecord::Base
  include Clearance::User
  #include Clearance::User

  has_many :trips
  validates :name, presence: true
  validates :about, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
  validate :birth_date_cannot_be_in_the_future

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing-avatar.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def birth_date_cannot_be_in_the_future
    errors.add(:birth_date, "can't be in the future") if birth_date.presence? && birth_date > Date.today 
  end
end