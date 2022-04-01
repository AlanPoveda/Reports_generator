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
    |> File.stream!()
    |> Enum.reduce(%{}, fn line, map ->
      [id, _food, price] = parse_line(line)
      Map.put(map, id, price)
    end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end

end
