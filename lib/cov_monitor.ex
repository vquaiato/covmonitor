defmodule CovMonitor do
  @moduledoc """
  Documentation for `CovMonitor`.
  """

  # fazer tratamento de erros
  # deixar o código mais Elixirish
  # escrever testes
  # retornar dados em um formato que queiramos
  def fazer_chamada_api(url) do
    {:ok, resposta} = HTTPoison.get(url)
    %{:body => corpo} = resposta
    casos_brasil = Jason.decode!(corpo)
    casos_brasil
  end
end
