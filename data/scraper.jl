import HTTP
# https://github.com/blegat/TableScraper.jl/tree/refactor
import TableScraper
import CSV
import Gumbo
using DataFrames

url = "https://arnold-neumaier.at/glopt/coconut/Benchmark/Library2_new_v1.html"

response = HTTP.get(url)
@assert response.status == 200
s = String(response.body)
html = Gumbo.parsehtml(s)
rows = TableScraper.scrape_tables(html)[1].rows
mat = permutedims(reduce(hcat, rows[9:end]))
df = DataFrame(mat[2:end, 1:end-1], mat[1, 1:end-1])
CSV.write("collection.csv", df)
