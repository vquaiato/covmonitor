defmodule CovMonitor.Controller do
  require Logger

  alias CovMonitor.Logic

  @api Application.get_env(:covmonitor, :covapi)

  def dados_covid_brasil() do
    # se tiver no cache
    # retorna do cache
    # senão
    case @api.casos_por_pais("brazil") do
      {:ok, resposta} -> resposta |> Logic.deltas()
      {_status, erro} -> Logger.error(erro)
    end
  end
end
