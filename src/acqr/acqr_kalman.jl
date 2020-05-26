function acqr_kalman(y,m::acqr;s::Bool=true)

	# parameters
	a = m.a
	c = m.c
	q = m.q
	r = m.r
	m1 = m.m1
	P1 = m.P1

    if s
        # stationary
        (xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik) = acqr_kfilter_s(y,a,c,q,r,m1)
		(xtN,PtN,Pt1tN) = acqr_ksmoother_s(a,xtt,Ptt,xtt1,Ptt1)
	else
		(xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik) = acqr_kfilter(y,a,c,q,r,m1,P1)
		(xtN,PtN,Pt1tN) = acqr_ksmoother(a,xtt,Ptt,xtt1,Ptt1)
	end

	salida = acqrKal(y,m,xtt1,Ptt1,xtt,Ptt,xtN,PtN,s)

	return salida
end
