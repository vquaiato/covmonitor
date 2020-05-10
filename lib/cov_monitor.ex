defmodule CovMonitor do
  @moduledoc """
  Documentation for `CovMonitor`.
  """

  # escrever testes
  # esta função tem muitas responsabilidades, não deveria
  def fazer_chamada_api(url) do
    case HTTPoison.get(url) do
      {:ok, resposta} -> parse_do_json(resposta) |> transformar_dados
      {_status, erro} -> IO.inspect(erro)
    end
  end

  #mover o matching do body direto pro heading da função
  defp parse_do_json(resposta_http) do
    %{:body => corpo} = resposta_http
    casos_brasil = Jason.decode!(corpo)
    casos_brasil
  end

  defp transformar_dados(casos_brasil_da_api) do
    Enum.map(casos_brasil_da_api, fn mapa ->
      %{
        "confirmados" => mapa["Confirmed"],
        "ativos" => mapa["Active"],
        "óbitos" => mapa["Deaths"],
        "recuperados" => mapa["Recovered"],
        "país" => "Brazil",
        "data" => mapa["Date"] |> DateTime.from_iso8601()
      }
    end)
  end
end
