RSpine= require "rspine"
 
class LoadMananger

  launchStage:  
    desktop:
      "appMetrics": ".app-metrics" 
      "menu": ".menu"    
      "newsFeed" : [".news-feed",".small-news-feed"]

  orbitStage:
    mobile:
      "mobileMenu" : ".mobile-menu"

  constructor: ->
    @requireApps()
    @requireLibs()
    #if User.count() > 0 then @initIgnitionStage() else User.one("refresh" , @initIgnitionStage)
    RSpine.one "platform:ajax-idle", @initOrbitStage

  initIgnitionStage: =>
    $.getScript("/#{User.first().getProfile()}_#{RSpine.device}.js")
      .done ( script, textStatus ) => 
        @requireApps(moduleList)
        @requireLibs(moduleList)
        RSpine.trigger "platform:apps_loaded"
        @initLaunchStage()

  initLaunchStage: ->  
    $.getScript( "/launchStage_#{RSpine.device}.js" )
      .done ( script, textStatus ) =>
        @requireLibs(moduleList)
        @requireComponents( @launchStage[RSpine.device] )

  initOrbitStage: =>
    $.getScript( "/orbitStage_#{RSpine.device}.js" )
      .done ( script, textStatus ) =>
        @requireLibs(moduleList)
        @requireComponents( @orbitStage[RSpine.device] )

  requireLibs: =>
    for lib in moduleList
      if lib.namespace == "library"
        require(lib.path)

  requireApps: =>
    for app in moduleList   
      if app.namespace == "app"
        RSpine.appsMetadata.push app
        RSpine.appsByPath[app.path] = app
        RSpine.trigger("platform:app-launch", app.path) if app.home
      

  requireComponents: (stage) =>
    for component, elements of stage
      elements = [elements] if !RSpine.isArray(elements)
      for element in elements
        Component = require("components/#{component}/#{component}") 
        if typeof Component is "function"
          new Component(el: $(element)  )
        else
          console.log "Error launching component: #{component}/#{component}, there's likely a syntax or logical error on it's main file"

module.exports = LoadMananger