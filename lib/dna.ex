defmodule Dna do
  require Util
  @dna_bases [:a, :t, :g, :c]

  @doc """
  Return a list consisting of n random bases from @dna_bases
  """
  def get_random_bases(n) when is_integer(n) do
    Enum.map(1..n, fn _i ->
      Enum.random(@dna_bases)
    end)
  end

  @doc """
  Do a continuous sequence of mutations
  """
  def n_random_mutations(dna, 0) when is_list(dna) do
    dna
  end

  def n_random_mutations(dna, n) when is_list(dna) and is_number(n) do
    random_mutation(dna) |> n_random_mutations(n - 1)
  end

  @doc """
  Choose a random mutation from the available ones.
  """
  def random_mutation(dna) when is_list(dna) do
    mutations = [
      &Dna.random_point_deletion/1,
      &Dna.random_point_insertion/1,
      &Dna.random_point_insertion/1,
      &Dna.random_point_replacement/1,
      &Dna.random_point_replacement/1
    ]

    fx = Enum.random(mutations)
    fx.(dna)
  end

  @doc """
  Delete a random base from the list, do nothing if empty list
  """
  def random_point_deletion([]) do
    []
  end

  def random_point_deletion(dna) when is_list(dna) do
    List.delete_at(dna, Util.rand_0_n_exclusive(length(dna)))
  end

  @doc """
  Insert a random base into the list
  """
  def random_point_insertion(dna) when is_list(dna) do
    List.insert_at(dna, Util.rand_0_n_inclusive(length(dna)), get_random_bases(1) |> hd)
  end

  @doc """
  Replace a random base by another one in list
  """
  def random_point_replacement(dna) when is_list(dna) do
    List.replace_at(dna, Util.rand_0_n_inclusive(length(dna)), get_random_bases(1) |> hd)
  end
end
