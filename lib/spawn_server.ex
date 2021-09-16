defmodule SpawnServer do
  require Organism
  require Dna

  use GenServer

  ## Client API

  @doc """
  Starts a genserver with this module's name
  """
  def start(_opts) do
    GenServer.start(__MODULE__, %{}, name: __MODULE__)
  end

  @doc """
  Spawns n organisms and returns all their PIDs
  """
  def spawn(n, init_genome_length) do
    GenServer.call(__MODULE__, {:spawn, n, init_genome_length})
  end

  @doc """
  Kill process with specific PID
  """
  def kill(pid) do
    GenServer.call(__MODULE__, {:kill, pid})
  end

  @doc """
  Spawns n organisms and returns all their PIDs
  """
  def get_pids() do
    GenServer.call(__MODULE__, :get)
  end

  ## Server (Callbacks)

  @impl true
  @doc """
  """
  def init(_state) do
    {:ok, []}
  end

  @impl true
  def handle_call({:spawn, n, init_genome_length}, _from, _state) do
    pids =
      for i <- 0..(n - 1) do
        initial_genome = Dna.get_random_bases(init_genome_length)
        {:ok, pid} = Organism.start(initial_genome)
        IO.puts("Initial genome for organism #{i} is #{inspect(Organism.get_genome(pid))}")
        pid
      end

    state = pids
    {:reply, state, state}
  end

  @impl true
  def handle_call({:kill, pid}, _from, state) do
    try do
      Process.exit(pid, :kill)
      newstate = state -- [pid]
      {:reply, newstate, newstate}
    rescue
      RuntimeError -> {:reply, state, state}
    end
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end
end
