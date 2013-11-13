RSpine= require "rspine"
 
class LoadMananger

  launchStage:  
    desktop:
      "appMetrics": ".app-metrics" 
      "breadcrum": ".breadcrum"
      "menu": ".menu"    

  orbitStage:
    mobile:
      "mobileMenu" : ".mobile-menu"

  constructor: ->
    @requireApps()
    #@requireComponents( @ignitionStage[RSpine.device] )  
    @initLaunchStage()
    RSpine.bind "platform:ajax-idle", @initOrbitStage

  initLaunchStage: ->  
    LazyLoad.js "#{RSpine.jsPath}launchStage_#{RSpine.device}.js", =>
      @requireComponents( @launchStage[RSpine.device] )

    LazyLoad.js "#{RSpine.jsPath}vendedores_#{RSpine.device}.js", =>
      @requireApps(moduleList)  
      RSpine.trigger "platform:apps_loaded"

  initOrbitStage: =>
    LazyLoad.js "#{RSpine.jsPath}orbitStage_#{RSpine.device}.js", =>
      for lib in moduleList
        require(lib.path)
      @requireComponents( @orbitStage[RSpine.device] )

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