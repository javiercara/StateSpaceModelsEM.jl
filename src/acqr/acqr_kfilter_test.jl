nt = 1000
seed = 99
m = acqr_simula(nt,seed)
y = m["y"]
a = m["a"]
c = m["c"]
q = m["q"]
r = m["r"]
x10 = m["m1"]
P10 = m["P1"]

###########################
print("Testing acqr_kfilter: ")
xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik = acqr_kfilter(y,a,c,q,r,x10,P10)
if sum(xtt.^2) > 1e-6
    println("OK")
end
