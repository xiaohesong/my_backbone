class Todos.Collections.Todos extends Backbone.Collection

  model: Todos.Models.Todo

  # url : 'api/todos'

  # Save all of the todo items under the `"todos"` namespace.
  # localStorage: new Store('todos')

  # Filter down the list of all todo items that are finished.
  done: ->
    @filter( (todo) -> todo.get('done') )

  # Filter down the list to only todo items that are still not finished.
  remaining: ->
    @without.apply(@, @done())

  # We keep the Todos in sequential order, despite being saved by unordered
  # GUID in the database. This generates the next order number for new items.
  nextOrder: ->
    if (!@length) then 1 else @last().get('order') + 1

  # Todos are sorted by their original insertion order.
  comparator: (todo) ->
    todo.get('order')

new Todo.Models.Todo()
