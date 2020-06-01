defmodule CovMonitor.Cache do
  use GenServer
  @behaviour CovMonitor.Cache.Behavior

  def init(_init_arg) do
    {:ok, %{}}
  end

  # chamada síncrona
  def handle_call({:obter, pais}, _from, state) do
    {:reply, state[pais], state}
  end

  # chamada assíncrona
  def handle_cast({:colocar, {pais, dados_covid}}, state) do
    {:noreply, Map.put(state, pais, dados_covid)}
  end

  # API Cliente
  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def colocar(pais, dados_covid) do
    GenServer.cast(__MODULE__, {:colocar, {pais, dados_covid}})
  end

  def obter(pais) do
    {:ok, GenServer.call(__MODULE__, {:obter, pais})}
  end
end
