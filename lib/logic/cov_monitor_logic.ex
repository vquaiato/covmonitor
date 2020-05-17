defmodule CovMonitor.Logic do
  def deltas([]), do: %{}
  def deltas(dados_covid) do
    primeiro = dados_covid |> Enum.take(-7) |> List.first()
    ultimo = List.last(dados_covid)

    %{
      "confirmados" => delta(primeiro["confirmados"], ultimo["confirmados"]),
      "recuperados" => delta(primeiro["recuperados"], ultimo["recuperados"]),
      "ativos" => delta(primeiro["ativos"], ultimo["ativos"]),
      "óbitos" => delta(primeiro["óbitos"], ultimo["óbitos"])
    }
  end

  defp delta(primeiro, ultimo) do
    diferenca = ultimo - primeiro
    div = diferenca / primeiro
    div * 100
  end
end
