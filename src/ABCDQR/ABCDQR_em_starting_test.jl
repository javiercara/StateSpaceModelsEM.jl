nt = 1000
seed = 99
m = ABCDQR_simula(nt,seed)
y = m["y"]
u = m["u"]

#######################
print("Testing ABCDQR_em_starting: ")
wi = collect(range(0.1, length=2, stop=3))
Ai,Bi,Ci,Di,Qi,Ri,Si,m1i,P1i = ABCDQR_em_starting(y,u,wi,1,true)
if sum(Ai.^2) > 1e-6
    println("OK")
end
