class Friendship < ActiveRecord::Base
  attr_accessible :user_id, :friend_id

  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :friend_id, :user_id, presence: true
  validates :friend_id, uniqueness: {scope: :user_id, message: "You are already following this user"}

end
