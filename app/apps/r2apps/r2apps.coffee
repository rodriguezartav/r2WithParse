RSpine = require("rspine")
   
class App extends RSpine.Model
  @configure "App","namespace", "name", "path", "index", "iconColor", "iconLabel", "label", "home", "isNewApp"
   
  constructor: ->
    super 
       
  @createBlankApp: ->
    app= 
      namespace: "app"
      name: "NewApp"
      iconColor: "blue"
      iconLabel: "iL"
      label: "New App"
      isNewApp: true

    App.create app
 
class Profile extends RSpine.Model
  @configure "Profile" , "name" , "appPaths", "dependencyPaths" ,"type"
  
  constructor: ->
    super 

  appExistsInPaths: (appPath) ->
    has = false
    for profile in Profile.all()
      for path in profile.appPaths
        has = true if path == appPath
    return true
      
  @toJson: ->
    r2jsFile= 
      parts: Profile.all()
    json = JSON.stringify r2jsFile

module.exports = Profile

class R2Apps extends RSpine.Controller
  className: "app-canvas r2apps" 
    
  elements:
    ".profile-list" : "profileList"
    ".app-list" : "applist"

  events:
    "click .btn_save_profiles" : "onSaveProfiles"
    "click .btn-action-new-profile" : "onNewProfile"
    "click .btn-action-new-app" : "onNewApp"
    "click .card" : "onCardClick"
    "click .item-editable" : "onItemEditableClick"
    "change .item-editable" : "onitemEditableChange"
    "change .validate-name" : "validateName"
    "click .btn-remove-app" : "onRemoveApp"
    "click .btn-delete-profile" : "onDeleteProfile"
    "click .app" : "onAppClick"
    "click .app-detail" : "onAppDetailClick"
    "click .btn-action-save-app" : "onSaveApp"
    
  constructor: ->
    super    
    @html require("app/r2apps/r2apps_layout")()   
    @dragdropRegistered = false
    Profile.bind "create", @renderProfiles
 
    RSpine.bind "platform:library-loaded-dragdrop", @registerDragDrop
 
    $.get("/r2apps").done (response) =>

      for profile in response.profiles.parts
        Profile.create profile if profile.type == "app"

      for app in response.apps
        App.create(app) if !app.home

      @renderApps()
      @registerDragDrop()

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
        didDrop: @onAddApp
                       
  renderProfiles: =>
    @profileList.html require("app/r2apps/r2apps_profile")(Profile.all())    
    
  renderApps: =>
    @applist.html require("app/r2apps/r2apps_app")(App.all())

  renderCard: (card,profile,showEditView=false) ->
    newCard = require("app/r2apps/r2apps_profile")(profile)
    card.replaceWith newCard
    newCard.addClass "editing" if showEditView

  onNewApp: (e) =>
    app = App.createBlankApp()
    @renderApps()

  onAppClick: (e) ->
    @applist.find(".list-item-detail").remove()
    target = $(e.target)
    target = target.parent() until target.hasClass "app"
    appId = target.data "app"
    app = App.find appId
    target.after require("app/r2apps/r2apps_appDetail")(app)
 
  onSaveApp: (e) =>
    target = $(e.target)
    detailDiv = target.parents(".app-detail")
    app = App.find detailDiv.data "app"
    for input in detailDiv.find("input") 
      input = $(input) 
      type = input.data("type")
      app[type] = input.val()

    request = $.ajax
      type: "PUT"
      contentType: "application/json"
      url: "/r2apps"
      processData: false
      data: JSON.stringify(app)

    request.success =>
      app.isNewApp=false
      app.save()
      @renderApps()
     
    request.error =>
      app.delete()
      @renderApps()

  onAppDetailClick: (e) ->
    target = $(e.target)
    return false if target.hasClass("item-editable")
    @renderApps()
 
  onNewProfile: =>
    Profile.create name: "New Profile", appPaths: [], type: "app"

  onCardClick: (e) =>
    card = $(e.target)
    card = card.parent() until card.hasClass "card"
    showEditView = if card.hasClass "editing" then false else true
    id= card.data("profile")
    profile = Profile.find(id)
    @renderCard(card,profile,showEditView)

  validateName: (e) =>
    target = $(e.target)
    nameExp = if target.hasClass("spaceable") then /[ a-zA-Z0-9_\-\.]+/ else /[a-zA-Z0-9_\-\.]+/
    newVal = nameExp.exec(target.val())
    target.val(newVal)

  onItemEditableClick: (e) ->
    e.preventDefault()
    e.stopImmediatePropagation()

  onitemEditableChange: (e) ->
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

  onDeleteProfile: (e) ->
    target = $(e.target)
    card = target.parents(".card")
    profileId = card.data("profile")
    profile = Profile.find profileId
    profile.destroy()
    card.remove()

  onSaveProfiles: =>
    json = Profile.toJson()
    request = $.ajax
      type: "post"
      contentType: "application/json"
      url: "/r2apps"
      data: json

    request.done =>
      console.log arguments

module.exports = R2Apps