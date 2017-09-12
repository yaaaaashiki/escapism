# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatrooms_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def post(message)
    Message.create!(body: message['body'], user_id: current_user.id, labo_id: params[:room_id])
    ActionCable.server.broadcast "chatrooms_channel_#{params[:room_id]}", body: message['body']
  rescue ActiveRecord::RecordInvalid => e
    logger.error("Bad request: ChatRoomsChannel post action 11 lines: Cannot create message #{e.record.error}")
  end
end
