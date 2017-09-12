App.chatrooms = App.cable.subscriptions.create("ChatRoomsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(message) {
    //alert(message['body']);
    // Called when there's incoming data on the websocket for this channel
  },

  post: function(message) {
    return this.perform('post', {
      body: message
    });
  }
});

$(document).on('keypress', '[data-behavior~=chatroom]', function(event) {
  if (event.keyCode === 13) {
    App.chatrooms.post(event.target.value);
    event.target.value = '';
    return event.preventDefault();
  }
});

