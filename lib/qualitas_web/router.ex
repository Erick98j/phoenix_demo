defmodule QualitasWeb.Router do
  use QualitasWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug QualitasWeb.Plugs.LoadUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", QualitasWeb do
    pipe_through :browser

    get "/", SessionController, :login

    get "/signup", AuthController, :signup
    post "/signup", AuthController, :create
    get "/login", SessionController, :login
    post "/login", SessionController, :create
    get "/logout", SessionController, :logout

  end

  scope "/", QualitasWeb do
    pipe_through :browser

    get "/policy", PageController, :policy

    get "/policies", PageController, :policies
    get "/policies/all", PageController, :policies
    get "/policies/to_due", PageController, :to_due
    get "/policies/finished", PageController, :finished
    get "/policies/cancelled", PageController, :cancelled
  end

  # Other scopes may use custom stacks.
  # scope "/api", QualitasWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: QualitasWeb.Telemetry
    end
  end
end
