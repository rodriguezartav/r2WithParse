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
    app.save()

    App.one "ajaxSuccess", ->      
      RSpine.trigger "modal:hide"

    App.one "ajaxError", ->
      console.log JSON.stringify(arguments)
    
  create: (app)  ->
    
  delete: (e) ->

module.exports = AdminPanelEditApp