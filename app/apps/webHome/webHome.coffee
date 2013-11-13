RSpine = require("rspine")

NewsFeed = require("components/newsFeed/newsFeed")
AppMenu = require("components/appMenu/appMenu")

class HomeView extends RSpine.Controller
  className: "app-canvas home-view"

  elements:
    ".news-feed" : "newsFeed"
    ".small-news-feed" : "smallNewsFeed"
    ".app-menu" : "appMenu"
    ".small-app-menu" : "smallAppMenu"

  constructor: ->
    super    
    @html require("app/webHome/layout_#{RSpine.app.layout}")()                               
    
    new NewsFeed(el: @newsFeed)
    new NewsFeed(el: @smallNewsFeed)

    new AppMenu el: @appMenu
    new AppMenu el: @smallAppMenu

module.exports = HomeView