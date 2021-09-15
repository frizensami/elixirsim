defmodule Simulator do
  require SpawnServer
  require Mutator
  require GeneExpressor

  @doc """
  Runs the simulation
  """
  def start do
    # Spawn the organisms
    SpawnServer.start([])
    pids = SpawnServer.spawn(100, 10)

    # Iterate through n rounds of mutations
    sim_cycles = 10
    sleep_time_ms = 100
    pop_mutation_fraction = 0.2

    simulate(pids, sim_cycles, sleep_time_ms, pop_mutation_fraction)
  end

  @doc """
  Runs the simulation to mutate and mate organisms
  """
  def simulate(_, 0, _, _) do
    IO.puts("\n-------SIMULATION COMPLETE-------\n")
  end

  def simulate(pids, cycles, sleep_time_ms, pop_mutation_fraction) do
    IO.puts("\n-------Simulation cycles remaining: #{cycles}-------\n")
    num_pids = length(pids)
    num_to_mutate = trunc(pop_mutation_fraction * num_pids)
    pids_to_mutate = Enum.take_random(pids, num_to_mutate)

    # Each cycle, run processes that mutate a proportion of the organisms (simulating radiation sources, etc)
    # These are implemented as tasks so that we can wait for them to complete before moving onto the next step
    tasks =
      pids_to_mutate
      |> Enum.map(fn pid ->
        Task.async(fn ->
          Mutator.mutate(pid, %{deletion: 0.2, insertion: 0.3, replacement: 0.4})
          GeneExpressor.express(pid, pids)
        end)
      end)

    Task.await_many(tasks)

    # Sleep between sim cycles to let mutations catch up
    :timer.sleep(sleep_time_ms)
    simulate(pids, cycles - 1, sleep_time_ms, pop_mutation_fraction)
  end
end
