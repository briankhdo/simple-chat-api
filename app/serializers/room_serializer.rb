# frozen_string_literal: true

class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :users_count, :user_names, :last_message

  def user_names
    object.messages.to_a.map(&:user).uniq.map(&:name)
  end

  def last_message
    object.messages.last&.message
  end
end
