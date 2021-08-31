defmodule DerdiniGG.Guardian do
  use Guardian, otp_app: :derdini_gg

  def subject_for_token(%{id: id}, _claims) do
    {:ok, id}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
  end
end
