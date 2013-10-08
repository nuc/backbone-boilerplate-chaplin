define (require, exports, module) ->
  'use strict'

  View = require 'views/base/view'

  module.exports = class DashboardView extends View
    template: 'templates/dashboard'
    container: 'body'
    autoRender: true

