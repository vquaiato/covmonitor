defmodule CovMonitor.Controller do
  require Logger

  alias CovMonitor.Adapter
  alias CovMonitor.Logic

  @api Application.get_env(:covmonitor, :covapi)

  # escrever testes
  def dados_covid_brasil() do
    case @api.casos_por_pais("brazil") do
      {:ok, resposta} -> resposta |> Adapter.de_casos_api_para_casos_interno()
      {_status, erro} -> Logger.error(erro)
    end
  end
end
