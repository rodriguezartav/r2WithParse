jQuery  = require("jqueryify")
require("rspine")
exports = @; 

describe 'adminPanel', ->
  
  before ->
    
    profiles = '{"records":[{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000NyeuIAC"},"Name":"Chatter Free User","Id":"00eA0000000NyeuIAC"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000NyftIAC"},"Name":"Chatter Moderator User","Id":"00eA0000000NyftIAC"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000ZFvgIAG"},"Name":"Ejecutivo Credito","Id":"00eA0000000ZFvgIAG"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000ZJ9uIAG"},"Name":"Contabilidad","Id":"00eA0000000ZJ9uIAG"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000ZJAYIA4"},"Name":"Ejecutivo Ventas","Id":"00eA0000000ZJAYIA4"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000ZKKEIA4"},"Name":"Presidencia","Id":"00eA0000000ZKKEIA4"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000ZKKJIA4"},"Name":"Vendedor","Id":"00eA0000000ZKKJIA4"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000atiwIAA"},"Name":"Integracion","Id":"00eA0000000atiwIAA"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000awZ5IAI"},"Name":"Tesoreria","Id":"00eA0000000awZ5IAI"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000awkiIAA"},"Name":"SubGerencia","Id":"00eA0000000awkiIAA"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000awm0IAA"},"Name":"Ejecutivo de Logistica","Id":"00eA0000000awm0IAA"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000azmRIAQ"},"Name":"Gerencia Comercial","Id":"00eA0000000azmRIAQ"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000b0MsIAI"},"Name":"Ejecutivo de Cuentas","Id":"00eA0000000b0MsIAI"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000b0xDIAQ"},"Name":"IT","Id":"00eA0000000b0xDIAQ"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000b1R2IAI"},"Name":"Coordinador","Id":"00eA0000000b1R2IAI"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000sYZHIA2"},"Name":"Platform System Admin","Id":"00eA0000000sYZHIA2"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000sYZLIA2"},"Name":"System Administrator","Id":"00eA0000000sYZLIA2"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000sYZMIA2"},"Name":"Standard User","Id":"00eA0000000sYZMIA2"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000sYZNIA2"},"Name":"Read Only","Id":"00eA0000000sYZNIA2"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000sYZOIA2"},"Name":"Solution Manager","Id":"00eA0000000sYZOIA2"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000sYZPIA2"},"Name":"Marketing User","Id":"00eA0000000sYZPIA2"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000sYZQIA2"},"Name":"Contract Manager","Id":"00eA0000000sYZQIA2"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000sYZRIA2"},"Name":"Guest License User","Id":"00eA0000000sYZRIA2"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000sYZSIA2"},"Name":"Force.com - Free User","Id":"00eA0000000sYZSIA2"},{"attributes":{"type":"Profile","url":"/services/data/v24.0/sobjects/Profile/00eA0000000yZBuIAM"},"Name":"Chatter External User","Id":"00eA0000000yZBuIAM"}]}';
    permisions = '[{"name": "vendedores","device": "desktop","appPaths": ["./app/apps/r2apps","./app/apps/pedidos","./app/apps/logistica","./app/apps/adminPanel"],"type": "app","id": "c-0"},{"name": "vendedores","device": "mobile","appPaths": ["./app/apps/appManagerMobile","./app/apps/pedidos"],"type": "app","id": "c-1"}]'
    apps = '[
      {
        "namespace": "app",
        "name": "webHome",
        "label": "home",
        "iconColor": "",
        "iconLabel": "Hm",
        "home": true,
        "path": "./app/apps/webHome"
      },
      {
        "namespace": "app",
        "name": "r2apps",
        "path": "./app/apps/r2apps",
        "iconColor": "purple",
        "iconLabel": "Pf",
        "label": "Admin",
        "isNewApp": false
      },
      {
        "namespace": "app",
        "name": "pedidos",
        "path": "./app/apps/pedidos",
        "iconColor": "red",
        "iconLabel": "Pe",
        "label": "Pedidos"
      },
      {
        "namespace": "app",
        "name": "mobileHome",
        "label": "home",
        "iconColor": "",
        "iconLabel": "Hm",
        "home": true,
        "path": "./app/apps/mobileHome"
      },
      {
        "namespace": "app",
        "name": "logistica",
        "label": "logistica app",
        "iconColor": "blue",
        "iconLabel": "Lg",
        "path": "./app/apps/logistica"
      },
      {
        "namespace": "app",
        "name": "appManagerMobile",
        "iconColor": "red",
        "iconLabel": "mM",
        "label": "Apps",
        "path": "./app/apps/appManagerMobile"
      },
      {
        "namespace": "app",
        "name": "adminPanel",
        "path": "./app/apps/adminPanel",
        "iconColor": "purple",
        "iconLabel": "Pf",
        "label": "Admin",
        "isNewApp": false
      }
    ]';

    appPermissionResponse = '{"test":"ok"}'
   
    #SETUP MOCKS FOR SERVER INTERACTION
    @server = sinon.fakeServer.create()
    @server.respondWith("GET", /sobjects/g , [ 200, { "Content-Type": "application/json" }, profiles ]);
    @server.respondWith("GET", /appPath/g , [ 200, { "Content-Type": "application/json" }, apps ]);
    @server.respondWith("GET", /appPermissions/g , [ 200, { "Content-Type": "application/json" }, permisions ]);
    @server.respondWith("POST", /appPermissions/g , [ 200, { "Content-Type": "application/json" }, appPermissionResponse ]);

    @server.respondWith("PUT", /apps/g , [ 200, { "Content-Type": "application/json" }, appPermissionResponse ]);

    #INSTANTIATE APP
    RSpine.libraries = {}
    require("rspine/lib/salesforceModel")
    require("rspine/lib/salesforceAjax")
    require("rspine/lib/ajax")
    require("library/bootstrapFramework/bootstrapFramework")
    require("library/modalFramework/modalFramework")
    RSpine.Model.salesforceHost = "";
    
    @AdminPanel = require("app/adminPanel/adminPanel")
    @Profile = require("app/adminPanel/profile")
    @App = require("app/adminPanel/app")
    @AppPermission = require("app/adminPanel/appPermission")

    @adminPanel = new @AdminPanel el: $(".test")

  after -> 
    #RESTORE SERVER MOCKS
    #@server.restore()

  describe "Constructor", ->
    
    it "should show the layout", ->
      $(".test").find(".content-body").should.not.equal null

    describe "should have retrieved profiles", () ->
      before (done) ->  
        @server.respond()
        setTimeout done, 500

      it "should have profiles" , () ->
        @Profile.count().should.be.above 0

      it "should have apps" , () ->
        @App.count().should.be.above 0      
          
      it "should have permisions" , ->
        @AppPermission.count().should.be.above 0

    describe "App", ->
      it "should show editing app module", ->
        $(".app-item").filter(":first").click()
        $(".adminPanelEditApp").html().should.not.equal null 
    
      it "should update app from FROM", ->
        $('input[data-type="iconLabel"]').val "TT"
        form = $(".app-detail-form")
        app = @App.find form.data "app"
        app = app.fromForm(form)
        app.iconLabel.should.equal "TT"

      it "should save app with changes", (done) ->
        $('input[data-type="iconLabel"]').val "TT"
        form = $(".app-detail-form")
        appId = form.data "app"
        
        @App.bind "customSuccess ajaxError ajaxSuccess", =>
          done()
        
        form.submit()

    describe "Profiles", ->
      it "should show Create App Permision PopUp", ->
        $(".btn-add-profile").click()
        $(".add-profile").length.should.be.above 0

      it "should add and render App Permision" , ->
        permisions = @AppPermission.count()
        btn = $(".add-profile")
        device = btn.html().toLowerCase()
        btn.click()
        @AppPermission.count().should.be.above permisions
        $(".app-permission-item > h5").html().should.equal device
        

      it "should save changes to profiles", (done) ->
        $(".btn-save-profiles").click()
        @AppPermission.bind "customSuccess", (data) ->
          done()
        @server.respond()
