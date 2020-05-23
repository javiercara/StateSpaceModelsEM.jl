function acqr_kfilter(y,a,c,q,r,x10,P10)
	#
	# Kalman filter for model
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
	Ptt = zeros(nt)
	xtt1 = zeros(nt+1)
	Ptt1 = zeros(nt+1)
	et = zeros(nt)
	St = zeros(nt)
	Kt = zeros(nt)
	loglik = 0.0

	# Filter
	xtt1[1] = x10
	Ptt1[1] = P10
	for t in 1:nt
		#  innovations
		et[t] = y[t] - c*xtt1[t]
		St[t] = c^2*Ptt1[t] + r # et variance

		# Kalman gain
		Kt[t] = Ptt1[t]*c/St[t] # kalman gain

		# filtered values
		xtt[t] = xtt1[t] + Kt[t]*et[t]
		Ptt[t] = (1 - Kt[t]*c)*Ptt1[t]

		# one-step ahead prediction
		xtt1[t+1] = a*xtt[t]
		Ptt1[t+1] = a^2*Ptt[t] + q

		# likelihood
		#l0 = et[t]^2/St[t] # typeof(l0) = Array{Float64,1}
		loglik = loglik + log(St[t]) + et[t]^2/St[t]
	end

	loglik =  - nt/2*log(2*pi) - 0.5*loglik

	return xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik

end
