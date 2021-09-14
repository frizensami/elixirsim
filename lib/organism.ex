defmodule Organism do
  @moduledoc """
  This module represents an organism containing a genome.
  A genome is a list containing :a, :t, :g, or :c.
  This simulates the 5' -> 3' DNA strand.
  """

  use GenServer

  ## Client APIs

  @doc """
  Starts a genserver with this module's name
  """
  def start_link(default_genome) when is_list(default_genome) do
    GenServer.start(__MODULE__, default_genome)
  end

  def get_genome(pid) do
    GenServer.call(pid, :genome)
  end

  ## Server (Callbacks)

  @doc """
  Initializes state with the current genome
  """
  @impl true
  def init(genome) do
    {:ok, genome}
  end

  @impl true
  @doc """
  Initializes state with the current genome
  # Just retrieves the current genome in this organism
  """
  def handle_call(:genome, _from, state) do
    {:reply, state, state}
  end

  @impl true
  @doc """
  Set current genome to specific list
  """
  def handle_cast({:set, genome}, _state) do
    {:noreply, genome}
  end
end
