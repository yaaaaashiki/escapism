function formatToSlash(ctime){
const yearHyphen = 5;
const secondDigit = 13;

let date = ctime.slice(yearHyphen)
            .replace("-", "/")
            .replace("T", " ")
            .slice(0, -secondDigit);

return date
}

function escapeHTML(body){
return $('<span><span />').text(body).html();
};

App.chatrooms = App.cable.subscriptions.create(
{
    channel: "ChatRoomsChannel",
    room_id: $("#chatroom").data('room_id')
},
{
    connected: function() {
    },

    disconnected: function() {
    },

    received: function(message) {
    const createdAt = formatToSlash(message['object']['created_at']);

    $("div .hogehoge").append(escapeHTML(message['object']['name'] + ' '))
                        .append(escapeHTML(message['object']['role'] + ' '))
                        .append(escapeHTML(message['object']['body'] + ' '))
                        .append(escapeHTML(createdAt))
                        .append('<br />');
    },

    post: function(message) {
    return this.perform('post', {
        body: message
    });
    }
}
);

$(document).on('keypress', `[data-behavior~=chatroom_${$("#chatroom").data('room_id')}]`, function(event) {
if (event.keyCode === 13) {
    App.chatrooms.post(event.target.value);
    event.target.value = '';
    return event.preventDefault();
}
});
