function acqr_em_starting(y)
    """
    computing the starting point for the em algorithm for acQR model

    y: time series

    javier.cara@upm.es, 2020-05
    """

    #
    nt = length(y)

    # least squares for a
    # ya = a*yb + w
    ya = y[2:nt]
    yb = y[1:nt-1]
    a = sum(ya.*yb)/sum(yb.^2)

    # noise
    w = ya - a*yb
    q = var(w)

    #
    c = 1
    r = 0.001*q

    # first state
    m1 = y[1]
    P1 = 0

    return a,c,q,r,m1,P1
end
