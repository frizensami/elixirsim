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
  Very rough simulation of genome after mating: grab a random half of each genome and concat them together
  """
  def mate(dna1, dna2) when is_list(dna1) and is_list(dna2) do
    dna1_half = get_random_dna_half(dna1)
    dna2_half = get_random_dna_half(dna2)
    dna1_half ++ dna2_half
  end

  def get_random_dna_half(dna) do
    dna_len = length(dna)
    dna_half_select = :rand.uniform_real()

    if dna_half_select < 0.5 do
      # Take elements from start to middle
      Enum.slice(dna, 0, trunc(dna_len / 2))
    else
      # Take all elements from the middle onwards
      Enum.slice(dna, trunc(dna_len / 2), trunc(dna_len))
    end
  end

  @doc """
  Do a continuous sequence of mutations
  """
  def n_random_mutations(dna, 0, _probs) when is_list(dna) do
    dna
  end

  def n_random_mutations(dna, n, probs) when is_list(dna) and is_number(n) do
    random_mutation(dna, probs) |> elem(1) |> n_random_mutations(n - 1, probs)
  end

  @doc """
  Choose a random mutation from the available ones.
  Pass the relative probabilities of mutation for each mutation type.
  E.g., %{deletion: 0.2, insertion: 0.3, replacement: 0.4}
  The probabilities have to sum to less than 1. If so, there is a chance that no mutation is applied.
  """
  def random_mutation(dna, %{deletion: delprob, insertion: insprob, replacement: replaceprob})
      when is_list(dna) do
    # Contract that the 
    if delprob + insprob + replaceprob > 1,
      do: raise("Mutation probabilities must be less than 1")

    prob_boundaries = {delprob, delprob + insprob, delprob + insprob + replaceprob}
    prob = :rand.uniform_real()

    # Check which mutation to run, if any
    case prob do
      _ when prob < elem(prob_boundaries, 0) ->
        {:delete, random_point_deletion(dna)}

      _ when prob < elem(prob_boundaries, 1) ->
        {:insert, random_point_insertion(dna)}

      _ when prob < elem(prob_boundaries, 2) ->
        {:replace, random_point_replacement(dna)}

      _ ->
        {:unchanged, dna}
    end
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
