define (require, exports, module) ->
  'use strict'

  $ = require('jquery')
  _ = require('underscore')

  Backbone = require('backbone')
  Chaplin = require('chaplin')

  # The application object.
  module.exports = class Application extends Chaplin.Application
    title: 'Chaplin boilerplate'

