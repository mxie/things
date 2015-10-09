defmodule Things.TodoController do
  use Things.Web, :controller

  plug :scrub_params, "todo" when action in [:create]

  alias Things.Todo
  alias Things.Repo

  def index(conn, params) do
    todos = Todo.sorted
    |> Todo.filtered(params["filter"])
    |> Repo.all

    todo = Todo.changeset(%Todo{})

    render conn, "index.html", todo: todo, todos: todos
  end

  def create(conn, %{"todo" => todo_params}) do
    todo = Todo.changeset(%Todo{}, todo_params)

    case Repo.insert todo do
      {:ok, _todo} ->
        redirect conn, to: todo_path(conn, :index)
      {:error, reason } ->
        todos = Repo.all(Todo.sorted)
        put_flash(conn, :error, "Oh no!")
        |> render "index.html", todo: todo, todos: todos
    end
  end

  def update(conn, %{"id" => id}) do
    todo = Repo.get(Todo, id)
    complete = !todo.complete

    Repo.update(%{todo | complete: complete})
    redirect conn, to: todo_path(conn, :index)
  end

  def delete(conn, %{"id" => id}) do
    Repo.get(Todo, id) |> Repo.delete

    redirect conn, to: todo_path(conn, :index)
  end
end
