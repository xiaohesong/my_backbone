	class OneRailsBackbone.Collections.Todos extends Backbone.Collection

    # Reference to this collection's model.
    model: OneRailsBackbone.Models.Todo


    url: '/api/todos'

    done: ->
      @filter( (todo) -> todo.get('done') )

    remaining: ->
      @without.apply(@, @done())

    nextOrder: ->
      if (!@length) then 1 else @last().get('order') + 1

    comparator: (todo) ->
      todo.get('order')
