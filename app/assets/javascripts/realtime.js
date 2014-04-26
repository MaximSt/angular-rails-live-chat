ChatApp = angular.module('ChatApp', []);

ChatApp.controller('ChatController', function ($scope) {
    $scope.messages = [];

    function start() {
        if (!window.EventSource) {
            alert('Your browser does not support SSE');
        }

        var source;

        function connect() {
            source = new EventSource('/realtime/stream');
        }

        connect();

        source.addEventListener('message', function (e) {
            var message = JSON.parse(e.data);
            $scope.$apply(function () {
                $scope.messages.unshift(message.message);
            });
        }, false);

        source.addEventListener('error', function (e) {
            if (e.readyState == EventSource.CLOSED) {
                connect();
            }
        }, false);
    }

    start();
});
