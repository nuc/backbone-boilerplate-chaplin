var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(function(require, exports, module) {
  'use strict';
  var Controller, DashboardController, DashboardView, _ref;
  Controller = require('controllers/base/controller');
  DashboardView = require('views/dashboard_view');
  return module.exports = DashboardController = (function(_super) {
    __extends(DashboardController, _super);

    function DashboardController() {
      _ref = DashboardController.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    DashboardController.prototype.index = function(params, options) {
      return this.view = new DashboardView;
    };

    return DashboardController;

  })(Controller);
});
