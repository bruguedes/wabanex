defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.Schemas.User
  alias Wabanex.User.Create

  describe "users queries" do
    test "sucess when a valid id", %{conn: conn} do
      params = %{name: "Bruno Guedes", email: "bruguedes@gmail.com", password: "121212"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
      {
        getUser(id: "#{user_id}") {
          id, email, name
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "bruguedes@gmail.com",
            "id" => "#{user_id}",
            "name" => "Bruno Guedes"
          }
        }
      }

      assert response == expected_response
    end

    test "fails when a valid id", %{conn: conn} do
      params = %{name: "Bruno Guedes", email: "bruguedes@gmail.com", password: "121212"}
      Create.call(params)

      query = """
      {
        getUser(id: "99702596-8909-46be-9648-58e3336a2c11") {
          id, email, name
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(200)

      assert %{"errors" => [%{"message" => "User not found"}]} = response
    end
  end

  describe "users mutations" do
    test "success creating new user", %{conn: conn} do
      mutation = """
      mutation {
        createUser(input: {name: "New user test", email: "test@email.com", password: "121212"}) {
          id, name, email
        }
       }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(200)

      assert %{
               "data" => %{
                 "createUser" => %{
                   "id" => _id,
                   "name" => "New user test",
                   "email" => "test@email.com"
                 }
               }
             } = response
    end
  end
end
