using Random
using Statistics
using Printf

mutable struct acqr
    a::Float64
    c::Float64
    q::Float64
    r::Float64
    m1::Float64
    P1::Float64
end
#
struct acqrEM
    y::Array{Float64,1}
    start::acqr
    fit::acqr
    loglik::Array{Float64,1}
    aic::Float64
    s::Bool
end
#
struct acqrKal
    y::Vector{Float64}
    model::acqr
    prediction
    predictionCov
    filter
    filterCov
    smoother
    smootherCov
    s::Bool
end


include("acqr_simula.jl")
include("acqr_kfilter.jl")
include("acqr_ksmoother.jl")
include("acqr_em_starting.jl")
include("acqr_em.jl")
include("acqr_kfilter_s.jl")
include("acqr_ksmoother_s.jl")
include("acqr_em_s.jl")
include("acqr_kalman.jl")
