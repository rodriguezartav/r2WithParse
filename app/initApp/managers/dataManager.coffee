RSpine = require("rspine")
Session = require("models/session")
User = require("models/user")

class DataManager

  constructor: ->
    RSpine.datamanager = @
    
    User.bind "refresh" , =>
      session = Session.first()
      session.user = User.first();
      session.save()
      @initializeData()

    $(document).bind "ajaxSend", ->
      DataManager.onAjax()
  
    $(document).bind "ajaxComplete", ->
      DataManager.onAjax()
  
  initializeData: ->
    RSpine.Model.SalesforceModel.initialize()
  
  @onAjax: ->
    window.clearTimeout(DataManager.ajaxIdleTimer)
    DataManager.ajaxIdleTimer = window.setTimeout DataManager.onAjaxIdle, 5000

  @onAjaxIdle: ->
    RSpine.trigger "platform:ajax-idle"
    console.log "DATA-MANAGER:36: Ajax on Idle"
  
module.exports = DataManager