defmodule Spawner do
  require Organism

  @doc """
  Spawns n organisms.
  """
  def spawn(n) do
    for i <- 0..(n - 1) do
      {:ok, pid} = Organism.start_link([:a, :t, :g])
      IO.puts("Initial genome for organism #{i} is #{inspect(Organism.get_genome(pid))}")
    end
  end
end
