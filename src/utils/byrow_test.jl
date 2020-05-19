y1 = zeros(5)
y2 = zeros(5,2)
print("Testing byrow: ")
y1,ny1,nt1 = byrow(y1)
y2,ny2,nt2 = byrow(y2)
if (ny1 == 1) && (ny2 == 2)
	println("OK")
end

