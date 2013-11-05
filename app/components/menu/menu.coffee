RSpine = require("rspine")

class Menu extends RSpine.Controller

  elements:
    ".liveApps" : "liveApps"

  events:
    "click .live-app-icon" : "onLiveAppIconClick"
    "click .social-icon" : "onSocialIconClick"

  constructor: ->
    super    

    @append require("components/menu/menu_layout")()
    @extra = $(".extra-menu")
    

    RSpine.bind "platform:app-shutdown-complete" , @renderApps
    RSpine.bind "platform:app-current-changed" , @renderApps
    
    @el.click @clickDontHideExtra
    @extra.click @clickDontHideExtra
    $("body").click @clickHideExtra

    @renderApps()

  destroyApp: (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "live-app-icon"
    appPath = target.data "path"
    
    RSpine.trigger "platform:app-shutdown" , appPath

  onLiveAppIconClick: (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "live-app-icon"
    appPath = target.data "path"
    
    if target.hasClass "active"
      @destroyApp(e)
    else
      RSpine.trigger "platform:app-launch" , appPath

  renderApps: ->
    $(".liveApps").html require("components/menu/menu_liveApp")(liveAppsByPath: RSpine.liveAppsByPath)

  onSocialIconClick: (e) =>
    @el.find(".social-icon").removeClass "active"
    target = $(e.target)
    target = target.parent() until target.hasClass "social-icon"
    
    type  = target.data("type")
    extraType = @extra.data("type")
    
    if @extra.hasClass "on"  then @extra.removeClass("on") else @extra.addClass ("on")
    @extra.addClass "on" if type != extraType
        
    @extra.removeClass(extraType)
    target.addClass("active") if @extra.hasClass("on")
  
    @extra.data "type" , type
    @extra.addClass(type)

  clickDontHideExtra: (e) ->
    e.preventDefault()
    e.stopImmediatePropagation();

  clickHideExtra: =>
    @extra.removeClass("on")
    @el.find(".social-icon").removeClass "purple"
    

module.exports = Menu