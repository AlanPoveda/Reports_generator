# defmodule ReportsGenerator do
#   def build(filename) do
#     case File.read("reports/#{filename}") do
#       {:ok, file} -> file
#       {:error, result} -> result
#     end
#   end
# end

defmodule ReportsGenerator do
  def build(filename) do
    "reports/#{filename}"
    |> File.read()
    |> handle_reponse()
  end

  defp handle_reponse({:ok, response}),do: response
  defp handle_reponse({:error, _response}),do: "No find file"

end
