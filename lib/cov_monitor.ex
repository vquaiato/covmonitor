defmodule CovMonitor do
  @moduledoc """
  Documentation for `CovMonitor`.
  """

  # escrever testes
  # retornar dados em um formato que queiramos
  def fazer_chamada_api(url) do
    case HTTPoison.get(url) do
      {:ok, resposta} -> parse_do_json(resposta)
      {_status, erro} -> IO.inspect erro
    end
  end

  defp parse_do_json(resposta_http) do
    %{:body => corpo} = resposta_http
    casos_brasil = Jason.decode!(corpo)
    casos_brasil
  end
end
