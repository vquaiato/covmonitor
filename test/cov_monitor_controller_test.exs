defmodule CovMonitorControllerTest do
  use ExUnit.Case, async: true
  import Mox

  doctest CovMonitor.Controller

  setup :verify_on_exit!

  test "dados_covid_brasil retorna lista com dados" do
    CovMonitor.Http.Mock
    |> expect(:casos_por_pais, fn _pais ->
      {:ok,
       [
         %{
           "Active" => 100,
           "Confirmed" => 100,
           "Recovered" => 10,
           "Deaths" => 1,
           "City" => "",
           "CityCode" => "",
           "Country" => "Brazil",
           "CountryCode" => "BR",
           "Date" => "2020-05-06T00:00:00Z",
           "Lat" => "-14.24",
           "Lon" => "-51.93",
           "Province" => ""
         }
       ]}
    end)

    assert CovMonitor.Controller.dados_covid_brasil() == [
             %{
               "ativos" => 100,
               "confirmados" => 100,
               "recuperados" => 10,
               "óbitos" => 1,
               "país" => "Brazil",
               "data" => "06/05/2020"
             }
           ]
  end

  test "api com erro retorna info sobre o erro" do
    CovMonitor.Http.Mock
    |> expect(:casos_por_pais, fn _pais -> {:erro, "Erro da api"} end)

    assert CovMonitor.Controller.dados_covid_brasil() == "Erro da api"
  end
end
