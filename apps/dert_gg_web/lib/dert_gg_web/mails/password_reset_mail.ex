# defmodule DertGGWeb.Mails.PasswordResetMail do
#   use Phoenix.Swoosh,
#     template_root: "lib/dert_gg_web/templates",
#     template_path: "mails"

#   alias DertGGWeb.Router.Helpers, as: Routes

#   def new(email, reset_token) do
#     new()
#     |> from("dont-reply@dert.gg")
#     |> to(email)
#     |> subject("Şifre yenileme talebi - Dert GG")
#     |> render_body("password_reset_mail.html", %{
#       reset_link: Routes.password_reset_url(DertGGWeb.Endpoint, :edit, reset_token)
#     })
#   end
# end
