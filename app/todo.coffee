todo = {}
# for simplicity, we use this component to namespace the model classes

# the Todo class has two properties
todo.Todo = (data) ->
  @description = m.prop(data.description)
  @done = m.prop(false)

# the TodoList class is a list of Todo's
todo.TodoList = Array

# define the view-model
todo.vm =
  init: ->
    # a running list of todos
    todo.vm.list = new todo.TodoList()

    # a slot to store the name of a new todo before it is created
    todo.vm.description = m.prop('')

    # adds a todo to the list, and clears the description field for user convenience
    todo.vm.add = (description) ->
      if description()
        todo.vm.list.push(new todo.Todo({description: description()}))
        todo.vm.description('')

# controller
todo.controller = -> todo.vm.init()
