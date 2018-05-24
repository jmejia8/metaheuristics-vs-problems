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