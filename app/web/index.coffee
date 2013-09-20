Spine = require("spine")
HeaderLink = require("headerLink")
require("lib/setup")
 
class App extends Spine.Controller

  elements:
    ".news-feed" : "newsFeed"

  constructor: ->
    super 

    LazyLoad.js "#{window.src.path}/#{window.src.build}/contentBox.js", =>
      require("lib/setup")
      ContentBox = require("components/contentBox/contentBox")
      NewsFeed = require("components/newsFeed/newsFeed")
      new ContentBox( el: $("aside") , tagSelectors: "h2,h3" , sourceSelector: "article")
      new NewsFeed(el: @newsFeed)
  

  
module.exports = App   