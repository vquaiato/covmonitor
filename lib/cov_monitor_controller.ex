defmodule CovMonitor.Controller do
  require Logger

  alias CovMonitor.{Logic, Cache}

  @api Application.get_env(:covmonitor, :covapi)
  @país "brazil"

  def dados_covid_brasil() do
    case dados_covid() do
      {:erro, erro} -> Logger.error(erro)
      {:ok, dados} -> dados |> Logic.deltas()
    end
  end

  defp dados_covid() do
    case Cache.obter(@país) do
      {:ok, nil} -> @api.casos_por_pais(@país)
      {:ok, dados} -> {:ok, dados}
    end
  end
end
