using Test
import CUTE


@testset "all" begin
	for name in CUTE.list_names()
		problem = CUTE.get_problem(name)
		@test try
			model = CUTE.get_model(problem.name)
			true
		catch
			false
		end
	end
end
