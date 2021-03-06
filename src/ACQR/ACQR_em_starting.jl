function ACQR_em_starting(y,wi,dt=1,odd = false)
    """
    computing the starting point for the em algorithm for ACQR model

    y: time series
    dt: time step

    wi muxt be > 0 and < Nyquist frequency (pi/dt)
    Ai = exp([0 1;-wi^2 -0.1*wi]) => nx is even = 2*length(wi)


    javier.cara@upm.es, 2020-05
    """

    ###byrow
    y,ny,nt = byrow(y)

    # size
    if odd
        nx = 2*length(wi) + 1
    else
        nx = 2*length(wi)
    end

    if ny == 1
        ym = y
    else
        ym = mean(y,dims = 1)
    end

    # X = [y_{t-1} y_{t-2} ... y_{nt-1}]'
    # X1 = [y_{t} y_{t-1} ... y_{nt}]'
    X = zeros(nx,nt-nx)
    X1 = zeros(nx,nt-nx)
    for k = 1:nx
        X[k,:] = ym[nx-k+1:nt-k]
        X1[k,:] = ym[nx-k+2:nt-k+1]
    end

    # least squares for matrix C
    C = (y[:,nx:(nt-1)]*X')/(X*X')
    C = Matrix(C)

    # noise
    V = y[:,(nx+1):nt] - C*X
    R = cov(V')

    # least squares for matrix A (it doesn't work)
    #A = (X1*X')/(X*X')

    A = zeros(nx,nx)
    for i = 1:length(wi)
        A[2*(i-1)+1,2*i] = 1
        A[2*i,2*(i-1)+1] = -wi[i]^2
        A[2*i,2*i] = -0.1*wi[i]
    end
    if odd
        A[nx,nx] = -0.1/dt
    end
    A = exp(A*dt)

    # noise
    W = X1 - A*X
    Q = cov(W')

    # noise covariance
    S = cov(W',V')

    # first state
    m1 = C\y[:,1:1]
    P1 = zeros(nx,nx)

    return A,C,Q,R,S,m1,P1
end
