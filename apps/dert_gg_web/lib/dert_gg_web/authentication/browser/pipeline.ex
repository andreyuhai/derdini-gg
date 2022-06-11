defmodule DertGGWeb.Authentication.Browser.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :dert_gg_web,
    error_handler: DertGGWeb.Authentication.Browser.ErrorHandler,
    module: DertGG.Authentication

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
