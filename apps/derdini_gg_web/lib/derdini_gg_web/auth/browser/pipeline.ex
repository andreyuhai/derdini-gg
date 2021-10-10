defmodule DerdiniGGWeb.Authentication.Browser.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :derdini_gg,
    error_handler: DerdiniGGWeb.Authentication.Browser.ErrorHandler,
    module: DerdiniGGWeb.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
