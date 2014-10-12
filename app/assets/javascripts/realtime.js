ChatApp = angular.module('ChatApp', []);

ChatApp.config(function ($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-TOKEN'] = $("meta[name=\"csrf-token\"]").attr("content");
});

ChatApp.controller('ChatController', function ($scope, $http) {
    $scope.messages = [];
    $scope.send = function () {
        var message = $scope.new_message;
        $http.post('/chats.js', {'message': message}).success(function() {});
        $scope.new_message = '';
    };

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
                $scope.messages.unshift(message);
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
