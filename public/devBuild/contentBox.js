
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
  "components/contentBox/contentBox": function(exports, require, module) {(function() {
  var $, ContentBox, Spine,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Spine = require("spine");

  if (!$) {
    $ = window.$;
  }

  ContentBox = (function(_super) {
    __extends(ContentBox, _super);

    ContentBox.className = "contentBox";

    ContentBox.prototype.elements = {
      ".content": "content"
    };

    ContentBox.prototype.getTemplatePath = function(name) {
      var parts, __dirname;
      if (!__dirname) {
        parts = module.id.split("/");
        parts.pop();
      }
      __dirname = parts.join("/");
      return require(__dirname + "/" + name);
    };

    function ContentBox() {
      var contents;
      ContentBox.__super__.constructor.apply(this, arguments);
      this.html(this.getTemplatePath("contentBox_layout")());
      contents = this.generateItems(this.tagSelectors, this.sourceSelector);
      this.render(contents);
    }

    ContentBox.prototype.generateItems = function(tagSelectors, sourceSelector) {
      var cls, contents, element, sourceElements, _i, _len;
      sourceElements = $(sourceSelector).find(tagSelectors);
      contents = "";
      for (_i = 0, _len = sourceElements.length; _i < _len; _i++) {
        element = sourceElements[_i];
        element = $(element);
        cls = element[0].tagName === "H3" ? "sub-" : "";
        contents += "<div class='" + cls + "item'><span class='name'>" + (element.html()) + "</span></div>";
      }
      return contents;
    };

    ContentBox.prototype.render = function(contents) {
      return $(".content").html(contents);
    };

    return ContentBox;

  })(Spine.Controller);

  module.exports = ContentBox;

}).call(this);
}, "components/contentBox/contentBox_layout": function(exports, require, module) {var content = function(__obj) {
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
      __out.push('<div class="contentBox">\n  <div class="box">\n    <span class="title">Table of Contents</span>\n    <div class="content"></div>\n  </div>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}
});


  //CSS Styles for Modules
  var css=".contentBox .box {  background-color: #ddd;  padding: 3px 10px;  border-radius: 7px;}.contentBox .title {  font-size: 25px;  color: #fff;  text-shadow: 1px 1px #999;}.contentBox .item {  font-size: 20px;}.contentBox .sub-item {  margin-left: 10px;}";
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
