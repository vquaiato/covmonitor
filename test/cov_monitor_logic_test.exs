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
      %{"confirmados" => 5, "ativos" => 2, "recuperados" => 2, "óbitos" => 2}
    ]

    assert Logic.deltas(input) == %{
             "confirmados" => 400,
             "ativos" => 100,
             "óbitos" => 100,
             "recuperados" => 100
           }
  end

  test "quando tem mais de 7 dias, retorna delta somente para 7 dias" do
    input = [
      %{"confirmados" => 5, "ativos" => 2, "recuperados" => 2, "óbitos" => 2},
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      Fix.dado_interno(),
      %{"confirmados" => 5, "ativos" => 2, "recuperados" => 2, "óbitos" => 2}
    ]

    assert Logic.deltas(input) == %{
             "confirmados" => 400,
             "ativos" => 100,
             "óbitos" => 100,
             "recuperados" => 100
           }
  end

  test "quando tem menos de 7 dias, retorna delta com dados que tem" do
    input = [
      Fix.dado_interno(),
      %{"confirmados" => 5, "ativos" => 2, "recuperados" => 2, "óbitos" => 2}
    ]

    assert Logic.deltas(input) == %{
             "confirmados" => 400,
             "ativos" => 100,
             "óbitos" => 100,
             "recuperados" => 100
           }
  end

  test "quando não tem dados" do
    assert Logic.deltas([]) == %{}
  end
end
