define (require, exports, module) ->
  'use strict'

  Commit = require 'models/commit'

  Collection = require 'models/base/collection'

  module.exports = class Commits extends Collection

    url: 'https://api.github.com/repos/moviepilot/seoserver/commits'

    model: Commit

