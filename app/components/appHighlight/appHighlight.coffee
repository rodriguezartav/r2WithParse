Spine = require("spine")
$ = window.$ if !$

class AppHighlight extends Spine.Controller
  @className: ""

  constructor: ->
    super    
    
    @html require("components/appHighlight/appHighlight_layout")()

module.exports = AppHighlight