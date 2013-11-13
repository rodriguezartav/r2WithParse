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
    
    #only load on launch once
    if !ChatterNews.launchQueryInvoked
      endpoint = "/services/data/v24.0/chatter/feeds/news/#{ Session.first().userId }/feed-items"
      ChatterNews.api({}, endpoint: endpoint)
      ChatterNews.launchQueryInvoked= true

    @bind()
  
  bind: ->
    ChatterNews.bind "apiSuccess", @onAjaxSuccess

  onAjaxSuccess: (response) =>
    ChatterNews.refresh response.items

    @render()

  render: =>
    @html require("components/newsFeed/newsFeed_item")(ChatterNews.all())
    @el.scrollTop(NewsFeed.lastScrollPosition) if NewsFeed.lastScrollPosition
    

  onPostClick: (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "post"
    
    id = target.data "id"
    item = ChatterNews.find id
    @showDetails(item)
  
  showDetails: (item) ->
    NewsFeed.lastScrollPosition = @el.scrollTop()
    @html require("components/newsFeed/newsFeed_detail")(item)

  onBtnCloseClick: (e) =>
    e.preventDefault();
    e.stopImmediatePropagation();
    @render()
    

module.exports = NewsFeed