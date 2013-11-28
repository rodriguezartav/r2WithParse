RSpine = require("rspine")     
require("lib/setup") 
Session = require("models/session")
User = require("models/user")
      
class App extends RSpine.Controller

  RSpine.showLoginBox = ->
    RSpine.trigger "modal:show", require("library/modalFramework/htmlModal") , {template: "r2Views/loginBoxView"}
    
  constructor: ->
    super
    RSpine.app = @
    modalFramework = new require("library/modalFramework/modalFramework")
    
    queryString = RSpine.getQueryParams(document.location.search);
    return RSpine.showLoginBox() if queryString["session"] == null || queryString["session"] == undefined

    RSpine.Model.salesforceHost = @apiServer + "/salesforce";
    
    session = Session.createFromQuery(queryString)
    RSpine.jsPath = "#{@path}/#{RSpine.session.orgId}"

    RSpine.bind "platform:login_invalid" , ->
      RSpine.showLoginBox()
    
    for check in $(".responsiveCheck")
      check = $(check)
      if check.css("display") != "none" then RSpine.device = check.data "device"
      $(".responsiveCheckWrapper").remove()

    User.query({id: Session.first().userId});
    
    @loadFile( "#{RSpine.jsPath}/initApp_#{RSpine.device}.js")

  loadFile: (url, retry) ->
    $.getScript( url )

      .done ( script, textStatus ) ->
        InitApp = require("initApp")
        initApp = new InitApp(el: $(".appWrapper"))
        RSpine.trigger "platform:initApp_loaded"

      .fail ( jqxhr, settings, exception ) =>

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