define (require, exports, module) ->
  'use strict'

  document.domain = "moviepilot.com"

  $ = require('jquery')
  _ = require('underscore')
  _s = require('underscore.string')
  d3 = require('d3')

  Backbone = require('backbone')
  Chaplin = require('chaplin')

  # The application object.
  module.exports = class Application extends Chaplin.Application
    title: 'Seoserver commits'

    initialize: ->
      super
      window.App = @

    queryParameterString: (query) ->
      _.map(query, (v, k) -> [k,v].join('=')).join('&')

    urlFromPathAndQuery: (path, query) ->
      path + "?" + @queryParameterString(query)
