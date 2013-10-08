var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(function(require, exports, module) {
  'use strict';
  var Chaplin, View, _ref;
  Chaplin = require('chaplin');
  return module.exports = View = (function(_super) {
    __extends(View, _super);

    function View() {
      _ref = View.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    View.prototype.getTemplateFunction = function() {
      var templates;
      if (!this.template) {
        return;
      }
      templates = require('templates');
      return templates["src/" + this.template + ".hbs"];
    };

    return View;

  })(Chaplin.View);
});
