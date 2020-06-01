defmodule CovMonitorControllerTest do
  use ExUnit.Case, async: true
  import Mox
  import ExUnit.CaptureLog
  require Logger

  alias Test.Fixtures.Api, as: Fix
  alias CovMonitor.Mock

  setup :verify_on_exit!

  test "dados_covid_brasil retorna lista com dados" do
    Mock
    |> expect(:obter, fn _pais -> {:ok, nil} end)
    |> expect(:colocar, fn _pais, dados -> {:ok, dados} end)
    |> expect(:casos_por_pais, fn _pais -> {:ok, [Fix.dado_interno()]} end)

    assert CovMonitor.Controller.dados_covid_brasil() ==
             [Fix.dado_interno()]
             |> CovMonitor.Logic.deltas()
  end

  test "api com erro gera log com info sobre o erro" do
    Mock
    |> expect(:obter, fn _pais -> {:ok, nil} end)
    |> expect(:casos_por_pais, fn _pais -> {:erro, "Erro da api"} end)

    assert capture_log(fn -> CovMonitor.Controller.dados_covid_brasil() end) =~ "Erro da api"
  end
end
