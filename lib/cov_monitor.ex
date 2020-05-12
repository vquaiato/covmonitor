defmodule CovMonitor do
  @moduledoc """
  Documentation for `CovMonitor`.
  """
alias CovMonitor.Adapter, as: Adapter

  # escrever testes
  # esta função tem muitas responsabilidades, não deveria
  def fazer_chamada_api(url) do
    case HTTPoison.get(url) do
      {:ok, resposta} -> parse_do_json(resposta) |> Adapter.de_casos_api_para_casos_interno
      {_status, erro} -> IO.inspect(erro)
    end
  end

  defp parse_do_json(%{:body => corpo} = _resposta_http) do
    Jason.decode!(corpo)
  end
end
