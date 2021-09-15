defmodule Mutator do
  @moduledoc """
  Mutates Organisms by their running pid
  """
  require Organism
  require Dna

  def mutate(pid, mutate_probs) do
    genome = Organism.get_genome(pid)
    {action, new_genome} = Dna.random_mutation(genome, mutate_probs)

    IO.puts(
      "Mutation on Organism #{inspect(pid)} resulted in #{inspect(action)} to get genome #{inspect(genome)}"
    )

    Organism.update_genome(pid, new_genome)
  end
end
