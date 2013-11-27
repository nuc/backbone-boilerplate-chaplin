define (require, exports, module) ->
  'use strict'

  CollectionView = require 'views/base/collection-view'
  CommitView = require 'views/commit-view'

  module.exports = class CommitsView extends CollectionView

    template: 'commits'

    itemView: CommitView

    listSelector: 'tbody'
