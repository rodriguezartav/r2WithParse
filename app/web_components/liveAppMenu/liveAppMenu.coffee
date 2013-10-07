RSpine = require("rspine")

class LiveAppMenu extends RSpine.Controller

  elements:
    ".liveApps" : "liveApps"

  events:
    "click .liveAppIcon" : "onLiveAppIconClick"

  constructor: ->
    super    

    @append require("components/liveAppMenu/liveAppMenu_layout")()

    RSpine.bind "platform:app-current-changed" , @renderApps
    
    @renderApps()

  onLiveAppIconClick: (e) ->
    target = $(e.target)
    appPath = target.data "path"
    RSpine.trigger "platform:app-launch" , appPath

  renderApps: ->
    $(".liveApps").html require("components/liveAppMenu/liveAppMenu_liveApp")(appAndPositions: RSpine.liveAppPositionByPath)

module.exports = LiveAppMenu