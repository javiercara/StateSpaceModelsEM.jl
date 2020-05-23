print("Testing acqr_simula: ")
nt = 1000
seed = 99
m = acqr_simula(nt,seed)
y = m["y"]

if sum(y.^2) > 1e-6
	println("OK")
end
