var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(function(require, exports, module) {
  'use strict';
  var $, Application, Backbone, Chaplin, _, _ref;
  _ = require('underscore');
  $ = require('jquery');
  Backbone = require('backbone');
  Chaplin = require('chaplin');
  return module.exports = Application = (function(_super) {
    __extends(Application, _super);

    function Application() {
      _ref = Application.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Application.prototype.title = 'Chaplin boilerplate';

    return Application;

  })(Chaplin.Application);
});
