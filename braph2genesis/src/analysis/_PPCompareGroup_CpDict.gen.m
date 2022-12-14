%% ¡header!
PPCompareGroup_CpDict < PanelProp (pr, panel property graph) is a plot of a group-based comparison dictionary property.

%%% ¡description!
PPCompareGroup_CpDict plots a table of the group-based comparison associated with a group comparison.

% % % CALLBACKS - These are callback functions:
% % % 
% % %     pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
% % %     pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
% % %     pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure

%%% ¡seealso!
GUI, PlotElement, CompareGroup, uitable

%% ¡props!

%%% ¡prop!
TAB_H (gui, size) is the height of the table in fontsize units.
%%%% ¡default!
30

%% ¡properties!
p
table
selected

contextmenu
%
menu_select_all
menu_clear_selection
menu_invert_selection
%
menu_comparison_calculate
menu_comparison_open_plots
menu_comparison_hide_plots
menu_comparison_open_elements
menu_comparison_hide_elements
menu_measure_open_brain_graph
menu_measure_close_brain_graph

f_comparison_plots
f_comparison_elements
f_brain_graphs

%% ¡methods!
function p_out = draw(pr, varargin)
    %DRAW draws the panel of the graph property and the comparison table.
    %
    % DRAW(PR) draws the panel of the graph property and the comparison table.
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

    pr.p = draw@PanelProp(pr, varargin{:});
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    if ~check_graphics(pr.contextmenu, 'uicontextmenu')
        pr.contextmenu = uicontextmenu( ...
            'Parent', ancestor(pr.p, 'figure'), ...
            'Tag', 'contextmenu' ...
            );
        pr.menu_select_all = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_select_all', ...
            'Text', 'Select All', ...
            'MenuSelectedFcn', {@cb_select_all} ...
            );
        pr.menu_clear_selection = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_clear_selection', ...
            'Text', 'Clear Selection', ...
            'MenuSelectedFcn', {@cb_clear_selection} ...
            );
        pr.menu_invert_selection = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_invert_selection', ...
            'Text', 'Invert Selection', ...
            'MenuSelectedFcn', {@cb_invert_selection} ...
            );
        pr.menu_comparison_calculate = uimenu( ...
            'Separator', 'on', ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_comparison_calculate', ...
            'Text', 'Calculate Selected Comparisons', ...
            'MenuSelectedFcn', {@cb_comparison_calculate} ...
            );
        pr.menu_comparison_open_plots = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_comparison_open_plots', ...
            'Text', 'Plot Selected Comparisons', ...
            'MenuSelectedFcn', {@cb_comparison_open_plots} ...
            );
        pr.menu_comparison_hide_plots = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_comparison_hide_plots', ...
            'Text', 'Hide Selected Plots', ...
            'MenuSelectedFcn', {@cb_comparison_hide_plots} ...
            );
        pr.menu_comparison_open_elements = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_comparison_open_elements', ...
            'Text', 'Data Selected Comparisons', ...
            'MenuSelectedFcn', {@cb_comparison_open_elements} ...
            );
        pr.menu_comparison_hide_elements = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_comparison_hide_elements', ...
            'Text', 'Hide Selected Data', ...
            'MenuSelectedFcn', {@cb_comparison_hide_elements} ...
            );
        pr.menu_measure_open_brain_graph = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_measure_open_brain_graph', ...
            'Text', 'Plot Selected Measures Brain Graph', ...
            'MenuSelectedFcn', {@cb_measure_open_brain_graph} ...
            );
        pr.menu_measure_close_brain_graph = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_measure_close_brain_graph', ...
            'Text', 'Hide Selected Plots Brain Graph', ...
            'MenuSelectedFcn', {@cb_measure_hide_brain_graph} ...
            );
    end
    function cb_select_all(~, ~) 
        pr.cb_select_all()
    end
    function cb_clear_selection(~, ~) 
        pr.cb_clear_selection()
    end
    function cb_invert_selection(~, ~) 
        pr.cb_invert_selection()
    end
    function cb_comparison_calculate(~, ~) 
        pr.cb_comparison_calculate()
    end
    function cb_comparison_open_plots(~, ~) 
        pr.cb_comparison_open_plots()
    end
    function cb_comparison_hide_plots(~, ~) 
        pr.cb_comparison_hide_plots()
    end
    function cb_comparison_open_elements(~, ~) 
        pr.cb_comparison_open_elements()
    end
    function cb_comparison_hide_elements(~, ~) 
        pr.cb_comparison_hide_elements()
    end
    function cb_measure_open_brain_graph(~, ~)
        pr.cb_measure_open_brain_graph()
    end
    function cb_measure_hide_brain_graph(~, ~)
        pr.cb_measure_hide_brain_graph()
    end
    
    if ~check_graphics(pr.table, 'uitable')
        pr.table = uitable( ...
            'Parent', pr.p, ...
            'Tag', 'table', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'ColumnSortable', true, ...
            'ContextMenu', pr.contextmenu, ... 
            'ColumnName', {'', 'Measure', 'Shape', 'Scope', 'Notes'}, ... 
            'ColumnFormat', {'logical',  'char', 'char', 'char', 'char'}, ... 
            'ColumnWidth', {30, 'auto', 'auto', 'auto', 'auto'}, ... 
            'ColumnEditable', [true false false false false], ...
            'CellEditCallback', {@cb_table_edit} ...
            );
    end
    function cb_table_edit(~, event) % (src, event)
        % only needs to update the selector
        
        i = event.Indices(1);

        if event.NewData == 1
            pr.selected = sort(unique([pr.selected(:); i]));
        else
            pr.selected = pr.selected(pr.selected ~= i);
        end
        
        pr.update()
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permissions of the pushbutton.
    %
    % UPDATE(PR) updates the content and permissions of the pushbutton.
    %
    % See also draw, redraw, PlotElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    function set_table()
        g = el.get('A1').get('G');
        cplist = Graph.getCompatibleMeasureList(g);
        cplist_already_calculated = cellfun(@(x) x.get('MEASURE'), el.get(prop).getItems(), 'UniformOutput', false);

        rowname = cell(length(cplist), 1);
        data = cell(length(cplist), 5);
        for cpi = 1:1:length(cplist)
            if any(cellfun(@(y) isequal(cplist{cpi}, y), cplist_already_calculated)) && ~isa(el.getComparison(cplist{cpi}).getr('DIFF'), 'NoValue')
                rowname{cpi} = 'C';
            else
                rowname{cpi} = '';
            end                
            
            if any(pr.selected == cpi)
                data{cpi, 1} = true;
            else
                data{cpi, 1} = false;
            end

            data{cpi, 2} = cplist{cpi};

            if Measure.is_nodal(cplist{cpi})
                data{cpi, 3} = 'NODAL';
            elseif Measure.is_global(cplist{cpi})
                data{cpi, 3} = 'GLOBAL';
            else
                data{cpi, 3} = 'BINODAL';
            end

            if Measure.is_superglobal(cplist{cpi})
                data{cpi, 4} = 'SUPERGLOBAL';
            elseif Measure.is_unilayer(cplist{cpi})
                data{cpi, 4} = 'UNILAYER';
            else
                data{cpi, 4} = 'BILAYER';
            end

            data{cpi, 5} = eval([cplist{cpi} '.getDescription()']);
        end
        set(pr.table, ...
            'RowName', rowname, ...
            'Data', data ...
            )

        % style SELECTED
        styles_row = find(pr.table.StyleConfigurations.Target == 'row');
        if ~isempty(styles_row)
            removeStyle(pr.table, styles_row)
        end
        if ~isempty(pr.selected)
            addStyle(pr.table, uistyle('FontWeight', 'bold'), 'row', pr.selected)
        end        
    end

    value = el.getr(prop);
    if isa(value, 'NoValue')
        % don't plot anything for a result not yet calculated
        set(pr.table, 'Visible', 'off')
    else
        set_table()
        set(pr.table, 'Visible', 'on')
    end
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel. 
    % 2. REDRAW() is typically called internally by PanelElement and does not need 
    %  to be explicitly called in children of PanelProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT = s(30)
    %
    % See also draw, update, PanelElement, s.

    [h, varargin] = get_and_remove_from_varargin(s(2), 'Height', varargin);
    Dh = s(pr.get('TAB_H'));
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    value = el.getr(prop);
    if isa(value, 'NoValue') % && el.getPropCategory(prop) == Category.RESULT 
        pr.redraw@PanelProp('Height', h, varargin{:})
    else
        pr.redraw@PanelProp('Height', h + Dh, varargin{:})
        drawnow()
        
        set(pr.table, ...
            'Units', 'pixels', ...
            'Position', [s(.3) s(.3) w(pr.p, 'pixels')-s(.6) Dh-s(.6)] ...
            )
    end
end
function cb_select_all(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    g = el.get('A1').get('G');
    cplist = Graph.getCompatibleMeasureList(g);

    pr.selected = [1:1:length(cplist)];

    pr.update()
end
function cb_clear_selection(pr)

    pr.selected = [];

    pr.update()
end
function cb_invert_selection(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    g = el.get('A1').get('G');
    cplist = Graph.getCompatibleMeasureList(g);

    selected_tmp = [1:1:length(cplist)];
    selected_tmp(pr.selected) = [];
    pr.selected = selected_tmp;

    pr.update()
end
function cb_comparison_calculate(pr) 

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    g = el.get('A1').get('G');
    cplist = Graph.getCompatibleMeasureList(g);
    
    wb = braph2waitbar(el.get('WAITBAR'), 0, ['Calculating ' num2str(length(pr.selected))  ' comparisons ...']);

    for i = 1:1:length(cplist)
        if ismember(i, pr.selected)
            measure = cplist{i};
            
            braph2waitbar(wb, .1 + .9 * i / length(pr.selected), ['Calculating comparison ' int2str(i) ' (' measure ') of ' int2str(length(pr.selected)) ' ...'])

            if isa(el.getComparison(measure).getr('DIFF'), 'NoValue')
                el.getComparison(measure).memorize('DIFF');
                el.getComparison(measure).memorize('P1');
                el.getComparison(measure).memorize('P2');
                el.getComparison(measure).memorize('CIL');
                el.getComparison(measure).memorize('CIU');
            end
        end
    end
    
    braph2waitbar(wb, 'close')

	pr.update();
end
function cb_comparison_open_plots(pr) 

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    g = el.get('A1').get('G');
    cplist = Graph.getCompatibleMeasureList(g);
    
    f = ancestor(pr.p, 'figure'); % parent GUI 
    N = ceil(sqrt(length(cplist))); % number of row and columns of figures
    
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        measure = cplist{i};

        cp = el.getComparison(measure);
        if length(pr.f_comparison_plots) < i || ~check_graphics(pr.f_comparison_plots{i}, 'figure')
            pr.f_comparison_plots{i} = GUIFig( ...
                'PF', cp.memorize('PFC'), ... % ensure that the property is stored
                'WAITBAR', Callback('EL', pr, 'TAG', 'WAITBAR'), ...
                'NAME', ['Figure - ' cp.get('ID') ' - ' BRAPH2.STR], ...
                'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
                    y0(f, 'normalized') ...
                    w(f, 'normalized') * 3 ...
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
                    ], ...
                'CLOSEREQ', false ...
                ).draw();
        else
            figure(pr.f_comparison_plots{i})
        end
    end
end
function cb_comparison_hide_plots(pr) 

    % hides selected subfigures
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        if length(pr.f_comparison_plots) >= i
            f_comparison_plot = pr.f_comparison_plots{i};
            if check_graphics(f_comparison_plot, 'figure')
                gui = get(f_comparison_plot, 'UserData');
                gui.cb_hide()
            end
        end
    end
end
function cb_comparison_open_elements(pr) 

    el = pr.get('EL');
    prop = pr.get('PROP');
    
    g = el.get('A1').get('G');
    cplist = Graph.getCompatibleMeasureList(g);
    
    f = ancestor(pr.p, 'figure'); % parent GUI 
    N = ceil(sqrt(length(cplist))); % number of row and columns of figures
    
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        measure = cplist{i};

        cp = el.getComparison(measure);
        if length(pr.f_comparison_elements) < i || ~check_graphics(pr.f_comparison_elements{i}, 'figure')
            pr.f_comparison_elements{i} = GUIElement( ...
                'PE', cp, ... 
                'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
                    ], ...
                'CLOSEREQ', false ...
                ).draw();
        else
            figure(pr.f_comparison_elements{i})
        end
    end
end
function cb_comparison_hide_elements(pr) 

    % hides selected subfigures
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        if length(pr.f_comparison_elements) >= i
            f_comparison_element = pr.f_comparison_elements{i};
            if check_graphics(f_comparison_element, 'figure')
                gui = get(f_comparison_element, 'UserData');
                gui.cb_hide()
            end
        end
    end
end
function cb_measure_open_brain_graph(pr)
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    g = el.get('A1').get('G');
        
    mlist = Graph.getCompatibleMeasureList(g);
    
    f = ancestor(pr.p, 'figure'); % parent GUI 
    N = ceil(sqrt(length(mlist))); % number of row and columns of figures
    
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        measure = mlist{i};

        cp = el.getComparison(measure);
        if Measure.is_nodal(cp.get('MEASURE_TEMPLATE'))
            if length(pr.f_brain_graphs) < i || ~check_graphics(pr.f_brain_graphs{i}, 'figure')
                pr.f_brain_graphs{i} = GUIFig( ...
                    'PF', cp.memorize('PFBG'), ... % ensure that the property is stored
                    'WAITBAR', Callback('EL', pr, 'TAG', 'WAITBAR'), ...
                    'NAME', ['Figure - ' cp.get('ID') '@' el.get('ID') ' - ' BRAPH2.STR], ...
                    'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
                    y0(f, 'normalized') ...
                    w(f, 'normalized') * 3 ...
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
                    ], ...
                    'CLOSEREQ', false ...
                    ).draw();
            else
                figure(pr.f_brain_graphs{i})
            end
        end        
    end
end
function cb_measure_hide_brain_graph(pr) 

    % hides selected subfigures
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        if length(pr.f_brain_graphs) >= i
            f_measure_brain_graph = pr.f_brain_graphs{i};
            if check_graphics(f_measure_brain_graph, 'figure')
                gui = get(f_measure_brain_graph, 'UserData');
                gui.cb_hide()
            end
        end
    end
end
function cb_bring_to_front(pr)

    cb_bring_to_front@Panel(pr);
    
    % brings to front comparison plot subfigures
    for i = 1:1:length(pr.f_comparison_plots)
        f_comparison_plot = pr.f_comparison_plots{i};
        if check_graphics(f_comparison_plot, 'figure')
            gui = get(f_comparison_plot, 'UserData');
            gui.cb_bring_to_front()
        end
    end
    
    % brings to front comparison element subfigures
    for i = 1:1:length(pr.f_comparison_elements)
        f_comparison_plot = pr.f_comparison_elements{i};
        if check_graphics(f_comparison_plot, 'figure')
            gui = get(f_comparison_plot, 'UserData');
            gui.cb_bring_to_front()
        end
    end   
    
    % brings to front comparison element subfigures
    for i = 1:1:length(pr.f_brain_graphs)
        f_brain_graph = pr.f_brain_graphs{i};
        if check_graphics(f_brain_graph, 'figure')
            gui = get(f_brain_graph, 'UserData');
            gui.cb_bring_to_front()
        end
    end  
end
function cb_hide(pr)
    
    cb_hide@Panel(pr);
    
    % hides comparison plot subfigures
    for i = 1:1:length(pr.f_comparison_plots)
        f_comparison_plot = pr.f_comparison_plots{i};
        if check_graphics(f_comparison_plot, 'figure')
            gui = get(f_comparison_plot, 'UserData');
            gui.cb_hide()
        end
    end
    
    % hides comparison element subfigures
    for i = 1:1:length(pr.f_comparison_elements)
        f_comparison_plot = pr.f_comparison_elements{i};
        if check_graphics(f_comparison_plot, 'figure')
            gui = get(f_comparison_plot, 'UserData');
            gui.cb_hide()
        end
    end    
    
     % hides comparison element subfigures
    for i = 1:1:length(pr.f_brain_graphs)
        f_brain_graph = pr.f_brain_graphs{i};
        if check_graphics(f_brain_graph, 'figure')
            gui = get(f_brain_graph, 'UserData');
            gui.cb_hide()
        end
    end   
end
function cb_close(pr)
    
    cb_close@Panel(pr);

    % closes comparison plot subfigures
    for i = 1:1:length(pr.f_comparison_plots)
        f_comparison_plot = pr.f_comparison_plots{i};
        if check_graphics(f_comparison_plot, 'figure')
            gui = get(f_comparison_plot, 'UserData');
            gui.cb_close()
        end
    end
    
    % closes comparison element subfigures
    for i = 1:1:length(pr.f_comparison_elements)
        f_comparison_element = pr.f_comparison_elements{i};
        if check_graphics(f_comparison_element, 'figure')
            gui = get(f_comparison_element, 'UserData');
            gui.cb_close()
        end
    end
    
    % closes comparison element subfigures
    for i = 1:1:length(pr.f_brain_graphs)
        f_brain_graph = pr.f_brain_graphs{i};
        if check_graphics(f_brain_graph, 'figure')
            gui = get(f_brain_graph, 'UserData');
            gui.cb_close()
        end
    end
end