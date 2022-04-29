class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, presence: true
  after_create :update_room_users_count

  def update_room_users_count
    room.update(users_count: room.messages.select(:user_id).distinct.count)
  end
end
