if (!window.EventSource) {
    alert('Your browser does not support SSE');
}

var source;

function connect() {
    source = new EventSource('/realtime/stream');
}

connect();

source.addEventListener('message', function (e) {
    /*
    console.log("got event:");
    console.log(e);
     */

    var event = JSON.parse(e.data);
    var li = jQuery('<li />');
    li.html(event.message);
    li.prependTo(jQuery('#chats'));
}, false);

source.addEventListener('error', function (e) {
    if (e.readyState == EventSource.CLOSED) {
        connect();
    }
}, false);
