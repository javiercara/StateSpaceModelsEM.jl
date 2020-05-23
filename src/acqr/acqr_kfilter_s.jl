function acqr_kfilter_s(y,a,c,q,r,x10)
	#
	# STATIONARY Kalman filter for model
	#
	# x_{t+1} = a*x_{t} + w_{t}
	# y_{t}   = c*x_{t} + v_{t}
	#
	# cov(w_{t},v_{t}) = [q 0;0 r]
	#
	# javier.cara@upm.es, 2020-05
	#

	nt = length(y)

	# allocation
	xtt = zeros(nt)
	xtt1 = zeros(nt+1)
	et = zeros(nt)
	loglik = 0.0

	# Stationary solution for Ptt1
	# p = a^2p - (acp)^2/(c^2p+r) + q
	A = c^2
	B = r - a^2*r  - c^2*q
	C = -q*r
	Ptt1 = (-B + sqrt(B^2 - 4*A*C))/(2*A)

	# variance of innovations
	St = c^2*Ptt1 + r

	# Kalman gain matrix
	Kt = Ptt1*c/St

	# Var[x_t|y_t]
	Ptt = (1 - Kt*c)*Ptt1

	# Filter
	xtt1[1] = x10
	for t in 1:nt
		#  innovations
		et[t] = y[t] - c*xtt1[t]

		# filtered values
		xtt[t] = xtt1[t] + Kt*et[t]

		# one-step ahead prediction
		xtt1[t+1] = a*xtt[t]

		# likelihood
		#l0 = et[t]^2/St[t] # typeof(l0) = Array{Float64,1}
		loglik = loglik  + et[t]^2/St
	end

	loglik =  - nt/2*log(2*pi) - nt/2*log(St) - 0.5*loglik

	return xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik

end
