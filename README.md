# Elixirsim
A genetic simulation involving millions of processes as a way to try out Elixir.

## What?
The most fascinating thing about Elixir/BEAM is its ability to run a large number (millions?) of lightweight processes.
What if we could run a large-scale DNA-based simulation involving a million organisms? I'll make this up as I go along.

## Concepts
### Individuals
Every individual organism is modelled as a GenServer that has its DNA genome as its state. 

### Simulation loop
The simulation is largely ***asynchronous** since most actions are taken by asynchronous processes.
This is somewhat true to life: we create a bunch of environmental stimulus and organisms take action, but there is generally no guarantee of when things happen.

Generally:


1. A number of organisms are spawned with random genomes
2. Begin simulation loop
   1. (Mutation) Spawn and run mutation stimulus processes for x% of the population -- these can randomly change organisms' genomes
   2. (Expression) For each organism, read its genome and express blocks of nucleotides (analogous to expressing proteins) as actions to change its state. Examples of gene expression could be
      - Organism dies
      - Organism reproduces
      - Nothing happens
   3. (Check state) Wait for mutations and gene expression processes to die off, then find the list of remaining organisms
   4. Repeat simulation loop til everything is done
   



