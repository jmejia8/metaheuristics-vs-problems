using Metaheuristics
using Mechanisms
using God

function problem1()
    precisionpts = PTS_VERTICAL_LINE

    D, f, g = getOptimizationProblem(precisionpts)

    max_evals = 20000D
    
    bounds =
        [ 0 60;
          0 60;
          0 60;
          0 60;
        -60 60;
        -60 60.0;
          0 2π;
        -60 60;
        -60 60;
         repmat([0 2π], size(precisionpts, 1))
        ]'

    fobj(x) =  f(x), g(x)
    return D, fobj, bounds, max_evals
end

function problem2()
    precisionpts = PTS_ELLIPTIC

    # synchronization
    X0 = [0,0.0,0]
    θ2 = [π/6, π/4, π/3, 10π/24, π/2]
    D, f, g = getOptimizationProblem(precisionpts, X0, θ2)

    max_evals = 60000
    
    bounds =
        [ 0 60;
          0 60;
          0 60;
          0 60;
        -60 60;
        -60 60.0;
        ]'

    fobj(x) =  f(x), g(x)
    return D, fobj, bounds, max_evals
end

function problem3()
    D, f, g = getOptimizationProblem(PTS_PAIR_1, PTS_PAIR_2)
    precisionpts = PTS_PAIR_1

    max_evals = 20000D

    bounds =
        [ 0 60;
          0 60;
          0 60;
          0 60;
        -60 60;
        -60 60.0;
          0 2π;
        -60 60;
        -60 60;
         repmat([0 2π], size(precisionpts, 1))
        ]'

    fobj(x) =  f(x), g(x)
    return D, fobj, bounds, max_evals
end

function problemControl()
    D, fobj = getDynamicOptimizationProblem()
    return D, fobj, [0.1ones(D) 50ones(D)]', 10000
end

function solverECA(Problem)
    D, fobj, bounds, max_evals = Problem()

    α_ = 1000.0

    if D == 15
        K = 3; N = 100; η_max = 2.0
    elseif D == 5
        K = 7; N = K*D; η_max = 2
    elseif D == 19
        K = 7; N = 200; η_max = 3.0
    else
        K = 3; N = 10; η_max = 4.0
        α_ = 100.0
    end

    objFunction(p, α = α_) = begin
            f, g = fobj(p)
            return f + α*sum(g)
        
    end

    p, err = eca(objFunction, D;
                    η_max = η_max,
                    K     = K,
                    N     = N,
                    limits= bounds,
                    p_bin= 0.03,
                    max_evals=max_evals)

    return p, err
end

    # jso, CMA y CGSA. 
function solverJSO(Problem)
    D, fobj, bounds, max_evals = Problem()

    return jso(fobj, D; max_evals=max_evals, limits=bounds)
end

function solverCMA(Problem)
    D, fobj, bounds, max_evals = Problem()
    
    return CMAES_AEP(fobj, D;max_evals=max_evals, limits=bounds)
end

function solverCGSA(Problem)
    D, fobj, bounds, max_evals = Problem()
    
    return CGSA(fobj, D; max_evals=max_evals, limits=bounds)
end

function test()
    problemSet = [problem1, problem2, problem3]
    
    solve(problemSet, solverECA)  
    
    solve(problemSet, solverJSO)

    solve(problemSet, solverCGSA)

    solve(problemSet, solverCMA)
end

test()