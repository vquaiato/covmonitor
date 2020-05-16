defmodule CovMonitor.Http do
  @callback casos_por_pais(String.t) :: {:ok, [%{}]} | {:erro, String.t}
end
