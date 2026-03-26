using Test
import CUTEJuMP


@testset "all" begin
	for name in CUTEJuMP.list_names()
		problem = CUTEJuMP.get_problem(name)
		@testset "$name" begin
			@test try
				model = CUTEJuMP.get_model(problem.name)
				true
			catch e
				println(e)
				false
			end
		end
	end
end
