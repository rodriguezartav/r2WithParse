RSpine = require("rspine")

class App extends RSpine.Model
  @configure "App" , "name","path" , "index", "iconColor" ,"iconLabel","label","home"
  
  constructor: ->
    super 

class Profile extends RSpine.Model
  @configure "Profile" , "name" , "appPaths", "dependencyPaths" ,"type"
  
  constructor: ->
    super 

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
    "click .btn-action-new" : "onNew"
    "click .card" : "onCardClick"
    "click .item-editable" : "onItemEditableClick"
    "change .item-editable" : "onitemEditableChange"
    "click .btn-remove-app" : "onRemoveApp"
    
  constructor: ->
    super    
    @html require("app/r2apps/r2apps_layout")()   
    Profile.bind "create", @renderProfiles
    Profile.bind "update", @save
 
    RSpine.bind "platform:library-loaded-dragdrop", @registerDragDrop
 
    $.get("/r2apps").done (response) =>

      for profile in response.profiles.parts
        Profile.create profile if profile.type == "app"

      console.log response.apps
      App.create app for app in response.apps
            
      @applist.html require("app/r2apps/r2apps_app")(App.all())
      @registerDragDrop()

  registerDragDrop: => 
    return false if @dragDropRegistered or !RSpine.libraries["DragDropFramework"]
    @dragDropRegistered == true

    $(".app-list>.app").dragdrop
      makeClone: true,
      sourceHide: false,
      dragClass: "whileDragging",
      parentContainer: $("body")
      canDrop: ($dst) ->
        return $dst.parents(".card").length == 1
      didDrop: ($src, $dst) =>
        id = $src.data "id"
        app = App.find id
        cardId = $dst.data "id"
        profile = Profile.find cardId
        profile.appPaths.push app.path
        profile.save()
        @updateCardView($dst, profile)
                       
  renderProfiles: =>
    @profileList.html require("app/r2apps/r2apps_profile")(Profile.all())    

  onNew: =>
    Profile.create name: "New Profile", appPaths: [], type: "app"

  onCardClick: (e) =>
    target = $(e.target)
    target = target.parent() until target.hasClass "card"
    id= target.data("id")
    profile = Profile.find(id)
    target.find(".card-for-edit").html require("app/r2apps/r2apps_profile_edit")(profile)
    target.toggleClass "editing"
    
  onItemEditableClick: (e) ->
    e.preventDefault()
    e.stopImmediatePropagation()

  onitemEditableChange: (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "item-editable"
    card = target.parents(".card")
    id= card.data("id")
    profile = Profile.find(id)
    profile[target.data("attr")] = target.val()
    profile.save()
    @updateCardView(card,profile)

  onRemoveApp: (e) ->
    target = $(e.target)
    card = target.parents(".card")
    
    path = target.data("path")
    profile = Profile.find target.data("profile")
    app = App.findByAttribute("path",path)
    index = profile.appPaths.indexOf path
    profile.appPaths.splice(index, 1);
    profile.save()
    @updateCardEdit(card,profile)
    @updateCardView(card,profile)

  updateCardEdit: (card,profile) ->
    card.find(".card-for-edit").html require("app/r2apps/r2apps_profile_edit")(profile)
      
  updateCardView: (card,profile) ->
    card.find(".card-for-view").html require("app/r2apps/r2apps_profile_view")(profile)

  save: =>
    json = Profile.toJson()
    console.log json
    request = $.ajax
      type: "post"
      contentType: "application/json"
      url: "/r2apps"
      data: json

    request.done =>
      console.log arguments

module.exports = R2Apps