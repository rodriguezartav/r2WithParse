RSpine= require "rspine"
 
class LoadMananger
 
  ignitionStage:
    "newsFeed"  :  [".news-feed", ".small-news-feed"]
    "appMenu": [".app-menu" , ".small-app-menu"]

  launchStage:
    "appMetrics": ".app-metrics"
    "breadcrum": ".breadcrum"
    "menu": ".menu"

  constructor: ->
    @requireApps()
    @requireComponents(@ignitionStage)  
    @initLaunchStage()
    RSpine.bind "platform:ajax-idle", @initOrbitStage

  initLaunchStage: ->  
    LazyLoad.js "#{RSpine.jsPath}launchStage.js", =>
      @requireComponents(@launchStage)

    LazyLoad.js "#{RSpine.jsPath}vendedores.js", =>
      @requireApps(moduleList)  
      RSpine.trigger "platform:apps_loaded"

  initOrbitStage: =>
    LazyLoad.js "#{RSpine.jsPath}orbitStage.js", =>
      for lib in moduleList
        require(lib.path)

  requireApps: =>
    for app in moduleList   
      if app.namespace == "app"
        console.log app
        RSpine.appsMetadata.push app
        RSpine.appsByPath[app.path] = app
        RSpine.trigger("platform:app-launch", app.path) if app.home

  requireComponents: (stage) =>
    for component, elements of stage
      elements = [elements] if !RSpine.isArray(elements)
      for element in elements
        Component = require("components/#{component}/#{component}") 
        new Component(el: $(element)  )

module.exports = LoadMananger