function acqr_simula(m::acqr, nt::Int, seed::Int)
	#
	# simulated model to test the functions
	#
	# nt: number of time instants
	# seed: seed for the random numbers

	# random seed
	# ------------------------------
	Random.seed!(seed)

	# state equation, no noise
	# ---------------------------------
	w = sqrt(m.q)*randn(nt) # w ~ N(0,q)
	x = zeros(nt)
	x[1] = m.m1 + sqrt(m.P1)*randn() # x1 ~ N(m1,P1)
	for t=1:nt-1
		x[t+1] = m.a*x[t] + w[t]
	end

	# observation equation
	# -------------------------------------
	v = sqrt(m.r)*randn(nt) # v ~ N(0,r)
	y = m.c*x + v

	salida = Dict(
	"y"=>y,"x"=>x,
	"w"=>w,"v"=>v)

	return salida
end
