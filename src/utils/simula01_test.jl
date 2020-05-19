print("Testing simula01: ")

m = simula01()

if sum((m["A"]).^2) > 1e-6
	println("OK")
end
