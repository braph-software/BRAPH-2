%% ¡header!
PPAnalyzeEnsemble_MeDict < PanelProp (pr, panel property graph) is a plot of a measure dictionary property.

%%% ¡description!
PPAnalyzeEnsemble_MeDict plots a table of the measures associated with the measure dictionary of the ensemble analysis.

% % % CALLBACKS - These are callback functions:
% % % 
% % %     pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
% % %     pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
% % %     pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure

%%% ¡seealso!
GUI, PlotElement, AnalyzeEnsemble, uitable

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
menu_graph_plot
menu_graph_element
%
menu_select_all
menu_clear_selection
menu_invert_selection
%
menu_measure_calculate
menu_measure_open_plots
menu_measure_hide_plots
menu_measure_open_elements
menu_measure_hide_elements
menu_measure_open_brain_graph
menu_measure_close_brain_graph

f_graph_plot
f_graph_element

f_measure_plots
f_measure_elements

f_brain_graphs

%% ¡methods!
function p_out = draw(pr, varargin)
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

    pr.p = draw@PanelProp(pr, varargin{:});
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    if ~check_graphics(pr.contextmenu, 'uicontextmenu')
        pr.contextmenu = uicontextmenu( ...
            'Parent', ancestor(pr.p, 'figure'), ...
            'Tag', 'contextmenu' ...
            );
        pr.menu_graph_plot = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_graph_plot', ...
            'Text', 'Plot Graph', ...
            'MenuSelectedFcn', {@cb_graph_plot} ...
            );
        pr.menu_graph_element = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_graph_element', ...
            'Text', 'Data Graph', ...
            'MenuSelectedFcn', {@cb_graph_element} ...
            );
        pr.menu_select_all = uimenu( ...
            'Separator', 'on', ...
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
        pr.menu_measure_calculate = uimenu( ...
            'Separator', 'on', ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_measure_calculate', ...
            'Text', 'Calculate Selected Measures', ...
            'MenuSelectedFcn', {@cb_measure_calculate} ...
            );
        pr.menu_measure_open_plots = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_measure_open_plots', ...
            'Text', 'Plot Selected Measures', ...
            'MenuSelectedFcn', {@cb_measure_open_plots} ...
            );
        pr.menu_measure_hide_plots = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_measure_hide_plots', ...
            'Text', 'Hide Selected Plots', ...
            'MenuSelectedFcn', {@cb_measure_hide_plots} ...
            );
        pr.menu_measure_open_elements = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_measure_open_elements', ...
            'Text', 'Data Selected Measures', ...
            'MenuSelectedFcn', {@cb_measure_open_elements} ...
            );
        pr.menu_measure_hide_elements = uimenu( ...
            'Parent', pr.contextmenu, ...
            'Tag', 'menu_measure_hide_elements', ...
            'Text', 'Hide Selected Data', ...
            'MenuSelectedFcn', {@cb_measure_hide_elements} ...
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
    function cb_graph_plot(~, ~) 
        pr.cb_graph_plot()
    end
    function cb_graph_element(~, ~) 
        pr.cb_graph_element()
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
    function cb_measure_calculate(~, ~) 
        pr.cb_measure_calculate()
    end
    function cb_measure_open_plots(~, ~) 
        pr.cb_measure_open_plots()
    end
    function cb_measure_hide_plots(~, ~) 
        pr.cb_measure_hide_plots()
    end
    function cb_measure_open_elements(~, ~) 
        pr.cb_measure_open_elements()
    end
    function cb_measure_hide_elements(~, ~) 
        pr.cb_measure_hide_elements()
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
        me_dict = el.get(prop);
        mlist = Graph.getCompatibleMeasureList(el.get('GRAPH_TEMPLATE'));
        mlist_already_calculated = cellfun(@(x) x.get('MEASURE'), me_dict.getItems(), 'UniformOutput', false);
        
        rowname = cell(length(mlist), 1);
        data = cell(length(mlist), 5);
        for mi = 1:1:length(mlist)
            if any(cellfun(@(y) isequal(mlist{mi}, y), mlist_already_calculated)) && ~isa(el.getMeasureEnsemble(mlist{mi}).getr('M'), 'NoValue')
                rowname{mi} = 'C';
            else
                rowname{mi} = '';
            end                
            
            if any(pr.selected == mi)
                data{mi, 1} = true;
            else
                data{mi, 1} = false;
            end

            data{mi, 2} = mlist{mi};

            if Measure.is_nodal(mlist{mi})
                data{mi, 3} = 'NODAL';
            elseif Measure.is_global(mlist{mi})
                data{mi, 3} = 'GLOBAL';
            else
                data{mi, 3} = 'BINODAL';
            end

            if Measure.is_superglobal(mlist{mi})
                data{mi, 4} = 'SUPERGLOBAL';
            elseif Measure.is_unilayer(mlist{mi})
                data{mi, 4} = 'UNILAYER';
            else
                data{mi, 4} = 'BILAYER';
            end

            data{mi, 5} = eval([mlist{mi} '.getDescription()']);
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
function cb_graph_plot(pr)
    
    el = pr.get('EL');
% % %     prop = pr.get('PROP');

    if ~check_graphics(pr.f_graph_plot, 'figure')
        f = ancestor(pr.p, 'figure');
        gui = GUIFig( ...
            'PF', el.memorize('PFGD'), ... % ensure that the property is stored
            'WAITBAR', Callback('EL', pr, 'TAG', 'WAITBAR'), ...
            'POSITION', [ ...
                x0(f, 'normalized')+w(f, 'normalized') ...
                y0(f, 'normalized') ...
                w(0,'normalized')-x0(f, 'normalized')-w(f, 'normalized') ...
                h(f, 'normalized') ...
                ], ...
            'CLOSEREQ', false ...
            );
        pr.f_graph_plot = gui.draw();
    else
        gui = get(pr.f_graph_plot, 'UserData');
        if get(pr.f_graph_plot, 'Visible')
            gui.cb_hide()
        else
            gui.cb_bring_to_front()
        end
    end

    pr.update()
end
function cb_graph_element(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');

    if ~check_graphics(pr.f_graph_element, 'figure')
        f = ancestor(pr.p, 'figure');
        gui = GUIElement( ...
            'PE', el.memorize(prop), ... % ensure that the property is stored
            'WAITBAR', Callback('EL', pr, 'TAG', 'WAITBAR'), ...
            'POSITION', [ ...
                x0(f, 'normalized')+w(f, 'normalized') ...
                y0(f, 'normalized') ...
                w(f, 'normalized') ...
                h(f, 'normalized') ...
                ], ...
            'CLOSEREQ', false ...
            );
        pr.f_graph_element = gui.draw();
    else
        gui = get(pr.f_graph_element, 'UserData');
        if get(pr.f_graph_element, 'Visible')
            gui.cb_hide()
        else
            gui.cb_bring_to_front()
        end
    end
        
    pr.update()
    
% % %     % updates and redraws the parent PanelElement as well as all siblings PanelProp's
% % %     pe = get(get(pr.p, 'Parent'), 'UserData');
% % %     pe.update()
% % %     pe.redraw()
end
function cb_select_all(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');
    g = el.get(prop);
    mlist = Graph.getCompatibleMeasureList(el.get('GRAPH_TEMPLATE'));

    pr.selected = [1:1:length(mlist)];

    pr.update()
end
function cb_clear_selection(pr)

    pr.selected = [];

    pr.update()
end
function cb_invert_selection(pr)

    el = pr.get('EL');
    prop = pr.get('PROP');
    g = el.get(prop);
    mlist = Graph.getCompatibleMeasureList(el.get('GRAPH_TEMPLATE'));

    selected_tmp = [1:1:length(mlist)];
    selected_tmp(pr.selected) = [];
    pr.selected = selected_tmp;

    pr.update()
end
function cb_measure_calculate(pr) 

    a = pr.get('EL');
% % %     prop = pr.get('PROP');
% % %     g = el.memorize(prop);
    mlist = Graph.getCompatibleMeasureList(a.get('GRAPH_TEMPLATE'));
    
    wb = braph2waitbar(a.get('WAITBAR'), 0, ['Calculating ' num2str(length(pr.selected))  ' measures ...']);

    for i = 1:1:length(mlist)
        if ismember(i, pr.selected)
            measure = mlist{i};
            
            braph2waitbar(wb, .1 + .9 * i / length(pr.selected), ['Calculating measure ' int2str(i) ' (' measure ') of ' int2str(length(pr.selected)) ' ...'])

            if isa(a.getMeasureEnsemble(measure).getr('M'), 'NoValue')
                a.getMeasureEnsemble(measure).memorize('M');
            end
        end
    end
    
    braph2waitbar(wb, 'close')

	pr.update();
end
function cb_measure_open_plots(pr) 

    a = pr.get('EL');
% % %     prop = pr.get('PROP');
% % %     g = a.memorize(prop);
    
    mlist = Graph.getCompatibleMeasureList(a.get('GRAPH_TEMPLATE'));
    
    f = ancestor(pr.p, 'figure'); % parent GUI 
    N = ceil(sqrt(length(mlist))); % number of row and columns of figures
    
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        measure = mlist{i};

        me = a.getMeasureEnsemble(measure);
        if length(pr.f_measure_plots) < i || ~check_graphics(pr.f_measure_plots{i}, 'figure')
            pr.f_measure_plots{i} = GUIFig( ...
                'PF', me.memorize('PFME'), ... % ensure that the property is stored
                'WAITBAR', Callback('EL', pr, 'TAG', 'WAITBAR'), ...
                'NAME', ['Figure - ' me.get('ID') '@' a.get('ID') ' - ' BRAPH2.STR], ...
                'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ...
                    y0(f, 'normalized') ...
                    w(f, 'normalized') * 3 ...
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ...
                    ], ...
                'CLOSEREQ', false ...
                ).draw();
        else
            figure(pr.f_measure_plots{i})
        end
    end
end
function cb_measure_hide_plots(pr) 

    % hides selected subfigures
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        if length(pr.f_measure_plots) >= i
            f_measure_plot = pr.f_measure_plots{i};
            if check_graphics(f_measure_plot, 'figure')
                gui = get(f_measure_plot, 'UserData');
                gui.cb_hide()
            end
        end
    end
end
function cb_measure_open_elements(pr) 

    a = pr.get('EL');
% % %     prop = pr.get('PROP');
% % %     g = a.memorize(prop);
    
    mlist = Graph.getCompatibleMeasureList(a.get('GRAPH_TEMPLATE'));
    
    f = ancestor(pr.p, 'figure'); % parent GUI 
    N = ceil(sqrt(length(mlist))); % number of row and columns of figures
    
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        measure = mlist{i};

        me = a.getMeasureEnsemble(measure);
        if length(pr.f_measure_elements) < i || ~check_graphics(pr.f_measure_elements{i}, 'figure')
            pr.f_measure_elements{i} = GUIElement( ...
                'PE', me, ... 
                'POSITION', [ ...
                    x0(f, 'normalized') + w(f, 'normalized') + mod(i - 1, N) * (1 - x0(f, 'normalized') - 2 * w(f, 'normalized')) / N ... % x = (f_gr_x + f_gr_w) / screen_w + mod(selected_it - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
                    y0(f, 'normalized') ... % y = f_gr_y / screen_h;
                    w(f, 'normalized') ... % w = f_gr_w / screen_w;
                    .5 * h(f, 'normalized') + .5 * h(f, 'normalized') * (N - floor((i - .5) / N )) / N ... % h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_it - .5) / N)) / N / screen_h;
                    ], ...
                'CLOSEREQ', false ...
                ).draw();
        else
            figure(pr.f_measure_elements{i})
        end
    end
end
function cb_measure_hide_elements(pr) 

    % hides selected subfigures
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        if length(pr.f_measure_elements) >= i
            f_measure_element = pr.f_measure_elements{i};
            if check_graphics(f_measure_element, 'figure')
                gui = get(f_measure_element, 'UserData');
                gui.cb_hide()
            end
        end
    end
end
function cb_measure_open_brain_graph(pr)
    a = pr.get('EL');
    
    mlist = Graph.getCompatibleMeasureList(a.get('GRAPH_TEMPLATE'));
    
    f = ancestor(pr.p, 'figure'); % parent GUI 
    N = ceil(sqrt(length(mlist))); % number of row and columns of figures
    
    for s = 1:1:length(pr.selected)
        i = pr.selected(s);
        
        measure = mlist{i};

        m = a.getMeasureEnsemble(measure);
        if Measure.is_nodal(m.get('measure'))
            if length(pr.f_brain_graphs) < i || ~check_graphics(pr.f_brain_graphs{i}, 'figure')
                pr.f_brain_graphs{i} = GUIFig( ...
                    'PF', m.memorize('PFBG'), ... % ensure that the property is stored
                    'WAITBAR', Callback('EL', pr, 'TAG', 'WAITBAR'), ...
                    'NAME', ['Figure - ' m.get('ID') '@' a.get('ID') ' - ' BRAPH2.STR], ...
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
    
    % bring to front graph plot figure
    if check_graphics(pr.f_graph_plot, 'figure')
        figure(pr.f_graph_plot)
        set(pr.f_graph_plot, ...
            'Visible', 'on', ...
            'WindowState', 'normal' ...
            )        
    end
    
    % bring to front graph element figure
    if check_graphics(pr.f_graph_element, 'figure')
        figure(pr.f_graph_element)
        set(pr.f_graph_element, ...
            'Visible', 'on', ...
            'WindowState', 'normal' ...
            )        
    end
    
    % brings to front measure plot subfigures
    for i = 1:1:length(pr.f_measure_plots)
        f_measure_plot = pr.f_measure_plots{i};
        if check_graphics(f_measure_plot, 'figure')
            gui = get(f_measure_plot, 'UserData');
            gui.cb_bring_to_front()
        end
    end
    
    % brings to front measure element subfigures
    for i = 1:1:length(pr.f_measure_elements)
        f_measure_plot = pr.f_measure_elements{i};
        if check_graphics(f_measure_plot, 'figure')
            gui = get(f_measure_plot, 'UserData');
            gui.cb_bring_to_front()
        end
    end    
    
    % brings to front measure element subfigures
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
    
    % hide callback graph plot figure
    if check_graphics(pr.f_graph_plot, 'figure')
        set(pr.f_graph_plot, 'Visible', 'off')
    end
    
    % hide callback graph element figure
    if check_graphics(pr.f_graph_element, 'figure')
        set(pr.f_graph_element, 'Visible', 'off')
    end
    
    % hides measure plot subfigures
    for i = 1:1:length(pr.f_measure_plots)
        f_measure_plot = pr.f_measure_plots{i};
        if check_graphics(f_measure_plot, 'figure')
            gui = get(f_measure_plot, 'UserData');
            gui.cb_hide()
        end
    end
    
    % hides measure element subfigures
    for i = 1:1:length(pr.f_measure_elements)
        f_measure_plot = pr.f_measure_elements{i};
        if check_graphics(f_measure_plot, 'figure')
            gui = get(f_measure_plot, 'UserData');
            gui.cb_hide()
        end
    end    
    
    % hides measure element subfigures
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

    % close callback graph plot figure
    if check_graphics(pr.f_graph_plot, 'figure')
        close(pr.f_graph_plot)
    end
    
    % close callback graph element figure
    if check_graphics(pr.f_graph_element, 'figure')
        close(pr.f_graph_element)
    end
    
    % closes measure plot subfigures
    for i = 1:1:length(pr.f_measure_plots)
        f_measure_plot = pr.f_measure_plots{i};
        if check_graphics(f_measure_plot, 'figure')
            gui = get(f_measure_plot, 'UserData');
            gui.cb_close()
        end
    end
    
    % closes measure element subfigures
    for i = 1:1:length(pr.f_measure_elements)
        f_measure_element = pr.f_measure_elements{i};
        if check_graphics(f_measure_element, 'figure')
            gui = get(f_measure_element, 'UserData');
            gui.cb_close()
        end
    end
    
    % closes measure element subfigures
    for i = 1:1:length(pr.f_brain_graphs)
        f_brain_graph = pr.f_brain_graphs{i};
        if check_graphics(f_brain_graph, 'figure')
            gui = get(f_brain_graph, 'UserData');
            gui.cb_close()
        end
    end
end