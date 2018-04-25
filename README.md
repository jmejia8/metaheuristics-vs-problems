# Metaheuristics vs engineering problems

Metaheuristics solve some engineering problems

## Requirements

- [Julia 0.6](https://julialang.org/)
- [Metaheuristics](https://raw.githubusercontent.com/jmejia8/Metaheuristics.jl) module:
```
Pkg.clone("git@github.com:jmejia8/Metaheuristics.jl.git") 
```
- [Mechanisms](https://raw.githubusercontent.com/jmejia8/Mechanisms.jl) module:
```
Pkg.clone("git@github.com:jmejia8/Mechanisms.jl.git") 
```
- [God](https://raw.githubusercontent.com/jmejia8/God.jl) module:
```
Pkg.clone("git@github.com:jmejia8/God.jl.git") 
```

## Run Experiments

Write in Julia REPL:

```julia
# the core
include("main.jl")
include("getResults.jl")

# run experiments (save results)
main()

# read and summarizes results
getResults()

# print statistics
printResults()

```