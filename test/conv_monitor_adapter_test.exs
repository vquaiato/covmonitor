defmodule CovMonitor.Adapter.Test do
  use ExUnit.Case

  alias CovMonitor.Adapter, as: Adapter

  @dado_api %{
    "Active" => 1,
    "Deaths" => 0,
    "Confirmed" => 2,
    "Recovered" => 10,
    "Date" => "2020-05-06T00:00:00Z",
    "Country" => "Brazil",
    "City" => "",
    "CityCode" => "",
    "CountryCode" => "BR",
    "Lat" => "-14.24",
    "Lon" => "-51.93",
    "Province" => ""
  }

  test "transforma mapa da api para nosso dado" do
    dado_esperado = %{
      "ativos" => 1,
      "óbitos" => 0,
      "confirmados" => 2,
      "recuperados" => 10,
      "data" => "06/05/2020",
      "país" => "Brazil"
    }

    assert Adapter.caso_api_para_caso_interno(@dado_api) == dado_esperado
  end

  test "transforma uma lista de mapas da api em uma lista de nossos dados" do
    dado_esperado = %{
      "ativos" => 1,
      "óbitos" => 0,
      "confirmados" => 2,
      "recuperados" => 10,
      "data" => "06/05/2020",
      "país" => "Brazil"
    }
    assert Adapter.de_casos_api_para_casos_interno([@dado_api]) == [dado_esperado]
  end
end
