define (require, exports, module) ->
  'use strict'

  Controller = require 'controllers/base/controller'
  DashboardView = require 'views/dashboard_view'

  module.exports = class DashboardController extends Controller
    index: (params, options) ->
      @view = new DashboardView
