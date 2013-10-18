define (require, exports, module) ->
  'use strict'

  View = require 'views/base/view'

  module.exports = class DashboardView extends View
    template: 'dashboard'
    container: 'body'
    autoRender: true

    initialize: ->
      super
      console.warn 'sup brozeph?'
