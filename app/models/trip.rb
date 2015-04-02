class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :places

  validates :name, presence: true
  validates :description, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
  validate :end_date_cannot_be_before_start_date

  def end_date_cannot_be_before_start_date
    errors.add(:end_date, "can't be before the start date") if end_date.presence? && start_date.presence? && end_date < start_date 
  end
end