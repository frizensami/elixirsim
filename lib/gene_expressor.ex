defmodule GeneExpressor do
  @moduledoc """
  Expresses genes within a genome, creating actions
  """
  # Genes are sequences of length 3 that map to certain actions
  @genes %{[:g, :g, :g] => :die, [:a, :a, :a] => :reproduce}

  require Organism
  require Dna

  def express(pid, pids) do
    Organism.get_genome(pid)
    |> express_genome
    |> Enum.each(fn action -> handle_action(action, pid, pids) end)
  end

  def express_genome(genome) do
    genome
    |> Enum.chunk_every(3)
    |> Enum.map(fn gene -> Map.fetch(@genes, gene) end)
    # Surely not idiomatic
    |> Enum.filter(fn res -> is_tuple(res) end)
    |> Enum.map(fn res -> elem(res, 1) end)
  end

  def handle_action(action, pid, pids) do
    case action do
      :die -> handle_die(pid)
      :reproduce -> handle_reproduce(pid, pids)
    end
  end

  def handle_die(pid) do
    IO.puts("Killing PID #{inspect(pid)} due to gene expression")
    SpawnServer.kill(pid)
  end

  def handle_reproduce(pid, pids) do
  end
end
