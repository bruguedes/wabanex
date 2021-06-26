defmodule Wabanex.Schemas.TrainingTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.Schemas.Training

  describe "changeset/1" do
    test "success when valid values" do
      params = %{
        start_date: "2021-06-22",
        end_date: "2021-07-22",
        user_id: "99702596-8909-46be-9648-58e3336a2c11",
        exercises: [
          %{
            name: "tricips",
            protocol_description: "regular",
            repetitions: "3x15",
            youtube_url: "www.youtube.com"
          },
          %{
            name: "biceps",
            protocol_description: "regular",
            repetitions: "3x15",
            youtube_url: "www.youtube.com"
          }
        ]
      }

      assert %Ecto.Changeset{
               valid?: true,
               errors: []
             } = Training.changeset(params)
    end

    test "fails when valid values" do
      params = %{
        start_date: "invalid",
        end_date: "invalid",
        user_id: "invalid",
        exercises: []
      }

      response = Training.changeset(params)

      expected_response = %{end_date: ["is invalid"], start_date: ["is invalid"]}

      assert errors_on(response) == expected_response
    end
  end
end
