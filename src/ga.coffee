#!/usr/bin/env coffee
#
# This is a simple Genetic Algorithm in CoffeeScript. The only
# provided function is One-Max, which simply rewards "1"s in the
# genome. Crossover is 1-pt and mutation is bit-flip. The effective
# crossover and mutation rates are 1 and 1.
#
# This is intended as part of an interactive 3D evolutionary
# architecture application using WebGL for the interface.
#
#
# More things to look at:
#
# http://chandlerprall.github.com/Physijs/ (CoffeeScript Physics engine)
#




# Random integer function
randn = (n) -> Math.floor(Math.random() * n)

# Individual has an integer-array genome and a fitness.
class Individual
    # To specify a genome, pass it in. To get a random genome, specify
    # the genomesize.
    constructor: (data, genomesize = -1) ->
        if genomesize > 0
            @genome = (randn(2) for i in [0 ... genomesize])
        else
            @genome = data

# GA has a population and iterates it over multiple generations
class GA
    constructor: (@genomesize, @popsize, @gens) ->
        @pop = (new Individual("dummy", @genomesize) for i in [0 ... popsize])
        # Evaluate and report on the initial population
        @evaluate()
        @print_stats(0)

    step: (gen) ->
        newpop = []
        while (newpop.length < @popsize)
            [d0, d1] = crossover(tournament(@pop, 3), tournament(@pop, 3))
            mutate(d0)
            mutate(d1)
            newpop.push(d0)
            newpop.push(d1)
        @pop = newpop
        @evaluate()
        @print_stats(gen)

    # Run the GA for gens generations.
    run: ->
        for gen in [1 .. @gens]
            @step(gen)
            # Quit early?
            if @best_fitness == best_possible_fitness
                break

    # Print a message
    print_stats: (gen) ->
        console.log("Gen #{gen}; best #{@best_fitness}")
        console.log(@pop)

    # Call the fitness function on the whole population. Can put stats
    # in here too.
    evaluate: ->
        for ind in @pop
            ind.fitness = fitness_fn(ind)
        @best_fitness = best(@pop).fitness

# Crossover two individuals to return two children.
crossover = (p0, p1) ->
    d0 = p0.genome
    d1 = p1.genome
    x = randn(d0.length)
    c0 = new Individual(d0[...x].concat(d1[x...]))
    c1 = new Individual(d1[...x].concat(d0[x...]))
    return [c0, c1]

# Flip a single bit. No mutation-probability or anything.
mutate = (p0) ->
    d0 = p0.genome
    x = randn(d0.length)
    if d0[x]
        d0[x] = 0
    else
        d0[x] = 1

# Find the best individual in a population. Replace this with a max()
# call when I find out how to do the equivalent of Python cmp()
best = (pop) ->
    b = pop[0]
    i = 1
    while i < pop.length
        if pop[i].fitness > b.fitness
            b = pop[i]
            bf = pop[i].fitness
        i += 1
    return b

# Tournament selection. Can reimplement using the JS port of Python's
# random module later
tournament = (pop, size) ->
    candidates = (pop[randn(pop.length)] for i in [0..size])
    return best(candidates)

# One-max fitness
fitness_fn = (ind) ->
    ind.genome.reduce (t, s) -> t + s
best_possible_fitness = 8

# Test
ga = new GA(8, 6, 10)
ga.run()
