defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "sucess when the file exists" do
      params = %{"filename" => "students.csv"}

      expected_response =
        {:ok,
         %{
           "Bruno" => 27.08415906989034,
           "Jardele" => 19.713321527615356,
           "Leonardo" => 25.46938775510204
         }}

      assert expected_response == IMC.calculate(params)
    end

    test "fail when the file not exists " do
      params = %{"filename" => "not_valid"}

      assert {:error, _message} = IMC.calculate(params)
    end
  end
end
