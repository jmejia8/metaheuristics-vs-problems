using CEC17, Mechanisms

function problemsCEC17(D::Int, fnum::Int)

    fobj(x::Array{Float64}) = cec17_test_func(x, fnum)

    bounds = [-100.0, 100.0]
    max_evals = 10000D

    return D, fobj, bounds, max_evals, fnum
end

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
    return D, fobj, bounds, max_evals, 1
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
    return D, fobj, bounds, max_evals,2
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
    return D, fobj, bounds, max_evals,3
end

function problemControl()
    D, fobj = getDynamicOptimizationProblem()
    return D, fobj, [0.1ones(D) 50ones(D)]', 10000,4
end