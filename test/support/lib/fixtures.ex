defmodule Test.Fixtures.Api do
  defp alterar_dado_padrao(mapa_valores, mapa_destino) do
    Map.merge(mapa_destino, mapa_valores)
  end

  def dado_api(valores), do: alterar_dado_padrao(valores, dado_api())

  def dado_api() do
    %{
      "Active" => 1,
      "Deaths" => 1,
      "Confirmed" => 1,
      "Recovered" => 1,
      "Date" => "2020-05-06T00:00:00Z",
      "Country" => "Brazil",
      "City" => "",
      "CityCode" => "",
      "CountryCode" => "BR",
      "Lat" => "-14.24",
      "Lon" => "-51.93",
      "Province" => ""
    }
  end

  def dado_interno(valores), do: alterar_dado_padrao(valores, dado_interno())

  def dado_interno() do
    %{
      ativos: 1,
      óbitos: 1,
      confirmados: 1,
      recuperados: 1,
      data: "06/05/2020",
      país: "Brazil"
    }
  end

  def deltas() do
    %DadosCovid{
      deltas: %DeltasCovid{
        confirmados: %{porcentagem: 100, absoluto: 1},
        ativos: %{porcentagem: 100, absoluto: 1},
        óbitos: %{porcentagem: 100, absoluto: 1},
        recuperados: %{porcentagem: 100, absoluto: 1}
      },
      atual: %AtuaisCovid{
        confirmados: 2,
        ativos: 2,
        óbitos: 2,
        recuperados: 2
      }
    }
  end
end
