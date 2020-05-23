function acqr_kalman(m::acqrEM)

	# parameters
	a = m.fit.a
	c = m.fit.c
	q = m.fit.q
	r = m.fit.r
	m1 = m.fit.m1
	P1 = m.fit.P1

    if m.s
        # stationary
        (xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik) = acqr_kfilter_s(y,a,c,q,r,m1)
		(xtN,PtN,Pt1tN) = acqr_ksmoother_s(a,xtt,Ptt,xtt1,Ptt1)
	else
		(xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik) = acqr_kfilter(y,a,c,q,r,m1,P1)
		(xtN,PtN,Pt1tN) = acqr_ksmoother(a,xtt,Ptt,xtt1,Ptt1)
	end

	salida = acqrKal(m,xtt1,Ptt1,xtt,Ptt,xtN,PtN)

	return salida
end
