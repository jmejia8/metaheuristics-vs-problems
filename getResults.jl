NRUNS       = 31
NPROBLEMS   = 4
solverNames = ["eca","jso", "cma", "cgsa" ]

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
getResults()

printResults()


# eca 1  & 3.786532e-29 & 4.058227e-04 & 3.224974e-02 & 1.612272e-01 & 100 
# jso 1  & 2.345126e-25 & 3.043847e-07 & 1.687520e-04 & 3.451134e-04 & 100 
# cma 1  & 2.209202e-02 & 1.916353e+02 & 1.458739e+03 & 2.757890e+03 & 100 
# cgsa 1  & 4.570335e+03 & 6.417455e+03 & 6.463569e+03 & 1.916707e+03 & 10 
# eca 2  & 2.628079e-03 & 2.628079e-03 & 2.628079e-03 & 2.892232e-17 & 100 
# jso 2  & 2.628079e-03 & 2.628079e-03 & 2.628079e-03 & 6.832825e-18 & 100 
# cma 2  & 2.628079e-03 & 2.628079e-03 & 1.262112e+00 & 7.012508e+00 & 100 
# cgsa 2  & 6.462590e+00 & 9.183622e+01 & 4.815914e+02 & 8.821277e+02 & 97 
# eca 3  & 2.749687e-01 & 1.350808e+01 & 8.998301e+00 & 6.193448e+00 & 100 
# jso 3  & 2.749692e-01 & 2.811624e-01 & 7.158562e-01 & 2.374197e+00 & 100 
# cma 3  & 1.047558e+00 & 1.946239e+01 & 2.400297e+02 & 6.007176e+02 & 77 
# cgsa 3  & 7.825923e+03 & 7.825923e+03 & 7.825923e+03 & NaN & 3 
# eca 4  & 2.157235e-01 & 2.340816e-01 & 2.310580e-01 & 4.235610e-03 & 100 
# jso 4  & 2.153763e-01 & 2.340816e-01 & 2.292994e-01 & 6.813895e-03 & 100 
# cma 4  & 2.281358e-01 & 2.375766e-01 & 2.447523e-01 & 2.030505e-02 & 100 
# cgsa 4  & 2.861939e-01 & 3.332296e-01 & 3.726253e-01 & 1.149488e-01 & 13 
