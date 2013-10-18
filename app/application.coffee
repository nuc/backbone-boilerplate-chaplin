define (require, exports, module) ->
  'use strict'

  _ = require('underscore')
  $ = require('jquery')
  Backbone = require('backbone')
  Chaplin = require('chaplin')

  # The application object.
  module.exports = class Application extends Chaplin.Application
    title: 'Chaplin boilerplate'

