RSpine = require("rspine")
$ = window.$ if !$

class AppMenu extends RSpine.Controller
  @className: ""

  events:
    "click .js-btn-app" : "onAppClick"

  constructor: ->
    super
    RSpine.bind "platform:apps_loaded" , =>
      @html require("components/appMenu/appMenu_layout")(apps: RSpine.appsMetadata)


  onAppClick: (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "js-btn-app"
    
    appPath = target.data "path"
    RSpine.trigger "platform:app-launch" , appPath

module.exports = AppMenu