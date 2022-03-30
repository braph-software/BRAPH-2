%% ¡header!
PPNNData_Measure < PlotProp (pr, plot property graph) is afor yuwei.

%%% ¡description!
PPNNData_Measure for yuwei

CALLBACKS - These are callback functions:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure

%%% ¡seealso!
GUI, PlotElement, PlotProp

%% ¡properties!
p
measure_tbl
measure_btn
select_all_btn
mlist
selected
already_calculated
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

    if ~check_graphics(pr.graph_btn, 'pushbutton') && ~pr.get_button_condition() && ...
            isempty(pr.measure_tbl) || ~check_graphics(pr.measure_tbl, 'uitable')
 

        pr.mlist = [];

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
        
         % maybe a select all
        pr.select_all_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Tag', 'Select_all_button', ...
            'Units', 'normalized', ...
            'String', 'Select All', ...
            'TooltipString', 'Select alla measures in the table', ...
            'Position', [.01 .02 .48 .09], ...
            'Visible', 'off', ...
            'Callback', {@cb_select_all} ...
            );

        % measure button
        pr.measure_btn = uicontrol( ...
            'Parent', pr.p, ...
            'Style', 'pushbutton', ...
            'Tag', 'measure_button', ...
            'Units', 'normalized', ...
            'String', 'Calculate Measures', ...
            'TooltipString', 'Calculate Selected Measures', ...
            'Position', [.51 .02 .48 .09], ...
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
        pr.cb_measure_calc()
    end
    function cb_select_all(~, ~)
        pr.selected = (1:1:length(pr.mlist))';
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
    button_state = pr.get_button_condition();

    if ~button_state
        
        set(pr.measure_tbl, 'Visible', 'off')
        set(pr.measure_btn, 'Visible', 'off')
        set(pr.select_all_btn, 'Visible', 'off')
        pr.graph = [];
        pr.already_calculated = [];
    else
        
        sub = gr1_nn.get(5).getItem(1); % change to tag
        pr.graph = sub.get('G');
        
        % visible gui
        set(pr.measure_tbl, 'Visible', 'on')
        set(pr.measure_btn, 'Visible', 'on')
        set(pr.select_all_btn, 'Visible', 'on')

        if  ~isa(pr.graph, 'NoValue') && isa(pr.graph, 'Graph')
            if isempty(pr.mlist)
                pr.mlist = Graph.getCompatibleMeasureList(pr.graph);
            end
            pr.already_calculated = pr.is_measure_calculated();
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

            row_names = cell(length(pr.already_calculated), 1);
            for i = 1:length(pr.already_calculated)
                if pr.already_calculated{i}
                    row_names{i} = 'C';
                else
                    row_names{i} = '';
                end
            end
            set(pr.measure_tbl, 'RowName', row_names)
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

    if pr.get_button_condition()
        if  ~isempty(pr.measure_tbl) && check_graphics(pr.measure_tbl, 'uitable')
        set(pr.measure_tbl, ...
        'Units', 'normalized', ...
        'Position', [.01 .13 .98 (Dh/(h+Dh)-.27)] ...
        )
        end
         pr.redraw@PlotProp('Height', (h + Dh)*1.5, varargin{:})
    else
        if  ~isempty(pr.measure_tbl) && isgraphics(pr.measure_tbl, 'uitable')
            set(pr.measure_tbl, ...
                'Units', 'normalized', ...
                'Position', [.01 .13 .98 (Dh/(h+Dh)-.32)], ...
                'Visible', 'off' ...
                )
        end
        pr.redraw@PlotProp(varargin{:})        
    end
end
function cb_measure_calc(pr)
    el = pr.get('EL');
    measure_short_list = pr.mlist(pr.selected);

    el.set('Measures', measure_short_list); % maybe its locked... sooo think when its possible to modify
    pr.update();
end
function list =  is_measure_calculated(pr)
    % IS_MEASURE_CALCULATED checks if a measure has been calculated for the graph.
    %
    % LIST = IS_MEASURE_CALCULATED(PR) returns an array with the check for
    %  previously calculated measures. C if a measures has been calculated
    %  and NC for nor calculated measures.
    %
    % See also get_button_condition.

    el = pr.get('EL');
    measure_dict = el.get('ME_DICT');
    measure_list = pr.mlist;
    calculated_list = cell(size(measure_list, 2), 1);
    if measure_dict.length() > 0
        for i = 1:length(measure_list)
            measure = measure_list{i};
            if any(cellfun(@(x) isequal(measure, x.get('ID')), measure_dict.getItems()))
                calculated_list{i} = 1;
            else
                calculated_list{i} = 0;
            end
        end
    else
        [calculated_list{:}] = deal(0);
    end
    list = calculated_list;
    end
function state = get_button_condition(pr)
    % GET_BUTTON_CONDITION returns the calculate button state.
    %
    % STATE = GET_BUTTON_CONDITION(PR) returns the calculate button state.
    %
    % see also is_measure_calculated.
    
    plot_prop_children = get(pr.p, 'Children');
    state = 0;
    for i = 1:length(plot_prop_children)
        pp_c = plot_prop_children(i);
        if check_graphics(pp_c, 'pushbutton') && isequal(pp_c.Tag, 'button_calc')
            if isequal(pp_c.Enable, 'off')
                state = 1;            
            end
        end
    end

end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to front the figure and its settings figure.
    %
    % CB_BRING_TO_FRONT(PR) brings to front the figure and its
    %  settings figure.
    %
    % See also cb_hide, cb_close.

    % brings to front settings panel
    pr.cb_bring_to_front@PlotProp();
    
    % bring to front measure class guis
    for i = 1:length(pr.f_m)
        f_m = pr.f_m{i};
        if check_graphics(f_m, 'figure')
            gui = get(f_m, 'UserData');
            pe = gui.get('PE');
            pe.cb_bring_to_front()
        end
    end

end
function cb_hide(pr)
    %CB_HIDE hides the figure and its settings figure.
    %
    % CB_HIDE(PR) hides the figure and its settings figure.
    %
    % See also cb_bring_to_front, cb_close.

    % hides settings panel
    pr.cb_hide@PlotProp();
    
    % bring to front measure class guis
    for i = 1:length(pr.f_m)
        f_m = pr.f_m{i};
        if check_graphics(f_m, 'figure')
            gui = get(f_m, 'UserData');
            pe = gui.get('PE');
            pe.cb_hide()
        end
    end
    
end
function cb_close(pr)
    %CB_CLOSE closes the figure.
    %
    % CB_CLOSE(PR) closes the figure and its children figures.
    %
    % See also cb_bring_to_front, cd_hide.

    % closes measure class guis
    for i = 1:length(pr.f_m)
        f_m = pr.f_m{i};
        if check_graphics(f_m, 'figure')
            close(f_m)
        end
    end
    
end
