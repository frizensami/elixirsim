defmodule Elixirsim do
  require Spawner

  @doc """
  Runs the simulation
  """
  def start do
    # Spawn the organisms
    pids = Spawner.spawn(100)

    # Iterate through n rounds of mutations
  end
end
