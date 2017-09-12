# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send(message)
    ActionCable.server.broadcast 'chat_rooms_channel', message: message['body']
  end
end
