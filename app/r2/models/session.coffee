RSpine = require('rspine')

class Session extends RSpine.Model
  @configure "Session" , "provider" , "user", "variables" 

  @createFromQuery: (sourceData) ->
    Session.destroyAll()
    session = Session.create JSON.parse sourceData
    RSpine.session = session
    
  constructor: ->
    super

  resetLastUpdate: ->
    @lastUpdate = {}
    @token = null;
    @lastLogin = null;
    @save()

  isExpired: =>
    return false if @lastLogin.less_than(110.minutes).ago
    return true

  

module.exports = Session