todo = {}
# for simplicity, we use this component to namespace the model classes

# the Todo class has two properties
todo.Todo = (data) ->
  @description = m.prop(data.description)
  @done = m.prop(false)

# the TodoList class is a list of Todo's
todo.TodoList = Array
