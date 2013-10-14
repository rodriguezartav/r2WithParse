RSpine = require("rspine")     
require("lib/setup") 
Session = require("models/session")

class App extends RSpine.Controller

  constructor: ->
    super
    RSpine.app = @
    queryString = RSpine.getQueryParams(document.location.search);
    window.location.href = "/login.html" if queryString["session"] == null || queryString["session"] == undefined

    RSpine.Model.salesforceHost = @apiServer + "/salesforce";
    session = Session.createFromQuery(queryString)
    RSpine.jsPath = "#{@path}/#{RSpine.session.orgId}/"

    RSpine.bind "platform:login_invalid" , ->
      window.location = "/login.html"

    LazyLoad.js "#{RSpine.jsPath}initApp.js", =>
      InitApp = require("initApp")
      initApp = new InitApp(el: ("body"))        
      RSpine.trigger "platform:initApp_loaded"

  RSpine.getImage= (url) ->
    return RSpine.Model.salesforceHost + "/photo?url=" + url

  RSpine.getQueryParams= (qs) ->
    tokens = null
    re = /[?&]?([^=]+)=([^&]*)/g;
    params = {}
    qs = qs.split("+").join(" ");
    params[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]) while tokens = re.exec(qs)
    return params;

module.exports = App