
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
  "components/appHighlight/appHighlight": function(exports, require, module) {(function() {
  var $, AppHighlight, RSpine,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require("rspine");

  if (!$) {
    $ = window.$;
  }

  AppHighlight = (function(_super) {
    __extends(AppHighlight, _super);

    AppHighlight.className = "";

    function AppHighlight() {
      AppHighlight.__super__.constructor.apply(this, arguments);
      this.html(require("components/appHighlight/appHighlight_layout")());
    }

    return AppHighlight;

  })(RSpine.Controller);

  module.exports = AppHighlight;

}).call(this);
}, "components/appHighlight/appHighlight_layout": function(exports, require, module) {var content = function(__obj) {
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
      __out.push('<div class="col-md-4 full-height">\n  \n  <div class="app-icon red">\n    <div class="text">Ze</div>\n    </div>\n  </div>  \n  \n</div>\n\n<div class="col-md-8 app-info">\n  <div class="title">App Name</div>\n  <div class="labels"> d d ads ds das sd d adas das dsa dasD ASD Ad sadS AD sad sad sad sdsfds fdsf dsafd saf dsf sadf</div>\n  <a class="btn btn-danger btn-block"> Abrir App</a>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}, "components/appMenu/appIcon": function(exports, require, module) {module.exports = function(values, data){ 
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
    
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
})(value));
    elem.data('item', value);
    $.merge(result, elem);
  }
  return result;
};}, "components/appMenu/appMenu": function(exports, require, module) {(function() {
  var $, AppMenu, RSpine,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require("rspine");

  if (!$) {
    $ = window.$;
  }

  AppMenu = (function(_super) {
    __extends(AppMenu, _super);

    AppMenu.className = "";

    AppMenu.prototype.events = {
      "click .app": "onAppClick"
    };

    function AppMenu() {
      var _this = this;
      AppMenu.__super__.constructor.apply(this, arguments);
      RSpine.bind("platform:apps_loaded", function() {
        return _this.html(require("components/appMenu/appMenu_layout")({
          apps: RSpine.apps
        }));
      });
    }

    AppMenu.prototype.onAppClick = function() {
      var kanban;
      kanban = $(".kanban");
      kanban.prepend('<div class="kanban-wrapper app-wrapper">\
      <div class="row full-height">\
        <div class="col-md-12 kan-col">\
          <div class="header blue"><span class="triangle"></span><span class="large-title">Pedidos del App</span></div>\
          <div class="sub-header">\
            <div class="sub-title">Todos los Clientes</div>\
          </div>\
        </div>\
      </div>\
    </div>');
      kanban.scrollTop(100000);
      return kanban.animate({
        scrollTop: 0
      }, 1000);
    };

    return AppMenu;

  })(RSpine.Controller);

  module.exports = AppMenu;

}).call(this);
}, "components/appMenu/appMenu_layout": function(exports, require, module) {var content = function(__obj) {
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
      var app, _i, _len, _ref;
    
      __out.push('<div class="row app-row">\n\n  ');
    
      _ref = this.apps;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        app = _ref[_i];
        __out.push('\n    <div class="col-md-4">\n      <div class="app-icon icon-small ');
        __out.push(__sanitize(app.iconColor));
        __out.push('">\n        <div class="gloss"></div>\n        <div class="text">');
        __out.push(__sanitize(app.iconLabel));
        __out.push('</div>\n      </div>\n      <div class="labels">Pedidos</div>\n    </div>\n  \n  ');
      }
    
      __out.push('\n\n</div>\n  \n  \n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}, "components/appMetrics/appMetrics": function(exports, require, module) {(function() {
  var $, AppMetrics, RSpine,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require("rspine");

  if (!$) {
    $ = window.$;
  }

  AppMetrics = (function(_super) {
    __extends(AppMetrics, _super);

    AppMetrics.className = "";

    function AppMetrics() {
      AppMetrics.__super__.constructor.apply(this, arguments);
      this.html(require("components/appMetrics/appMetrics_layout")());
    }

    return AppMetrics;

  })(RSpine.Controller);

  module.exports = AppMetrics;

}).call(this);
}, "components/appMetrics/appMetrics_layout": function(exports, require, module) {var content = function(__obj) {
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
      __out.push('<div class="row">\n  <div class="col-md-6">\n    <div class="blue graph"></div>\n  </div>\n  <div class="col-md-6">\n    <div class="purple graph"></div>\n  </div>\n</div>\n<div class="row">\n  <div class="col-md-12">\n    <div class="gray-light graph"></div>\n  </div>\n</div>\n<div class="row">        \n  <div class="col-md-6">\n    <div class="graph gray-light"></div>\n  </div>\n  <div class="col-md-6">\n    <div class="graph green">       </div>\n  </div>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}, "components/breadcrum/breadcrum": function(exports, require, module) {(function() {
  var $, Breadcrum, RSpine, User,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  RSpine = require("rspine");

  if (!$) {
    $ = window.$;
  }

  User = require("models/user");

  Breadcrum = (function(_super) {
    __extends(Breadcrum, _super);

    Breadcrum.className = "";

    function Breadcrum() {
      var _this = this;
      Breadcrum.__super__.constructor.apply(this, arguments);
      User.bind("refresh", function() {
        return _this.html(require("components/breadcrum/breadcrum_layout")(User.first()));
      });
    }

    return Breadcrum;

  })(RSpine.Controller);

  module.exports = Breadcrum;

}).call(this);
}, "components/breadcrum/breadcrum_layout": function(exports, require, module) {var content = function(__obj) {
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
      __out.push('  <div class="col-md-11">\n  \n  \n  \n    <h1>Welcome ');
    
      __out.push(__sanitize(this.name));
    
      __out.push('</h1>\n  </div>\n  <div class="col-md-1">\n    <h1>O</h1>\n  </div>\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}
});

moduleList = [
  
    

     
  
    

     
  
    

     
  
    

     
  
    

     
  
    

     
  
    

     
  
    

     
  
    

     
  
]


  //CSS Styles for Modules
  var css=".app-highlight .title {  line-height: 1.6;  color: #ee5437;}.app-highlight .app-icon {  width: 90%;  height: 95px;}.app-highlight .app-icon .text {  color: white;  font-size: 60px;  font-family: sans-serif;  line-height: 0px;  font-weight: bold;  text-align: center;}.app-highlight .labels {  margin-bottom: 6px;  line-height: 1.2;}";
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
