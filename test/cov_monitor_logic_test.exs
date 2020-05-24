defmodule CovMonitor.Logic.Test do
  use ExUnit.Case

  alias Test.Fixtures.Api, as: Fix
  alias CovMonitor.Logic

  test "quando tem 7 dias, retorna delta dos últimos 7 dias" do
    input = [
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(%{"confirmados" => 2, "ativos" => 2, "recuperados" => 2, "óbitos" => 2})
    ]

    assert Logic.deltas(input) == Fix.deltas()
  end

  test "quando tem mais de 7 dias, retorna delta somente para 7 dias" do
    dia_fora_do_range = %{"confirmados" =>5, "ativos" => 2, "recuperados" => 2, "óbitos" => 2}

    input = [
      dia_fora_do_range,
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(%{"confirmados" => 2, "ativos" => 2, "recuperados" => 2, "óbitos" => 2})
    ]

    assert Logic.deltas(input) == Fix.deltas()
  end

  test "deltas de porcentagem retornam como inteiros" do
    input = [
      Fix.dado_interno(%{"confirmados" => 123}),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(%{"confirmados" => 177})
    ]

    assert Logic.deltas(input)
            |> Map.get("deltas")
            |> Map.get("confirmados")
            |> Map.get("porcentagem")
            == 43
  end

  test "quando tem menos de 7 dias, retorna delta com dados que tem" do
    input = [
      Fix.dado_interno(),
      Fix.dado_interno(%{"confirmados" => 2, "ativos" => 2, "recuperados" => 2, "óbitos" => 2})
    ]

    assert Logic.deltas(input) == Fix.deltas()
  end

  test "quando não tem dados" do
    assert Logic.deltas([]) == %{}
  end
end
