function dlyap(A,Q)

	# Solving Discrete LYAPunov equation using Silvester equation
	#
	# Sylvester equation A*X + X*B + C = 0
	# if B = -(A')^(-1), C = Q*(A')^(-1) 
	# => A*X - X*(A')^(-1) + Q*(A')^(-1) = 0 
	# => A*X*A' - X + Q = 0  -> Discrete Lyapunov equation

	Atinv = Array{Float64,2}(inv(A'))
	B = -Atinv
	C = Q*Atinv
	X = sylvester(A, B, C)
	
	return X
	
end

