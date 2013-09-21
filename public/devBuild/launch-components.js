
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
  var $, AppHighlight, Spine,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Spine = require("spine");

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

  })(Spine.Controller);

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
      __out.push('<div class="col-md-4 app-icon full-height">\n  \n  <div class="icon red">\n    <div class="text">Ze</div>\n    </div>\n  </div>  \n  \n</div>\n\n<div class="col-md-8 app-info">\n  <div class="title">App Name</div>\n  <div class="labels"> d d ads ds das sd d adas das dsa dasD ASD Ad sadS AD sad sad sad sdsfds fdsf dsafd saf dsf sadf</div>\n  <a class="btn btn-danger btn-block"> Abrir App</a>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}
});


  //CSS Styles for Modules
  var css=".app-highlight .title {  line-height: 1.6;  color: #ee5437;}.app-highlight .icon {  width: 90%;  height: 95px;}.app-highlight .icon .text {  color: white;  font-size: 60px;  font-family: sans-serif;  line-height: 0px;  font-weight: bold;  text-align: center;}.app-highlight .labels {  margin-bottom: 6px;  line-height: 1.2;}.app-highlight .star {  position: absolute;  width: 0;  height: 0;  border-left: 10px solid transparent;  border-right: 10px solid transparent;  border-bottom: 10px solid red;}.app-highlight .star:after {  content: '';  position: absolute;  width: 0;  height: 0;  border-left: 10px solid transparent;  border-right: 10px solid transparent;  border-top: 10px solid red;  margin: 5px 0 0 -10px;}";
  
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
