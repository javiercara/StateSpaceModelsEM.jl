# StateSpaceModelsEM

[![Travis](https://travis-ci.org/javiercara/StateSpaceModelsEM.jl.svg?branch=master)](https://travis-ci.org/javiercara/StateSpaceModelsEM.jl.svg?branch=master)

`StateSpaceModelsEM` is a Julia package to estimate State Space Models using the Expectation-Maximization algorithm.

The following models are included:

- The ACQR model:

      x_{t+1} = Ax_{t} + w_{t},   w_{t} -> N(0,Q)

      y_{t}   = Cx_{t} + v_{t},   v_{t} -> N(0,R)

      x_{1} -> N(m_{1},P_{1})

- The ABCDQR model:

      x_{t+1} = Ax_{t} + Bu_{t} + w_{t},   w_{t} -> N(0,Q)

      y_{t}   = Cx_{t} + Du_{t} + v_{t},   w_{t} -> N(0,Q)

      x_{1} -> N(m_{1},P_{1})

## Installation

To install the package:

```julia
julia> using Pkg; Pkg.add(PackageSpec(url="https://github.com/javiercara/StateSpaceModelsEM.jl", rev="master"))
```

## Author

* **Javier Cara**, javier.cara@upm.es, ETSI Industriales, Universidad Politecnica de Madrid (Spain).
