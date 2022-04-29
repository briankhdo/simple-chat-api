# frozen_string_literal: true

class MessageSerializer < ActiveModel::Serializer
  attributes :id, :message

  belongs_to :user
  belongs_to :room
end
