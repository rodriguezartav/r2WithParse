RSpine = require("rspine")
$ = window.$ if !$
Session = require("models/session")
ChatterNews = require("models/chatterNews")


class NewsFeed extends RSpine.Controller

  elements:
    ".content" : "content"
    ".js_src_posts" : "jsSrcPosts"
   
  constructor: ->
    super    
    @html require("components/newsFeed/newsFeed_layout")(ChatterNews.all())

    base = new RSpine.Ajax.Base();
    request = base.ajaxQueue {} ,
      type: 'GET',
      url: RSpine.Model.salesforceHost + "/api?path=/services/data/v24.0/chatter/feeds/news/#{Session.first().userId}/feed-items"
    
    request.done (response) => 
      for item in response.items
        ChatterNews.create item
      @jsSrcPosts.html require("components/newsFeed/newsFeed_item")(ChatterNews.all())

module.exports = NewsFeed