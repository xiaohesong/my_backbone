 class OneRailsBackbone.Views.Todo extends Backbone.View

    #... is a list tag.
    tagName:  'li'

    template: JST["todos/todos"]

    events:
      "click .check"              : "toggleDone"
      "dblclick div.todo-content" : "edit"
      "click span.todo-destroy"   : "clear"
      "keypress .todo-input"      : "updateOnEnter"
      'blur input'                : 'close'
      "click #new-todo"           : "new"

    initialize: ->
      # console.log("View Todo Render")
      @listenTo(@model, 'change', @render)
      @listenTo(@model, 'destroy', @remove)

    render: ->
      # console.log("View Todo Render")
      @$el.html(@template(@model.toJSON()))
      @cacheInput()
      @

    new: ->
      console.log("xianshi?");

    cacheInput: ->
      console.log("Views-Todo")
      @$input = @$('.todo-input')

    toggleDone: ->
      @model.toggle()

    edit: ->
      @$el.addClass('editing')
      @$input.focus()

    close: ->
      @model.save({content: @$input.val()})
      @$el.removeClass('editing')

    updateOnEnter: (e) ->
      @close() if e.keyCode == 13


    remove: ->
      @stopListening()
      @undelegateEvents()
      @$el.remove()

    clear: ->
      @model.clear()
