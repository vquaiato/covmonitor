defmodule CovMonitor.Controller do
  require Logger

  alias CovMonitor.{Logic, Cache}

  @api Application.get_env(:covmonitor, :covapi)
  @cache Application.get_env(:covmonitor, :covcache)

  @país "brazil"

  def dados_covid_brasil() do
    case dados_covid() do
      {:erro, erro} -> Logger.error(erro)
      {:ok, dados} -> dados |> Logic.deltas()
    end
  end

  defp dados_covid() do
    case @cache.obter(@país) do
      {_, nil} -> chamar_api_e_colocar_no_cache()
      {_, dados} -> {:ok, dados}
    end
  end

  defp chamar_api_e_colocar_no_cache() do
    case @api.casos_por_pais(@país) do
      {:ok, dados} -> {:ok, adicionar_cache(dados)}
      {:erro, erro} -> {:erro, erro}
    end
  end

  defp adicionar_cache(dados) do
    @cache.colocar(@país, dados)
    dados
  end
end
