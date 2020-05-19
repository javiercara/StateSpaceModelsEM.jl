nt = 1000
seed = 99
m = ABCDQR_simula(nt,seed)
y = m["y"]
u = m["u"]

############################### starting point
wi = collect(range(0.1, length=2, stop=3))
Ai,Bi,Ci,Di,Qi,Ri,Si,m1i,P1i = ABCDQR_em_starting(y,u,wi,1,true)

#######################
max_iter=10
tol=1e-6
txo=false
print("Testing ABCDQR_em: ")
A,B,C,D,Q,R,m1,P1,loglik,aic = ABCDQR_em(y,u,Ai,Bi,Ci,Di,Qi,Ri,m1i,P1i,max_iter,tol,txo)
if sum(A.^2) > 1e-6
    println("OK")
end
