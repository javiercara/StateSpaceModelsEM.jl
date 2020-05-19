nt = 1000
seed = 99
m = ACQR_simula(nt,seed)
y = m["y"]

#######################
print("Testing ACQR_em_starting: ")
wi = collect(range(0.1, length=3, stop=3))
Ai,Ci,Qi,Ri,Si,m1i,P1i = ACQR_em_starting(y,wi,1,true)
if sum(Ai.^2) > 1e-6
    println("OK")
end
