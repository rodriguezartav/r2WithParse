spine = require("spine")
require("jquery.mockjax")
$ = Spine.$ if !$

$.mockjax({
  url: 'http://localhost:3001/test',
  contentType: 'text/json',
  proxy: '/mocks/test.json'
});


$.mockjax({
  url: 'http://localhost:3001/users',
  contentType: 'text/json',
  proxy: '/mocks/user.json'
});