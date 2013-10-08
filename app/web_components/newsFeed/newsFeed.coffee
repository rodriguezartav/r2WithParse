RSpine = require("rspine")
$ = window.$ if !$
Session = require("models/session")
ChatterNews = require("models/chatterNews")


class NewsFeed extends RSpine.Controller

  elements:
    ".content" : "content"
    ".js_src_posts" : "jsSrcPosts"
    
  events:
    "click .post" : "onPostClick"
    "click .btn-close" : "onBtnCloseClick"
   
  constructor: ->
    super    
    @html require("components/newsFeed/newsFeed_layout")()

    base = new RSpine.Ajax.Base();
    request = base.ajaxQueue {} ,
      type: 'GET',
      url: RSpine.Model.salesforceHost + "/api?path=/services/data/v24.0/chatter/feeds/news/#{Session.first().userId}/feed-items"
    
    request.done (response) => 
      for item in response.items
        ChatterNews.create item
      @render()

  render: =>
    @jsSrcPosts.html require("components/newsFeed/newsFeed_item")(ChatterNews.all())
    @el.scrollTop(NewsFeed.lastScrollPosition) if NewsFeed.lastScrollPosition
    

  onPostClick: (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "post"
    
    id = target.data "id"
    item = ChatterNews.find id
    @showDetails(item)
  
  showDetails: (item) ->
    NewsFeed.lastScrollPosition = @el.scrollTop()
    @jsSrcPosts.html require("components/newsFeed/newsFeed_detail")(item)

  onBtnCloseClick: (e) =>
    e.preventDefault();
    e.stopImmediatePropagation();
    @render()
    

module.exports = NewsFeed