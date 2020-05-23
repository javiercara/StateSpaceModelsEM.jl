nt = 1000
seed = 99
m = acqr_simula(nt,seed)
y = m["y"]
a = m["a"]
c = m["c"]
q = m["q"]
r = m["r"]
x10 = m["m1"]

###########################
print("Testing acqr_ksmoother_s: ")
xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik = acqr_kfilter_s(y,a,c,q,r,x10)
xtN,PtN,Pt1tN = acqr_ksmoother_s(a,xtt,Ptt,xtt1,Ptt1)
if sum(xtN.^2) > 1e-6
    println("OK")
end
