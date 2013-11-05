RSpine = require("rspine")
    
class App extends RSpine.Model
  @configure "App","namespace", "name", "path", "index", "iconColor", "iconLabel", "label", "home", "isNewApp"
   
  constructor: -> 
    super 

  @createBlankApp: ->
    number = Math.random() * 10000
    appname = "app" + number
    app= 
      namespace: "app"
      name: "app"
      iconColor: "blue"
      iconLabel: "iL"
      label: "app"
      isNewApp: true
 
    App.create app

class Profile extends RSpine.Model
  @configure "Profile" , "name" , "appPaths", "dependencyPaths" ,"type"

  constructor: ->
    super

  @removeAppFromProfiles: (appPath) ->
    for profile in Profile.all()
      index = profile.appPaths.indexOf appPath
      profile.appPaths.splice(index, 1)
      profile.save()

  appExistsInPaths: (appPath) ->
    has = false
    for profile in Profile.all()
      for path in profile.appPaths
        has = true if path == appPath
    return true

  @toJSON: ->
    r2jsFile= 
      parts: Profile.all()
    json = JSON.stringify r2jsFile

###
***

# APPS SECTION

***
###

class Apps extends RSpine.Controller
  
  events:
    "click .app" : "onListItemClick"
    "submit .app-detail-form" : "onSave"
    "click .btn-action-delete-app" : "onDelete"
    "click .btn-action-close-app" : "onClose"

  constructor: ->
    super
    @bind()

  bind: ->
    App.bind "refresh" , @render
    
  shutdown: ->
    App.unbind "refresh" , @render

  render: =>
    @html require("app/r2apps/r2apps_app")(App.all())

  onCreate: (e) =>
    App.createBlankApp()
    @render()
 
  onListItemClick: (e) =>
    target = $(e.target)
    target = target.parent() until target.hasClass "app"
    appId = target.data "app"
    app = App.find appId
    detailHtml = require("app/r2apps/r2apps_appDetail")(app)
    target.replaceWith detailHtml 

  onClose: (e) =>
    @render()
  
  onSave: (e) =>
    e.preventDefault()
    target = $(e.target)
    app = App.find target.data "app"
    app.fromForm(target)

    request = $.ajax
      type: if app.isNewApp then "PUT" else "POST"
      contentType: "application/json"
      url: "/r2app"
      processData: false
      data: JSON.stringify app

    request.success =>
      app.isNewApp=false
      app.save()
      @render()

    request.error =>
      app.delete()
      @render()

  onDelete: (e) =>
    target = $(e.target)
    detailDiv = target.parents(".app-detail")
    app = App.find detailDiv.data "app"

    request = $.ajax
      type: "DEL"
      contentType: "application/text"
      url: "/r2app" #?path=#{app.path}"
      processData: false

    request.success =>
      Profile.removeAppFromProfiles(app.path)
      app.destroy()
      @render()
      @app.saveData()

    request.error (error) =>
      console.error "An error occured deleting Apps is probablt related to your FileSystem"
      console.error error
      @render()

###
***

# PROFILE SECTION

***
###

class Profiles extends RSpine.Controller

  events:
    "click .card" : "onListItemClick"
    "click .item-editable" : "onEditableItemClick"
    "change .item-editable" : "onEditableItemChange"
    "click .btn-remove-app-from-profile" : "onRemoveApp"
    "click .btn-delete-profile" : "onDelete"

  constructor: ->
    super
    @bind()

  bind: ->
    Profile.bind "refresh", @render
    App.bind "destroy", @render

  shutdown: ->
    Profile.unbind "refresh", @render
    App.unbind "destroy", @render
    
  render: =>
    @html require("app/r2apps/r2apps_profile")(Profile.all())

  renderCard: (card,profile,showEditView=false) ->
    newCard = require("app/r2apps/r2apps_profile")(profile)
    card.replaceWith newCard
    newCard.addClass "editing" if showEditView
    
  onCreate: =>
    Profile.create name: "New Profile", appPaths: [], type: "app"
    @render()
    
  onListItemClick: (e) =>
    card = $(e.target)
    card = card.parent() until card.hasClass "card"
    showEditView = if card.hasClass "editing" then false else true
    id= card.data("profile")
    profile = Profile.find(id)
    @renderCard(card,profile,showEditView)
    
  onEditableItemClick: (e) ->
    e.preventDefault()
    e.stopImmediatePropagation()
    
  onEditableItemChange: (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "item-editable"
    card = target.parents(".card")
    id= card.data("profile")
    profile = Profile.find(id)
    type = target.data("attr")
    value = target.val().trim()
    profile[type] = target.val()
    profile.save()
    
  onAddApp: (appEl, card) =>
    card = card.parent() until card.hasClass "card"
    appId = appEl.data "app"
    app = App.find appId
    profileId = card.data "profile"
    profile = Profile.find profileId
    profile.appPaths.push app.path
    profile.save()
    @renderCard(card,profile)

  onRemoveApp: (e) ->
    target = $(e.target)
    path = target.data("path")
    card = target.parents(".card")    
    profileId = card.data("profile")
    profile = Profile.find profileId
    app = App.findByAttribute("path",path)
    index = profile.appPaths.indexOf path
    profile.appPaths.splice(index, 1);
    profile.save()
    @renderCard(card,profile)
    
  onDelete: (e) ->
    target = $(e.target)
    card = target.parents(".card")
    profileId = card.data("profile")
    profile = Profile.find profileId
    profile.destroy()
    card.remove()

###
***

# R2APPS SECTION

***
###

class R2Apps extends RSpine.Controller
  className: "app-canvas r2apps" 

  elements:
    ".profile-list" : "profileList"
    ".app-list" : "appList"

  events: 
    "click .btn-action-new-profile" : "onCreateProfile"
    "click .btn-action-new-app" : "onCreateApp" 
    "click .btn_save_profiles" : "saveData"

  constructor: ->
    super    
    @dragdropRegistered = false
    @render()
    @apps = new Apps(el: @appList, app: @)
    @profiles = new Profiles(el: @profileList, app: @)
    @loadData()
    RSpine.bind "platform:library-loaded-dragdrop", @registerDragDrop

  render: ->
    @html require("app/r2apps/r2apps_layout")()  

    RSpine.one "platform-app-launch-complete" , ->
      RSpine.resizeColumns ".content-body", 170

  loadData: =>
    request = $.get("/r2apps")
    
    request.success (response) =>
      for profile in response.profiles
        Profile.create profile if profile.type == "app"
        
      for app in response.apps
        App.create(app) if !app.home

      App.trigger "refresh"
      Profile.trigger "refresh"
      @registerDragDrop()

    request.error (error) ->
      console.error "An error occured receiving data from your FileSystem. Please make sure the /r2apps.json file is valid and all Apps referenced exist on the FileSystem and Path"
      console.error error

  registerDragDrop: => 
    dragableElements = $(".app-list>.app>.drag-handle")
    if dragableElements.dragdrop and !@dragdropRegistered
      @dragdropRegistered = true
      $(dragableElements).dragdrop
        makeClone: true,
        sourceHide: false,
        dragClass: "whileDragging",
        parentContainer: $("body")
        canDrop: (destination) ->
          return destination.parents(".card").length == 1
        didDrop: (source, destination) =>
          @profiles.onAddApp( source, destination )

  onCreateProfile: ->
    @profiles.onCreate()

  onCreateApp: ->
    @apps.onCreate()

  saveData: (callback) =>
    request = $.ajax
      type: "post"
      contentType: "application/json"
      url: "/r2apps"
      data: JSON.stringify(Profile.all())

    request.success (result) =>
      callback?(result)

    request.error (error) =>
      console.error "An error ocurred saving data to your FileSystem it's propably a permission error."
      console.error error

  shutdown: ->
    @apps.shutdown()
    @profiles.shutdown()
    RSpine.unbind "platform:library-loaded-dragdrop", @registerDragDrop
    @apps.release()
    @profiles.release()
    @apps= null;
    @profiles=null;
    @release()

module.exports = R2Apps
R2Apps.App = App;
R2Apps.Profile = Profile;

