define (require, exports, module) ->
  'use strict'

  Chaplin = require 'chaplin'

  module.exports = class View extends Chaplin.View

    # Precompiled templates function initializer.
    getTemplateFunction: ->
      return unless @template
      templates = require('templates')
      templates["src/#{@template}.hbs"]

