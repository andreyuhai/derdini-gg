defmodule DerdiniGGWeb.Authentication.Api.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :derdini_gg,
    error_handler: DerdiniGGWeb.Authentication.Api.ErrorHandler,
    module: DerdiniGGWeb.Authentication

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.LoadResource, allow_blank: true
end
