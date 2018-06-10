using DataFrames
using HypothesisTests

function statitistic(M::Matrix{Float64})
    # rows = funs
    # cols = runs

    result = zeros(size(M,1), 5)
    for i = 1:size(M,1)
        x = M[i,:]
        
        result[i, 1] = minimum(x)
        result[i, 2] = median(x)
        result[i, 3] = mean(x)
        result[i, 4] = maximum(x)
        result[i, 5] = std(x)
    end

    return result
end

function printSummary(stats)
    for i = 1:size(stats,1)        
        @printf("Best = %.4e  Median = %.4e  Mean = %.4e  Worst = %.4e  std = %.4e\n",
                    stats[i, 1],
                    stats[i, 2],
                    stats[i, 3],
                    stats[i, 4],
                    stats[i, 5])
    end
end

function printSummaryLatex(thetable)
    stats = statitistic(thetable)
    println("fn & Best &  Median &  Mean &  Worst &  Std. \\\\ \n")
    for i = 1:size(stats,1)        
        @printf("%d & %.4e & %.4e & %.4e & %.4e & %.4e \\\\ \n", i,
                    stats[i, 1],
                    stats[i, 2],
                    stats[i, 3],
                    stats[i, 4],
                    stats[i, 5])
    end
end

function printComparison(D, nfuns = 30)
    # Compares ECA
    thenames = ["eca", "jso", "CMA", "CGSA"]

    outputTable = DataFrame()

    ecatable = readcsv("summary/eca/eca_$(D)_runs_fx.csv")

    for name = thenames
        thetable = readcsv("summary/$(name)/$(name)_$(D)_runs_fx.csv") 
        stats =  statitistic(thetable)

        outputTable[Symbol("$(name)_mean")] =  stats[ :, 3 ]
        # outputTable[Symbol("$(name)_std")]  =  stats[ :, 5 ]

        if name == "eca"
            continue
        end

        res = String[]

        for i = 1:nfuns
            x, y = ecatable[i,:], thetable[i,:]

            p = pvalue(SignedRankTest(x, y)) 

            if p < 0.05
                mx, my = median(x), median(y)
                if mx < my
                    push!(res, "+")
                elseif mx == my
                    push!(res, "≈")
                else
                    push!(res, "-")
                end
            
            else
                push!(res, "≈")
            end
        end

        outputTable[Symbol("eca_vs_$(name)")]  =  res
        


    end


    return outputTable
    
end


# println("==================================================")
# println("D = 10")
# printSummaryLatex(readcsv("summary/eca/eca_10_runs_fx.csv"))

# println("==================================================")
# println("D = 30")
# printSummaryLatex(readcsv("summary/eca/eca_30_runs_fx.csv"))
# println("==================================================")
a = printComparison(10)
writetable("comparison.txt", a)
