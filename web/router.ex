defmodule Mroutinez.Router do
  use Mroutinez.Web, :router

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

  scope "/", Mroutinez do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/routines", RoutineController
    resources "/registrations", RegistrationController, only: [:new, :create]

    # sessions
    get "/login", SessionController, :new 
    post "/login", SessionController, :create
    delete "logout", SessionController, :delete
  end
end
