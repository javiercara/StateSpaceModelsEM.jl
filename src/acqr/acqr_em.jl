function acqr_em(y,start::acqr;
	ae = true, ce = true, qe = true, re = true,
	max_iter = 100,tol = 1e-09,txo = false)
	#
	# estimate a, c, Q, R, m1, P1 using the EM algorithm for model
	#
	# x_{t+1} = a*x_{t} + w_{t}
	# y_{t}   = c*x_{t} + v_{t}
	#
	# cov(w_{t},v_{t}) = [q 0;0 r]
	# x1 -> N(m1,P1)
	#
	# javier.cara@upm.es, 2020-05
	#

	#
	nt = length(y)

	# initial values
	a = start.a
	c = start.c
	q = start.q
	r = start.r
	m1 = start.m1
	P1 = start.P1

	# log-likelihood values
	loglikv = zeros(max_iter)

	# Syy does not depend on the iterations
	Syy = sum(y.^2)

	tol1 = 1.0
	iter = 1
	while (iter <= max_iter) && (tol1 > tol)
		time1 = time()

		# E-step
		# ---------------------------------------------------------------------------------
		# Kalmanfilter
		(xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik) = acqr_kfilter(y,a,c,q,r,m1,P1)
		(xtN,PtN,Pt1tN) = acqr_ksmoother(a,xtt,Ptt,xtt1,Ptt1)

		loglikv[iter] = loglik
		if iter > 1
			tol1 = abs( (loglikv[iter] - loglikv[iter-1])/loglikv[iter-1] )
		end

		# Sxx, Sx1x, Syx, Sx1x1
		Sxx = sum(PtN[1:nt]) + sum(xtN[1:nt].^2)
		Sx1x = sum(Pt1tN[1:nt]) + sum(xtN[2:nt+1].*xtN[1:nt])
		Syx = sum(y.*xtN[1:nt])
		Sx1x1 = Sxx - (PtN[1] + xtN[1]^2) + (PtN[nt+1] + xtN[nt+1]^2)

		# M-step
		# -------------------------------------------------------------------------------------
		# Matrices m1 y P1
		m1 = xtN[1]
		P1 = PtN[1]

		# parameter a
		if ae
			a = Sx1x/Sxx
		end

		# parameter q
		if qe
			q = Sx1x1 - 2*a*Sx1x + a^2*Sxx
			q = 1/nt*q
		end

		# parameter c
		if ce
			c = Syx/Sxx
		end

		# parameter r
		if re
			r = Syy - 2*c*Syx + c^2*Sxx
			r = 1/nt*r
		end

		etime = time() - time1
		if txo
			println( "Iter " * @sprintf("%3d",iter) * ",   @time = " * @sprintf("%.2E",etime) * ",   logLik = " * @sprintf("%.6E",loglik) * ",   tol = ", @sprintf("%.2E",tol1) )
		end

		iter += 1

	end

	loglikv = loglikv[1:(iter-1)]

	# Akaike Information Criterion
	P = 4
	aic = -2*loglikv[end] + 2*P

	# output
	fit = acqr(a,c,q,r,m1,P1)
	salida = acqrEM(y,start,fit,loglikv,aic,false)
	return salida

end
