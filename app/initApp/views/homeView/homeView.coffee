RSpine = require("rspine")

class HomeView extends RSpine.Controller
  className: "app-canvas home-view"

  constructor: ->
    super    
    @html require("views/homeView/layout_#{RSpine.app.layout}")()                               

module.exports = HomeView