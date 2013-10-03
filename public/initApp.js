
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
      console.log("oj");
      Cliente.autoQuery = true;
      return RSpine.Model.SalesforceModel.initialize();
    };

    return DataManager;

  })();

  module.exports = DataManager;

}).call(this);
}, "index": function(exports, require, module) {(function() {
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
      this.html(require("layout_" + this.layout)());
      RSpine.Model.salesforceHost = this.apiServer + "/salesforce";
      Session.createFromQuery(this.session);
      new DataManager();
      RSpine.bind("platform:login_invalid", function() {
        return window.location = "/login.html";
      });
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
        return LazyLoad.js("" + window.src.path + "/" + window.src.build + "/apps_vendedores.js", function() {
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
      return LazyLoad.js("" + window.src.path + "/" + window.src.build + "/launch-components.js", function() {
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
      __out.push('<div class="outer-container full-height">\n  <div class="row full-height">\n    <div class="col-md-1 menu"></div>\n    <div class="col-md-11 kanban">\n      <div class="kanban-wrapper">\n        \n        \n        <div class="row breadcrum">\n        </div>\n        \n        \n        <div class="row full-height">\n          \n          \n          <div class="col-md-4 kan-col-wrapper large social-ban kan-col">\n            <div class="header blue"><span class="triangle"></span><span class="large-title">!Buenos días Mari!</span></div>\n            <div class="sub-header">\n              <div class="sub-title">Que hay de nuevo?</div>\n            </div>\n            <div class="content-body scrollable">\n              <div class="news-feed content-body-wrapper"></div>\n            </div>\n          </div>\n          \n          \n          \n          \n          <div class="col-md-4 kan-col-wrapper app-ban kan-col">\n            <div class="header red"><span class="triangle"></span><span class="large-title">Apps mas usadas</span></div>\n            <div class="sub-header">\n              <div class="sub-title text-center">Home</div>\n            </div>\n            <div class="content-body">\n              <div class="inner-wrapper content-body-wrapper">\n                <div class="row app-highlight"></div>\n              </div>\n              \n              <div class="app-menu">\n              </div>\n              \n            </div>\n          </div>\n          \n          <div class="col-md-4 kan-col-wrapper large metric-ban kan-col">\n            <div class="header purple"><span class="triangle"></span><span class="large-title">Que paso con el cliente </span></div>\n            <div class="sub-header">\n              <div class="sub-title">Todos los Clientes</div>\n            </div>\n            <div class="content-body">\n              <div class="content-body-wrapper">\n    \n                <div class="app-metrics"></div>\n    \n              </div>\n            </div>\n          </div>\n        </div>\n      </div>\n    </div>\n  </div>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}, "lib/setup": function(exports, require, module) {(function() {


}).call(this);
}, "models/chatterNews": function(exports, require, module) {(function() {
  var ChatterNews, RSpine, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require('rspine');

  ChatterNews = (function(_super) {
    __extends(ChatterNews, _super);

    function ChatterNews() {
      _ref = ChatterNews.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    ChatterNews.configure("ChatterNews", "actor", "body", "comments", "likes", "url");

    return ChatterNews;

  })(RSpine.Model);

  module.exports = ChatterNews;

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
}, "models/session": function(exports, require, module) {(function() {
  var RSpine, Session,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require('rspine');

  Session = (function(_super) {
    __extends(Session, _super);

    Session.configure("Session", "provider", "user", "variables", "userId");

    Session.createFromQuery = function(sourceData) {
      var parts, session;
      Session.destroyAll();
      session = Session.create(JSON.parse(sourceData));
      parts = session.user.id.split("/");
      session.userId = parts[parts.length - 1];
      session.save();
      return RSpine.session = session;
    };

    function Session() {
      this.isExpired = __bind(this.isExpired, this);
      Session.__super__.constructor.apply(this, arguments);
    }

    Session.prototype.resetLastUpdate = function() {
      this.lastUpdate = {};
      this.token = null;
      this.lastLogin = null;
      return this.save();
    };

    Session.prototype.isExpired = function() {
      if (this.lastLogin.less_than(110..minutes).ago) {
        return false;
      }
      return true;
    };

    return Session;

  })(RSpine.Model);

  module.exports = Session;

}).call(this);
}, "models/user": function(exports, require, module) {(function() {
  var RSpine, User, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require('rspine');

  User = (function(_super) {
    __extends(User, _super);

    function User() {
      this.getLastUpdate = __bind(this.getLastUpdate, this);
      _ref = User.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    User.configure("User", "Name", "SmallPhotoUrl", "FirstName", "Online", "Status", "LastUpdate", "Perfil__c");

    User.extend(RSpine.Model.Ajax);

    User.extend(RSpine.Model.SalesforceModel);

    User.avoidQueryList = ["Online", "Status", "LastUpdate"];

    User.standardObject = true;

    User.filters = {
      "": "IsActive = true",
      "id": "id = '?' ",
      "vendedor": "Profile = 'Cobrador' or Profile = 'Vendedor'"
    };

    User.prototype.getLastUpdate = function() {
      if (!this.LastUpdate) {
        return new Date(Date.parse("1970-1-1"));
      }
      return this.LastUpdate;
    };

    return User;

  })(RSpine.Model);

  module.exports = User;

}).call(this);
}
});

  moduleList = [
  
    
    
    

     
  
    
    
    

     
  
    
    
    

     
  
    
    
    

     
  
    
    
    

     
  
    
    
    

     
  
    
    
    

     
  
    
    
    

     
  
  ]

