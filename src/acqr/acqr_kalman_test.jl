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
print("Testing acqr_kalman: ")
start = acqr(0.5,0.5,1,1,0,0)
me = acqr_em_s(y,start,max_iter=10)
mk = acqr_kalman(me)
if sum(mk.pred.^2) > 1e-6
    println("OK")
end
