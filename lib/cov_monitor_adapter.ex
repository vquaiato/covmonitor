defmodule CovMonitor.Adapter do

  def de_casos_api_para_casos_interno(casos_api) do
    Enum.map(casos_api, fn caso_api ->
      caso_api_para_caso_interno(caso_api)
    end)
  end

  def caso_api_para_caso_interno(caso_api) do
    %{
      confirmados: caso_api["Confirmed"],
      ativos: caso_api["Active"],
      óbitos: caso_api["Deaths"],
      recuperados: caso_api["Recovered"],
      país: "Brazil",
      data: de_iso_string_para_string_brasil(caso_api["Date"])
    }
  end

  defp de_iso_string_para_string_brasil(iso_string) do
    pad = fn num ->
      num
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
    end

    case iso_string |> DateTime.from_iso8601() do
      {:ok, data, _zero} -> "#{pad.(data.day)}/#{pad.(data.month)}/#{data.year}"
      _ -> "Sem Data"
    end
  end
end
