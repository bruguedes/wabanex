defmodule WabanexWeb.Resolvers.User do
  def get(%{id: user_id}, _context), do: Wabanex.User.Get.call(user_id)
  def create(%{input: params}, _context), do: Wabanex.User.Create.call(params)
end
