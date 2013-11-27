define (require, exports, module) ->
  'use strict'

  Chaplin = require 'chaplin'
  SiteView = require 'views/site-view'

  module.exports = class Controller extends Chaplin.Controller

    beforeAction: (params) ->
      super

      @compose 'site', SiteView

