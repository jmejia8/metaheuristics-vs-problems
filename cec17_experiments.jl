using Metaheuristics, God

include("problems.jl")
include("solvers.jl")

current_run = 1

function cec17_experiments()
    NRUNS = 31
    NFUNS = 30
    
    solverSet = [solverECA, solverJSO, solverCMA, solverCGSA]
    D = 10

    results = zeros(NFUNS, NRUNS)

    for fnum = 1:NFUNS
        for nrun = 1:NRUNS
            # update run id
            global current_run = nrun

            
            problem() = problemsCEC17(D, fnum)

            # get solutions
            fx = solve(problem, solverECA)

            results[fnum, nrun] = fx

            @printf(" run: %d \t f = %d \t Error = %e \n", nrun, fnum, fx)
            
            
        end

        stats = statitistic(results[fnum:fnum, :])
        println("")
        printSummary(stats)
        # save results
        writecsv("output/summary_fun$(fnum)_$(current_run).csv", stats)
        println("------------------------------------------")
    end
    
    println("------------------------------------------")

    stats_all = statitistic(results)

    printSummary(stats_all)
    writecsv("summary_all.csv", stats_all)
    writecsv("summary_fx_all.csv", results)
    
    println("------------------------------------------")
    println("Todo terminó bien.")


end

cec17_experiments()
