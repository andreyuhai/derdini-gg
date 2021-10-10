defmodule DerdiniGGWeb.Router do
  use DerdiniGGWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DerdiniGGWeb.Authentication.Browser.Pipeline
  end

  pipeline :browser_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug DerdiniGGWeb.Authentication.Api.Pipeline
  end

  pipeline :api_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", DerdiniGGWeb do
    pipe_through :browser

    scope "/" do
      pipe_through :browser_auth

      get "/", PageController, :index
      delete "/logout", SessionController, :delete
    end

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/", DerdiniGGWeb.Api do
    pipe_through :api

    scope "/" do
      pipe_through :api_auth

      resources "/derts", PageController, only: [:index]
      get "/auth", AuthController, :index
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", DerdiniGGWeb do
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
      live_dashboard "/dashboard", metrics: DerdiniGGWeb.Telemetry
    end
  end
end
