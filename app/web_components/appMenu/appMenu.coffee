RSpine = require("rspine")
$ = window.$ if !$

class AppMenu extends RSpine.Controller
  @className: ""

  events:
    "click .app" : "onAppClick"

  constructor: ->
    super
    RSpine.bind "platform:apps_loaded" , =>
      @html require("components/appMenu/appMenu_layout")(apps: RSpine.apps)


  onAppClick: (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "app"
    
    appPath = target.data "path"
    App = require(appPath)

    
    kanban = $(".kanban")
    app = new App()
    kanban.prepend app.el
    
    kanban.scrollTop 100000;
    kanban.animate({scrollTop:0}, 1000 );

module.exports = AppMenu