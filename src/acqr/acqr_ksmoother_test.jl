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
print("Testing acqr_ksmoother: ")
xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik = acqr_kfilter(y,a,c,q,r,x10,P10)
xtN,PtN,Pt1tN = acqr_ksmoother(a,xtt,Ptt,xtt1,Ptt1)
if sum(xtN.^2) > 1e-6
    println("OK")
end
