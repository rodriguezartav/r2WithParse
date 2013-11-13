RSpine = require('rspine')

class App extends RSpine.Model
  @configure "App","namespace", "name", "path", "index", "iconColor", "iconLabel", "label", "home"

  @extend RSpine.Model.Ajax
  @extend RSpine.Model.Ajax.Auto

  @url: "/apps?appPath=./app/apps"

  constructor: -> 
    super 

  @createBlankApp: ->
    number = Math.random() * 10000
    appname = "app" + number
    app= 
      namespace: "app"
      name: "app"
      iconColor: "blue"
      iconLabel: "iL"
      label: "app"
      isNewApp: true
 
    App.create app


module.exports = App