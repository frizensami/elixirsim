defmodule Util do
  def rand_0_n_inclusive(n) do
    :rand.uniform(n + 1) - 1
  end

  def rand_0_n_exclusive(n) do
    :rand.uniform(n) - 1
  end
end
