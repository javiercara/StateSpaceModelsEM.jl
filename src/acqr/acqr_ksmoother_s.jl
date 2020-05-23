function acqr_ksmoother_s(a,xtt,Ptt,xtt1,Ptt1)
	#
	# STATIONARY Kalman smoother for model
	#
	# x_{t+1} = ax_{t} + w_{t}
	# y_{t}   = cx_{t} + v_{t}
	#
	# cov(w_{t},v_{t}) = [q 0;0 r]
	#
	# javier.cara@upm.es, 2020-05
	#

	nt = length(xtt)

	# allocation
	xtN = zeros(nt+1)

	# values for t = nt+1
	xtN[nt+1] = xtt1[nt+1]

	# values for t=nt
	xtN[nt] = xtt[nt]

	# Kalman Smoother matrix J
	Jt = (Ptt*a) / Ptt1

	# PtN = Ptt + Jt^2*(PtN - Ptt1) =>
	PtN =  (Ptt - Jt^2*Ptt1)/(1-Jt^2)
	Pt1tN = PtN*Jt

	# smother
	for t = nt-1:-1:1
		xtN[t] = xtt[t] + Jt*( xtN[t+1] - xtt1[t+1] )
	end

	return xtN,PtN,Pt1tN

end
