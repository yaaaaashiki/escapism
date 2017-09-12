App.room = App.cable.subscriptions.create("ChatRoomsChannel", {
  connected: function() {
    //Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(message) {
    console.log("abc")
    return alert(message['body']);
  },

  send: function(message) {
    return this.perform('send',{
      body: message
    });
  }
});

$(document).on('keypress', '[data-behavior~=chat_rooms]', function(event) {
  if (event.keyCode === 13) {
    App.room.send(event.target.value);
    event.target.value = '';
    return event.preventDefault();
  }
});
