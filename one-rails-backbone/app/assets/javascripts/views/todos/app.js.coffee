class OneRailsBackbone.Views.App extends Backbone.View

    # Instead of generating a new element, bind to the existing skeleton of
    # the App already present in the HTML.
    el: $('#todoapp')

    # Our template for the line of statistics at the bottom of the app.
    template: JST["todos/todos"]

    # collection: new OneRailsBackbone.Collections.Todos
    # Delegated events for creating new items, and clearing completed ones.
    events:
      "keypress #new-todo":  "createOnEnter"
      "keyup #new-todo":     "showTooltip"
      "click .todo-clear a": "clearCompleted"
      "click #new-todo": "showClick"
    # At initialization we listen to the relevant events on the `Todos`
    # collection, when items are added or changed. This collection is
    # passed on the constructor of this AppView. Kick things off by
    # loading any preexisting todos that might be saved in *localStorage*.
    initialize: ->
      @collection = new OneRailsBackbone.Collections.Todos
      @input    = @$("#new-todo")
      # new OneRailsBackbone.Views.Todo
      @listenTo(@collection, 'add', @addOne)
      @listenTo(@colzaixianlection, 'reset', @addAll)
      @listenTo(@collection, 'all', @render)
      # console.log("Views App -- initialize");
      @collection.fetch()

    showClick: ->
      alert("what");

    # Re-rendering the App just means refreshing the statistics -- the rest
    # of the app doesn't change.
    render: ->
      done = @collection.done().length
      # console.log("View App Render");
      @$('#todo-stats').html(@template(
        total:      @collection.length
        done:       @collection.done().length
        remaining:  @collection.remaining().length
      ))


    # Add a single todo item to the list by creating a view for it, and
    # appending its element to the `<ul>`.
    addOne: (todo) ->
      view = new OneRailsBackbone.Views.Todo(model: todo)
      console.log("Views App --addOne (el)");
      @$('#todo-list').append view.render().el
    # Add all items in the **Todos** collection at once.
    addAll: ->
      @collection.each @addOne
      console.log("Views App --addAll");

    # Generate the attributes for a new Todo item.
    newAttributes: ->
      content: @input.val()
      order:   @collection.nextOrder()
      done:    false
      console.log("Views Todos --newAttributes");
    # If you hit return in the main input field, create new **Todo** model
    # persisting it to *localStorage*.
    createOnEnter: (e) ->
      return if e.keyCode != 13
      @collection.create @newAttributes()
      @input.val('')
      # console.log("View App createOnEnter");

    # Clear all done todo items, destroying their models.
    clearCompleted: ->
      _.each(@collection.done(), (todo) -> todo.clear() )
      false

    # Lazily show the tooltip that tells you to press `enter` to save
    # a new todo item, after one second.
    showTooltip: ->
      tooltip = @$('.ui-tooltip-top')
      val = @input.val()
      tooltip.fadeOut()
      clearTimeout(@tooltipTimeout) if @tooltipTimeout
      return if (val == '' || val == @input.attr('placeholder'))
      show = () -> tooltip.show().fadeIn()
      @tooltipTimeout = _.delay(show, 1000)
      console.log("View App showTooltip")
