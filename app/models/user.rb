class User < ActiveRecord::Base
  include Clearance::User

  has_many :trips
  has_many :comments
  has_many :friendships
  #has_many :friends, through: :friendships
  #has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  #has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :name, presence: true
  validates :about, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
  validate :birth_date_cannot_be_in_the_future

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing-avatar.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def birth_date_cannot_be_in_the_future
    errors.add(:birth_date, "can't be in the future") if !birth_date.blank? && birth_date > Date.today 
  end

  def has_trips?
    return true if self.trips.count != 0 
  end

  def friends
    friends ||= Array.new

    friendships = Friendship.where('user_id = ? OR friend_id = ?', id, id)
    friendships.each do |friendship|
      friends << UserFriendship.new(self, friendship)     
    end

    friends
  end

  def has_friends?
    return true if self.friends.count != 0 
  end

  class UserFriendship
    attr_reader :friendship, :friend
    def initialize(user, friendship)
      @friendship = friendship

      if user.id == friendship.user_id
        @friend = User.find(friendship.friend_id)
      else
        @friend = User.find(friendship.user_id)
      end
    end
  end
end