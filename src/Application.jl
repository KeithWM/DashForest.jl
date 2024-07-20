function create()
    app = dash()
    
    app.layout = html_div([
        # html_div([
        #     dcc_input(
        #         id="adding-rows-name",
        #         placeholder="Enter a column name...",
        #         value="",
        #         style=Dict("padding" =>  10)
        #     ),
        #     html_button("Add Column", id="adding-rows-button", n_clicks=0)
        # ], style=Dict("height" =>  50)),
    
        dash_datatable(
            id="adding-rows-table",
            columns=[Dict(
                "name" =>  "Column $i",
                "id" =>  "column-$i",
                "deletable" =>  true,
                "renamable" =>  true
            ) for i in 1:4],
            data=[
                Dict("column-$i" =>  (j + (i-1)*5)-1 for i in 1:4)
                for j in 1:5
            ],
            editable=true,
            row_deletable=true
        ),
    
        html_button("Add Row", id="adding-rows-button", n_clicks=0),
    
        dcc_graph(id="adding-rows-graph")
    ])
    callback!(addrow_callback, app,
        Output("adding-rows-table", "data"),
        Input("adding-rows-button", "n_clicks"),
        State("adding-rows-table", "data"),
        State("adding-rows-table", "columns")
    )
    
    callback!(app,
        Output("adding-rows-graph", "figure"),
        Input("adding-rows-table", "data"),
        Input("adding-rows-table", "columns")
    ) do rows, columns
        try
            return Dict(
                "data" =>  [Dict(
                    "type" =>  "heatmap",
                    "z" =>  [[row[Symbol(c.id)] for c in columns] for row in rows],
                    "x" =>  [c.name for c in columns]
                )]
            )
        catch
            throw(PreventUpdate())
        end
    end
    
    return app
end

    
function addrow_callback(n_clicks, existing_data, columns)
    return if n_clicks > 0
        new_row = Dict(c.id =>  "" for c in columns)
        new_data =  vcat(Dict.(existing_data), new_row)
        @show new_data |> size
        return new_data
    else
        return existing_data
    end
end