RSpine = require("rspine")
$ = window.$ if !$

class Menu extends RSpine.Controller
  @className: "menu"

  elements:
    ".content" : "content"
   
  constructor: ->
    super    
    @html require("components/menu/menu_layout")()


  
module.exports = Menu