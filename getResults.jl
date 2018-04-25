NRUNS       = 31
NPROBLEMS   = 4
solverNames = ["jso", "cma", "cgsa" ]

function getResults()

    for name = solverNames
        for problem = 1:NPROBLEMS
            fname_out = "summary_$(name)_$(problem).csv"
            
            result = []            
            for r = 1:NRUNS
                fname_in = "output/$(name)_$(r)_$(problem).csv"

                if !isfile(fname_in) || filesize(fname_in) == 0
                    continue
                end

                println(fname_in)

                conv = readcsv(fname_in)

                push!(result, conv[end,2])

            end

            writecsv(fname_out, result)
        end
    end

end

function printResults()
    for problem = 1:NPROBLEMS
        for name = solverNames
            fname_in = "summary_$(name)_$(problem).csv"
            
            if !isfile(fname_in) || filesize(fname_in) == 0
                continue
            end
            
            d = readcsv(fname_in)
            ratio = round(Int, 100length(d)/NRUNS)
            @printf("%s %d  & %e & %e & %e & %e & %i \n", name, problem, minimum(d), median(d), mean(d), std(d), ratio)
        end
    end
end
# getResults()

printResults()
