defmodule Wabanex.Schemas.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.Schemas.User

  describe "changeset/1" do
    test "success when valid values" do
      params = %{name: "Bruno Guedes", email: "bruguedes@gmail.com", password: "121212"}

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{name: "Bruno Guedes", email: "bruguedes@gmail.com", password: "121212"},
               errors: []
             } = User.changeset(params)
    end

    test "fails when valid values" do
      params = %{name: "B", email: "bruguedesgmail.com", password: ""}

      response = User.changeset(params)

      expected_response = %{
        email: ["has invalid format"],
        name: ["should be at least 3 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
