defmodule DerdiniGGWeb.Authentication.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :derdini_gg,
    error_handler: DerdiniGGWeb.Authentication.ErrorHandler,
    module: DerdiniGGWeb.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
