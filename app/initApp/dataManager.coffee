RSpine = require("rspine")
Session = require("models/session")
User = require("models/user")

Cliente = require("models/cliente")

class DataManager
    
  constructor: ->
    RSpine.datamanager = @
    
    User.bind "refresh" , =>
      session = Session.first()
      session.user = User.first();
      session.save()
      @initializeData()
  
  
  initializeData: ->
    Cliente.autoQuery=true;
    RSpine.Model.SalesforceModel.initialize()
  
  
module.exports = DataManager