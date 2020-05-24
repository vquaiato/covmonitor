defmodule CovMonitor.Cache.Test do
  use ExUnit.Case, async: true


  setup do
    cache = start_supervised!(CovMonitor.Cache)

    %{cache_pid: cache}
  end

  test "cache é iniciado", %{cache_pid: pid} do
    assert is_pid(pid)
  end

  test "é possível colocar no cache usando chave de país" do
    assert CovMonitor.Cache.colocar("brasil", %{}) == :ok
  end

  test "é possível obter do cache usando chave de país" do
    CovMonitor.Cache.colocar("brasil", "valor do cache")
    assert CovMonitor.Cache.obter("brasil") == "valor do cache"
  end
end
