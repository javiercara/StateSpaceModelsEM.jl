nt = 1000
seed = 99
ssm = acqr(0.8,1.5,2,3,0.5,2)
m = acqr_simula(ssm,nt,seed)
y = m["y"]
a = ssm.a
c = ssm.c
q = ssm.q
r = ssm.r
x10 = ssm.m1
P10 = ssm.P1

###########################
print("Testing acqr_kalman: ")
start = acqr(0.5,0.5,1,1,0,0)
me = acqr_em_s(y,start,max_iter=10)
mk = acqr_kalman(y,me.fit,s=true)
if sum(mk.prediction.^2) > 1e-6
    println("OK")
end
