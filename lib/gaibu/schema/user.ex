defmodule Gaibu.Schema.User do
  use Ecto.Schema
  @derive {Jason.Encoder, only: [:username, :name, :email, :is_active]}

  schema "users" do
    field :username, :string
    field :name, :string
    field :email, :string
    field :password, :string
    field :is_active, :boolean, default: true
  end

  def changeset(user, params \\ %{}) do
    fields = [:username, :name, :email, :password]
    fields_required = fields;
    user
    |> Ecto.Changeset.cast(params, fields)
    |> Ecto.Changeset.validate_required(fields_required)
    |> Ecto.Changeset.validate_length(:username, min: 4, max: 30)
    |> Ecto.Changeset.validate_length(:name, min: 4, max: 100)
    |> Ecto.Changeset.validate_length(:email, min: 6, max: 100)
    |> Ecto.Changeset.update_change(:password, fn input -> input end)
    |> Ecto.Changeset.unique_constraint(:email)
  end
end
