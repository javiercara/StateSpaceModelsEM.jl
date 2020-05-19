
#=
BibText
@TECHREPORT{Benner95acollection,
author = {Peter Benner and Alan J. Laub and Volker Mehrmann},
title = {A Collection of Benchmark Examples for the Numerical Solution of
Algebraic Riccati Equations II: Discrete-Time Case},
institution = {FAK. F. MATHEMATIK, TU CHEMNITZ--ZWICKAU},
year = {1995}
}
    
=#

# ------------------------------------------------------------------
# ejm1 collection of benchmark examples
A1 = [4. 3.;-4.5 -3.5]
B1 = [1. -1]'
R1 = 1.
Q1 = [9. 6.;6. 4.]
X1 = (1+sqrt(5))/2*[9 6;6 4] # theoretical solucion

X11 = dare(A1,B1,Q1,R1) # computed solution
    
# --------------------------------------------------------------------
# ejm computed with mathematica
Am = [1. -1 1;0 1 1;0 0 1]
Bm = [1. 0;1 0;0 1]
Rm = [10 0;0 0.1]
Qm = [10 0 0;0 1 0;0 0 0.1]
Xm = [42.2835 -68.5247 -3.94783;-68.5247 154.043 16.0017;-3.94783 16.0017 8.33197] # mathematica solution
    
Xmm = dare(Am,Bm,Qm,Rm) # computed solution
    
#####
    

print("Testing dare: ")
if (sum((X1-X11).^2) < 1e-6) && (sum((Xm-Xmm).^2) < 1e-6)
	println("OK")
end
