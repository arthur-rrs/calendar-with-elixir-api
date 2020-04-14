defmodule Gaibu.Token do

  use Guardian, otp_app: :gaibu

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = Gaibu.Repo.get!(Gaibu.Schema.User, id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

end
