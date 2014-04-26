# A simple realtime chat using Rails and Angularjs


## Requirement

* Thin/Puma servers or similar
* Chrome or Firefox or something else that support SSE natively. 


## Some tricks and pitfalls in ActionController::live

During the development, I noticed some common pitfalls in ActionController::live, I call them `坑` (pronounced as "/kng/")

* During development, you have to use either Thin or Puma as
  server. There might be others but I did not test. WEBrick shipped by
  default would not work because it's not threaded server.
* Make sure you have `config.allow_concurrency = true` in
  `environments/development.rb`. This will remove several Rails global
  locks that stops requests from being processed.
* It's quite interesting that alto ugh AngularJS is using existing
  jQuery library rather than using its own mocking library, it still
  requires manual settings for CSRF-Token.
  
I believe all the three issues will be fixed in Rails soon.
