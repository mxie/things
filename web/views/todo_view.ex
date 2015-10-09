defmodule Things.TodoView do
  use Things.Web, :view

  def complete_text(todo) do
    if todo.complete do
      "Mark Incomplete"
    else
      "Mark Complete"
    end
  end
end
