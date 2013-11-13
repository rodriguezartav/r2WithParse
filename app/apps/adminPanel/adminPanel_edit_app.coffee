RSpine = require "rspine"
App = require("app/adminPanel/app")
 
class AdminPanelEditApp extends RSpine.Controller
  className: "adminPanelEditApp" 

  events:
    "submit .app-detail-form" : "save"
    "click .btn-delete-app" : "delete"

  constructor: ->
    super
    @render()

  bind: ->

  unbind: ->

  render: ->
    @html require("app/adminPanel/layout_edit_app")(@data)

  save: (e) ->
    e.preventDefault()
    target = $(e.target)
    app = App.exists( target.data("app") )
    
    if !app then return @create( App.fromForm(target) )

    @update(app.fromForm(target))

  update: (app) ->  
    app.save done: (data) ->
      RSpine.trigger "modal:hide"

  create: (app)  ->
    app.path = App.appPath + "/" + app.name
    app.save 
      done: (data) ->
        RSpine.trigger "modal:hide"

      fail: (data) =>
        app.delete()

  delete: (e) ->
    target = $(e.target)
    app = App.exists( target.parents("form").data("app") )
    app.id = app.name
    app.destroy 
      done: ->
        RSpine.trigger "modal:hide"

module.exports = AdminPanelEditApp