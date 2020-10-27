defmodule MuffinApi.Guardian do
  use Guardian, otp_app: :muffin_api
  alias MuffinApi.Account
  alias MuffinApi.Account.User

  require Logger

  def subject_for_token(user = %User{}, _claims) do
    sub = user.id
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :resource_not_found}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    user = Account.get_user!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
