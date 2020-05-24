defmodule CovMonitor.Http.Api do
  @behaviour CovMonitor.Http

  alias CovMonitor.Adapter

  def casos_por_pais(pais \\ "brazil") do
    case HTTPoison.get("https://api.covid19api.com/total/dayone/country/#{pais}") do
      {:ok, resposta} ->
        {:ok,
         parse_do_json(resposta)
         |> Adapter.de_casos_api_para_casos_interno()}

      {_status, erro} ->
        {:erro, erro}
    end
  end

  defp parse_do_json(%{:body => corpo} = _resposta_http) do
    Jason.decode!(corpo)
  end
end
