defmodule Test.Fixtures.Api do
  defp alternar_dado_padrao(mapa_valores, mapa_destino) do
    mapa_valores
    |> Enum.map(fn {key, value} -> Map.put(mapa_destino, key, value) end)
    |> List.first()
  end

  def dado_api(valores), do: alternar_dado_padrao(valores, dado_api())

  @spec dado_api :: %{optional(<<_::24, _::_*8>>) => <<_::_*16>> | 1 | 11}
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

  def dado_interno(valores), do: alternar_dado_padrao(valores, dado_interno())

  def dado_interno() do
    %{
      "ativos" => 1,
      "óbitos" => 1,
      "confirmados" => 1,
      "recuperados" => 1,
      "data" => "06/05/2020",
      "país" => "Brazil"
    }
  end
end
