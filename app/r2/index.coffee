RSpine = require("rspine")     
require("lib/setup") 
Session = require("models/session")
User = require("models/user")
         
class App extends RSpine.Controller
  
  elements:   
    ".app-highlight" : "appHighlight"
    ".kanban" : "kanban"
    ".kanban-wrapper" : "kanbanWrapper"

  loginStage:
    "login" : ".login-wrapper"

  ignitionStage:
    "newsFeed"  :  ".news-feed" 
    "menu"      :  ".menu"
    
  launchStage:
    "appHighlight": ".app-highlight"  
    "appMenu": ".app-menu"  
    "appMetrics": ".app-metrics"  
    "breadcrum": ".breadcrum"  

  constructor: ->
    super
    @html require("layout_#{@layout}")()
    RSpine.Model.salesforceHost = @apiServer + "/salesforce";
    Session.createFromQuery(@session)

    RSpine.bind "platform:login_invalid" , ->
      #  window.location = "/login.html"

    User.fetch({}, query: true);

    @requireComponents(@ignitionStage)  
    @initLaunchStage()

  initLaunchStage: ->  
    LazyLoad.js "#{window.src.path}/#{window.src.build}/launch-components.js", =>
      require("lib/setup")
      @requireComponents(@launchStage)

  requireComponents: (stage) ->
    for component,element of stage
      Component = require("components/#{component}/#{component}") 
      new Component(el: $(element)  )


module.exports = App   