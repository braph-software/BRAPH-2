%% ¡header!
PPNNDataGAT_Measures < PlotProp (pr, plot property graph) is afor yuwei.

%%% ¡description!
PPNNDataGAT_Measures represents all compatible measures for a graph attention network as a table.

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
p
measure_tbl
measure_btn
select_all_btn
deselect_all_btn
mlist
selected
graph
f_m % array of measure class figures

%% ¡props_update!

%%% ¡prop!
ENABLE (metadata, option) switches between off and inactive fields.
%%%% ¡default!
'inactive'

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

    pr.p = draw@PlotProp(pr, varargin{:});
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    pr.graph = el.get('G');
    
    if  isempty(pr.measure_tbl) || ~check_graphics(pr.measure_tbl, 'uitable')
        if isempty(pr.mlist)
            pr.mlist = Graph.getCompatibleMeasureList(pr.graph);
        end
        idx_nodal = cell2mat(cellfun(@(x) Measure.is_nodal(x), pr.mlist, 'UniformOutput', false));
        pr.mlist = pr.mlist(idx_nodal);
        pr.selected = find(ismember(string(pr.mlist), string(el.get('MEASURES'))));<<<<<<<<<<<<<<
        pr.measure_tbl = uitable( ...
            'Parent', pr.p, ...
            'Visible', 'on', ...
            'ColumnName', {'SEL', 'Measure', 'Shape', 'Scope', 'Notes'}, ...
            'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ColumnEditable', [true false false false false], ...
            'Visible', 'off', ...
            'CellEditCallback', {@cb_measure_edit} ...
            );

        pr.select_all_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Tag', 'Select_all_button', ...
            'Units', 'normalized', ...
            'String', 'Select All', ...
            'TooltipString', 'Select all measures in the table', ...
            'Position', [.01 .02 .30 .09], ...
            'Visible', 'off', ...
            'Callback', {@cb_select_all} ...
            );

        pr.deselect_all_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Tag', 'Select_all_button', ...
            'Units', 'normalized', ...
            'String', 'Deselect All', ...
            'TooltipString', 'Deselect all measures in the table', ...
            'Position', [.33 .02 .30 .09], ...
            'Visible', 'off', ...
            'Callback', {@cb_deselect_all} ...
            );

        % measure button
        pr.measure_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Tag', 'measure_button', ...
            'Units', 'normalized', ...
            'String', 'Set Measures', ...
            'TooltipString', 'Set selected Measures', ...
            'Position', [.66 .02 .30 .09], ...
            'Visible', 'off', ...
            'Callback', {@cb_measure_btn} ...
            );
    end
    function cb_measure_edit(~, event)
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
                % dont do anything
        end
        pr.update()
    end
    function cb_measure_btn(~, ~)
        pr.cb_set_measures()
    end
    function cb_select_all(~, ~)
        pr.selected = (1:1:length(pr.mlist))';
        pr.update();
    end
    function cb_deselect_all(~, ~)
        pr.selected = [];
        pr.update();
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
    pr.graph = el.get('G');

    % visible gui
    pe = ancestor(pr.p, 'figure').UserData.get('PE');
    set(pr.measure_tbl, 'Visible', 'on')
    set(pr.measure_btn, 'Visible', 'on')
    set(pr.select_all_btn, 'Visible', 'on')
    set(pr.deselect_all_btn, 'Visible', 'on')

    if  ~isa(pr.graph, 'NoValue') && isa(pr.graph, 'Graph')
        if isempty(pr.mlist)
            pr.mlist = Graph.getCompatibleMeasureList(pr.graph);
        end
        idx_nodal = cell2mat(cellfun(@(x) Measure.is_nodal(x), pr.mlist, 'UniformOutput', false));
        pr.mlist = pr.mlist(idx_nodal);

        data = cell(length(pr.mlist), 5);
        for mi = 1:1:length(pr.mlist)
            if any(pr.selected == mi)
                data{mi, 1} = true;
            else
                data{mi, 1} = false;
            end
            data{mi, 2} = pr.mlist{mi};
            if Measure.is_nodal(pr.mlist{mi})
                data{mi, 3} = 'NODAL';
            elseif Measure.is_global(pr.mlist{mi})
                data{mi, 3} = 'GLOBAL';
            else
                data{mi, 3} = 'BINODAL';
            end
            if Measure.is_superglobal(pr.mlist{mi})
                data{mi, 4} = 'SUPERGLOBAL';
            elseif Measure.is_unilayer(pr.mlist{mi})
                data{mi, 4} = 'UNILAYER';
            else
                data{mi, 4} = 'BILAYER';
            end
            data{mi, 5} = eval([pr.mlist{mi} '.getDescription()']);
        end
        set(pr.measure_tbl, 'Data', data)
        set(pr.measure_tbl, 'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto'})

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
    [Dh, varargin] = get_and_remove_from_varargin(20, 'DHeight', varargin);

    if  ~isempty(pr.measure_tbl) && check_graphics(pr.measure_tbl, 'uitable')
        set(pr.measure_tbl, ...
            'Units', 'normalized', ...
            'Position', [.01 .13 .98 (Dh/(h+Dh)- .12)] ...
            )
    end
    if strcmp(get(pr.measure_tbl, 'Visible'), 'on')
        pr.redraw@PlotProp('Height', h + Dh, varargin{:})
        set(pr.measure_btn, 'Visible', 'on')
        set(pr.select_all_btn, 'Visible', 'on')
        set(pr.deselect_all_btn, 'Visible', 'on')
    else
        pr.redraw@PlotProp(varargin{:})
        set(pr.measure_btn, 'Visible', 'off')
        set(pr.select_all_btn, 'Visible', 'off')
        set(pr.deselect_all_btn, 'Visible', 'off')
    end
    
end
function cb_set_measures(pr)
    el = pr.get('EL');
    measure_short_list = pr.mlist(pr.selected);
    el.set('Measures', measure_short_list); 
    pr.update();
end
function cb_hide_table(pr)
% yuwei, should this el = pr.get('EL');
% el.set('measures', []);
    set(pr.measure_tbl, 'Visible', 'off');
    pr.redraw();
end
function cb_show_table(pr)
    set(pr.measure_tbl, 'Visible', 'on');
    pr.redraw();
end
