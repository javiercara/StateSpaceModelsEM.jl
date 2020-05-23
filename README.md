# StateSpaceModelsEM

[![Travis](https://travis-ci.org/javiercara/StateSpaceModelsEM.jl.svg?branch=master)](https://travis-ci.org/javiercara/StateSpaceModelsEM.jl.svg?branch=master)

`StateSpaceModelsEM` is a Julia package to estimate State Space Models using the Expectation-Maximization algorithm.

The following models are included:

- The **acqr** model:

      x_{t+1} = ax_{t} + w_{t},   w_{t} -> N(0,q)

      y_{t}   = cx_{t} + v_{t},   v_{t} -> N(0,r)

      x_{1} -> N(m_{1},P_{1})
      
      a,c,q,r \in R

- The ACQR model:

      x_{t+1} = Ax_{t} + w_{t},   w_{t} -> N(0,Q)

      y_{t}   = Cx_{t} + v_{t},   v_{t} -> N(0,R)

      x_{1} -> N(m_{1},P_{1})

      A \in R^{nx,nx}, C \in R^{ny,nx}, Q \in R^{nx,nx}, R \in R^{ny,ny}

- The ABCDQR model:

      x_{t+1} = Ax_{t} + Bu_{t} + w_{t},   w_{t} -> N(0,Q)

      y_{t}   = Cx_{t} + Du_{t} + v_{t},   w_{t} -> N(0,R)

      x_{1} -> N(m_{1},P_{1})

## Installation

To install the package:

```julia
julia> using Pkg; Pkg.add(PackageSpec(url="https://github.com/javiercara/StateSpaceModelsEM.jl", rev="master"))
```

## Author

* **Javier Cara**, javier.cara@upm.es, ETSI Industriales, Universidad Politecnica de Madrid (Spain).
