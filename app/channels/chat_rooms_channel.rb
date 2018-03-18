# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatrooms_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def post(message)
    if current_user.labo_student?  && !current_user.belongs_to_this_labo?(params[:room_id].to_i)
      flash[:alert] = "You cannot send message for another lab chat pages"
      return
    end
    new_message = Message.create!(body: message['body'], user_id: current_user.id, labo_id: params[:room_id])
    ActionCable.server.broadcast "chatrooms_channel_#{params[:room_id]}", object: create_message_hash(new_message)
  rescue ActiveRecord::RecordInvalid => e
    logger.error("Bad request: ChatRoomsChannel post action 11 lines: Cannot create message #{e.record.error}")
  end

  def create_message_hash(message)
    {
      name: current_user.username,
      role: current_user.get_role_name,
      body: message.body,
      created_at: message.created_at
    }
  end
end
