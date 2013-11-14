RSpine = require("rspine")

AppMenu = require("components/appMenu/appMenu")

class HomeView extends RSpine.Controller
  className: "app-canvas home-view"

  elements:
    ".app-menu" : "appMenu"
    ".small-app-menu" : "smallAppMenu"

  constructor: ->
    super    
    @html require("app/webHome/layout_#{RSpine.app.layout}")()                               


    new AppMenu el: @appMenu
    new AppMenu el: @smallAppMenu

module.exports = HomeView