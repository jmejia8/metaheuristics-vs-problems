using Metaheuristics, God

include("problems.jl")
include("solvers.jl")
include("tools.jl")

current_run = 1

function cec17_experiments(a=1, b=30)
    D = 30
    SOLVER_NAME = "CGSA"

    NRUNS = 31
    NFUNS = 30
    solver = nothing

    solverSet = [solverECA, solverJSO, solverCMA, solverCGSA]

    results = zeros(NFUNS, NRUNS)

    if SOLVER_NAME == "eca"
        solver = solverECA
    elseif SOLVER_NAME == "jso"
        solver = solverJSO
    elseif SOLVER_NAME == "CMA"
        solver = solverCMA
    elseif SOLVER_NAME == "CGSA"
        solver = solverCGSA
    end

    !isdir("output/$SOLVER_NAME") && mkdir("output/$SOLVER_NAME")
    !isdir("summary/$SOLVER_NAME") && mkdir("summary/$SOLVER_NAME")

    for fnum = a:b
        for nrun = 1:NRUNS
            # update run id
            global current_run = nrun

            
            problem() = problemsCEC17(D, fnum)

            # get solutions
            fx = solve(problem, solver)

            results[fnum, nrun] = fx

            @printf(" run: %d \t f = %d \t Error = %e \n", nrun, fnum, fx)
            
            
        end

        stats = statitistic(results[fnum:fnum, :])
        println("")
        printSummary(stats)
        # save results
        writecsv("output/$(SOLVER_NAME)/summary_$(SOLVER_NAME)_fun$(fnum)_$(current_run).csv", results[fnum:fnum, :])
        println("------------------------------------------")
    end
    
    println("------------------------------------------")

    stats_all = statitistic(results)

    printSummary(stats_all)
    writecsv("summary/$(SOLVER_NAME)/$(SOLVER_NAME)_$(D)_stats.csv", stats_all)
    writecsv("summary/$(SOLVER_NAME)/$(SOLVER_NAME)_$(D)_runs_fx.csv", results)
    
    println("------------------------------------------")
    println("Todo terminó bien.")


end

# cec17_experiments()
