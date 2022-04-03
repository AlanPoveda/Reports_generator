defmodule ReportsGenerator do
  alias ReportsGenerator.Parse #Para reduzir o nome

  def build(filename) do
    filename
    |> Parse.parse_file()
    |> Enum.reduce(report_acc(), fn line, map -> sum_values(line, map) end)
  end

  defp sum_values([id, _food, price], map), do: Map.put(map, id, map[id] + price)

  defp report_acc, do: Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})
end
