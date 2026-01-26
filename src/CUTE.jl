module CUTE

export list_names
export get_problem
export get_all_problems
export get_model

import CSV
import DataFrames as DF
import JuMP

const COLLECTION = CSV.read(joinpath(@__DIR__, "..", "data", "collection.csv"), DF.DataFrame)

list_names()::Vector{String} = Vector{String}(COLLECTION[:, "Problem"])

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


function get_problem(name::AbstractString)::Problem
	idx = findfirst(==(name), COLLECTION[:, "Problem"])

	sol = COLLECTION[idx, "Fbest"]
	Fbest = nothing
	if !ismissing(sol)
		Fbest = tryparse(Float64, String(sol))
	end

	number = COLLECTION[idx, "Number"]
	classification = COLLECTION[idx, "Classification"]
	N = COLLECTION[idx, "N"]
	M = COLLECTION[idx, "M"]
	Nnl = COLLECTION[idx, "Nnl"]
	Mnl = COLLECTION[idx, "Mnl"]
	Nz = COLLECTION[idx, "Nz"]

    return Problem(number, name, classification, N, M, Nnl, Mnl, Nz, Fbest)
end

function get_all_problems()::Vector{Problem}
	ret = Vector{Problem}()

	for idx in eachindex(COLLECTION[:, 1])
		sol = COLLECTION[idx, "Fbest"]
		Fbest = nothing
		if !ismissing(sol)
			Fbest = tryparse(Float64, String(sol))
		end

		name = String(COLLECTION[idx, "Problem"])
		number = COLLECTION[idx, "Number"]
		classification = COLLECTION[idx, "Classification"]
		N = COLLECTION[idx, "N"]
		M = COLLECTION[idx, "M"]
		Nnl = COLLECTION[idx, "Nnl"]
		Mnl = COLLECTION[idx, "Mnl"]
		Nz = COLLECTION[idx, "Nz"]

		push!(ret, Problem(number, name, classification, N, M, Nnl, Mnl, Nz, Fbest))
	end

	return ret
end


function load_nl_file(path::AbstractString)::JuMP.Model
	model = JuMP.read_from_file(path; use_nlp_block = false)
	return model
end

function get_model(name::AbstractString)::JuMP.Model
	if !(name in COLLECTION[:, "Problem"])
		throw(error("'$name' is not a valid CUTE problem name. For reference, visit https://arnold-neumaier.at/glopt/coconut/Benchmark/Library2_new_v1.html"))
	end
	try
		load_nl_file(joinpath(@__DIR__, "..", "data", "NL", "$(name).nl"))
	catch
		throw(error("This model cannot be loaded by the current version of the NL file parser"))
	end
end

end
