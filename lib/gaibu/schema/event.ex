defmodule Gaibu.Schema.Event do
  use Ecto.Schema
  @derive {Jason.Encoder, only: [:id, :name, :date_at, :time_at, :description, :user_id]}
  schema "events" do
    field :name, :string
    field :date_at, :date
    field :time_at, :time
    field :description, :string
    field :user_id, :integer
  end

  def changeset(event, params \\ %{}) do
    fields = [:name, :date_at, :time_at, :description, :user_id]
    fields_required = fields;
    event
    |> Ecto.Changeset.cast(params, fields)
    |> Ecto.Changeset.validate_required(fields_required)
    |> Ecto.Changeset.validate_length(:name, min: 4, max: 100)
    |> Ecto.Changeset.validate_length(:description, min: 0, max: 2000)
    |> Ecto.Changeset.validate_number(:user_id, greater_than: 0)
  end

end
