class OneRailsBackbone.Models.Todo extends Backbone.Model


    defaults:
      content: 'empty todo...'
      done: false

    initialize: ->
        @set('content': @defaults.content) unless @get('content')
        # console.log("Views.Model initialize");

    toggle: ->
      @save(done: !@get('done'))

    clear: ->
      @destroy()
