RSpine = require("rspine")
$ = window.$ if !$
Session = require("models/session")
ChatterNews = require("models/chatterNews")


class NewsFeed extends RSpine.Controller
  @className: "news-feed"

  elements:
    ".content" : "content"
   
  constructor: ->
    super    


    base = new RSpine.Ajax.Base();
    request = base.ajaxQueue {} ,
      type: 'GET',
      url: RSpine.Model.salesforceHost + "/api?path=/services/data/v24.0/chatter/feeds/news/#{Session.first().userId}/feed-items"
    
    request.done (response) => 
      console.log response.items
      for item in response.items
        ChatterNews.create item
      console.log ChatterNews.all()
      @html require("components/newsFeed/newsFeed_item")(ChatterNews.all())


    $(".kan-col-wrapper > .content-body").mouseover (e) ->
      target = $(e.target)
      target = target.parent() until target.hasClass "content-body"
      
      wrapper= target.find(".content-body-wrapper")
      
      if wrapper.height() > target.height()
        $(".kanban").css "overflow","hidden" 
      
        $(".kan-col-wrapper > .content-body").one "mouseout" , ->
          $(".kanban").css "overflow","scroll"

  
module.exports = NewsFeed