defmodule CovMonitor.Controller do
  @moduledoc """
  Documentation for `CovMonitor`.
  """
  alias CovMonitor.Adapter, as: Adapter

  @api Application.get_env(:covmonitor, :covapi)

  # escrever testes
  def dados_covid_brasil() do
    case @api.casos_por_pais("brazil") do
      {:ok, resposta} -> resposta |> Adapter.de_casos_api_para_casos_interno()
      {_status, erro} -> IO.inspect(erro)
    end
  end
end
