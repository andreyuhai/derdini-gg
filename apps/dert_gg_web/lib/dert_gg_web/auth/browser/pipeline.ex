defmodule DertGGWeb.Authentication.Browser.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :dert_gg,
    error_handler: DertGGWeb.Authentication.Browser.ErrorHandler,
    module: DertGGWeb.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
