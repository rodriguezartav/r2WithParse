RSpine = require("rspine")

class LiveAppMenu extends RSpine.Controller

  elements:
    ".liveApps" : "liveApps"

  events:
    "click .liveAppIcon" : "onLiveAppIconClick"
    "click .social-icon" : "onSocialIconClick"

  constructor: ->
    super    

    @append require("components/liveAppMenu/liveAppMenu_layout")()

    #Extra Menu
    @extra = $(".extra-menu")

    RSpine.bind "platform:app-current-changed" , @renderApps
    
    @renderApps()

  onLiveAppIconClick: (e) ->
    target = $(e.target)
    appPath = target.data "path"
    RSpine.trigger "platform:app-launch" , appPath

  renderApps: ->
    $(".liveApps").html require("components/liveAppMenu/liveAppMenu_liveApp")(appAndPositions: RSpine.liveAppPositionByPath)

  onSocialIconClick: (e) =>
    @el.find(".social-icon").removeClass "red"
    target = $(e.target)
    target = target.parent() until target.hasClass "social-icon"
    type  = target.data("type")
    extraType = @extra.data("type")
    
    if @extra.hasClass "on"  then @extra.removeClass("on") else @extra.addClass ("on")
    @extra.addClass "on" if type != extraType
        
    @extra.removeClass(extraType)
    target.addClass("red") if @extra.hasClass("on")
  
    @extra.data "type" , type
    @extra.addClass(type)

module.exports = LiveAppMenu