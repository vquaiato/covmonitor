defmodule CovMonitor.Adapter.Test do
  use ExUnit.Case

  alias CovMonitor.Adapter, as: Adapter
  alias Test.Fixtures.Api, as: Fix

  test "transforma mapa da api para nosso dado" do
    assert Adapter.caso_api_para_caso_interno(Fix.dado_api()) == Fix.dado_interno()
  end

  test "transforma uma lista de mapas da api em uma lista de nossos dados" do
    assert Adapter.de_casos_api_para_casos_interno([Fix.dado_api()]) == [Fix.dado_interno()]
  end

  test "transforma uma lista com mais de um dado da api em uma lista com mais de um dado interno" do
    dados_api = [
      Fix.dado_api(),
      Fix.dado_api(%{"Active" => 1000, "Confirmed" => 50})
    ]

    dados_esperado = [
      Fix.dado_interno(),
      Fix.dado_interno(%{"ativos" => 1000, "confirmados" => 50})
    ]

    assert Adapter.de_casos_api_para_casos_interno(dados_api) == dados_esperado
  end
end
