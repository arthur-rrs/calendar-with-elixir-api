defmodule Gaibu.Schema.UserLogin do
  use Ecto.Schema
  import Ecto.Query

  def changeset(user, params \\ %{}) do
    fields = [:email, :password, ]
    fields_required = fields;
    user
    |> Ecto.Changeset.cast(params, fields)
    |> Ecto.Changeset.validate_required(fields_required)
    |> Ecto.Changeset.validate_length(:email, min: 6, max: 100)
  end

  def authenticate_user(email, plain_text_password) do
    query = from u in Gaibu.Schema.User, where: u.email == ^email
    case Gaibu.Repo.one(query) do
      x when is_nil(x) -> {:error, :invalid_credentials}
      user ->
        if plain_text_password == user.password do
          {:ok, user}
        else
          {:error, :invalid_password}
        end
    end
  end
end
