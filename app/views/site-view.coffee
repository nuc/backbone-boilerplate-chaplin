define (require, exports, module) ->
  'use strict'

  View = require 'views/base/view'

  # Site view is a top-level view which is bound to body.
  module.exports = class SiteView extends View

    autoRender: true

    container: 'body'

    template: 'site'

    id: 'container'

    regions:
      'main': '#main-content'
