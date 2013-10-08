var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(function(require, exports, module) {
  'use strict';
  var DashboardView, View, _ref;
  View = require('views/base/view');
  return module.exports = DashboardView = (function(_super) {
    __extends(DashboardView, _super);

    function DashboardView() {
      _ref = DashboardView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    DashboardView.prototype.template = 'templates/dashboard';

    DashboardView.prototype.container = 'body';

    DashboardView.prototype.autoRender = true;

    return DashboardView;

  })(View);
});
