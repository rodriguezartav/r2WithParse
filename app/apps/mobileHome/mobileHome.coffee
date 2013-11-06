RSpine = require("rspine")

AppMenu = require("components/appMenu/appMenu")

class HomeView extends RSpine.Controller
  className: "app-canvas home-view"

  elements:
    ".app-menu" : "appMenu"

  constructor: ->
    super    
    @html require("app/mobileHome/layout")()                               
    
    RSpine.one "platform-app-launch-complete" , ->
      RSpine.resizeColumns ".content-body", 106

    new AppMenu el: @appMenu
    

module.exports = HomeView