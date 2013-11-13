RSpine = require "rspine"
App = require("app/adminPanel/app")
 
class AdminPanelEditApp extends RSpine.Controller
  className: "adminPanelEditApp" 

  events:
    "submit .app-detail-form" : "save"

  constructor: ->
    super
    AdminPanelEditApp.c = 1
    @render()

  bind: ->

  unbind: ->

  render: ->
    @html require("app/adminPanel/layout_edit_app")(@data)

  save: (e) ->
    e.preventDefault()
    target = $(e.target)
    app = App.exists( target.data("app") )
    
    return @create(App.createBlankApp().fromForm(target)) if !app
    @update(app.fromForm(target))

  update: (app) ->   
    app.save done: (data) ->
      console.log "hiding"
      RSpine.trigger "modal:hide"

    
  create: (app)  ->
    app.save 

      done: (data) ->
        console.log "hiding"
        RSpine.trigger "modal:hide"

      fail: (data) =>
        app.delete()
    
    
    
    
  delete: (e) ->

module.exports = AdminPanelEditApp