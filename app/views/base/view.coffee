define (require, exports, module) ->
  'use strict'

  Chaplin = require 'chaplin'

  module.exports = class View extends Chaplin.View

    # Precompiled templates function initializer.
    getTemplateFunction: ->
      template = @template || @options.template

      if template
        if _.isEmpty window.Handlebars.templates
          # Direct require call throw errors when running tests.
          require.call(require, 'templates')[template]
        else
          window.Handlebars.templates[template]
