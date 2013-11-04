RSpine= require "rspine"

class DesktopManager extends RSpine.Controller

  elements:
    ".platform-canvas" : "pCanvas"

  #See variables in initApp

  constructor: ->
    super
    @html require("layout_#{RSpine.device}")()
    
    RSpine.liveAppPaths = []
    RSpine.liveAppsByPath = {}
    RSpine.liveAppPositionByPath = {}
    
    RSpine.bind "platform:app-launch", @launchApp      
    RSpine.bind "platform:app-shutdown", @shutdownApp 
    RSpine.bind "platform:library-loaded-keyboard" , @registerKeys
    RSpine.bind "platform:library-loaded-touch" , @registerTouch
    RSpine.bind "platform-app-launch-complete" , @resizeApps
  
    @registerSize()
  
  launchApp: (appPath) =>
    return @goToApp(appPath) if RSpine.liveAppsByPath[appPath]
    
    App = require(appPath)
    return console.log "Error launching App: #{appPath}, there's likely a syntax or logical error on it's main file" if typeof App isnt "function"
    app = new App()

    RSpine.liveAppPaths.push appPath
    RSpine.liveAppsByPath[appPath] = app

    appMetadata = RSpine.appsByPath[appPath]
    app.el.addClass appMetadata.name

    @pCanvas.append app.el
    app.el.data("path" , appPath  )

    @calculatePositionIndex()
    @goToApp(appPath)
    
    @largest = 0
    setTimeout =>
      height = app.el.height()
      contentBody = app.el.find(".content-body")
      adjustedHeight=  height - contentBody.offset().top
      contentBody.css "height" , adjustedHeight + "px"
    , 500
    
    RSpine.trigger "platform-app-launch-complete"
 
  goToApp: (path) ->
    RSpine.currentApp = RSpine.liveAppsByPath[path]
    RSpine.currentAppPath = path;
    @pCanvas.animate({scrollTop: RSpine.liveAppPositionByPath[path] }, 500 );
    RSpine.trigger "platform:app-current-changed"

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

  calculatePositionIndex: =>
    RSpine.liveAppPositionByPath = {}
    for appEl in @pCanvas.find(".app-canvas")
      path = $(appEl).data("path")
      RSpine.liveAppPositionByPath[path] = appEl.offsetTop
     
  moveUp: =>
    index = RSpine.liveAppPaths.indexOf RSpine.currentAppPath
    @launchApp( RSpine.liveAppPaths[ index - 1 ] ) if (index - 1) > -1

  moveDown: =>
    index = RSpine.liveAppPaths.indexOf RSpine.currentAppPath
    @launchApp(RSpine.liveAppPaths[ index + 1 ]) if (index + 1) < RSpine.liveAppPaths.length
    
  realignApp: =>
    index = RSpine.liveAppPaths.indexOf RSpine.currentAppPath
    @launchApp(RSpine.liveAppPaths[ index ]) 
    
  resizeApps: =>
    $(".app-canvas").css "height", ($(window).height() - 40)
    @calculatePositionIndex()
    @realignApp();
       
  registerSize: =>
    $(window).resize =>
      clearTimeout(@resizeTimer);
      @resizeTimer = setTimeout @resizeApps , 1500

  registerTouch: =>
    Hammer(@pCanvas).on "dragdown dragup", (ev) =>

      timeNow = new Date().getTime();
      if(timeNow - @lastMoveAnimation < 1000) 
        event.preventDefault();
        return;

      @lastMoveAnimation = timeNow;

      @moveDown() if ev.type == "dragup"
      @moveUp() if ev.type == "dragdown"

  registerKeys: =>
    Mousetrap.bind 'up', @moveUp

    Mousetrap.bind 'down', @moveDown

    Mousetrap.bind 'h', =>
      @launchApp(RSpine.liveAppPaths[ 0 ])

module.exports = DesktopManager