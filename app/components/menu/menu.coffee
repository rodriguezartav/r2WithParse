Spine = require("spine")
$ = window.$ if !$

class Menu extends Spine.Controller
  @className: "menu"

  elements:
    ".content" : "content"
   
  constructor: ->
    super    
    @html require("components/menu/menu_layout")()


  
module.exports = Menu