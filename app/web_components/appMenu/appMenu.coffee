RSpine = require("rspine")
$ = window.$ if !$

class AppMenu extends RSpine.Controller
  @className: ""

  events:
    "click .app" : "onAppClick"

  constructor: ->
    super
    RSpine.bind "platform:apps_loaded" , =>
      @html require("components/appMenu/appMenu_layout")(apps: RSpine.apps)


  onAppClick: ->
    kanban = $(".kanban")
    kanban.prepend '<div class="kanban-wrapper app-wrapper">
      <div class="row full-height">
        <div class="col-md-12 kan-col">
          <div class="header blue"><span class="triangle"></span><span class="large-title">Nombre del App</span></div>
          <div class="sub-header">
            <div class="sub-title">Todos los Clientes</div>
          </div>
        </div>
      </div>
    </div>'
    
    
    kanban.scrollTop 100000;
    kanban.animate({scrollTop:0}, 1000 );

module.exports = AppMenu