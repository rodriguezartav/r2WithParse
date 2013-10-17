RSpine = require("rspine")
$ = window.$ if !$

User = require("models/user");

class Breadcrum extends RSpine.Controller
  @className: ""

   
  constructor: ->
    super    

    User.bind "refresh" , =>
      @html require("components/breadcrum/breadcrum_layout")(User.first())

module.exports = Breadcrum