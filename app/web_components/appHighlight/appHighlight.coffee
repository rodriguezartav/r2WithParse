RSpine = require("rspine")
$ = window.$ if !$

class AppHighlight extends RSpine.Controller
  @className: ""

  constructor: ->
    super    
    
    @html require("components/appHighlight/appHighlight_layout")()

module.exports = AppHighlight