defmodule Wabanex.User.Get do
  import Ecto.Query

  alias Ecto.UUID
  alias Wabanex.Repo
  alias Wabanex.Schemas.{Training, User}

  def call(id) do
    id
    |> UUID.cast()
    |> hendle_response()
  end

  defp hendle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, load_training(user)}
    end
  end

  defp hendle_response(:error) do
    {:error, "Invalid UUID"}
  end

  defp load_training(user) do
    today = Date.utc_today()

    query =
      from t in Training,
        where: ^today >= t.start_date and ^today <= t.end_date

    Repo.preload(user, trainings: {first(query, :inserted_at), :exercises})
  end
end
