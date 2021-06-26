defmodule Wabanex.Schemas.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Wabanex.Schemas.Training

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:email, :name, :password]

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    has_many :trainings, Training

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    # |> validate_required(@fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
  end
end
