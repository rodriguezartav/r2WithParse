RSpine = require("rspine")

class Menu extends RSpine.Controller

  elements:
    ".liveApps" : "liveApps"

  events:
    "click .liveAppIcon" : "onLiveAppIconClick"
    "click .social-icon" : "onSocialIconClick"

  constructor: ->
    super    

    @append require("components/menu/menu_layout")()
    @extra = $(".extra-menu")
    

    RSpine.bind "platform:app-current-changed" , @renderApps
    
    @el.click @clickDontHideExtra
    @extra.click @clickDontHideExtra
    $("body").click @clickHideExtra

    @renderApps()

  onLiveAppIconClick: (e) ->
    target = $(e.target)
    appPath = target.data "path"
    RSpine.trigger "platform:app-launch" , appPath

  renderApps: ->
    $(".liveApps").html require("components/menu/menu_liveApp")(appAndPositions: RSpine.liveAppPositionByPath)

  onSocialIconClick: (e) =>
    @el.find(".social-icon").removeClass "purple"
    target = $(e.target)
    target = target.parent() until target.hasClass "social-icon"
    
    type  = target.data("type")
    extraType = @extra.data("type")
    
    if @extra.hasClass "on"  then @extra.removeClass("on") else @extra.addClass ("on")
    @extra.addClass "on" if type != extraType
        
    @extra.removeClass(extraType)
    target.addClass("purple") if @extra.hasClass("on")
  
    @extra.data "type" , type
    @extra.addClass(type)

  clickDontHideExtra: (e) ->
    e.preventDefault()
    e.stopImmediatePropagation();

  clickHideExtra: =>
    @extra.removeClass("on")
    @el.find(".social-icon").removeClass "purple"
    

module.exports = Menu