Spine = require("spine")
$ = window.$ if !$

class Name extends Spine.Controller
  @className: ""

   
  constructor: ->
    super    
    @html require("components/name/name_layout")()

module.exports = Name