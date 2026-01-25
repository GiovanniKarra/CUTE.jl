import CSV
import HTTP
using DataFrames


df = CSV.read("collection.csv", DataFrame)

url = "https://vanderbei.princeton.edu/ampl/nlmodels/cute/"
for name in df[!, "Problem"]
	response = HTTP.get("$(url)$(name).mod")
	@assert response.status == 200
	s = String(response.body)
	write("AMPL/$(name).mod", s)
end
