%% ¡header!
PPGraph < PlotProp (pr, plot property graph) is a plot of a graph property.

%%% ¡description!
PPGraph plots the measure table associated with a graph of the analysis.
It also provides the buttons to navigate the graphical interface of both
the measures and the graph.

CALLBACK - This is a callback function:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure

%%% ¡seealso!
GUI, PlotElement, PlotProp, AnalyzeGroup, 

%% ¡properties!
p
measure_tbl
measure_btn
graph_btn
mlist
selected
already_calculated
f_m % array of measure figures

%% ¡props_update!

%%% ¡prop!
ENABLE (metadata, option) switches between off and inactive fields.
%%%% ¡default!
'off'

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the graph property and the measure table.
    %
    % DRAW(PR) draws the panel of the graph property and the measure table.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, refresh, uipanel.

    el = pr.get('EL');
    prop = pr.get('PROP');

    pr.p = draw@PlotProp(pr, 'DeleteFcn', {@close_f_measures}, varargin{:});
   
    function close_f_measures(~, ~)
        for i = 1:length(pr.fm)
            f_m = pr.fm{i};
            if check_graphics(f_m, 'figure')
                close(f_m)
            end
        end
    end

    if ~check_graphics(pr.graph_btn, 'pushbutton') || ~check_graphics(pr.measure_btn, 'pushbutton')
        % graph button
        pr.graph_btn = uicontrol( ...
            'Style', 'pushbutton', ...
            'Tag', 'pushbutton_value', ...
            'Parent', pr.p, ...
            'Units', 'normalized', ...
            'String', el.get(prop).tostring(), ...
            'Position', [.01 .11 .48 .09], ...
            'Callback', {@cb_graph_btn} ...
            );

        % measure button
        pr.measure_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Tag', 'measure_button', ...
            'Units', 'normalized', ...
            'String', 'Measures', ...
            'Position', [.01 .01 .48 .09], ...
            'Callback', {@cb_measure_btn} ...
            );

    end

    if isempty(pr.measure_tbl) || ~isgraphics(pr.measure_tbl, 'uitable')
        pr.mlist = [];

        pr.measure_tbl = uitable( ...
            'Parent', pr.p, ...
            'CellEditCallback', {@cb_measure_selection} ...
            );
        tbl_selectall_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Units', 'normalized', ...
            'Position', [.51 .11 .48 .09], ...
            'Visible', 'on', ...
            'String', 'Select All', ...
            'TooltipString', 'Select all measures', ...
            'Callback', {@cb_table_selectall} ...
            );
        tbl_clearselection_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Units', 'normalized', ...
            'Position', [.51 .01 .48 .09], ...
            'Visible', 'on', ...
            'String', 'Clear All', ...
            'TooltipString', 'Clear selection', ...
            'Callback', {@cb_table_clearselection} ...
            );
    end

        function cb_graph_btn(~, ~) % (src, event)
            pr.cb_graph_value()
        end
        function cb_measure_btn(~, ~)
            pr.cb_measure_value()
        end
        function cb_measure_selection(~, event)
            i = event.Indices(1);
            col = event.Indices(2);
            newdata = event.NewData;
            switch col
                case 1
                    if newdata == 1
                        pr.selected = sort(unique([pr.selected(:); i]));
                    else
                        pr.selected = pr.selected(pr.selected ~= i);
                    end

                otherwise
            end
            pr.update()
        end
        function cb_table_selectall(~, ~)  % (src, event)
            pr.mlist = Graph.getCompatibleMeasureList(el.get(prop));
            pr.selected = (1:1:length(pr.mlist))';
            pr.update()            
        end
        function cb_table_clearselection(~, ~)  % (src, event)
            pr.selected = [];
            pr.update()
        end

    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the pushbutton.
    %
    % UPDATE(PR) updates the content and permissions of the pushbutton.
    %
    % See also draw, redraw, refresh, PlotElement.

    update@PlotProp(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');
    graph = el.get(prop);

    button_calc = pr.get_button_condition();
    set(...
        pr.measure_tbl, ...
        'Visible', 'on', ...
        'ColumnName', {'SEL', 'Measure', 'CAL' 'Shape', 'Scope', 'Notes'}, ...
        'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
        'ColumnEditable', [true false false false false false] ...
        );

    if isequal(button_calc.Enable, 'on')

    else

        if  ~isa(graph, 'NoValue') && isa(graph, 'Graph')
            if isempty(pr.mlist)
                pr.mlist = Graph.getCompatibleMeasureList(graph);
            end
            pr.already_calculated = pr.is_measure_calculated();
            data = cell(length(pr.mlist), 6);
            for mi = 1:1:length(pr.mlist)
                if any(pr.selected == mi)
                    data{mi, 1} = true;
                else
                    data{mi, 1} = false;
                end
                data{mi, 2} = pr.mlist{mi};
                data{mi, 3} = pr.already_calculated{mi};
                if Measure.is_nodal(pr.mlist{mi})
                    data{mi, 4} = 'NODAL';
                elseif Measure.is_global(pr.mlist{mi})
                    data{mi, 4} = 'GLOBAL';
                else
                    data{mi, 4} = 'BINODAL';
                end

                if Measure.is_superglobal(pr.mlist{mi})
                    data{mi, 5} = 'SUPERGLOBAL';
                elseif Measure.is_unilayer(pr.mlist{mi})
                    data{mi, 5} = 'UNILAYER';
                else
                    data{mi, 5} = 'BILAYER';
                end

                data{mi, 6} = eval([pr.mlist{mi} '.getDescription()']);
            end
            set(pr.measure_tbl, 'Data', data)
            set(pr.measure_tbl, 'ColumnWidth', {'auto', 'auto', 'auto', 'auto', 'auto', 'auto'})
        end
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its
    %   graphical objects.
    %
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects.
    % 2. REDRAW() is typically called internally by PlotElement and does not need
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=3.33 characters.
    %
    % See also draw, update, refresh, PlotElement.

    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
    [Dh, varargin] = get_and_remove_from_varargin(15, 'DHeight', varargin);

    set(pr.measure_tbl, ...
        'Units', 'normalized', ...
        'Position', [.01 .22 .98 (Dh/(h+Dh)-.22)] ...
        )

    pr.redraw@PlotProp('Height', h + Dh, varargin{:})
end
function cb_graph_value(pr)
    %CB_GRAPH_VALUE executes callback for the pushbutton.
    %
    % CB_GRAPH_VALUE(PR) executes callback for the pushbutton.
    %  It opens Graph GUI.
    %
    % See also cb_measure_value.

    el = pr.get('EL');
    prop = pr.get('PROP');

    pr.update()

    % TODO: check this part of the code once GUI is finalized
    value = el.getr(prop);
    if isa(value, 'NoValue')
        GUI('PE', el.getPropDefault(prop)).draw()
    else
        GUI('PE', el.get(prop)).draw()
    end
end
function cb_measure_value(pr)
    %CB_MEASURE_VALUE executes callback for the pushbutton.
    %
    % CB_MEASURE_VALUE(PR) executes callback for the pushbutton.
    %  It opens Measure GUI.
    %
    % See also cb_graph_value.

    el = pr.get('EL');
    prop = pr.get('PROP');
    graph = el.memorize(prop);
    pr.mlist = Graph.getCompatibleMeasureList(graph);

    measure_short_list = pr.mlist(pr.selected);

    % calculate
    if pr.get('WAITBAR')
        wb = waitbar(0, ['Calculating ' num2str(length(pr.selected))  ' measures ...'], 'Name', BRAPH2.NAME);
        set_braph2_icon(wb)
    end    

    for i = 1:length(pr.mlist)
        if ~ismember(pr.mlist(i), measure_short_list)
            continue;
        end
        
        measure = pr.mlist{i};
        if pr.get('WAITBAR')
            waitbar(.1 + .70 * i / length(pr.selected), wb, ['Calculating measure ' measure ]);
        end
        result_measure = graph.getMeasure(measure);
        result_measure.memorize('M');
        pr.f_m{i} = GUI('pe', result_measure).draw();
        pr.already_calculated{i} = 'C';
    end

    % close progress bar
    if pr.get('WAITBAR')
        close(wb)
    end
    pr.update();
end
function list =  is_measure_calculated(pr)
    el = pr.get('EL');
    prop = pr.get('PROP');
    graph = el.memorize(prop);
    measure_dict = graph.get('M_DICT');
    measure_list = pr.mlist;
    calculated_list = cell(size(measure_list, 2), 1);
    if measure_dict.length() > 0
        for i = 1:length(measure_list)
            measure = measure_list{i};
            if any(cellfun(@(x) isequal(measure, x.get('ID')), measure_dict.getItems()))
                calculated_list{i} = 'C';
            else
                calculated_list{i} = 'F';
            end
        end
    else
        [calculated_list{:}] = deal('F');
    end
    list = calculated_list;
end
function btn = get_button_condition(pr)
    plot_prop_children = get(pr.p, 'Children');
    for i = 1:length(plot_prop_children)
        pp_c = plot_prop_children(i);
        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_calc')
            btn = pp_c;
        end
    end

end
function update_brain_atlas(pr)
    %UPDATE_BRAIN_ATLAS updates the brain atlas.
    %
    % UPDATE_BRAIN_ATLAS(PR) updates the brain atlas. Usually used
    %  triggered by PPBrainAtlas_BRDict.
    %
    % See also PPBrainAtlas_BRDict.
    
    if isgraphics(pr.f_pba, 'figure')
        pba = pr.get('PBA');
        try
            pba.draw('Parent', pr.f_pba)
        catch e
            if strcmp(e.identifier, 'MATLAB:badsubscript') % regions added too fast by the user
                % do nothing
            else
                rethrow(e)
            end
        end
    end
end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to front the brain atlas figure and its settings figure.
    %
    % CB_BRING_TO_FRONT(PR) brings to front the brain atlas figure and its
    %  settings figure.
    %
    % See also cb_hide, cb_close.

    % brings to front settings panel
    pr.cb_bring_to_front@PlotProp();

    % brings to front brain atlas figure
    children = get(pr.f_pba, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'uipanel') && strcmp(get(children(i), 'Tag'), 'h_panel')
            pba = get(children(i), 'UserData');
            pba.cb_bring_to_front()
        end
    end
end
function cb_hide(pr)
    %CB_HIDE hides the brain atlas figure and its settings figure.
    %
    % CB_HIDE(PR) hides the brain atlas figure and its settings figure.
    %
    % See also cb_bring_to_front, cb_close.

    % hides settings panel
    pr.cb_hide@PlotProp();

    % hides brain atlas figure
    children = get(pr.f_pba, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'uipanel') && strcmp(get(children(i), 'Tag'), 'h_panel')
            pba = get(children(i), 'UserData');
            pba.cb_hide()
        end
    end
end
function cb_close(pr)
    %CB_CLOSE closes the brain atlas figure and its settings figure.
    %
    % CB_CLOSE(PR) closes the brain atlas figure and its settings figure.
    %
    % See also cb_bring_to_front, cd_hide.

    % closes settings panel
    pr.cb_close@PlotProp();

    % closes brain atlas figure
    children = get(pr.f_pba, 'Children');
    for i = 1:1:length(children)
        if check_graphics(children(i), 'uipanel') && strcmp(get(children(i), 'Tag'), 'h_panel')
            pba = get(children(i), 'UserData');
            pba.cb_close()
        end
    end
end
