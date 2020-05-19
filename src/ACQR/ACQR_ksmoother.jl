function ACQR_ksmoother(A,xtt,Ptt,xtt1,Ptt1)
	# 
	# Kalman smoother for model
	# 
	# x_{t+1} = Ax_{t} + w_{t}
	# y_{t}   = Cx_{t} + v_{t}
	# 
	# cov(w_{t},v_{t}) = [Q 0;0 R]
	#
	# javier.cara@upm.es, 2016-02
	# 
	
	nx,nt = size(xtt)

	# allocation
	xtN = zeros(nx,nt+1)
	PtN = zeros(nx,nx,nt+1)
	Pt1tN = zeros(nx,nx,nt)

	# values for t = nt+1
	xtN[:,nt+1] = xtt1[:,nt+1]
	PtN[:,:,nt+1] = Ptt1[:,:,nt+1]

	# values for t=nt
	xtN[:,nt] = xtt[:,nt]
	PtN[:,:,nt] = Ptt[:,:,nt]
	Pt1tN[:,:,nt] = A*Ptt[:,:,nt]

	# smother
	for t = nt-1:-1:1
		# Kalman Smoother matrix J
		Jt = (Ptt[:,:,t]*A') / Ptt1[:,:,t+1]

		xtN[:,t] = xtt[:,t] + Jt*( xtN[:,t+1] - xtt1[:,t+1] )
		PtN[:,:,t] = Ptt[:,:,t] + Jt*( PtN[:,:,t+1] - Ptt1[:,:,t+1] )*Jt'

		Pt1tN[:,:,t] = PtN[:,:,t+1]*Jt'
	end
	
	return xtN,PtN,Pt1tN
	
end

