define (require, exports, module) ->
  'use strict'

  Controller = require 'controllers/base/controller'
  CommitsView = require 'views/commits-view'
  Commits = require 'models/commits'

  module.exports = class ThingController extends Controller

    index: (params, option) ->

      @collection = new Commits()
      @collection.fetch()

      @view = new CommitsView
        region: 'main'
        collection: @collection

