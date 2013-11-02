RSpine = require("rspine")

class AppManagerMobile extends RSpine.Controller
  className: "app-canvas"
  
  elements:
    ".profile-list" : "profileList"
    
  constructor: ->
    super    
    @html require("app/appManagerMobile/layout") 
    @profiles = []
    @loadData()
    @bind()
  
  loadData: =>
    request = $.get("/r2apps")

    request.success (response) =>
      @profiles = response.profiles
      @render()
      
    request.error (error) =>
      @profiles.html "<li class='alert alert-danger'>This app only works while running on localhost</li>"
      console.error "An error occured receiving data from your FileSystem. Please make sure the /r2apps.json file is valid and all Apps referenced exist on the FileSystem and Path"
      console.error error

  render: ->
    @profileList.html require("app/appManagerMobile/item")(@profiles) 

  bind: ->
  
  shutdown: ->
    @release()

module.exports = AppManagerMobile