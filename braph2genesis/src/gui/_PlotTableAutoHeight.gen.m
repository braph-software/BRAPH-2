%% ¡header!
PlotTableAutoHeight < Plot (pl, plot table ) is a plot of a table that affects his super height.

%%% ¡description!
PlotTableAutoHeight is a plot of a table that affects his super height.

%%% ¡seealso!
GUI, Plot.

%% ¡properties!
height
table
outer_panel

%% ¡methods!
function set_table(pl, table, pp)
    pl.table = table;
    pl.outer_panel = pp;
end
function height = get_h(pl)
    set(pl.table, 'Units', 'characters');
    table_data = get(pl.table, 'Data');
    height = size(table_data, 2) + 1; % add the row of tags
end

