defmodule DerdiniGGWeb.Router do
  use DerdiniGGWeb, :router

  pipeline :browser_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :guardian do
    plug DerdiniGGWeb.Authentication.Pipeline
  end

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

  scope "/", DerdiniGGWeb do
    pipe_through [:browser, :guardian]

    scope "/" do
      pipe_through :browser_auth

      get "/", PageController, :index
      delete "/logout", SessionController, :delete
    end

    resources "/register", RegistrationController, only: [:new, :create]
    resources "/login", SessionController, only: [:new, :create]
  end

  scope "/", DerdiniGGWeb do
    pipe_through [:api, :api_auth]

    resources "/derts", PageApiController, only: [:index]
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
