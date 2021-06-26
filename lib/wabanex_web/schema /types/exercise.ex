defmodule WabanexWeb.Schema.Types.Exercise do
  use Absinthe.Schema.Notation

  @desc "Exercise representation"
  object :exercise do
    field :id, non_null(:uuid4)
    field :name, non_null(:string)
    field :youtube_url, non_null(:string)
    field :protocol_description, non_null(:string)
    field :repetitions, non_null(:string)
  end

  input_object :create_exercise_input do
    field :name, non_null(:string), description: "Exercise name"
    field :youtube_url, non_null(:string), description: "URL Video"
    field :protocol_description, non_null(:string), description: "Protocol description"
    field :repetitions, non_null(:string), description: "Number serie and repetitions"
  end
end