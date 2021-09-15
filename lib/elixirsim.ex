defmodule Elixirsim do
  require Spawner

  @doc """
  Runs the simulation
  """
  def start do
    pids = Spawner.spawn(100)
  end
end
