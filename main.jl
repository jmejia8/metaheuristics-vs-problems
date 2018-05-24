using Metaheuristics, God

include("problems.jl")
include("solvers.jl")

current_run = 1

function test()
    problemSet = [problem1, problem2, problem3]
    
    solve(problemSet, solverECA)  
    
    solve(problemSet, solverJSO)

    solve(problemSet, solverCGSA)

    solve(problemSet, solverCMA)
end

function real_world_experiments()
    NRUNS = 31
    
    problemSet = [problem1, problem2, problem3, problemControl]
    solverSet = [solverJSO, solverCMA, solverCGSA]

    for nrun = 31:NRUNS
        # update run id
        global current_run = nrun

        println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        println(" run:  \t ", nrun)
        println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
        # get solutions
        sols = solve(problemSet, solverSet)
        
        # save results
        writecsv("output/run_$current_run", sols)
        
    end
end

