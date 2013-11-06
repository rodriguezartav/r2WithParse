RSpine= require "rspine"

class DesktopManager extends RSpine.Controller

  elements:
    ".mobile-platform-canvas" : "pCanvas"

  #See variables in initApp

  constructor: ->
    super
    @html require("layout_#{RSpine.device}")()
    
    RSpine.liveAppPaths = []
    RSpine.liveAppsByPath = {}
    RSpine.liveAppPositionByPath = {}
    
    RSpine.bind "platform:app-launch", @launchApp      
    RSpine.bind "platform:app-shutdown", @shutdownApp 
    RSpine.bind "platform:library-loaded-touch" , @registerTouch
    
  launchApp: (appPath) =>
    app = RSpine.liveAppsByPath[appPath]
    
    if !app    
      App = require(appPath)
      return console.log "Error launching App: #{appPath}, there's likely a syntax or logical error on it's main file" if typeof App isnt "function"
      app = new App()

      RSpine.liveAppPaths.push appPath
      RSpine.liveAppsByPath[appPath] = app

      appMetadata = RSpine.appsByPath[appPath]
      app.el.addClass appMetadata.name
      app.el.data("path" , appPath  )

    RSpine.currentApp?.el.detach()
    @pCanvas.html app.el
    RSpine.currentApp = app
    RSpine.currentAppPath = appPath;
    
    RSpine.trigger "platform:app-current-changed"
    RSpine.trigger "platform-app-launch-complete"

  shutdownApp: (appPath) =>
    index = RSpine.liveAppPaths.indexOf appPath
    app = RSpine.liveAppsByPath[appPath]
    appMetadata = RSpine.appsByPath[appPath]
    nextAppIndex = if index < RSpine.liveAppsByPath - 1 then index + 1 else 0

    return false if appMetadata.home

    RSpine.liveAppPaths.splice(1,index)
    RSpine.liveAppsByPath[appPath] = null
    delete RSpine.liveAppsByPath[appPath]
    if app.shutdown then app.shutdown() else console.error appPath + " does not have Shutdown Function - Warning Memory Leak Anti-Pattern"

    @pCanvas.find(".#{appMetadata.name}").remove()
    @calculatePositionIndex()

    RSpine.trigger "platform:app-shutdown-complete"

  moveUp: =>
    index = RSpine.liveAppPaths.indexOf RSpine.currentAppPath
    @launchApp( RSpine.liveAppPaths[ index - 1 ] ) if (index - 1) > -1

  moveDown: =>
    index = RSpine.liveAppPaths.indexOf RSpine.currentAppPath
    @launchApp(RSpine.liveAppPaths[ index + 1 ]) if (index + 1) < RSpine.liveAppPaths.length
    

  registerTouch: =>
    Hammer(@pCanvas).on "dragdown dragup", (ev) =>

      timeNow = new Date().getTime();
      if(timeNow - @lastMoveAnimation < 1000) 
        event.preventDefault();
        return;

      @lastMoveAnimation = timeNow;

      @moveDown() if ev.type == "dragup"
      @moveUp() if ev.type == "dragdown"

module.exports = DesktopManager