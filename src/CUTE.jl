module CUTE

import CSV
import DataFrames as DF
import JuMP

const COLLECTION = CSV.read(joinpath(@__DIR__, "..", "data", "collection.csv"), DF.DataFrame)

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


function load_nl_file(path::AbstractString)::JuMP.Model
	model = JuMP.read_from_file(path; use_nlp_block = false)
	return model
end

function get_model(name::AbstractString)::JuMP.Model
		load_nl_file(joinpath(@__DIR__, "..", "data", "NL", "$(name).nl"))
end

end
