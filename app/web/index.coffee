Spine = require("spine")
NewsFeed = require("components/newsFeed/newsFeed")
Menu = require("components/menu/menu") 
require("lib/setup")
   
class App extends Spine.Controller

  elements:
    ".news-feed" : "newsFeed"
    ".menu" : "menu"
    ".app-highlight" : "appHighlight"
    ".kanban" : "kanban"
    ".kanban-wrapper" : "kanbanWrapper"
    
  events:
    "click .app" : "onAppClick"


  constructor: ->
    super 
    new NewsFeed(el: @newsFeed)
    new Menu(el: @menu)

    LazyLoad.js "#{window.src.path}/#{window.src.build}/launch-components.js", =>
      require("lib/setup")
      AppHighlight = require("components/appHighlight/appHighlight") 
      new AppHighlight(el: $(".app-highlight")  )
      
      
  onAppClick: ->
    @kanban.prepend '<div class="kanban-wrapper app-wrapper">
      <div class="row full-height">
        <div class="col-md-12 kan-col">
          <div class="header blue"><span class="triangle"></span><span class="large-title">Nombre del App</span></div>
          <div class="sub-header">
            <div class="sub-title">Todos los Clientes</div>
          </div>
        </div>
      </div>
    </div>'
    
    @kanban.scrollTop 100000;
    @kanban.animate({scrollTop:0}, 1000 );
    

     
  

  
module.exports = App   