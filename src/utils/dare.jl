function dare(A,B,Q,R,S=0)
	# 
	# solves discrete-time algebraic Riccati equation
	# X = A'XA - (A'XB+S)(R+B'XB)^{-1}(B'XA+S') + Q
	#
	# R^{-1} is not computed
	#
	# javier.cara@upm.es, 2016-02 
	# 
	
	# Dimensions
	n,m = size(B)
	
	if S== 0
		S = zeros(n,m)
	end

	L = [A zeros(n,n) B;Q -Matrix(I, n, n) S;S' zeros(m,n) R]
	M = [Matrix(I, n, n) zeros(n,n) zeros(n,m); zeros(n,n) -A' zeros(n,m);zeros(m,n) -B' zeros(m,m)]

	# Compute the eigenvalue decomposition
	(d,v) = eigen(L,M)
	
	# Sort the eigenvalues
	ew = abs.(d)
	pos = sortperm(ew)

	# Compute X
	v1 = v[1:n,pos[1:n]]
	v2 = v[n+1:2*n,pos[1:n]]
	X = real(v2/v1)
	
	return X

end

