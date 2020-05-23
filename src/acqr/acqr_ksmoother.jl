function acqr_ksmoother(a,xtt,Ptt,xtt1,Ptt1)
	#
	# Kalman smoother for model
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
	PtN = zeros(nt+1)
	Pt1tN = zeros(nt)

	# values for t = nt+1
	xtN[nt+1] = xtt1[nt+1]
	PtN[nt+1] = Ptt1[nt+1]

	# values for t=nt
	xtN[nt] = xtt[nt]
	PtN[nt] = Ptt[nt]
	Pt1tN[nt] = a*Ptt[nt]

	# smother
	for t = nt-1:-1:1
		# Kalman Smoother matrix J
		Jt = (Ptt[t]*a) / Ptt1[t+1]

		xtN[t] = xtt[t] + Jt*( xtN[t+1] - xtt1[t+1] )
		PtN[t] = Ptt[t] + Jt^2*( PtN[t+1] - Ptt1[t+1] )

		Pt1tN[t] = PtN[t+1]*Jt
	end

	return xtN,PtN,Pt1tN

end
