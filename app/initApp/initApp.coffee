RSpine = require("rspine")     
require("lib/setup") 
Session = require("models/session")
User = require("models/user")
 
DataManager = require "dataManager"
      
class InitApp extends RSpine.Controller
  
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
    @html require("layout_#{RSpine.app.layout}")()                               

    new DataManager()

    User.fetch({id: Session.first().userId}, query: true);

    @requireComponents(@ignitionStage)  
    @initLaunchStage()

    User.bind "refresh" , =>
      user = User.first();


    LazyLoad.js "#{RSpine.jsPath}/apps_vendedores.js", =>
      RSpine.apps = moduleList
      RSpine.trigger "platform:apps_loaded"

  createAccount_click: (event) ->
    accountForm = event.target
    account = new Account(accountForm)

  initLaunchStage: ->  
    LazyLoad.js "#{RSpine.jsPath}/launch-components.js", =>
      require("lib/setup")
      @requireComponents(@launchStage)

  requireComponents: (stage) ->
    for component,element of stage
      Component = require("components/#{component}/#{component}") 
      new Component(el: $(element)  )


module.exports = InitApp   