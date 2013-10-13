RSpine = require("rspine")
$ = window.$ if !$

class AppMenu extends RSpine.Controller
  @className: ""

  events:
    "click .js-btn-app" : "onAppClick"

  constructor: ->
    super
    RSpine.bind "platform:apps_loaded" , =>
      columnsInMenu = if @el.attr("class").indexOf("small") == -1 then 4 else 6
      @html require("components/appMenu/appMenu_layout")(apps: RSpine.appsMetadata, columnsInMenu: columnsInMenu )


  onAppClick: (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "js-btn-app"
    
    appPath = target.data "path"
    RSpine.trigger "platform:app-launch" , appPath

module.exports = AppMenu