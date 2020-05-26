function acqr_em_starting(y)
    """
    computing the starting point for the em algorithm for acQR model

    y: time series

    javier.cara@upm.es, 2020-05
    """

    #
    nt = length(y)

    # least squares for c
    # ya = c*yb + v
    ya = y[2:nt]
    yb = y[1:nt-1]
    c = sum(ya.*yb)/sum(yb.^2)

    # noise
    v = ya - c*yb
    r = var(v)

    #
    a = 0.5 # must be < 1

    # noise
    w = ya - a*yb
    q = var(w)

    # first state
    m1 = y[1]/c
    P1 = 1

    return acqr(a,c,q,r,m1,P1)
end
