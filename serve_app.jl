using DashForest: create, run_server

app = create()

import JSON3
json3ify(x) = JSON3.read(JSON3.write(x))
dash_callback_call(cb, args...) = cb(json3ify.(args)...)

# @show app.layout.children[1].data |> size
# dash_callback_call(DashForest.addrow_callback, 1, app.layout.children[1].data, app.layout.children[1].columns)
# @show app.layout.children[1].data |> size

run_server(app, "0.0.0.0", debug=true)
