Spine = require("spine")
$ = window.$ if !$

class NewsFeed extends Spine.Controller
  @className: "news-feed"

  elements:
    ".content" : "content"
   
  constructor: ->
    super
    @html require("components/newsFeed/newsFeed_layout")()
    @append require("components/newsFeed/newsFeed_layout")()
    @append require("components/newsFeed/newsFeed_layout")()
    @append require("components/newsFeed/newsFeed_layout")()


  
module.exports = NewsFeed