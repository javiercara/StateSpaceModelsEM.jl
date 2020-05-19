nt = 1000
seed = 99
m = ACQR_simula(nt,seed)
y = m["y"]
A = m["A"]
C = m["C"]
Q = m["Q"]
R = m["R"]
x10 = m["m1"]
P10 = m["P1"]

#######################
print("Testing ACQR_kfilter_s: ")
xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik = ACQR_kfilter_s(y,A,C,Q,R,x10)
if sum(xtt.^2) > 1e-6
    println("OK")
end
########################
