RSpine = require("rspine")     
require("lib/initSetup")

Session = require("models/session")
User = require("models/user")
DataManager = require "managers/dataManager"
LayoutManager = require "managers/layoutManager"
LoadManager = require "managers/loadManager"

class InitApp extends RSpine.Controller


  #Variables
  # appsMetadata: Metadata of all Apps
  # appsByPath: Dictionary of path with values of App Metadata
  # Live Apps Patgs: Array of Paths of instantiate Apps
  # LiveAppsByPath: Dictionary of Paths with values of instantiate Apps
  # liveAppPositionByPath: Dictionary of Paths with positions
  # 

  constructor: ->
    super
    homeViewMetaData = {path: "views/homeView/homeView",name: "Home View", iconColor:"blue", iconLabel:"Hm" }
    RSpine.appsMetadata = [ homeViewMetaData ];
    RSpine.appsByPath =  {}
    RSpine.appsByPath[homeViewMetaData.path] = homeViewMetaData
    
    RSpine.liveAppPaths = []
    RSpine.liveAppsByPath = {}
    RSpine.liveAppPositionByPath = {}

    new LayoutManager(el: @el)
    new LoadManager(el: @el)
    new DataManager()

module.exports = InitApp   

# Events:
#  platform:app-launch
#  platform:app-shutdown
#  platform:apps_loaded
#  platform-app-launch-complete   
#  platform:app-current-changed
#  platform:ajax-idle
#  platform:library-loaded-keyboard
