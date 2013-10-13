RSpine= require "rspine"
 
class LoadMananger
 
  ignitionStage:
    "newsFeed"  :  [".news-feed", ".small-news-feed"]
    "appMenu": [".app-menu" , ".small-app-menu"]

  launchStage:
    "appMetrics": ".app-metrics"
    "breadcrum": ".breadcrum"
    "liveAppMenu": ".menu"

  constructor: ->
    
    @requireComponents(@ignitionStage)  
    @initLaunchStage()
    RSpine.bind "platform:ajax-idle", @initOrbitStage

  initLaunchStage: ->  
    LazyLoad.js "#{RSpine.jsPath}/launch-components.js", =>
      @requireComponents(@launchStage)

    LazyLoad.js "#{RSpine.jsPath}/apps_vendedores.js", =>
      for app in moduleList   
        RSpine.appsMetadata.push app
        RSpine.appsByPath[app.path] = app  
      RSpine.trigger "platform:apps_loaded"

  initOrbitStage: =>
    LazyLoad.js "#{RSpine.jsPath}/orbit-components.js", =>
      for lib in moduleList
        require(lib.path)

  requireComponents: (stage) =>
    for component,elements of stage
      elements = [elements] if !RSpine.isArray(elements)
      for element in elements
        console.log element
        console.log $(element)
        Component = require("components/#{component}/#{component}") 
        new Component(el: $(element)  )

module.exports = LoadMananger