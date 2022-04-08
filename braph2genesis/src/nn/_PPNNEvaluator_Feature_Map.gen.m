%% ¡header!
PPNNEvaluator_Feature_Map < PlotPropCell (pr, plot property featur map) is a plot of the feature map.

%%% ¡description!
PPNNEvaluator_Feature_Map plots the feature map with in a brain atlas.
CALLBACK - This is a callback function:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the brain viewer
    pr.<strong>cb_hide</strong>() - hides the brain viewer
    pr.<strong>cb_close</strong>() - closes the brain viewer

%%% ¡seealso!
GUI, PlotElement, PlotProp, PlotPropcell

%% ¡properties!
p
table_value_cell
plot_brain_btn
f_brain
f_settings

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the panel of the cell property.
    %
    % DRAW(PR) draws the panel of the cell property.
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
    
    pr.p = draw@PlotPropCell(pr, varargin{:});
    
    pr.plot_brain_btn = uicontrol(pr.p, ...
        'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [0.01 0.01 0.97 0.1], ...
        'String', 'Plot the map', ...
        'TooltipString', 'Plot the feature map in a brain surface.' , ...
        'Callback', {@cb_plot_brain} ...
        );
    
    function cb_plot_brain(~, ~)
        drawnow()
        pr.plot_brain_surface();
        pr.update()
    end
    
    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content and permission of the table.
    %
    % UPDATE(PR) updates the content and permission of the table.
    %
    % See also draw, redraw, refresh, PlotElement.
    
    update@PlotProp(pr)
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        % don't plot anything for a result not yet calculated
    else
        value_cell = el.get(prop);
        if isempty(pr.table_value_cell) || ~isequal(size(pr.table_value_cell), size(value_cell))
            pr.table_value_cell = cell(size(value_cell));
        end
        for r = 1:1:size(pr.table_value_cell, 1)
            for c = 1:1:size(pr.table_value_cell, 2)
                if ~check_graphics(pr.table_value_cell{r, c}, 'uitable')
                    pr.table_value_cell{r, c} = uitable('Parent', pr.p);
                end
                set(pr.table_value_cell{r, c}, ...
                    'Data', value_cell{r, c}, ...
                    'Tooltip', [num2str(r) ' ' num2str(c)], ...
                    'FontUnits', BRAPH2.FONTUNITS, ...
                    'FontSize', BRAPH2.FONTSIZE, ...
                    'ColumnEditable', true, ...
                    'CellEditCallback', {@cb_table_value_cell, r, c} ...
                    )
            end
        end
    end

    function cb_table_value_cell(~, event, r, c) % (src, event)
        pr.cb_table_value_cell(r, c, event.Indices(1), event.Indices(2), event.NewData)
    end

    if check_graphics(pr.f_brain, 'figure')
        % prevents multiple PlotBrainAtlas figure creations (re-enabled when figure is closed)
        set(pr.plot_brain_btn, 'Enable', 'off');
    else
        % enables creation of a PlotBrainAtlas figure
        set(pr.plot_brain_btn, 'Enable', 'on');
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
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=1.8 minimum height when no cell to show
    %  - DHEIGHT=20 additional height when data to show
    %
    % See also draw, update, refresh, PlotElement.
    
    
    redraw@PlotProp(pr);
    
    [h, varargin] = get_and_remove_from_varargin(1.8, 'Height', varargin);
    [Dh, varargin] = get_and_remove_from_varargin(18, 'DHeight', varargin);
    child_uitable = [];
    children = pr.p.Children;
    for i = 1:length(children)
        if children(i).Type == "uitable"
            child_uitable = children(i);
            break
        end
    end
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    value = el.getr(prop);
    
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        if isgraphics(child_uitable)
            set(child_uitable, 'Visible', 'off');
        end
        set(pr.plot_brain_btn, 'Visible', 'off');
        if isgraphics(pr.f_brain)
            delete(pr.f_brain)
        end
        pr.redraw@PlotProp('Height', h, varargin{:})
    else
        value_cell = el.get(prop);
    
        if isempty(value_cell)
            set(pr.plot_brain_btn, 'Visible', 'off');
            if isgraphics(child_uitable)
                set(child_uitable, 'Visible', 'off');
            end
            pr.redraw@PlotProp('Height', h, varargin{:})
        else
            set(pr.plot_brain_btn, 'Visible', 'on');
            if isgraphics(child_uitable)
                set(child_uitable, 'Visible', 'on');
            end
            pr.redraw@PlotProp('Height', h + Dh + 4, varargin{:})
        end
    
        for r = 1:1:size(value_cell, 1)
            for c = 1:1:size(value_cell, 2)
                table_w = (.98 - .01) / size(value_cell, 2);
                table_h = (Dh / (h + Dh) - .01) / size(value_cell, 1);
                set(pr.table_value_cell{r, c}, ...
                    'Units', 'normalized', ...
                    'Position', ...
                    [ ...
                    .01 + (c - 1) * table_w ...
                    .02 + (size(value_cell, 1) - r) * table_h + 0.1 ...
                    table_w ...
                    table_h - 0.1  ...
                    ] ...
                    )
            end
        end
    end
end
function plot_brain_surface(pr)
    % define constants or variables
    el = pr.get('el');
    prop = pr.get('prop');
    sub = el.get('GR').get('SUB_DICT').getItem(1);
    surf = sub.get('BA').get('SURF');
    
    f_ba = ancestor(pr.p, 'Figure'); % BrainAtlas GUI
    f_ba_x = Plot.x0(f_ba, 'pixels');
    f_ba_y = Plot.y0(f_ba, 'pixels');
    f_ba_w = Plot.w(f_ba, 'pixels');
    f_ba_h = Plot.h(f_ba, 'pixels');
    
    screen_x = Plot.x0(0, 'pixels');
    screen_y = Plot.y0(0, 'pixels');
    screen_w = Plot.w(0, 'pixels');
    screen_h = Plot.h(0, 'pixels');
    
    % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
    x = f_ba_x + f_ba_w;
    h = f_ba_h / 1.61;
    y = f_ba_y + f_ba_h - h;
    w = f_ba_w * 1.61;
    
    pr.f_brain = figure( ...
        'NumberTitle', 'off', ...
        'Units', 'normalized', ...
        'Position', [x/screen_w y/screen_h w/screen_w h/screen_h], ...
        'CloseRequestFcn', {@cb_f_pba_close} ...
        );
    
    set_braph2_icon(pr.f_brain)
    set(pr.f_brain, 'Name', [pr.get('el').getClass() ' - ' pr.get('el').get('ID')])
    menu_about = BRAPH2.add_menu_about(pr.f_brain);
    ui_toolbar = findall(pr.f_brain, 'Tag', 'FigureToolBar');
    delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
    delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
    
    pba = PlotBrainNN('SURF', surf, 'NNEL', el, 'ATLAS', sub.get('BA'));
    pba.draw('Parent', pr.f_brain)
    
    % Plot settings panel
    pr.f_settings = pba.settings();
    set(pr.f_settings, 'Position', [x/screen_w f_ba_y/screen_h w/screen_w (f_ba_h-h)/screen_h]);
    pr.f_settings.OuterPosition(4) = (f_ba_h-h)/screen_h;
    pr.f_settings.OuterPosition(2) = f_ba_y/screen_h;

    function cb_f_pba_close(~, ~)
        delete(pr.f_brain)
        pr.update()
    end
end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to front the brain atlas figure and its settings figure.
    %
    % CB_BRING_TO_FRONT(PR) brings to front the brain atlas figure and its
    %  settings figure.
    %
    % See also cb_hide, cb_close.

    % bring to front settings panel
    pr.cb_bring_to_front@PlotProp();
    
    if isgraphics(pr.f_brain)
        set(pr.f_brain, 'Visible', 'on');
        set(pr.f_settings, 'Visible', 'on');
    end
end
function cb_hide(pr)
    %CB_HIDE hides the brain atlas figure and its settings figure.
    %
    % CB_HIDE(PR) hides the brain atlas figure and its settings figure.
    %
    % See also cb_bring_to_front, cb_close.

    % hide settings panel
    pr.cb_hide@PlotProp();

    if isgraphics(pr.f_brain)
        set(pr.f_brain, 'Visible', 'off');
        set(pr.f_settings, 'Visible', 'off');
    end
end
function cb_close(pr)
    %CB_CLOSE closes the figure.
    %
    % CB_CLOSE(PR) closes the figure and its children figures.
    %
    % See also cb_bring_to_front, cd_hide.
    
    pr.cb_close@PlotProp();

    if isgraphics(pr.f_brain)
        delete(pr.f_brain);
    end
end
