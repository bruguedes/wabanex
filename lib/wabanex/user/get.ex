defmodule Wabanex.User.Get do
  alias Ecto.UUID
  alias Wabanex.Repo
  alias Wabanex.Schemas.User

  def call(id) do
    id
    |> UUID.cast()
    |> hendle_response()
  end

  defp hendle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp hendle_response(:error) do
    {:error, "Invalid UUID"}
  end
end
