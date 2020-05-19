nt = 1000
seed = 99
m = ACQR_simula(nt,seed)
y = m["y"]

############################### starting point
wi = collect(range(0.1, length=2, stop=3))
Ai,Ci,Qi,Ri,Si,m1i,P1i = ACQR_em_starting(y,wi,1,true)

#######################
max_iter=10
tol=1e-6
txo=false
print("Testing ACQR_em: ")
A,C,Q,R,m1,P1,loglik,aic = ACQR_em(y,Ai,Ci,Qi,Ri,m1i,P1i,max_iter,tol,txo)
if sum(A.^2) > 1e-6
    println("OK")
end
