RSpine = require('rspine')
   
class Profile extends RSpine.Model
  @configure "Profile", "Name"
  
  @extend RSpine.Model.SalesforceModel
  @extend RSpine.Model.SalesforceAjax

  @standardObject= true;

  constructor: ->
    super

  @removeAppFromProfiles: (appPath) ->
    for profile in Profile.all()
      index = profile.appPaths.indexOf appPath
      profile.appPaths.splice(index, 1)
      profile.save()

  appExistsInPaths: (appPath) ->
    has = false
    for profile in Profile.all()
      for path in profile.appPaths
        has = true if path == appPath
    return true

module.exports = Profile