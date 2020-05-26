print("Testing acqr_simula: ")
nt = 1000
seed = 99
ssm = acqr(0.8,1.5,2,3,0.5,2)
m = acqr_simula(ssm,nt,seed)
y = m["y"]

if sum(y.^2) > 1e-6
	println("OK")
end
