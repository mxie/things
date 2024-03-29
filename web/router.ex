defmodule Things.Router do
  use Things.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Things do
    pipe_through :browser # Use the default browser stack

    get "/", TodoController, :index
    resources "/todos", TodoController, only: [:create, :update, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Things do
  #   pipe_through :api
  # end
end
