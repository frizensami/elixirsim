defmodule DnaTest do
  use ExUnit.Case
  doctest Dna

  # MUST BE RUN WITH SEED 0
  test "Mates DNA strings of odd lengths correctly" do
    dna1 = [:a, :t, :g]
    dna2 = [:f, :r, :z]

    dna3 = Dna.mate(dna1, dna2)
    assert dna3 == [:t, :g, :f]
  end

  test "Mates DNA strings of even lengths correctly" do
    dna1 = [:a, :g, :t, :g]
    dna2 = [:f, :y, :r, :z]

    dna3 = Dna.mate(dna1, dna2)
    assert dna3 == [:t, :g, :r, :z]
  end

  test "Mates DNA strings of 0 lengths correctly" do
    dna1 = []
    dna2 = []

    dna3 = Dna.mate(dna1, dna2)
    assert dna3 == []
  end

  test "Mates DNA strings with 1 length 0 correctly" do
    dna1 = [:a, :t]
    dna2 = []

    dna3 = Dna.mate(dna1, dna2)
    assert dna3 == [:t]
  end
end
