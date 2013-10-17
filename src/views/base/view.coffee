define (require, exports, module) ->
  'use strict'

  Chaplin = require 'chaplin'

  module.exports = class View extends Chaplin.View

    listen:
      'sync model': 'render'

    # Precompiled templates function initializer.
    getTemplateFunction: ->
      return unless @template
      templates = require('templates')
      templates["src/#{@template}.hbs"]

