nt = 1000
seed = 99
ssm = acqr(0.8,1.5,2,3,0.5,2)
m = acqr_simula(ssm,nt,seed)
y = m["y"]

#######################
print("Testing acqr_em_starting: ")
ssm = acqr_em_starting(y)
if sum(ssm.c^2) > 1e-6
    println("OK")
end
