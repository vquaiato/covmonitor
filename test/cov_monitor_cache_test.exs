defmodule CovMonitor.Cache.Test do
  use ExUnit.Case, async: true

  alias CovMonitor.Cache

  test "é possível colocar no cache usando chave de país" do
    assert Cache.colocar("brasil", %{}) == :ok
  end

  test "é possível obter do cache usando chave de país" do
    Cache.colocar("brasil", "valor do cache")
    assert Cache.obter("brasil") == {:ok, "valor do cache"}
  end

  test "quando não tem item no cache retorna {:ok nil}" do
    Cache.colocar("chave", "valor do cache")
    assert Cache.obter("chave-inexsistente") == {:ok, nil}
  end
end
