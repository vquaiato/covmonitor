defmodule CovMonitor.Http.Api do
  @behaviour CovMonitor.Http

  alias CovMonitor.Adapter

  def casos_por_pais(pais \\ "brazil") do
    case HTTPoison.get("https://api.covid19api.com/live/country/#{pais}/status/confirmed") do
      {:ok, resposta} -> parse_do_json(resposta) |> Adapter.de_casos_api_para_casos_interno()
      {_status, erro} -> IO.inspect(erro)
    end
  end

  defp parse_do_json(%{:body => corpo} = _resposta_http) do
    Jason.decode!(corpo)
  end
end
