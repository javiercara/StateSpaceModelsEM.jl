function ACQR_simula(nt::Int, seed::Int)
	#
	# simulated model to test the functions
	#
	# nt: number of time instants
	# seed: seed for the random numbers

	# random seed
	# ------------------------------
	Random.seed!(seed)

	# simulated system
	# ----------------------------
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
	u = 100*randn(2,nt) # if 100 is not used, Q and R are too small

	# state equation, no noise
	# ---------------------------------
	x = zeros(4,nt)
	w = B*u
	for t=1:nt-1
		x[:,t+1] = A*x[:,t] + w[:,t]
	end
	Q = cov(w')

	# observation equation
	# -------------------------------------
	v = D*u
	y = C*x + v

	# covariance matrices
	Q = cov(w')
	R = cov(v')
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
