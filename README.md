# CUTEJuMP.jl

This package provides a [JuMP](https://jump.dev) interface to the [CUTE](https://arnold-neumaier.at/glopt/coconut/Benchmark/Library2_new_v1.html) optimisation problem set.


## Installation

To install, simply run

```
pkg> add https://github.com/GiovanniKarra/CUTEJuMP.jl.git
```

Maybe soon it will be available as a full Julia package :)


## Usage

To get the full collection of CUTEJuMP problems :

```julia
import CUTEJuMP

problems = CUTEJuMP.get_all_problems()
```

where `problems` is a `Vector` of `Problem`

```julia
struct Problem
	number::Int;
	name::String;
	classification::String;
	N::Int;
	M::Int;
	Nnl::Int;
	Mnl::Int;
	Nz::Int;
	best_obj::Union{Float64, Nothing};
end
```

To get a specific problem :

```julia
import CUTEJuMP

problem = CUTEJuMP.get_problem("3pk")
```

And to get the `JuMP` model :

```julia
import CUTEJuMP

problem = CUTEJuMP.get_problem("3pk")
model = CUTEJuMP.get_model(problem.name)  # Or simply CUTEJuMP.get_model("3pk")
```
