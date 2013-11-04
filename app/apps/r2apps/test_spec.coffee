jQuery  = require("jqueryify")
require("rspine")
exports = @;

describe 'R2Apps', ->
  
  before ->
     
    #SETUP MOCKS FOR SERVER INTERACTION
    @server = sinon.fakeServer.create()
    get = 
      profiles: [
        { "name":"vendedores", "appPaths": ["./app/apps/r2apps"], "type": "app", "id": "c-0" }
      ]
      apps: [
        {"namespace":"app","name":"r2apps","iconColor":"blue","iconLabel":"Ab","label":"App Builder","path": "app/r2apps/r2apps"}
      ]

    @server.respondWith("GET","/r2apps", [ 200, { "Content-Type": "application/json" }, JSON.stringify( get ) ]);

    @server.respondWith("POST","/r2apps", [200, { "Content-Type": "application/json" }, JSON.stringify( {result: "ok"} )]);

    @server.respondWith("PUT","/r2app", [200, { "Content-Type": "application/json" }, JSON.stringify( {result: "ok"} )]);

    @server.respondWith("POST","/r2app", [200, { "Content-Type": "application/json" }, JSON.stringify( {result: "ok"} )]);

    @server.respondWith("DEL","/r2app", [200, { "Content-Type": "application/json" }, JSON.stringify( {result: "ok"} )]);

    #INSTANTIATE APP
    @R2Apps = require("app/r2apps/r2apps")
    @r2app = new @R2Apps el: $(".test")

  after -> 
    #RESTORE SERVER MOCKS
    @server.restore()

  describe "R2Apps", ->
    
    it "should render App's Layout" , ->
      $(".test").find(".profile-list").length.should.equal 1
      $(".test").find(".app-list").length.should.equal 1

      @r2app.profileList.should.not.equal null
      @r2app.appList.should.not.equal null
      

    it "should load profile data", ->
      @server.respond()
      Profile = @R2Apps.Profile
      Profile.count().should.equal 1

    it "should load app data", ->
      @server.respond()
      App = @R2Apps.App
      App.count().should.equal 1

    it "should save profile configurations", ->
      callback = (response) ->
        response.result.should.equal "ok"
      @r2app.saveData(callback)
      @server.respond()

    it "should start App Section", ->
      $(".test").find(".app").length.should.equal 1

    it "should start Profile Section", ->
      $(".test").find(".profile").length.should.equal 1

  describe "Profiles" , ->
   
    it "should create a Profile", ->
      @r2app.profiles.onCreate()
      $(".test").find(".profile").length.should.equal 2

    it "should create a Profile with a click", ->
      $(".btn-action-new-profile").trigger("click")
      $(".test").find(".profile").length.should.equal 3

    it "should show details when clicked on Item", ->
      card = $(".card").filter(":first").trigger("click")
      @r2app.profiles.el.find(".editing").length.should.equal 1

    it "not turn card when click on editable item", ->
      card = $(".card>.item-editable").filter(":first").trigger("click")
      @r2app.profiles.el.find(".editing").length.should.equal 1

    it "should change profile name", ->
      target = @r2app.profiles.el.find("input")[0]
      target.value = "changedProfile"
      e = target: target
      @r2app.profiles.onEditableItemChange(e)
      @R2Apps.Profile.first().name.should.equal "changedProfile"

    it "should change profile name with input", ->
      target = @r2app.profiles.el.find("input").filter(":first")
      target.val "changedProfileAgain"
      target.trigger("change")
      @R2Apps.Profile.first().name.should.equal "changedProfileAgain"

    it "should add an App to Profile", ->     
      appEl = $($(".app")[0])
      card = $($(".profile")[0])
      @r2app.profiles.onAddApp( appEl, card )
      @R2Apps.Profile.first().appPaths.length.should.equal 2

    it "should remove an App from Profile", ->
      btn = $(".btn-remove-app-from-profile")[0]
      e = target: btn
      @r2app.profiles.onRemoveApp(e)      
      @R2Apps.Profile.first().appPaths.length.should.equal 1

    it "should remove an App from Profile with click", ->
      $(".btn-remove-app-from-profile").filter(":first").trigger("click")
      @R2Apps.Profile.first().appPaths.length.should.equal 0

    it "should delete profile", ->
      btn = $(".btn-delete-profile")[0]
      e = target: btn
      @r2app.profiles.onDelete(e)      
      @R2Apps.Profile.count().should.equal 2
      $(".test").find(".profile").length.should.equal 2

    it "should delete profile on click", ->
      $(".btn-delete-profile").filter(":last").trigger("click")
      $(".test").find(".profile").length.should.equal 1

  describe "Apps" , ->

    it "should create an App on click", ->
      $(".btn-action-new-app").filter(":first").trigger("click")
      $(".test").find(".app").length.should.equal 2
      @R2Apps.App.count().should.equal 2

    it "should show details when clicked on Item", ->
      $(".app").filter(":first").trigger("click")
      $(".app").length.should.equal 1
      $(".app-detail").length.should.equal 1

    it "should show info after item after detail", ->
      $(".app-detail").filter(":first").trigger("click")
      $(".app").length.should.equal 2
      $(".app-detail").length.should.equal 0

    it "should save changes to App", ->
      e = target: $(".app")[0]
      @r2app.apps.onListItemClick(e)
      $(".app-detail > input").val("An")
      $(".btn-action-save-app").filter(":first").trigger("click")
      @server.respond()
      @R2Apps.App.first().label.should.equal "An"

    it "should delete an App on click", ->
      e = target: $(".app")[0]
      @r2app.apps.onListItemClick(e)
      appId = $(e.target).data "app"
      appPath = @R2Apps.App.find(appId).path
      $(".btn-action-delete-app").filter(":first").trigger("click")
      @server.respond()
      $(".app").length.should.equal 1
      @R2Apps.App.count().should.equal 1
      for profile in @R2Apps.Profile.all()
        for path in profile.appPaths
          path.should.not.equal appPath
       

    it "should save changes to new App", ->
      appEl = $(".app")
      appId = appEl.data "app"
      e = target: appEl[0]
      @r2app.apps.onListItemClick(e)
      $(".app-detail > input").val("an3")
      $(".btn-action-save-app").filter(":first").trigger("click")

      @server.respond() 
      @R2Apps.App.find(appId).name.should.equal "an3"
      @R2Apps.App.find(appId).label.should.equal "an3"

  describe "App", ->

    it "should create an app" , ->
      App = @R2Apps.App
      App.createBlankApp()
      
      App.first().namespace.should.equal "app"
      
  describe "Profile", ->
    
    it "should remove App from Profile", ->
      Profile = @R2Apps.Profile
      profile1 = Profile.create appPaths: ["a/1","b/2","c/3"]
      profile2 = Profile.create appPaths: ["c/3","d/4","e/5"]
      Profile.removeAppFromProfiles("c/3")
      profile1.appPaths.length.should.equal 2
      profile2.appPaths.length.should.equal 2

    it "should return true for App Exists in Path", ->
      Profile = @R2Apps.Profile
      profile = Profile.create appPaths: ["a/1","b/2","c/3"]
      result = profile.appExistsInPaths("a/1")
      result.should.equal true
      
    it "should return proper JSON", ->
      Profile = @R2Apps.Profile
      profile = Profile.create appPaths: ["a/1","b/2","c/3"]
      JSON.parse(Profile.toJSON()) 
