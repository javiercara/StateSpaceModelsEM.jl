function simula01()
	#
	# simulated model to test the functions
	#
	# simulated mechanical system
	#
	# |    k1    ------     k2    ------
	# |---###---|  m1  |---###---|  m2  |
	# |    c1    ------     c2    ------
	# |           @  @             @  @
	# |========================================
	#
    # javier.cara@upm.es, 2018-04-16

	# time step
	dt = 0.02

	# matrices for the mechanical system M-K-G
	# ----------------------------------------
	# mass matrix
	m1 = 35
	m2 = 17.5
	M = [m1 0;0 m2]
	Minv = [1/m1 0;0 1/m2] # inv(M)

	# stiffness matrix
	k1 = 8750
	k2 = 3500
	K = [k1+k2 -k2;-k2 k2]
	# theoretical natural frecuencies: 1.71 Hz, 3.31 Hz

	# eigenvalues and eigenvectors
	D,V = eigen(K,M)
	W = sqrt.(D) # modal frequencies rad/s

	# modal matrices
	Mm = V'*M*V
	Km = V'*K*V

	# damping ratios
	zm = [0.02, 0.02]

	# modal damping matrix
	Gm = zeros(2,2)
	for i in 1:2
		Gm[i,i] = 2*sqrt(Mm[i,i]*Km[i,i])*zm[i]
	end

	# damping matrix
	G = (V')\Gm/V

	# matrices for the discrete state space model
	# --------------------------------------------------------------
	# Matrix A
	Ac = [zeros(2,2) Matrix{Float64}(I,2,2);-Minv*K -Minv*G] # Continuous Matrix A
	A = exp(Ac*dt) # discrete Matrix A

	# Matrix C (continuous = discrete)
	C = [-Minv*K -Minv*G]

	# Matrix B
	# Js is the input location matrix
	J = Matrix{Float64}(I,2,2)
	Bc = [zeros(2,2);Minv*J] # continuous matrix B
	B = (A - Matrix{Float64}(I,4,4))*inv(Ac)*Bc # discrete matrix B

	# matrix D (continuous = discrete)
	D = Minv*J

	# eigenvectors with maximum component = 1
	V1 = zeros(2,2)
	for j in 1:2
		maxval = V[1,j]
		if abs(V[2,j]) > abs(maxval)
			maxval = V[2,j]
		end
		V1[:,j] = V[:,j]/maxval
	end
	# modal masses corresponding to V1
	Mm1 = V1'*M*V1
	mm1 = diag(Mm1)

	m = Dict("dt"=>dt,"M"=>M,"K"=>K,"G"=>G,
	"wm"=>W,"zm"=>zm,"Vm"=>V1,"mm"=>mm1,
	"A"=>A,"B"=>B,"C"=>C,"D"=>D
	)

	return m
end
