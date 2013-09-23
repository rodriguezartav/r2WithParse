RSpine = require("rspine")
$ = window.$ if !$

class Name extends RSpine.Controller
  @className: ""

   
  constructor: ->
    super    
    @html require("components/name/name_layout")()

module.exports = Name