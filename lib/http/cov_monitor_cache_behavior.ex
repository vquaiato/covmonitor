defmodule CovMonitor.Cache.Behavior do
  @callback colocar(String.t(), %{}) :: :ok
  @callback obter(String.t()) :: {:ok, %{}} | {:ok, nil}
end
