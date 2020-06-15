class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User

  def self.add_friend(user_id, friend_id, state)
    user_friendship = create(user_id: user_id, friend_id: friend_id, state: state)
    [user_friendship]
  end
end
