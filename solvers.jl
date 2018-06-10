TOL = 1e-8

function solverECA_d(Problem)
    D, fobj, bounds, max_evals = Problem()

    # α_    = max(100, 500 + 500randn()) #rand(100:1000, 1)[1] #1000.0
    K     = rand(3:7, 1)[1]
    N     = K*D#rand(2D:11D,1)[1]
    η_max = 2 + 2rand()

    # if D == 15
    #     K = 3; N = 100; η_max = 2.0
    # elseif D == 5
    #     K = 7; N = K*D; η_max = 2
    # elseif D == 19
    #     K = 7; N = 200; η_max = 3.0
    # else
    #     K = 3; N = 10; η_max = 4.0
    #     α_ = 100.0
    # end

    objFunction(p) = begin
        return fobj(p)
            # return f + α*sum(g)
        
    end

    pp = 0.90 + 0.1rand()
    pp2 = 0.03 + 0.02rand()
    p, err = eca(objFunction, D;
                    η_max = η_max,
                    K     = K,
                    N     = N,
                    limits= bounds,
                    p_bin= pp2,
                    p_exploit=pp,
                    max_evals=max_evals)
    println(">>> cr", pp)
    println(">>> bn", pp2)
    println("K = $K \t N = $N \t η_max = $η_max")
    println("--------------------------------------------------")

    return p, err
end

function solverECA(Problem)

    D, fobj, bounds, max_evals, pname = Problem()

    x, f = eca(fobj, D; limits = bounds,
                        max_evals = max_evals,
                        saveConvergence = "output/eca/eca_$(D)_run$(current_run)_f$(pname).csv",
                        showResults=false
        )

    f = abs(f - 100.0pname)

    if f < TOL
        return 0.0
    end

    return f
end

    # jso, CMA y CGSA. 
function solverJSO(Problem)
    D, fobj, bounds, max_evals, pname = Problem()

    x, f =  jso(fobj, D; saveConvergence="output/jso/jso_$(D)_run$(current_run)_f$(pname).csv",
                        max_evals = max_evals,
                        limits    = bounds)
    f = abs(f - 100.0pname)

    if f < TOL
        return 0.0
    end

    return f
end

function solverCMA(Problem)
    D, fobj, bounds, max_evals, pname = Problem()
    
    x, f =  CMAES_AEP(fobj, D; saveConvergence="output/CMA/cma_$(D)_run$(current_run)_f$(pname).csv",
                              max_evals = max_evals,
                              limits    = bounds)
    f = abs(f - 100.0pname)

    if f < TOL
        return 0.0
    end

    return f
end

function solverCGSA(Problem)
    D, fobj, bounds, max_evals, pname = Problem()
    
    x, f =  CGSA(fobj, D; saveConvergence = "output/CGSA/cgsa_$(D)_run$(current_run)_f$(pname).csv",
                         max_evals = max_evals,
                         limits    = bounds)
    f = abs(f - 100.0pname)

    if f < TOL
        return 0.0
    end

    return f
end