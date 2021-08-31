defmodule DerdiniGGWeb.Authentication do
  use Guardian, otp_app: :derdini_gg
  alias DerdiniGG.{Accounts, Accounts.Account}

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_account(id) do
      %Account{} = account ->
        {:ok, account}

      nil ->
        {:error, :resource_not_found}
    end
  end

  def log_in(conn, account) do
    __MODULE__.Plug.sign_in(conn, account)
  end

  def get_current_account(conn) do
    __MODULE__.Plug.current_resource(conn)
  end
end
