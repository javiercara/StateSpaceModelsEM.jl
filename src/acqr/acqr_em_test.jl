nt = 1000
seed = 99
m = acqr_simula(nt,seed)
y = m["y"]

#######################
start = acqr(0.5,0.5,1,1,0,0)
print("Testing acqr_em: ")
m1 = acqr_em(y,start,max_iter=10)
if sum(m1.fit.a^2) > 1e-6
    println("OK")
end
