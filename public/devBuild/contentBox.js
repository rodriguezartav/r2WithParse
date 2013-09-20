
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
module.exports = content;}, "components/newsFeed/newsFeed-comment": function(exports, require, module) {module.exports = function(values, data){ 
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
};}, "components/newsFeed/newsFeed-post": function(exports, require, module) {module.exports = function(values, data){ 
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
      __out.push('\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
})(value));
    elem.data('item', value);
    $.merge(result, elem);
  }
  return result;
};}, "components/newsFeed/newsFeed": function(exports, require, module) {(function() {
  var $, NewsFeed, Spine,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Spine = require("spine");

  if (!$) {
    $ = window.$;
  }

  NewsFeed = (function(_super) {
    __extends(NewsFeed, _super);

    NewsFeed.className = "news-feed";

    NewsFeed.prototype.elements = {
      ".content": "content"
    };

    function NewsFeed() {
      NewsFeed.__super__.constructor.apply(this, arguments);
      this.html(require("components/newsFeed/newsFeed_layout")());
      this.append(require("components/newsFeed/newsFeed_layout")());
      this.append(require("components/newsFeed/newsFeed_layout")());
      this.append(require("components/newsFeed/newsFeed_layout")());
    }

    return NewsFeed;

  })(Spine.Controller);

  module.exports = NewsFeed;

}).call(this);
}, "components/newsFeed/newsFeed_layout": function(exports, require, module) {var content = function(__obj) {
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
      __out.push('<div class="row post">\n\n    <div class="col-md-1 post-image-wrapper">\n      <img src="images/lau.png" />\n    </div>\n\n    <div class="col-md-11">\n      <div class="post-area">\n        <span class="title">Laura Sanchez</span>\n        <span class="text">ds f jknkj ds ewen wehe  d ekkddk ndkdbe du3n  manana dds dfs fsdds dsfjsjsdi oifjkewf o jsdf sfdksdop oidsajkdsoda jadkdas kals</span>\n      </div>\n\n\n\n\n      <div class="row post-actions">\n        <div class="col-md-12">\n          <a class="labels comment">Comente</a>\n          <a class="labels like">Me gusta</a>\n        </div>\n      </div>\n    \n      <div class="row post-comments"> \n\n        <div class="row inner-wrapper">\n        \n          <div class="col-md-1 ">\n            <img src="images/quiros.png">\n          </div>\n\n          <div class="col-md-11">\n            <div class="post-area">\n              <span class="title"> Rolando Quiros</span>\n              <span class="text"> ds f jknkj ds ewen wehe dd ekkddk ndkdbe du3n  manana dds dfs fsdds dsfjsjsdi oifjkewf o jsdf sfdksdop oidsajkdsoda jadkdas kals</span>\n              <div class="row post-actions">\n                <div class="col-md-11">\n                  <a class="labels comment"> Comente</a>\n                  <a class="labels like"> Me Gusta</a>\n                </div>\n              </div>\n            </div>\n          </div>\n        </div>\n  \n  \n      </div>\n\n      <div class="row post-new-comment">\n        <div class="row">\n          <div class="col-md-1 ">\n            <img src="images/mau.png" />\n          </div>\n\n          <div class="col-md-11">\n            <textarea class="form-control" rows="1"/>\n          </div>\n        </div>\n\n      </div>\n\n  </div>\n\n    \n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
module.exports = content;}
});


  //CSS Styles for Modules
  var css=".contentBox .box {  background-color: #ddd;  padding: 3px 10px;  border-radius: 7px;}.contentBox .title {  font-size: 25px;  color: #fff;  text-shadow: 1px 1px #999;}.contentBox .item {  font-size: 20px;}.contentBox .sub-item {  margin-left: 10px;}.post {  margin-top: 16.5px;  margin-bottom: 33px;}.post:first-child {  margin-top: 0px;}.post img {  width: 33px;  height: 31.68px;}.post .title {  display: inline-block;  margin-right: 7px;  color: #4a4b4c;  font-weight: 700;}.post .post-actions {  margin: 3px;  margin-bottom: 0px;}.post .post-actions a.labels {  display: inline-block;  margin-right: 6px;  cursor: pointer;  color: #1cb5ea;}.post .post-comments {  margin-bottom: 4px;  border-left: 1px solid #f1f2f2;}.post .post-comments a.comment {  display: none;}.post .post-new-comment {  position: relative;}.post .post-new-comment img {  display: inline-block;}.post .post-new-comment textarea {  display: inline-block;  position: absolute;  width: 90%;}";
  
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
