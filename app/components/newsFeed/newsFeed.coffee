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


    $(".kan-col-wrapper > .content-body").mouseover (e) ->
      target = $(e.target)
      target = target.parent() until target.hasClass "content-body"
      
      wrapper= target.find(".content-body-wrapper")
      
      if wrapper.height() > target.height()
        $(".kanban").css "overflow","hidden" 
      
        $(".kan-col-wrapper > .content-body").one "mouseout" , ->
          $(".kanban").css "overflow","scroll"

  
module.exports = NewsFeed