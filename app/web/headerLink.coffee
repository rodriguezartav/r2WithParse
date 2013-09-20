Spine = require("spine")
$ = window.$ if !$

class HeaderLink
  
  constructor: (path,mainLinksString) ->
    matchedItem = @setCurrentHeaderLink(path,mainLinksString)
    @renderMainLink(matchedItem)

  setCurrentHeaderLink: (path,mainLinksString) ->
    mainLink = null
    mainLinks = $(mainLinksString)
    for item in mainLinks
      item = $(item)
      mainLink = item if path == item.attr("href")
    mainLink

  renderMainLink: (matchedItem) ->
    linkTag = matchedItem.parents(".mainLink")
    linkTag.addClass("active") if linkTag
    linkTag
  
module.exports = HeaderLink