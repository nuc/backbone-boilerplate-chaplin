define (require, exports, module) ->
  'use strict'

  View = require 'views/base/view'

  module.exports = class CommitView extends View

    autoRender: true

    template: 'commit'

    tagName: 'tr'

