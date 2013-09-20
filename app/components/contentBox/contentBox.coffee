Spine = require("spine")
$ = window.$ if !$

class ContentBox extends Spine.Controller
  @className: "contentBox"

  elements:
    ".content" : "content"

  getTemplatePath: (name) ->
    if !__dirname
      parts = module.id.split "/"
      parts.pop()
    __dirname = parts.join "/"
    require __dirname + "/" + name
    
  constructor: ->
    super
    @html @getTemplatePath("contentBox_layout")()
    contents = @generateItems(@tagSelectors,@sourceSelector)
    @render(contents)

  generateItems: (tagSelectors,sourceSelector) ->
    sourceElements = $(sourceSelector).find(tagSelectors)
    contents = ""
    for element in sourceElements
      element = $(element)
      cls = if element[0].tagName == "H3" then "sub-" else ""
      contents += "<div class='#{cls}item'><span class='name'>#{element.html()}</span></div>"
    contents

  render: (contents) ->
    $(".content").html contents
  
module.exports = ContentBox