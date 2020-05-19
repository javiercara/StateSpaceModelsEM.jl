nt = 1000
seed = 99
m = ABCDQR_simula(nt,seed)
y = m["y"]
u = m["u"]
A = m["A"]
B = m["B"]
C = m["C"]
D = m["D"]
Q = m["Q"]
R = m["R"]
x10 = m["m1"]
P10 = m["P1"]

###########################
print("Testing ABCDQR_kfilter: ")
xtt,Ptt,xtt1,Ptt1,et,St,Kt,loglik = ABCDQR_kfilter(y,u,A,B,C,D,Q,R,x10,P10)
if sum(xtt.^2) > 1e-6
    println("OK")
end
