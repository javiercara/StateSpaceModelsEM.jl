function acqr_simula(nt::Int, seed::Int)
	#
	# simulated model to test the functions
	#
	# nt: number of time instants
	# seed: seed for the random numbers

	# random seed
	# ------------------------------
	Random.seed!(seed)

	# state-space system
	# --------------------------------------
	a = 0.8
	c = 1
	ts = 0.01 # sampling time

	# state equation, no noise
	# ---------------------------------
	q = 2
	w = sqrt(q)*randn(nt)
	x = zeros(nt)
	for t=1:nt-1
		x[t+1] = a*x[t] + w[t]
	end

	# observation equation
	# -------------------------------------
	r = 3
	v = sqrt(r)*randn(nt)
	y = c*x + v

	# starting values
	m1 = y[1]/c
	P1 = 0
	
	m = Dict("ts"=>ts,
	"y"=>y,"x"=>x,
	"w"=>w,"v"=>v,
	"a"=>a,"c"=>c,
	"q"=>q,"r"=>r,
	"m1"=>m1,"P1"=>P1)

	return m
end
