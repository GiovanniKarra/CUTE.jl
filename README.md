# CUTE.jl

This package provides a [JuMP](https://jump.dev) interface to the [CUTE](https://arnold-neumaier.at/glopt/coconut/Benchmark/Library2_new_v1.html) optimisation problem set.


## Installing

To install, simply run

```pkg> add https://github.com/GiovanniKarra/CUTE.jl.git```

Maybe soon it will be available as a full Julia package :)


## Usage

To get the full collection of CUTE problems :

```julia
import CUTE

problems = CUTE.get_all_problems()
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
import CUTE

problem = CUTE.get_problem("3pk")
```

And to get the `JuMP` model :

```julia
import CUTE

problem = CUTE.get_problem("3pk")
model = CUTE.get_model(problem.name)  # Or simply CUTE.get_model("3pk")
```
