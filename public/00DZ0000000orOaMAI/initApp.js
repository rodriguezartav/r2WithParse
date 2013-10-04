
(function(/*! Stitch !*/) {
  if (!this.require) {
    var modules = {}, cache = {}, require = function(name, root) {
      var path = expand(root, name), indexPath = expand(path, './index'), module, fn;
      module   = cache[path] || cache[indexPath]
      if (module) {
        return module.exports;
      } else if (fn = modules[path] || modules[path = indexPath]) {
        module = {id: path, exports: {}};
        try {
          cache[path] = module;
          fn(module.exports, function(name) {
            return require(name, dirname(path));
          }, module);
          return module.exports;
        } catch (err) {
          delete cache[path];
          throw err;
        }
      } else {
        throw 'module \'' + name + '\' not found';
      }
    }, expand = function(root, name) {
      var results = [], parts, part;
      if (/^\.\.?(\/|$)/.test(name)) {
        parts = [root, name].join('/').split('/');
      } else {
        parts = name.split('/');
      }
      for (var i = 0, length = parts.length; i < length; i++) {
        part = parts[i];
        if (part == '..') {
          results.pop();
        } else if (part != '.' && part != '') {
          results.push(part);
        }
      }
      return results.join('/');
    }, dirname = function(path) {
      return path.split('/').slice(0, -1).join('/');
    };
    this.require = function(name) {
      return require(name, '');
    }
    this.require.define = function(bundle) {
      for (var key in bundle)
        modules[key] = bundle[key];
    };
    this.require.modules = modules;
    this.require.cache   = cache;
  }
  return this.require.define;
}).call(this)({
  "dataManager": function(exports, require, module) {(function() {
  var Cliente, DataManager, RSpine, Session, User;

  RSpine = require("rspine");

  Session = require("models/session");

  User = require("models/user");

  Cliente = require("models/cliente");

  DataManager = (function() {
    function DataManager() {
      var _this = this;
      RSpine.datamanager = this;
      User.bind("refresh", function() {
        var session;
        session = Session.first();
        session.user = User.first();
        session.save();
        return _this.initializeData();
      });
    }

    DataManager.prototype.initializeData = function() {
      Cliente.autoQuery = true;
      return RSpine.Model.SalesforceModel.initialize();
    };

    return DataManager;

  })();

  module.exports = DataManager;

}).call(this);
}, "initApp": function(exports, require, module) {(function() {
  var DataManager, InitApp, RSpine, Session, User,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require("rspine");

  require("lib/setup");

  Session = require("models/session");

  User = require("models/user");

  DataManager = require("dataManager");

  InitApp = (function(_super) {
    __extends(InitApp, _super);

    InitApp.prototype.elements = {
      ".app-highlight": "appHighlight",
      ".kanban": "kanban",
      ".kanban-wrapper": "kanbanWrapper"
    };

    InitApp.prototype.loginStage = {
      "login": ".login-wrapper"
    };

    InitApp.prototype.ignitionStage = {
      "newsFeed": ".news-feed",
      "menu": ".menu"
    };

    InitApp.prototype.launchStage = {
      "appHighlight": ".app-highlight",
      "appMenu": ".app-menu",
      "appMetrics": ".app-metrics",
      "breadcrum": ".breadcrum"
    };

    function InitApp() {
      var _this = this;
      InitApp.__super__.constructor.apply(this, arguments);
      this.html(require("layout_" + RSpine.app.layout)());
      new DataManager();
      User.fetch({
        id: Session.first().userId
      }, {
        query: true
      });
      this.requireComponents(this.ignitionStage);
      this.initLaunchStage();
      User.bind("refresh", function() {
        var user;
        user = User.first();
        return LazyLoad.js("" + RSpine.jsPath + "/apps_vendedores.js", function() {
          RSpine.apps = moduleList;
          return RSpine.trigger("platform:apps_loaded");
        });
      });
    }

    InitApp.prototype.createAccount_click = function(event) {
      var account, accountForm;
      accountForm = event.target;
      return account = new Account(accountForm);
    };

    InitApp.prototype.initLaunchStage = function() {
      var _this = this;
      return LazyLoad.js("" + RSpine.jsPath + "/launch-components.js", function() {
        require("lib/setup");
        return _this.requireComponents(_this.launchStage);
      });
    };

    InitApp.prototype.requireComponents = function(stage) {
      var Component, component, element, _results;
      _results = [];
      for (component in stage) {
        element = stage[component];
        Component = require("components/" + component + "/" + component);
        _results.push(new Component({
          el: $(element)
        }));
      }
      return _results;
    };

    return InitApp;

  })(RSpine.Controller);

  module.exports = InitApp;

}).call(this);
}, "layout_web": function(exports, require, module) {var content = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<div class="outer-container full-height">\n  <div class="row full-height">\n    <div class="col-md-1 menu"></div>\n    <div class="col-md-11 kanban">\n      <div class="kanban-wrapper">\n        <div class="row breadcrum">\n        </div>\n\n        <div class="row full-height">\n          \n          <div class="col-md-4 kan-col-wrapper large social-ban kan-col">\n            <div class="header blue"><span class="triangle"></span><span class="large-title">!Buenos días Mari!</span></div>\n            <div class="sub-header">\n              <div class="sub-title">Que hay de nuevo?</div>\n            </div>\n            <div class="content-body scrollable">\n              <div class="news-feed content-body-wrapper"></div>\n            </div>\n          </div>\n          \n          \n          \n          \n          <div class="col-md-4 kan-col-wrapper app-ban kan-col">\n            <div class="header red"><span class="triangle"></span><span class="large-title">Apps mas usadas</span></div>\n            <div class="sub-header">\n              <div class="sub-title text-center">Home</div>\n            </div>\n            <div class="content-body">\n              <div class="inner-wrapper content-body-wrapper">\n                <div class="row app-highlight"></div>\n              </div>\n              \n              <div class="app-menu">\n              </div>\n              \n            </div>\n          </div>\n          \n          <div class="col-md-4 kan-col-wrapper large metric-ban kan-col">\n            <div class="header purple"><span class="triangle"></span><span class="large-title">Que paso con el cliente </span></div>\n            <div class="sub-header">\n              <div class="sub-title">Todos los Clientes</div>\n            </div>\n            <div class="content-body">\n              <div class="content-body-wrapper">\n    \n                <div class="app-metrics"></div>\n    \n              </div>\n            </div>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}, "lib/setup": function(exports, require, module) {(function() {


}).call(this);
}, "models/cliente": function(exports, require, module) {(function() {
  var Cliente, RSpine, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require('rspine');

  Cliente = (function(_super) {
    __extends(Cliente, _super);

    function Cliente() {
      this.filterByName = __bind(this.filterByName, this);
      _ref = Cliente.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Cliente.configure('Cliente', 'Name', 'CodigoExterno', "Activo", "Saldo", "DiasCredito", "CreditoAsignado", "Rating_Crediticio", "Negociacion", "LastModifiedDate", "Ruta", "Transporte", "Direccion", "Telefono", "RutaTransporte");

    Cliente.extend(RSpine.Model.SalesforceModel);

    Cliente.extend(RSpine.Model.Ajax);

    Cliente.querySinceLastUpdate = true;

    Cliente.avoidInsertList = ["Name", "Rating_Crediticio", "CodigoExterno", "Activo", "Saldo", "DiasCredito", "LastModifiedDate", "Meta", "Ventas", "PlazoRecompra", "PlazoPago"];

    Cliente.filters = {
      "": " Activo__c = true",
      "conSaldo": " Saldo__c != 0",
      "credito": " CreditoAsignado__c > 0 and DiasCredito__c > 0",
      "contado": " CreditoAsignado__c = 0 and DiasCredito__c = 0"
    };

    Cliente.to_name_array = function() {
      var cliente, clientes, names, _i, _len;
      clientes = Cliente.all();
      names = [];
      for (_i = 0, _len = clientes.length; _i < _len; _i++) {
        cliente = clientes[_i];
        names.push(cliente.Name);
      }
      return names;
    };

    Cliente.prototype.validate = function() {
      if (!this.Name) {
        return "El nombre del cliente es obligatorio";
      }
    };

    Cliente.prototype.willOverDraft = function(monto) {
      var od;
      od = false;
      if (monto + this.Saldo > this.CreditoAsignado) {
        od = true;
      }
      return od;
    };

    Cliente.prototype.filterByName = function(query, item) {
      var myRegExp, result;
      if (item.Activo === false) {
        return false;
      }
      if (item.DiasCredito > 0 && this.contado === true) {
        return false;
      }
      if (item.DiasCredito === 0 && this.contado === false) {
        return false;
      }
      if (!item.Name) {
        return false;
      }
      myRegExp = new RegExp(Cliente.queryToRegex(query), 'gi');
      result = item.Name.search(myRegExp) > -1 || String(item.CodigoExterno).indexOf(query) === 0;
      return result;
    };

    Cliente.typeAheadMatcher = function(item) {
      if (!item) {
        return false;
      }
      if (item.toLowerCase().indexOf(this.query.trim().toLowerCase()) !== -1) {
        return true;
      }
    };

    Cliente.typeAheadSorter = function(items) {
      return items.sort();
    };

    Cliente.typeAheadHighlighter = function(item) {
      var regex;
      regex = new RegExp('(' + this.query + ')', 'gi');
      return item.replace(regex, "<strong>$1</strong>");
    };

    Cliente.typeAheadSource = function(query, process) {
      var cliente, clientes, map, _i, _len, _ref1;
      clientes = [];
      map = {};
      _ref1 = Cliente.all();
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        cliente = _ref1[_i];
        map[cliente.Name] = cliente;
        clientes.push(cliente.Name);
      }
      console.log(clientes);
      return process(clientes);
    };

    return Cliente;

  })(RSpine.Model);

  module.exports = Cliente;

}).call(this);
}, "components/menu/menu": function(exports, require, module) {(function() {
  var $, Menu, RSpine,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require("rspine");

  if (!$) {
    $ = window.$;
  }

  Menu = (function(_super) {
    __extends(Menu, _super);

    Menu.className = "menu";

    Menu.prototype.elements = {
      ".content": "content"
    };

    function Menu() {
      Menu.__super__.constructor.apply(this, arguments);
      this.html(require("components/menu/menu_layout")());
    }

    return Menu;

  })(RSpine.Controller);

  module.exports = Menu;

}).call(this);
}, "components/menu/menu_layout": function(exports, require, module) {var content = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<div class="labels">Rodco</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}, "components/newsFeed/newsFeed": function(exports, require, module) {(function() {
  var $, ChatterNews, NewsFeed, RSpine, Session,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require("rspine");

  if (!$) {
    $ = window.$;
  }

  Session = require("models/session");

  ChatterNews = require("models/chatterNews");

  NewsFeed = (function(_super) {
    __extends(NewsFeed, _super);

    NewsFeed.className = "news-feed";

    NewsFeed.prototype.elements = {
      ".content": "content"
    };

    function NewsFeed() {
      var base, request,
        _this = this;
      NewsFeed.__super__.constructor.apply(this, arguments);
      base = new RSpine.Ajax.Base();
      request = base.ajaxQueue({}, {
        type: 'GET',
        url: RSpine.Model.salesforceHost + ("/api?path=/services/data/v24.0/chatter/feeds/news/" + (Session.first().userId) + "/feed-items")
      });
      request.done(function(response) {
        var item, _i, _len, _ref;
        console.log(response.items);
        _ref = response.items;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          ChatterNews.create(item);
        }
        console.log(ChatterNews.all());
        return _this.html(require("components/newsFeed/newsFeed_item")(ChatterNews.all()));
      });
      $(".kan-col-wrapper > .content-body").mouseover(function(e) {
        var target, wrapper;
        target = $(e.target);
        while (!target.hasClass("content-body")) {
          target = target.parent();
        }
        wrapper = target.find(".content-body-wrapper");
        if (wrapper.height() > target.height()) {
          $(".kanban").css("overflow", "hidden");
          return $(".kan-col-wrapper > .content-body").one("mouseout", function() {
            return $(".kanban").css("overflow", "scroll");
          });
        }
      });
    }

    return NewsFeed;

  })(RSpine.Controller);

  module.exports = NewsFeed;

}).call(this);
}, "components/newsFeed/newsFeed_item": function(exports, require, module) {module.exports = function(values, data){ 
  var $  = jQuery, result = $();
  values = $.makeArray(values);
  data = data || {};
  for(var i=0; i < values.length; i++) {
    var value = $.extend({}, values[i], data, {index: i});
    var elem  = $((function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      var RSpine, comment, _i, _len, _ref;
    
      RSpine = require("rspine");
    
      __out.push('\n\n<div class="row post">\n\n  <div class="col-md-1 post-image-wrapper">\n    <img src="');
    
      __out.push(__sanitize(RSpine.getImage(this.photoUrl)));
    
      __out.push('" />\n  </div>\n\n  <div class="col-md-11">\n    <div class="post-area">\n      <span class="title">');
    
      __out.push(__sanitize(this.actor.name));
    
      __out.push('</span>\n      <span class="text">');
    
      __out.push(__sanitize(this.body.text));
    
      __out.push('</span>\n    </div>\n\n    <div class="row post-actions">\n      <div class="col-md-12">\n        <a class="labels like">Me gusta (');
    
      __out.push(__sanitize(this.likes.total));
    
      __out.push(')</a>\n      </div>\n    </div>\n  \n    <div class="row post-comments"> \n      ');
    
      _ref = this.comments.comments;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        comment = _ref[_i];
        __out.push('\n        <div class="row inner-wrapper">\n      \n          <div class="col-md-1 ">\n            <img src="');
        __out.push(__sanitize(RSpine.getImage(comment.user.photo.smallPhotoUrl)));
        __out.push('">\n          </div>\n\n          <div class="col-md-11">\n            <div class="post-area">\n              <span class="title">');
        __out.push(__sanitize(comment.user.name));
        __out.push('</span>\n              <span class="text">');
        __out.push(__sanitize(comment.body.text));
        __out.push('</span>\n              <div class="row post-actions">\n                <div class="col-md-11">\n                  <a class="labels like"> Me Gusta (');
        __out.push(__sanitize(this.likes.total));
        __out.push(')</a>\n                </div>\n              </div>\n            </div>\n          </div>\n        </div>\n      ');
      }
    
      __out.push('\n    </div>\n\n    <div class="row post-new-comment">\n      <div class="row">\n        <div class="col-md-1 ">\n          <img src="');
    
      __out.push(__sanitize(RSpine.getImage(RSpine.session.user.SmallPhotoUrl)));
    
      __out.push('">\n        </div>\n        <div class="col-md-11">\n          <textarea class="form-control" rows="1"/>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
})(value));
    elem.data('item', value);
    $.merge(result, elem);
  }
  return result;
};}
});


  //CSS Styles for Modules
  var css=".post {  margin-top: 16.5px;  margin-bottom: 33px;}.post:first-child {  margin-top: 0px;}.post img {  width: 33px;  height: 31.68px;}.post .title {  display: inline-block;  margin-right: 7px;  color: #4a4b4c;  font-weight: 700;}.post .post-actions {  margin: 3px;  margin-bottom: 0px;}.post .post-actions a.labels {  display: inline-block;  margin-right: 6px;  cursor: pointer;  color: #1cb5ea;}.post .post-comments {  margin-bottom: 4px;  border-left: 1px solid #f1f2f2;}.post .post-comments a.comment {  display: none;}.post .post-new-comment {  position: relative;}.post .post-new-comment img {  display: inline-block;}.post .post-new-comment textarea {  display: inline-block;  position: absolute;  width: 90%;}";
  var head  = document.head || document.getElementsByTagName('head')[0];
  (function(/*! Stitch !*/) {
    if (!this.require) {
      var modules = {}, cache = {}, require = function(name, root) {
        var path = expand(root, name), indexPath = expand(path, './index'), module, fn;
        module   = cache[path] || cache[indexPath]
        if (module) {
          return module.exports;
        } else if (fn = modules[path] || modules[path = indexPath]) {
          module = {id: path, exports: {}};
          try {
            cache[path] = module;
            fn(module.exports, function(name) {
              return require(name, dirname(path));
            }, module);
            return module.exports;
          } catch (err) {
            delete cache[path];
            throw err;
          }
        } else {
          throw 'module \'' + name + '\' not found';
        }
      }, expand = function(root, name) {
        var results = [], parts, part;
        if (/^\.\.?(\/|$)/.test(name)) {
          parts = [root, name].join('/').split('/');
        } else {
          parts = name.split('/');
        }
        for (var i = 0, length = parts.length; i < length; i++) {
          part = parts[i];
          if (part == '..') {
            results.pop();
          } else if (part != '.' && part != '') {
            results.push(part);
          }
        }
        return results.join('/');
      }, dirname = function(path) {
        return path.split('/').slice(0, -1).join('/');
      };
      this.require = function(name) {
        return require(name, '');
      }
      this.require.define = function(bundle) {
        for (var key in bundle)
          modules[key] = bundle[key];
      };
      this.require.modules = modules;
      this.require.cache   = cache;
    }
    return this.require.define;
  }).call(this)({
    "dataManager": function(exports, require, module) {(function() {
  var Cliente, DataManager, RSpine, Session, User;

  RSpine = require("rspine");

  Session = require("models/session");

  User = require("models/user");

  Cliente = require("models/cliente");

  DataManager = (function() {
    function DataManager() {
      var _this = this;
      RSpine.datamanager = this;
      User.bind("refresh", function() {
        var session;
        session = Session.first();
        session.user = User.first();
        session.save();
        return _this.initializeData();
      });
    }

    DataManager.prototype.initializeData = function() {
      Cliente.autoQuery = true;
      return RSpine.Model.SalesforceModel.initialize();
    };

    return DataManager;

  })();

  module.exports = DataManager;

}).call(this);
}, "initApp": function(exports, require, module) {(function() {
  var DataManager, InitApp, RSpine, Session, User,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require("rspine");

  require("lib/setup");

  Session = require("models/session");

  User = require("models/user");

  DataManager = require("dataManager");

  InitApp = (function(_super) {
    __extends(InitApp, _super);

    InitApp.prototype.elements = {
      ".app-highlight": "appHighlight",
      ".kanban": "kanban",
      ".kanban-wrapper": "kanbanWrapper"
    };

    InitApp.prototype.loginStage = {
      "login": ".login-wrapper"
    };

    InitApp.prototype.ignitionStage = {
      "newsFeed": ".news-feed",
      "menu": ".menu"
    };

    InitApp.prototype.launchStage = {
      "appHighlight": ".app-highlight",
      "appMenu": ".app-menu",
      "appMetrics": ".app-metrics",
      "breadcrum": ".breadcrum"
    };

    function InitApp() {
      var _this = this;
      InitApp.__super__.constructor.apply(this, arguments);
      this.html(require("layout_" + RSpine.app.layout)());
      new DataManager();
      User.fetch({
        id: Session.first().userId
      }, {
        query: true
      });
      this.requireComponents(this.ignitionStage);
      this.initLaunchStage();
      User.bind("refresh", function() {
        var user;
        user = User.first();
        return LazyLoad.js("" + RSpine.jsPath + "/apps_vendedores.js", function() {
          RSpine.apps = moduleList;
          return RSpine.trigger("platform:apps_loaded");
        });
      });
    }

    InitApp.prototype.createAccount_click = function(event) {
      var account, accountForm;
      accountForm = event.target;
      return account = new Account(accountForm);
    };

    InitApp.prototype.initLaunchStage = function() {
      var _this = this;
      return LazyLoad.js("" + RSpine.jsPath + "/launch-components.js", function() {
        require("lib/setup");
        return _this.requireComponents(_this.launchStage);
      });
    };

    InitApp.prototype.requireComponents = function(stage) {
      var Component, component, element, _results;
      _results = [];
      for (component in stage) {
        element = stage[component];
        Component = require("components/" + component + "/" + component);
        _results.push(new Component({
          el: $(element)
        }));
      }
      return _results;
    };

    return InitApp;

  })(RSpine.Controller);

  module.exports = InitApp;

}).call(this);
}, "layout_web": function(exports, require, module) {var content = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<div class="outer-container full-height">\n  <div class="row full-height">\n    <div class="col-md-1 menu"></div>\n    <div class="col-md-11 kanban">\n      <div class="kanban-wrapper">\n        <div class="row breadcrum">\n        </div>\n\n        <div class="row full-height">\n          \n          <div class="col-md-4 kan-col-wrapper large social-ban kan-col">\n            <div class="header blue"><span class="triangle"></span><span class="large-title">!Buenos días Mari!</span></div>\n            <div class="sub-header">\n              <div class="sub-title">Que hay de nuevo?</div>\n            </div>\n            <div class="content-body scrollable">\n              <div class="news-feed content-body-wrapper"></div>\n            </div>\n          </div>\n          \n          \n          \n          \n          <div class="col-md-4 kan-col-wrapper app-ban kan-col">\n            <div class="header red"><span class="triangle"></span><span class="large-title">Apps mas usadas</span></div>\n            <div class="sub-header">\n              <div class="sub-title text-center">Home</div>\n            </div>\n            <div class="content-body">\n              <div class="inner-wrapper content-body-wrapper">\n                <div class="row app-highlight"></div>\n              </div>\n              \n              <div class="app-menu">\n              </div>\n              \n            </div>\n          </div>\n          \n          <div class="col-md-4 kan-col-wrapper large metric-ban kan-col">\n            <div class="header purple"><span class="triangle"></span><span class="large-title">Que paso con el cliente </span></div>\n            <div class="sub-header">\n              <div class="sub-title">Todos los Clientes</div>\n            </div>\n            <div class="content-body">\n              <div class="content-body-wrapper">\n    \n                <div class="app-metrics"></div>\n    \n              </div>\n            </div>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}, "lib/setup": function(exports, require, module) {(function() {


}).call(this);
}, "models/cliente": function(exports, require, module) {(function() {
  var Cliente, RSpine, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require('rspine');

  Cliente = (function(_super) {
    __extends(Cliente, _super);

    function Cliente() {
      this.filterByName = __bind(this.filterByName, this);
      _ref = Cliente.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Cliente.configure('Cliente', 'Name', 'CodigoExterno', "Activo", "Saldo", "DiasCredito", "CreditoAsignado", "Rating_Crediticio", "Negociacion", "LastModifiedDate", "Ruta", "Transporte", "Direccion", "Telefono", "RutaTransporte");

    Cliente.extend(RSpine.Model.SalesforceModel);

    Cliente.extend(RSpine.Model.Ajax);

    Cliente.querySinceLastUpdate = true;

    Cliente.avoidInsertList = ["Name", "Rating_Crediticio", "CodigoExterno", "Activo", "Saldo", "DiasCredito", "LastModifiedDate", "Meta", "Ventas", "PlazoRecompra", "PlazoPago"];

    Cliente.filters = {
      "": " Activo__c = true",
      "conSaldo": " Saldo__c != 0",
      "credito": " CreditoAsignado__c > 0 and DiasCredito__c > 0",
      "contado": " CreditoAsignado__c = 0 and DiasCredito__c = 0"
    };

    Cliente.to_name_array = function() {
      var cliente, clientes, names, _i, _len;
      clientes = Cliente.all();
      names = [];
      for (_i = 0, _len = clientes.length; _i < _len; _i++) {
        cliente = clientes[_i];
        names.push(cliente.Name);
      }
      return names;
    };

    Cliente.prototype.validate = function() {
      if (!this.Name) {
        return "El nombre del cliente es obligatorio";
      }
    };

    Cliente.prototype.willOverDraft = function(monto) {
      var od;
      od = false;
      if (monto + this.Saldo > this.CreditoAsignado) {
        od = true;
      }
      return od;
    };

    Cliente.prototype.filterByName = function(query, item) {
      var myRegExp, result;
      if (item.Activo === false) {
        return false;
      }
      if (item.DiasCredito > 0 && this.contado === true) {
        return false;
      }
      if (item.DiasCredito === 0 && this.contado === false) {
        return false;
      }
      if (!item.Name) {
        return false;
      }
      myRegExp = new RegExp(Cliente.queryToRegex(query), 'gi');
      result = item.Name.search(myRegExp) > -1 || String(item.CodigoExterno).indexOf(query) === 0;
      return result;
    };

    Cliente.typeAheadMatcher = function(item) {
      if (!item) {
        return false;
      }
      if (item.toLowerCase().indexOf(this.query.trim().toLowerCase()) !== -1) {
        return true;
      }
    };

    Cliente.typeAheadSorter = function(items) {
      return items.sort();
    };

    Cliente.typeAheadHighlighter = function(item) {
      var regex;
      regex = new RegExp('(' + this.query + ')', 'gi');
      return item.replace(regex, "<strong>$1</strong>");
    };

    Cliente.typeAheadSource = function(query, process) {
      var cliente, clientes, map, _i, _len, _ref1;
      clientes = [];
      map = {};
      _ref1 = Cliente.all();
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        cliente = _ref1[_i];
        map[cliente.Name] = cliente;
        clientes.push(cliente.Name);
      }
      console.log(clientes);
      return process(clientes);
    };

    return Cliente;

  })(RSpine.Model);

  module.exports = Cliente;

}).call(this);
}, "components/menu/menu": function(exports, require, module) {(function() {
  var $, Menu, RSpine,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require("rspine");

  if (!$) {
    $ = window.$;
  }

  Menu = (function(_super) {
    __extends(Menu, _super);

    Menu.className = "menu";

    Menu.prototype.elements = {
      ".content": "content"
    };

    function Menu() {
      Menu.__super__.constructor.apply(this, arguments);
      this.html(require("components/menu/menu_layout")());
    }

    return Menu;

  })(RSpine.Controller);

  module.exports = Menu;

}).call(this);
}, "components/menu/menu_layout": function(exports, require, module) {var content = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<div class="labels">Rodco</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}, "components/newsFeed/newsFeed": function(exports, require, module) {(function() {
  var $, ChatterNews, NewsFeed, RSpine, Session,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require("rspine");

  if (!$) {
    $ = window.$;
  }

  Session = require("models/session");

  ChatterNews = require("models/chatterNews");

  NewsFeed = (function(_super) {
    __extends(NewsFeed, _super);

    NewsFeed.className = "news-feed";

    NewsFeed.prototype.elements = {
      ".content": "content"
    };

    function NewsFeed() {
      var base, request,
        _this = this;
      NewsFeed.__super__.constructor.apply(this, arguments);
      base = new RSpine.Ajax.Base();
      request = base.ajaxQueue({}, {
        type: 'GET',
        url: RSpine.Model.salesforceHost + ("/api?path=/services/data/v24.0/chatter/feeds/news/" + (Session.first().userId) + "/feed-items")
      });
      request.done(function(response) {
        var item, _i, _len, _ref;
        console.log(response.items);
        _ref = response.items;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          ChatterNews.create(item);
        }
        console.log(ChatterNews.all());
        return _this.html(require("components/newsFeed/newsFeed_item")(ChatterNews.all()));
      });
      $(".kan-col-wrapper > .content-body").mouseover(function(e) {
        var target, wrapper;
        target = $(e.target);
        while (!target.hasClass("content-body")) {
          target = target.parent();
        }
        wrapper = target.find(".content-body-wrapper");
        if (wrapper.height() > target.height()) {
          $(".kanban").css("overflow", "hidden");
          return $(".kan-col-wrapper > .content-body").one("mouseout", function() {
            return $(".kanban").css("overflow", "scroll");
          });
        }
      });
    }

    return NewsFeed;

  })(RSpine.Controller);

  module.exports = NewsFeed;

}).call(this);
}, "components/newsFeed/newsFeed_item": function(exports, require, module) {module.exports = function(values, data){ 
  var $  = jQuery, result = $();
  values = $.makeArray(values);
  data = data || {};
  for(var i=0; i < values.length; i++) {
    var value = $.extend({}, values[i], data, {index: i});
    var elem  = $((function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      var RSpine, comment, _i, _len, _ref;
    
      RSpine = require("rspine");
    
      __out.push('\n\n<div class="row post">\n\n  <div class="col-md-1 post-image-wrapper">\n    <img src="');
    
      __out.push(__sanitize(RSpine.getImage(this.photoUrl)));
    
      __out.push('" />\n  </div>\n\n  <div class="col-md-11">\n    <div class="post-area">\n      <span class="title">');
    
      __out.push(__sanitize(this.actor.name));
    
      __out.push('</span>\n      <span class="text">');
    
      __out.push(__sanitize(this.body.text));
    
      __out.push('</span>\n    </div>\n\n    <div class="row post-actions">\n      <div class="col-md-12">\n        <a class="labels like">Me gusta (');
    
      __out.push(__sanitize(this.likes.total));
    
      __out.push(')</a>\n      </div>\n    </div>\n  \n    <div class="row post-comments"> \n      ');
    
      _ref = this.comments.comments;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        comment = _ref[_i];
        __out.push('\n        <div class="row inner-wrapper">\n      \n          <div class="col-md-1 ">\n            <img src="');
        __out.push(__sanitize(RSpine.getImage(comment.user.photo.smallPhotoUrl)));
        __out.push('">\n          </div>\n\n          <div class="col-md-11">\n            <div class="post-area">\n              <span class="title">');
        __out.push(__sanitize(comment.user.name));
        __out.push('</span>\n              <span class="text">');
        __out.push(__sanitize(comment.body.text));
        __out.push('</span>\n              <div class="row post-actions">\n                <div class="col-md-11">\n                  <a class="labels like"> Me Gusta (');
        __out.push(__sanitize(this.likes.total));
        __out.push(')</a>\n                </div>\n              </div>\n            </div>\n          </div>\n        </div>\n      ');
      }
    
      __out.push('\n    </div>\n\n    <div class="row post-new-comment">\n      <div class="row">\n        <div class="col-md-1 ">\n          <img src="');
    
      __out.push(__sanitize(RSpine.getImage(RSpine.session.user.SmallPhotoUrl)));
    
      __out.push('">\n        </div>\n        <div class="col-md-11">\n          <textarea class="form-control" rows="1"/>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
})(value));
    elem.data('item', value);
    $.merge(result, elem);
  }
  return result;
};}
  });

    moduleList = [
    
      
      
      

       
    
      
      
      

       
    
      
      
      

       
    
      
      
      

       
    
      
      
      

       
    
      
      
      

       
    
      
      
      

       
    
      
      
      

       
    
      
      
      

       
    
    ]

  
    //CSS Styles for Modules
    var css=".post {  margin-top: 16.5px;  margin-bottom: 33px;}.post:first-child {  margin-top: 0px;}.post img {  width: 33px;  height: 31.68px;}.post .title {  display: inline-block;  margin-right: 7px;  color: #4a4b4c;  font-weight: 700;}.post .post-actions {  margin: 3px;  margin-bottom: 0px;}.post .post-actions a.labels {  display: inline-block;  margin-right: 6px;  cursor: pointer;  color: #1cb5ea;}.post .post-comments {  margin-bottom: 4px;  border-left: 1px solid #f1f2f2;}.post .post-comments a.comment {  display: none;}.post .post-new-comment {  position: relative;}.post .post-new-comment img {  display: inline-block;}.post .post-new-comment textarea {  display: inline-block;  position: absolute;  width: 90%;}";
    var head  = document.head || document.getElementsByTagName('head')[0];
    var style = document.createElement('style');

    style.type = 'text/css';

    if (style.styleSheet) {
      style.styleSheet.cssText = css;
    }
    else {
      style.appendChild(document.createTextNode(css));
    }

    head.appendChild(style);
  
  var style = document.createElement('style');

  style.type = 'text/css';

  if (style.styleSheet) {
    style.styleSheet.cssText = css;
  }
  else {
    style.appendChild(document.createTextNode(css));
  }

  head.appendChild(style);
