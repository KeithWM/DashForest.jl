module DashForest

using Dash
using CSV
using DataFrames 
using JSON3

df = DataFrame([
        (climate = "Sunny", temperature = 13, city ="NYC"),
        (climate = "Snowy", temperature = 43, city ="Montreal"),
        (climate = "Sunny", temperature = 50, city ="Miami"),
        (climate = "Rainy", temperature = 30, city ="NYC")
])

include("Application.jl")
export create

end # module DashForest
