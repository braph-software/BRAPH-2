%% ¡header!
PPGraph < PlotProp (pr, plot property graph) is a plot of a graph property.

%%% ¡description!
PPGraph plots the measure table associated with a graph of the analysis.
It also provides the buttons to navigate the graphical interface of both
the measures and the graph.

%%% ¡seealso!
GUI, PlotElement, PlotProp, AnalyzeGroup, 

%% ¡properties!
p
measure_tbl
measure_btn
graph_btn
mlist
selected

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
    
    pr.p = draw@PlotProp(pr, varargin{:});
    
    if ~check_graphics(pr.graph_btn, 'pushbutton') || ~check_graphics(pr.measure_btn, 'pushbutton')
        % graph button
        pr.graph_btn = uicontrol( ...
            'Style', 'pushbutton', ...
            'Tag', 'pushbutton_value', ...
            'Parent', pr.p, ...
            'Units', 'normalized', ...
            'Position', [.01 .01 .4 .1], ... % position defined here because it's always the same
            'FontUnits', BRAPH2.FONTUNITS, ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Callback', {@cb_graph_btn} ...
            );
        
        % measure button       
        pr.measure_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Tag', 'measure_button', ...
            'Units', 'normalized', ...
            'Position', [.51 .01 .4 .1], ...
            'FontUnits', BRAPH2.FONTUNITS, ...
            'FontSize', BRAPH2.FONTSIZE, ...
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
            'Position', [.01 .11 .22 .07], ...
            'Visible', 'on', ...
            'String', 'Select All', ...
            'TooltipString', 'Select all measures', ...
            'Callback', {@cb_table_selectall} ...
            );
        tbl_clearselection_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Units', 'normalized', ...
            'Position', [.01 .01 .22 .07], ...
            'Visible', 'on', ...
            'String', 'Clear', ...
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
%         pr.update(pr.selected, pr.already_calculated)
        pr.update()
    end
    function cb_table_selectall(~, ~)  % (src, event)
        pr.mlist = Graph.getCompatibleMeasureList(el.get(prop));
        pr.selected = (1:1:length(pr.mlist))';
        pr.update()
%         pr.update(pr.selected, pr.already_calculated)
    end
    function cb_table_clearselection(~, ~)  % (src, event)
        pr.selected = [];
        pr.update()
%         pr.update(pl.selected, pl.already_calculated)
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
    
    set(pr.measure_tbl, ...
        'Units', 'normalized', ...
        'Position', [.02 .2 .9 .7], ...
        'Visible', 'on', ...
        'ColumnName', {'SEL', 'Measure', 'CAL' 'Shape', 'Scope', 'Notes'}, ...
        'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
        'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
        'ColumnEditable', [true false false false false false] ...
        )
    
    pr.mlist = Graph.getCompatibleMeasureList(graph);
    if isa(graph, 'Graph')
        data = cell(length(pr.mlist), 6);
        for mi = 1:1:length(pr.mlist)
            if any(pr.selected == mi)
                data{mi, 1} = true;
            else
                data{mi, 1} = false;
            end
            data{mi, 2} = pr.mlist{mi};
            data{mi, 3} = pr.already_calculated(mi);
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
    
    pr.redraw@PlotProp('Height', 3.33, varargin{:})
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
    f = waitbar(0, ['Calculating ' num2str(length(pr.selected))  ' measures ...'], 'Name', BRAPH2.NAME);
    set_icon(f)
    for i = 1:length(pr.mlist)
        if ~ismember(pr.mlist(i), measure_short_list)
            continue;
        end
        progress = (i / length(pr.selected)) * .8;
        extra = (i / length(pr.selected)) * 1.05 * .8;
        measure = pr.mlist{i};
        waitbar(progress, f, ['Calculating measure: ' measure ' ...']);
        result_measure{i} = g.getMeasure(measure).memorize('M'); %#ok<AGROW>
        waitbar(extra, f, ['Measure: ' measure ' Calculated! ...']);
        pr.already_calculated(i) = 'C';
    end
    
    % close progress bar
    if exist('f', 'var')
        waitbar(1, f, 'Finishing')
        pause(.5)
        close(f)
    end
    pr.update(pr.selected,  pr.already_calculated);
end
