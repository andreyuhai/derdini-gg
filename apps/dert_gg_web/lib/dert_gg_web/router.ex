defmodule DertGGWeb.Router do
  use DertGGWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    # plug :fetch_flash
    plug :fetch_live_flash
    plug :put_root_layout, {DertGGWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DertGGWeb.Authentication.Browser.Pipeline
  end

  pipeline :browser_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug DertGGWeb.Authentication.Api.Pipeline
  end

  pipeline :api_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", DertGGWeb do
    pipe_through :browser

    scope "/" do
      pipe_through :browser_auth

      delete "/logout", SessionController, :delete
    end

    live "/", DertsLive
    live "/:entry_id", DertsLive

    resources "/login", SessionController, only: [:new, :create]
    resources "/password-reset", PasswordResetController, only: [:new, :create, :update, :edit]
    resources "/register", RegistrationController, only: [:new, :create]
  end

  scope "/api/v1", DertGGWeb.Api do
    pipe_through :api

    scope "/" do
      pipe_through :api_auth

      resources "/derts", PageController, only: [:index]
      resources "/votes", VoteController, only: [:create]
      resources "/auth", AuthController, only: [:index]
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", DertGGWeb do
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
      live_dashboard "/dashboard", metrics: DertGGWeb.Telemetry
    end
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:browser]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
