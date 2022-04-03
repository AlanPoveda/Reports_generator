defmodule ReportsGenerator do
  alias ReportsGenerator.Parse #Para reduzir o nome

  #variable global para ser acessada somente nesse módulo
  @avaliable_foods [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]

  @options ["users", "foods"]

  def build(filename) do
    filename
    |> Parse.parse_file()
    |> Enum.reduce(report_acc(), fn line, report -> sum_values(line, report) end)
  end

  # Aqui ele já recebe a lista toda e ainda retorna o valor maior
  def higher_value(record, option) when option in @options do
   {:ok, Enum.max_by(record[option], fn {_key, value} -> value end)}
  end

  #Tratativa de erro, se não tiver a opção valida
  def higher_value(_record, _option), do: {:error, "Invalid option!"}

  # Aqui ele soma os valores e ainda retorna um map novo
  defp sum_values([id, food_name, price], %{"foods" => foods, "users" => users} = report) do
    users = Map.put(users, id, users[id] + price)
    foods = Map.put(foods, food_name, foods[food_name] + 1)

    %{ report | "users" => users, "foods" => foods}
  end

  # Ele criar um map zerado para poder fazer a soma dos itens
  defp report_acc() do
    foods = Enum.into(@avaliable_foods, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})
    %{"users" => users, "foods" => foods}
  end
end
