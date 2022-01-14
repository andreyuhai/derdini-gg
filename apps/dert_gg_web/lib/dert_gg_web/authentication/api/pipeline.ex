defmodule DertGGWeb.Authentication.Api.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :dert_gg_web,
    error_handler: DertGGWeb.Authentication.Api.ErrorHandler,
    module: DertGGWeb.Authentication

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.LoadResource, allow_blank: true
end
