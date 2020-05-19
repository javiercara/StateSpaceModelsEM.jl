function ABCDQR_simula(nt::Int,seed::Int)
	#
	# simulated model to test the functions
	#
	# nt: number of time instants
	# seed: seed for the random numbers

	# random seed
	# ------------------------------
	Random.seed!(seed)

	# simulated system
	m = simula01()

	# vibration parameters
	# ----------------------------
	# time interval (s)
	dt = m["dt"]

	# state-space matrices
	# --------------------------------------
	A = m["A"]
	B = m["B"]
	C = m["C"]
	D = m["D"]

	# input definition
	# ---------------------------------------
	# system input
	u = 100*randn(2,nt) # if 100 is not used, Q and R are too little

	# state equation, no noise
	# ---------------------------------
	x = zeros(4,nt)
	for t=1:nt-1
		x[:,t+1] = A*x[:,t] + B*u[:,t]
	end
	P = cov(x')
	Q = 0.01*P # std approx 0.1
	ch = cholesky(Q)
	w = ch.L*randn(4,nt)

	# state equation with noise
	# ------------------------------------------
	x = zeros(4,nt)
	for t = 1:nt-1
		x[:,t+1] = A*x[:,t] + B*u[:,t] + w[:,t]
	end

	# observation equation
	# -------------------------------------
	y = C*x + D*u
	L = cov(y')
	R = 0.01*L # std approx 0.1
	ch = cholesky(R)
	v = ch.L*randn(2,nt)
	y = y + v

	#
	S = cov(w',v')

	# starting values
	m1 = C\y[:,1:1]
	P1 = 0*A

	m = Dict("dt"=>dt,
	"y"=>y,"u"=>u,
	"A"=>A,"B"=>B,"C"=>C,"D"=>D,
	"Q"=>Q,"R"=>R,"S"=>S,
	"m1"=>m1,"P1"=>P1)

	return m

end
