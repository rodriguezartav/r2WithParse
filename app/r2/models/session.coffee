RSpine = require('rspine')

class Session extends RSpine.Model
  @configure "Session" , "provider" , "user", "variables" ,"userId" , "orgId"

  @createFromQuery: (sourceData) ->
    Session.destroyAll()
    session = Session.create JSON.parse sourceData.session
    parts =  session.user.id.split("/")

    session.userId = parts[parts.length - 1 ]
    session.orgId = parts[parts.length - 2 ]
    session.save()
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