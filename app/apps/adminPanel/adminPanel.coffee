RSpine = require "rspine"
Profile = require("app/adminPanel/profile")
App = require("app/adminPanel/app")
AppPermission = require("app/adminPanel/appPermission")
EditApp = require("app/adminPanel/adminPanel_edit_app")

class AdminPanel extends RSpine.Controller
  className: "app-canvas adminPanel" 

  elements:
    ".profile-list" : "profileList"
    ".app-list" : "appList"
    ".app-permission-list" : "appPermissionList"

  events:
    "click .app-item" : "onEditApp"
    "click .add-profile" : "onAddProfile"
    "click .btn-save-profiles" : "onSaveProfiles"

  constructor: ->
    super
    @render()
    @bind()
    Profile.query()
    App.fetch()
    console.log "TODO BEFORE LAUNCH"
    AppPermission.url= "/appPermissions?pathToFile=./config/apps.json"
    
    RSpine.one "platform:library-loaded-bootstrap", =>
      @profileList.find(".btn-add-profile").popover()

  bind: ->
    Profile.bind "refresh", @renderProfiles
    App.bind "refresh", @renderApps
    AppPermission.bind "refresh create", @renderPermissions

  unbind: ->
    Profile.unbind "refresh", @renderProfiles
    Profile.unbind "refresh", @renderApps    
    AppPermission.unbind "refresh create", @renderPermissions

  render: ->
    @html require("app/adminPanel/layout")()

  renderApps: =>
    list = require("app/adminPanel/layout_item_app")(App.all())
    @appList.html list
    AppPermission.fetch()

  renderProfiles: =>
    list = require("app/adminPanel/layout_item_profile")(Profile.all())
    @profileList.html list
    @profileList.find(".btn-add-profile").popover?()

  renderPermissions: =>
    list = require("app/adminPanel/layout_item_app_permission")(AppPermission.all())
    @appPermissionList.html list

  onAddProfile: (e) ->
    target = $(e.target)
    device = target.html().toLowerCase()
    profileId = target.data "profile"
    profile = Profile.find profileId
    $(".btn-add-profile").popover("hide")
    ap = AppPermission.create type: "app", name: profile.Name, device: device, appPaths: []

  onEditApp:  (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "app-item"
    app = App.find target.data "app"
    RSpine.trigger "modal:show", EditApp , { title: app.name, data: app }

  onSaveProfiles: (e) ->
    AppPermission.custom( AppPermission.toJSON() , { method: "POST" })

  shutdown: (e) =>
    @release()
    @unbind()
    

module.exports = AdminPanel   