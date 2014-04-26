# A simple realtime chat using Rails and Angularjs


## Requirement

* Thin/Puma servers or similar
* Chrome or Firefox or something else that support SSE natively. 


## Some tricks and pitfalls in ActionController::live

During the development, I noticed some common pitfalls in ActionController::live, I call them `坑` (pronounced as "/kng/")

* During development, you have to use either Thin or Puma as
  server. There might be others but I did not test. WEBrick shipped by
  default would not work because it's not threaded server.
* Make sure you have `config.cache_classes = true` in
  `environments/development.rb`. However, with this option enabled,
  you have to manually restart your development server for nearly all
  code changes you made. It's quite painful. This is becuase when
  reload application's code, there would be some dead locks, which
  would block new requests from being served.
* It's quite interesting that although AngularJS is using existing
  jQuery library rather than using its own mocking library, it still
  requires manual settings for CSRF-Token.
  
I believe all the three issues will be fixed in Rails soon.
