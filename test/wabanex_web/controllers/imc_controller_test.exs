defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "success when all parameters are valid", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "result" => %{
          "Bruno" => 27.08415906989034,
          "Jardele" => 19.713321527615356,
          "Leonardo" => 25.46938775510204
        }
      }

      assert expected_response == response
    end

    test "fails when the parameter is invalid", %{conn: conn} do
      params = %{"filename" => "not_valid.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      assert %{"result" => "Error while opening the file"} == response
    end
  end
end
