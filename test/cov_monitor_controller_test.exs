defmodule CovMonitorControllerTest do
  use ExUnit.Case, async: true
  import Mox
  import ExUnit.CaptureLog
  require Logger

  alias Test.Fixtures.Api, as: Fix

  setup :verify_on_exit!

  test "dados_covid_brasil retorna lista com dados" do
    CovMonitor.Http.Mock
    |> expect(:casos_por_pais, fn _pais -> {:ok, [Fix.dado_api()]} end)

    assert CovMonitor.Controller.dados_covid_brasil() == [
             Fix.dado_interno()
           ]
  end

  test "api com erro retorna info sobre o erro" do
    CovMonitor.Http.Mock
    |> expect(:casos_por_pais, fn _pais -> {:erro, "Erro da api"} end)

    assert capture_log(fn -> CovMonitor.Controller.dados_covid_brasil() end) =~ "Erro da api"
  end
end
