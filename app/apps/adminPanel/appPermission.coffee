RSpine = require('rspine')

class AppPermission extends RSpine.Model
  @configure "AppPermission" , "name", "device" , "appPaths", "dependencyPaths" ,"type"

  @extend RSpine.Model.Ajax

  @url: "/appPermissions?pathToFile=./config/apps.json"

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

  @toJSON: ->
    arr = []
    for item in AppPermission.all()
      arr.push item
    res =  JSON.stringify arr
    res
    
module.exports = AppPermission

