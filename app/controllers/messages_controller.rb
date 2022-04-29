# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_message, only: %i[show update destroy]

  # GET /messages
  def index
    @messages = room.messages.includes(:user).order(id: :desc).limit(30)

    render json: ActiveModelSerializers::SerializableResource.new(@messages, each_serializer: MessageSerializer).as_json
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    @message = room.messages.new(message_params)

    if @message.save
      render json: @message.as_json(include: %i[user room]), status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private

  def room
    @room ||= Room.find(params[:room_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = room.messages.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:user_id, :room_id, :message)
  end
end
