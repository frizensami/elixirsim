defmodule Spawner do
  require Organism
  require Dna

  @doc """
  Spawns n organisms and returns all their PIDs
  """
  def spawn(n) do
    pids =
      for i <- 0..(n - 1) do
        initial_genome = Dna.get_random_bases(10)
        {:ok, pid} = Organism.start(initial_genome)
        IO.puts("Initial genome for organism #{i} is #{inspect(Organism.get_genome(pid))}")
        pid
      end
  end
end
