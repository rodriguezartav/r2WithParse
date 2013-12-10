RSpine = require("rspine")
require("lib/setup")
Session = require("models/session")
Demo = require("models/demo")
      
class App extends RSpine.Controller

  constructor: ->
    super
    RSpine.app = @
    modalFramework = new require("library/modalFramework/modalFramework")

    $.ajaxSetup
      beforeSend: (xhr) =>
        xhr.setRequestHeader( 'X-Parse-Application-Id' , 'ZvhMsT4JTbYVTYkXsTtAdlKvdIiEB5JSsB20nTAA' );
        xhr.setRequestHeader( 'X-Parse-REST-API-Key' , 'MiiFXlrAXM3hTSyISSc1eRXcO9tgO9MzHobvK5H1' );


    RSpine.jsPath = "#{@path}/#{@orgId}"

    for check in $(".responsiveCheck")
      check = $(check)
      if check.css("display") != "none" then RSpine.device = check.data "device"
      $(".responsiveCheckWrapper").remove()
    
    @loadFile( "/initApp_#{RSpine.device}.js" )

  loadFile: (url, retry) ->
    $.getScript( url )
      .done ( script, textStatus ) ->
        InitApp = require("initApp")
        initApp = new InitApp(el: $(".appWrapper"))
        RSpine.trigger "platform:initApp_loaded"

  RSpine.getImage= (url) ->
    return RSpine.Model.salesforceHost + "/photo?url=" + url

  RSpine.getCookie= (cookie) ->
    parts = document.cookie.split(name + "=");
    if (parts.length == 2) then return parts.pop().split(";").shift();

  RSpine.getQueryParams= (qs) ->
    tokens = null
    re = /[?&]?([^=]+)=([^&]*)/g;
    params = {}
    qs = qs.split("+").join(" ");
    params[decodeURIComponent(tokens[1])] = decodeURIComponent(tokens[2]) while tokens = re.exec(qs)
    return params;

module.exports = App