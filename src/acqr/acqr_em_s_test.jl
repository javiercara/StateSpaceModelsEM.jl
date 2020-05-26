nt = 1000
seed = 99
ssm = acqr(0.8,1.5,2,3,0.5,2)
m = acqr_simula(ssm,nt,seed)
y = m["y"]

#######################
start = acqr(0.5,0.5,1,1,0,0)
print("Testing acqr_em_s: ")
m1 = acqr_em_s(y,start,max_iter=10)
if sum(m1.fit.a^2) > 1e-6
    println("OK")
end
