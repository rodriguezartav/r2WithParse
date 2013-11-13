RSpine = require("rspine")

class MobileMenu extends RSpine.Controller
 
  elements:
    ".mobile-menu-icon" : "mobileMenuIcon"
 
  events:
    "click .live-app-icon" : "onLiveAppIconClick"

 
  constructor: ->
    super    
    RSpine.bind "platform-app-launch-complete" , @render
    RSpine.bind "platform:app-launch-complete" , @render

    @el.show()
    @render()

  render: =>
    @html require("components/mobileMenu/layout")()
    content = require("components/mobileMenu/liveApps")(liveAppsByPath: RSpine.liveAppsByPath)

    @mobileMenuIcon.popover(content: content)


  onLiveAppIconClick: (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "live-app-icon"
    appPath = target.data "path"

    if target.hasClass "active"
      @destroyApp(e)
    else
      RSpine.trigger "platform:app-launch" , appPath

module.exports = MobileMenu