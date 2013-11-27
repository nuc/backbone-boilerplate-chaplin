define (require, exports, module) ->
  'use strict'

  Chaplin = require 'chaplin'

  module.exports = class View extends Chaplin.View

    # Precompiled templates function initializer.
    getTemplateFunction: ->
      template = @template || @options.template
      require('templates')[template] if template
