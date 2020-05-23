nt = 1000
seed = 99
m = acqr_simula(nt,seed)
y = m["y"]

#######################
print("Testing acqr_em_starting: ")
ai,ci,qi,ri,m1i,P1i = acqr_em_starting(y)
if sum(ai^2) > 1e-6
    println("OK")
end
