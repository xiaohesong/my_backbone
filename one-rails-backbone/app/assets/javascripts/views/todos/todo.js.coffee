 class OneRailsBackbone.Views.Todo extends Backbone.View

    #... is a list tag.
    tagName:  'li'

    # Cache the template function for a single item.
    # template: _.template(todosTemplate)
    template: JST['todos/todo']

    # The DOM events specific to an item.
    events:
      "click .check"              : "toggleDone"
      "dblclick div.todo-content" : "edit"
      "click span.todo-destroy"   : "clear"
      "keypress .todo-input"      : "updateOnEnter"
      'blur input': 'close'

    # The TodoView listens for changes to its model, re-rendering. Since there's
    # a one-to-one correspondence between a **Todo** and a **TodoView** in this
    # app, we set a direct reference on the model for convenience.
    initialize: ->
      @listenTo(@model, 'change', @render)
      # in case the model is destroyed via a collection method
      # and not by a user interaction from the DOM, the view
      # should remove itself
      @listenTo(@model, 'destroy', @remove)

    # Re-render the contents of the todo item.
    # To avoid XSS (not that it would be harmful in this particular app),
    # we use underscore's "<%-" syntax in template to set the contents of the todo item.
    render: ->
      @$el.html(@template(@model.toJSON()))
      @cacheInput()
      @

    cacheInput: ->
      @$input = @$('.todo-input')

    # Toggle the `"done"` state of the model.
    toggleDone: ->
      @model.toggle()

    # Switch this view into `"editing"` mode, displaying the input field.
    edit: ->
      @$el.addClass('editing')
      @$input.focus()

    # Close the `"editing"` mode, saving changes to the todo.
    close: ->
      @model.save({content: @$input.val()})
      @$el.removeClass('editing')

    # If you hit `enter`, we're through editing the item.
    updateOnEnter: (e) ->
      @close() if e.keyCode == 13

    # Remove this view from the DOM.
    # Remove event listeners from: DOM, @model
    remove: ->
      @stopListening()
      @undelegateEvents()
      @$el.remove()

    # Remove the item, destroy the model.
    clear: ->
      @model.clear()
