RSpine= require "rspine"

class LayoutManager extends RSpine.Controller

  elements:
    ".platform-canvas" : "pCanvas"

  #See variables in initApp

  constructor: ->
    super
    @html require("layout_#{RSpine.app.layout}")()
    
    RSpine.liveAppPaths = []
    RSpine.liveAppsByPath = {}
    RSpine.liveAppPositionByPath = {}
    
    RSpine.bind "platform:app-launch", @launchApp      
    RSpine.bind "platform:app-shutdown", @shutdownApp 
    RSpine.bind "platform:library-loaded-keyboard" , @registerKeys
    @launchApp("views/homeView/homeView")

    $(window).resize @calculatePositionIndex

  launchApp: (appPath) =>
    #return RSpine.scrollToApp( appPath ) if RSpine.liveAppsIndexByPath(path)
    # or RSpine.liveApps.length >= 1

    return @goToApp(appPath) if RSpine.liveAppsByPath[appPath]
    App = require(appPath)
    app = new App()

    RSpine.liveAppPaths.push appPath
    RSpine.liveAppsByPath[appPath] = app

    @pCanvas.append app.el
    app.el.data("path" , appPath  )

    @calculatePositionIndex()
    @goToApp(appPath)
    
    RSpine.trigger "platform:app-launch-complete"

  shutdownApp: ->

  goToApp: (path) ->
    RSpine.currentApp = RSpine.liveAppsByPath[path]
    RSpine.currentAppPath = path;
    @pCanvas.animate({scrollTop: RSpine.liveAppPositionByPath[path] }, 500 );
    RSpine.trigger "platform:app-current-changed"
    
  calculatePositionIndex: =>
    RSpine.liveAppPositionByPath = {}
    for appEl in @pCanvas.find(".app-canvas")
      path = $(appEl).data("path")
      RSpine.liveAppPositionByPath[path] = appEl.offsetTop
      
  registerKeys: =>
    Mousetrap.bind 'up', =>
      index = RSpine.liveAppPaths.indexOf RSpine.currentAppPath
      @launchApp( RSpine.liveAppPaths[ index - 1 ] ) if (index - 1) > -1

    Mousetrap.bind 'down', =>
      index = RSpine.liveAppPaths.indexOf RSpine.currentAppPath
      @launchApp(RSpine.liveAppPaths[ index + 1 ]) if (index + 1) < RSpine.liveAppPaths.length

    Mousetrap.bind 'h', =>
      @launchApp(RSpine.liveAppPaths[ 0 ])

module.exports = LayoutManager