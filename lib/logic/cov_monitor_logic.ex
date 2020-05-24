defmodule CovMonitor.Logic do
  def deltas([]), do: %{}
  def deltas(dados_covid) do
    primeiro = dados_covid |> Enum.take(-7) |> List.first()
    atual = List.last(dados_covid)

    %{"deltas" =>
      %{
        "confirmados" => delta_info(primeiro["confirmados"], atual["confirmados"]),
        "recuperados" => delta_info(primeiro["recuperados"], atual["recuperados"]),
        "ativos" => delta_info(primeiro["ativos"], atual["ativos"]),
        "óbitos" => delta_info(primeiro["óbitos"], atual["óbitos"])
      },
      "atual" => %{
        "confirmados" => atual["confirmados"],
        "ativos" => atual["ativos"],
        "recuperados" => atual["recuperados"],
        "óbitos" => atual["óbitos"],
      }
    }
  end

  defp delta_info(primeiro, ultimo) do
    %{
      "porcentagem" => delta_porcentagem(primeiro, ultimo),
      "absoluto" => delta_absoluto(primeiro, ultimo)
    }
  end

  defp delta_porcentagem(primeiro, ultimo) do
    diferenca = delta_absoluto(primeiro, ultimo)
    (diferenca /primeiro * 100) |> trunc
  end

  defp delta_absoluto(primeiro, ultimo), do: ultimo - primeiro
end
