define (require, exports, module) ->
  'use strict'

  Chaplin = require 'chaplin'

  module.exports = class Controller extends Chaplin.Controller
    beforeAction: -> super

