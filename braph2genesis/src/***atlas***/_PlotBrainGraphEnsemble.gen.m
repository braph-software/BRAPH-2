%% ¡header!
PlotBrainGraphEnsemble < PlotBrainAtlas (pl, plot brain graph) is a plot of a brain graph of a measure ensemble.

%%% ¡description!
PlotBrainGraphEnsemble manages the plot of the graph edges, arrows and cylinders.
PlotBrainGraphEnsemble utilizes the surface created from PlotBrainAtlas to
integrate the regions to a brain surface.

CALLBACKS - These are callback functions:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the measure figure and its settings figure
    pr.<strong>cb_hide</strong>() - hides the measure figure and its settings figure
    pr.<strong>cb_close</strong>() - closes the measure figure and its settings figure

%%% ¡seealso!
Plot, BrainAtlas, PlotBrainSurface, PlotBrainAtlas, MeasureEnsemble.

%% ¡constants!
PLOT_LINESTYLE_TAG = { ...
    '-' ...
    ':' ...
    '-.' ...
    '--' ...
    'none' ...
    }

PLOT_LINESTYLE_NAME = { ...
    'solid' ...
    'dotted' ...
    'dashdot' ...
    'dashed' ...
    'none' ...
    }

% Symbols
INIT_SYM_MARKER = 'o'
INIT_SYM_SIZE = 1
INIT_SYM_EDGE_COLOR = 'b'
INIT_SYM_FACE_COLOR = 'b'

% Spheres
INIT_SPH_EDGE_COLOR = 'none'
INIT_SPH_EDGE_ALPHA = .5
INIT_SPH_FACE_COLOR = [.9 .4 .1]
INIT_SPH_FACE_ALPHA = .5
INIT_SPH_R = 1

% IDs
INIT_ID_FONT_SIZE = 1
INIT_ID_FONT_NAME = 'helvetica'
INIT_ID_FONT_COLOR = [0 0 0]
INIT_ID_FONT_INTERPRETER = 'none'

% Labels
INIT_LAB_FONT_SIZE = 1
INIT_LAB_FONT_NAME = 'helvetica'
INIT_LAB_FONT_COLOR = [0 0 0]
INIT_LAB_FONT_INTERPRETER = 'none'

%% ¡properties!
edges  % structure of 2D cell arrays containing edge properties
f_edges_settings  % edge settings figure handle
f_arrs_settings  % arrow settings figure handle
f_cyls_settings  % cylinder settings figure handle

% edge line
INIT_LIN_COLOR = [0 0 0];

% Arrows
INIT_ARR_COLOR = [0 0 0];
INIT_ARR_SWIDTH = .1;
INIT_ARR_HLENGTH = 1;
INIT_ARR_HWIDTH = 1;
INIT_ARR_HNODE = .5;
INIT_ARR_N = 32;

% Cylinders
INIT_CYL_COLOR = [0 0 0];
INIT_CYL_R = .1;
INIT_CYL_N = 32;

h_axes
pp
TABBKGCOLOR = [.98 .95 .95];
f_settings
f_graph_settings
f_measures_settings

%% ¡props!
%%% ¡prop!
ME (metadata, item) is the measure.

%%% ¡prop!
TYPE (metadata, string) is the type of measure.

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the brain atlas graph graphical panel.
    %
    % DRAW(PL) draws the brain atlas graph graphical panel.
    %
    % H = DRAW(PL) returns a handle to the brain atlas graph graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain atlas graph graphical panel H.
    %
    % see also settings, uipanel, isgraphics.

    pl.pp = draw@PlotBrainAtlas(pl, varargin{:});

    if isempty(pl.h_axes) || ~isgraphics(pl.h_axes, 'axes')
        pl.h_axes =  get(pl.pp, 'Children');
    end

    % close function
    set(pl.pp, 'DeleteFcn', {@close_f_settings}, ...
        varargin{:})

        function close_f_settings(~, ~)
            if ~isempty(pl.f_settings) && isgraphics(pl.f_settings, 'figure')
                close(pl.f_settings)
            end
        end

    brain_regions_length = pl.get('ATLAS').get('BR_DICT').length();
    pl.edges.h = NaN(brain_regions_length);
    pl.edges.arr = NaN(brain_regions_length);
    pl.edges.cyl = NaN(brain_regions_length);
    pl.edges.texts = NaN(brain_regions_length);
    pl.edges.X1 = zeros(brain_regions_length, 1);
    pl.edges.Y1 = zeros(brain_regions_length, 1);
    pl.edges.Z1 = zeros(brain_regions_length, 1);
    pl.edges.X2 = zeros(brain_regions_length, 1);
    pl.edges.Y2 = zeros(brain_regions_length, 1);
    pl.edges.Z2 = zeros(brain_regions_length, 1);

    % output
    if nargout > 0
        h_panel = pl.pp;
    end
end
function f_settings  = settings(pl, varargin)
    %SETTINGS opens the brain surface property editor GUI.
    %
    % SETTINGS(PL) allows the user to specify the properties of the brain
    %  atlas plot by opening a GUI property editor.
    %
    % F = SETTINGS(PL) returns a handle to the brain atlas property editor GUI.
    %
    % SETTINGS(PL, 'Property', VALUE, ...) sets the properties of the brain
    %  atlas property editor GUI with custom property-value couples.
    %  All standard plot properties of figure can be used.
    %
    % See also draw, figure, isgraphics.
    
    f_settings = settings@PlotBrainAtlas(pl, varargin{:});
    pl.f_settings = f_settings;
    
    ui_toolbar = findall(f_settings, 'Tag', 'FigureToolBar');
    ui_toolbar_separator = uipushtool(ui_toolbar, 'Separator', 'on', 'Visible', 'off');
    
    ui_toolbar_mcr = uipushtool(ui_toolbar, ...
        'Separator', 'on', ...
        'TooltipString', 'Brain Regions', ...
        'CData', imread('icon_measure_panel.png'), ...
        'ClickedCallback', {@cb_panel_mcr});   
    
    ui_toolbar_graph = uipushtool(ui_toolbar, ...
        'Separator', 'on', ...
        'TooltipString', 'Brain Connections', ...
        'CData', imread('icon_graph_panel.png'), ...
        'ClickedCallback', {@cb_panel_graph});
    
    ui_toolbar_surface = uipushtool(ui_toolbar, ...
        'Separator', 'on', ...
        'TooltipString', 'Brain Surface', ...
        'CData', imread('icon_surface_panel.png'), ...
        'ClickedCallback', {@cb_panel_surface});
    
    % declare two more panels and get the initial one
    surface_panel = getSurfacePanel();
    ui_panel_graph = uipanel(f_settings, ...
        'Units', 'normalized', ...
        'BackgroundColor', [1 .9725 .929], ...
        'Visible', 'off', ...
        'Enable', 'off', ...
        'Position', [0 0 1 1]);
    
    ui_panel_mcr = uipanel(f_settings, ...
        'Units', 'normalized', ...
        'BackgroundColor', [1 .9725 .929], ...
        'Visible', 'off', ...
        'Enable', 'off', ...
        'Position', [0 0 1 1]);
    
    function cb_panel_surface(~, ~)
        set(surface_panel, 'Visible', 'on', 'Enable', 'on')
        set(ui_panel_graph, 'Visible', 'off', 'Enable', 'off')
        set(ui_panel_mcr, 'Visible', 'off', 'Enable', 'off')
    end
    function cb_panel_graph(~, ~)
        set(surface_panel, 'Visible', 'off', 'Enable', 'off')
        set(ui_panel_graph, 'Visible', 'on', 'Enable', 'on')
        set(ui_panel_mcr, 'Visible', 'off', 'Enable', 'off')
        if  isempty(pl.f_graph_settings)
            pl.getBrainGraphPanel(ui_panel_graph);
        end
    end
    function cb_panel_mcr(~, ~)
        set(surface_panel, 'Visible', 'off', 'Enable', 'off')
        set(ui_panel_graph, 'Visible', 'off', 'Enable', 'off')
        set(ui_panel_mcr, 'Visible', 'on', 'Enable', 'on')
        if isempty(pl.f_measures_settings)
            pl.getMCRPanel(ui_panel_mcr);
        end
    end
    function h_panel = getSurfacePanel()
        h_panel = get(f_settings, 'Child');
        ui_title = uicontrol(h_panel, ...
            'Style', 'text', ...
            'String', 'Surface Panel', ...
            'Units', 'normalized', ...
            'BackgroundColor', [1 .9725 .929], ...
            'HorizontalAlignment', 'left', ...
            'FontWeight', 'bold', ...
            'Position', [0.01 .91 0.3 0.08]);
    end

    cb_panel_mcr()

    if nargout > 0
        f_settings = pl.f_settings;
    end
end
function cb_bring_to_front(pl)
    %CB_BRING_TO_FRONT brings to front the brain view figure and its settings figure.
    %
    % CB_BRING_TO_FRONT(PR) brings to front the brain view figure and its
    %  settings figure.
    %
    % See also cb_hide.
    
    pl.cb_bring_to_front@PlotBrainAtlas();    
    if check_graphics(pl.f_graph_settings, 'figure')
        set(pl.f_graph_settings, 'Visible' , 'on', 'WindowState', 'normal');
    end
    if check_graphics(pl.f_measures_settings, 'figure')
        set(pl.f_measures_settings, 'Visible' , 'on', 'WindowState', 'normal');
    end    
end
function cb_hide(pl)
    %CB_HIDE hides the brain view figure and its settings figure.
    %
    % CB_HIDE(PR) hides the brain view figure and its settings figure.
    %
    % See also cb_bring_to_front.
    
    pl.cb_hide@PlotBrainAtlas();  
    
    if check_graphics(pl.f_graph_settings, 'figure')
        set(pl.f_graph_settings, 'Visible' , 'off');
    end
    if check_graphics(pl.f_measures_settings, 'figure')
        set(pl.f_measures_settings, 'Visible' , 'off');
    end   
end

function h = link_edge(pl, i, j, varargin)
    % LINK_EDGE plots edge link as line
    %
    % LINK_EDGE(BG, I, J) plots the edge link from the brain regions
    % I to J as a line, if not plotted.
    %
    % H = LINK_EDGE(BG, I, J) returns the handle to the edge link
    % from the brain region I to J.
    %
    % LINK_EDGE(BG, I, J, PROPERTY, VALUE, ...) sets the property
    % of the edge link line PROPERTY to VALUE.
    % All standard plot properties of plot3 can be used.
    % The line properties can also be changed when hidden.
    %
    % See also PlotBrainGraph, plot3, link_edges, text_edge.

    if i == j  % removes diagonal
        return;
    end
    % get brain regions

    br_1 = pl.get('ATLAS').get('BR_DICT').getItem(i);
    br_2 = pl.get('ATLAS').get('BR_DICT').getItem(j);
    % get coordinates
    X1 = br_1.get('X');
    Y1 = br_1.get('Y');
    Z1 = br_1.get('Z');

    X2 = br_2.get('X');
    Y2 = br_2.get('Y');
    Z2 = br_2.get('Z');

    if ~ishandle(pl.edges.h(j, i))
        if ~ishandle(pl.edges.h(i, j))

            pl.edges.h(i, j) = plot3( ...
                pl.get_axes(), ...
                [X1 X2], ...
                [Y1 Y2], ...
                [Z1 Z2], ...
                'Color', pl.INIT_LIN_COLOR, ...
                'LineStyle', '-', 'LineWidth', 1);
        else
            x1 = pl.edges.X1(i, j);
            y1 = pl.edges.Y1(i, j);
            z1 = pl.edges.Z1(i, j);

            x2 = pl.edges.X2(i, j);
            y2 = pl.edges.Y2(i, j);
            z2 = pl.edges.Z2(i, j);

            if x1 ~= X1 || y1 ~= Y1 || z1 ~= Z1 ...
                    || x2 ~= X2 || y2 ~= Y2 || z2 ~= Z2

                set(pl.edges.h(i, j), 'XData', [X1 X2]);
                set(pl.edges.h(i, j), 'YData', [Y1 Y2]);
                set(pl.edges.h(i, j), 'ZData', [Z1 Z2]);
            end
        end
    else
        pl.edges.h(i, j) = pl.edges.h(j, i);
    end
    pl.edges.X1(i, j) = X1;
    pl.edges.Y1(i, j) = Y1;
    pl.edges.Z1(i, j) = Z1;

    pl.edges.X2(i, j) = X2;
    pl.edges.Y2(i, j) = Y2;
    pl.edges.Z2(i, j) = Z2;

    % sets properties
    for n = 1:2:length(varargin)
        switch lower(varargin{n})
            case 'linestyle'
                set(pl.edges.h(i, j),'LineStyle', varargin{n + 1});
            case 'linewidth'
                set(pl.edges.h(i, j),'LineWidth', varargin{n + 1});
            case 'color'
                set(pl.edges.h(i, j),'Color', varargin{n + 1});
            otherwise
                set(pl.edges.h(i, j),varargin{n}, varargin{n + 1});
        end
    end

    if nargout>0
        h = pl.edges.h(i, j);
    end
end
function link_edge_on(pl, i, j)
    % LINK_EDGE_ON shows a edge link
    %
    % LINK_EDGE_ON(BG, I, J) shows the edge link from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_off.

    if ishandle(pl.edges.h(i, j))
        set(pl.edges.h(i, j), 'Visible', 'on')
    end
end
function link_edge_off(pl, i, j)
    % LINK_EDGE_OFF hides a edge link
    %
    % LINK_EDGE_OFF(BG, I, J) hides the edge link from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if ishandle(pl.edges.h(i, j))
        set(pl.edges.h(i, j), 'Visible', 'off')
    end
end
function link_edges(pl, i_vec, j_vec, varargin)
    % LINK_EDGES plots multiple edge links as lines
    %
    % LINK_EDGES(BG, I_VEC, J_VEC) plots the edge links from the
    % brain regions specified in I_VEC to the ones specified in
    % J_VEC, if not plotted. I_VEC and J_VEC need not be the same
    % size.
    %
    % LINK_EDGES(BG, [], []) plots the edge links between all
    % possible brain region combinations.
    %
    % LINK_EDGES(BG, I_VEC, J_VEC, PROPERTY, RULE) sets the property
    % of the multiple edge links' PROPERTY to RULE.
    % All standard plot properties of plot3 can be used.
    % The line properties can also be changed when hidden.
    %
    % See also PlotBrainGraph, plot3, link_edge.

    if nargin < 2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pl.get('ATLAS').get('BR_DICT').length()
            for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                pl.link_edge(i, j, varargin{:})
            end
        end
    else
        if length(i_vec) == 1
            i_vec = i_vec * ones(size(j_vec));
        end
        if length(j_vec) == 1
            j_vec = j_vec * ones(size(i_vec));
        end

        for m = 1:1:length(i_vec)
            pl.link_edge(i_vec(m), j_vec(m), varargin{:})
        end
    end
end
function link_edges_on(pl, i_vec, j_vec)
    % LINK_EDGES_ON shows multiple edge link
    %
    % LINK_EDGES_ON(BG, I, J) shows multiple edge link from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edges, link_edges_off.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pl.get('ATLAS').get('BR_DICT').length()
            for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                pl.link_edge_on(i, j)
            end
        end
    else
        if length(i_vec) == 1
            i_vec = i_vec * ones(size(j_vec));
        end
        if length(j_vec) == 1
            j_vec = j_vec * ones(size(i_vec));
        end

        for m = 1:1:length(i_vec)
            pl.link_edge_on(i_vec(m), j_vec(m))
        end
    end
end
function link_edges_off(pl, i_vec, j_vec)
    % LINK_EDGES_OFF hides multiple edge links
    %
    % LINK_EDGES_OFF(BG, I, J) hides multiple edge links from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pl.get('ATLAS').get('BR_DICT').length()
            for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                pl.link_edge_off(i, j)
            end
        end
    else
        if length(i_vec) == 1
            i_vec = i_vec * ones(size(j_vec));
        end
        if length(j_vec) == 1
            j_vec = j_vec * ones(size(i_vec));
        end

        for m = 1:1:length(i_vec)
            pl.link_edge_off(i_vec(m), j_vec(m))
        end
    end
end
function link_edges_settings(pl, i_vec, j_vec, varargin)
    % LINK_EDGES_SETTINGS sets edges' properties
    %
    % LINK_EDGES_SETTINGS(BG) allows the user to interractively
    % change the edges settings via a graphical user interface.
    %
    % LINK_LINS_SETTINGS(BG, PROPERTY, VALUE, ...) sets the property
    % of the GUI's PROPERTY to VALUES.
    %   Admissible properties are:
    %       FigPosition  -   position of the GUI on the screen
    %       FigColor     -   background color of the GUI
    %       FigName      -   name of the GUI
    %
    % See also PlotBrainGraph.

    atlas_length = pl.get('ATLAS').get('BR_DICT').length();
    data = cell(atlas_length, atlas_length);

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        i_vec = 1:1:atlas_length;
        j_vec = 1:1:atlas_length;
    end
    if length(i_vec) == 1
        i_vec = i_vec * ones(size(j_vec));
    end
    if length(j_vec) == 1
        j_vec = j_vec * ones(size(i_vec));
    end
    for p = 1:1:length(i_vec)
        if i_vec(p) ~= j_vec(p)
            data{i_vec(p), j_vec(p)} = true;
        else
            data{i_vec(p), j_vec(p)} = false;
        end
    end

    set_color = pl.INIT_LIN_COLOR;

    % sets position of figure
    FigPosition = [.50 .30 .30 .30];
    FigColor = pl.TABBKGCOLOR;
    FigName = 'Brain Graph Edges Settings';
    for n = 1:2:length(varargin)
        switch lower(varargin{n})
            case 'figposition'
                FigPosition = varargin{n + 1};
            case 'figcolor'
                FigColor = varargin{n + 1};
            case 'figname'
                FigName = varargin{n + 1};
        end
    end

    % create a figure
    if isempty(pl.f_edges_settings) || ~ishandle(pl.f_edges_settings)
        pl.f_edges_settings = figure('Visible', 'off');
    end
    f = pl.f_edges_settings;
    set(f, 'units', 'normalized')
    set(f, 'Position', FigPosition)
    set(f, 'Color', FigColor)
    set(f, 'Name', FigName)
    set(f, 'MenuBar', 'none')
    set(f, 'Toolbar', 'none')
    set(f, 'NumberTitle', 'off')
    set(f, 'DockControls', 'off')

    ui_table = uitable(f, 'Units', 'normalized');
    set(ui_table, 'BackgroundColor', pl.TABBKGCOLOR)
    set(ui_table, 'Position', [.03 .215 .54 .71])
    set(ui_table, 'ColumnWidth', {40})
    [string{1:atlas_length}] = deal('logical');
    set(ui_table, 'ColumnFormat', string)
    set(ui_table, 'ColumnEditable', true)
    set(ui_table, 'Data', data)
    set(ui_table, 'CellEditCallback', {@cb_table_edit});

    ui_button_show = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized');
    set(ui_button_show, 'Position', [.60 .825 .18 .10])
    set(ui_button_show, 'String', 'Show lines')
    set(ui_button_show, 'TooltipString', 'Show selected lines')
    set(ui_button_show, 'Callback', {@cb_show})

    ui_button_hide = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized' );
    set(ui_button_hide, 'Position', [.80 .825 .18 .10])
    set(ui_button_hide, 'String', 'Hide lines')
    set(ui_button_hide, 'TooltipString', 'Hide selected lines')
    set(ui_button_hide, 'Callback', {@cb_hide})

    ui_popup_style = uicontrol(f, 'Units', 'normalized', 'Style',  'popup', 'String', {''});
    set(ui_popup_style, 'Position', [.62 .575 .35 .10])
    set(ui_popup_style, 'String', PlotBrainGraph.PLOT_LINESTYLE_NAME)
    set(ui_popup_style, 'Value', 1)
    set(ui_popup_style, 'TooltipString', 'Select line style');
    set(ui_popup_style, 'Callback', {@cb_style})

    ui_text_width = uicontrol(f, 'Style', 'text', 'Units', 'normalized');
    set(ui_text_width, 'Position', [.62 .330 .10 .10])
    set(ui_text_width, 'String', 'Link width ')
    set(ui_text_width, 'HorizontalAlignment', 'left')
    set(ui_text_width, 'FontWeight', 'bold')

    ui_edit_width = uicontrol(f, 'Style', 'edit', 'Units', 'normalized');
    set(ui_edit_width, 'Position', [.72 .325 .25 .10])
    set(ui_edit_width, 'HorizontalAlignment', 'center')
    set(ui_edit_width, 'FontWeight', 'bold')
    set(ui_edit_width, 'String', '1')
    set(ui_edit_width, 'Callback', {@cb_width})

    ui_button_linecolor = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized');
    set(ui_button_linecolor, 'ForegroundColor', set_color)
    set(ui_button_linecolor, 'Position', [.62 .075 .35 .10])
    set(ui_button_linecolor, 'String', 'Link Color')
    set(ui_button_linecolor, 'TooltipString', 'Select line color')
    set(ui_button_linecolor, 'Callback', {@cb_linecolor})

    ui_button_clearselection = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized');
    set(ui_button_clearselection, 'Position', [.03 .075 .54 .10])
    set(ui_button_clearselection, 'String', 'Clear Selection')
    set(ui_button_clearselection, 'TooltipString', 'Clear selected links')
    set(ui_button_clearselection, 'Callback', {@cb_clearselection})

        function cb_table_edit(~, event)  % (src, event)
            i = event.Indices(1);
            j = event.Indices(2);

            if i~=j
                if data{i, j} == true
                    data{i, j} = false;
                else
                    data{i, j} = true;
                end
                set(ui_table, 'Data', data)
            end
        end
        function update_link_edges()
            style = pl.PLOT_LINESTYLE_TAG{get(ui_popup_style, 'Value')};
            width = real(str2double(get(ui_edit_width, 'String')));
            indices = find(~cellfun(@isempty, data));

            for m = 1:1:length(indices)
                if data{indices(m)} == 1
                    [i, j] = ind2sub(size(data), indices(m));
                    pl.link_edges(i, j, 'LineStyle', style, 'LineWidth', width, ...
                        'Color', set_color);
                end
            end
        end
        function cb_show(~, ~)  % (src, event)
            indices = find(~cellfun(@isempty, data));

            for m = 1:1:length(indices)
                if data{indices(m)}==1
                    [i, j] = ind2sub(size(data), indices(m));
                    update_link_edges()
                    pl.link_edges_on(i, j)
                end
            end
        end
        function cb_hide(~, ~)  % (src, event)
            indices = find(~cellfun(@isempty, data));

            for m = 1:1:length(indices)
                if data{indices(m)}==1
                    [i, j] = ind2sub(size(data), indices(m));
                    pl.link_edges_off(i, j)
                end
            end
        end
        function cb_style(~, ~)  % (src, event)
            update_link_edges()
        end
        function cb_width(~, ~)  % (src, event)
            width = real(str2double(get(ui_edit_width, 'String')));

            if isempty(width) || width < 1
                set(ui_edit_width, 'String', '1')
            end
            update_link_edges()
        end
        function cb_linecolor(~, ~)  % (src, event)
            set_color_prev = get(ui_button_linecolor, 'ForegroundColor');
            set_color = uisetcolor();
            if length(set_color )== 3
                set(ui_button_linecolor, 'ForegroundColor', set_color)
                update_link_edges()
            else
                set_color = set_color_prev;
            end
        end
        function cb_clearselection(~, ~)  % (src, event)
            [data{:}] = deal(zeros(1));
            set(ui_table, 'Data', data)
        end
    set(f, 'Visible', 'on')
end
function bool = link_edge_is_on(pl, i, j)
    % LINK_EDGE_IS_ON checks if line link is visible
    %
    % BOOL = LINK_EDGE_IS_ON(BG, I, J) returns true if the line link
    % from the brain regions I to J is visible and false otherwise.
    %
    % See also PlotBrainGraph.

    bool = ishandle(pl.edges.h(i, j)) && strcmpi(get(pl.edges.h(i, j), 'Visible'), 'on');
end

function h = arrow_edge(pl, i, j, varargin)
    % ARROW_EDGE plots edge link as an arrow
    %
    % ARROW_EDGE(BG, I, J) plots the edge link from the brain regions
    % I to J as a line, if not plotted.
    %
    % H = ARROW_EDGE(BG, I, J) returns the handle to the edge link
    % from the brain region I to J.
    %
    % ARROW_EDGE(BG, I, J, PROPERTY, VALUE, ...) sets the property
    % of the edge link line PROPERTY to VALUE.
    % All standard plot properties of plot3 can be used.
    % The line properties can also be changed when hidden.
    %
    % See also PlotBrainGraph, plot3, link_edges.

    if i == j  % removes diagonal
        return;
    end
    
    % get brain regions
    br_1 = pl.get('ATLAS').get('BR_DICT').getItem(i);
    br_2 = pl.get('ATLAS').get('BR_DICT').getItem(j);
    % get coordinates
    X1 = br_1.get('X');
    Y1 = br_1.get('Y');
    Z1 = br_1.get('Z');

    X2 = br_2.get('X');
    Y2 = br_2.get('Y');
    Z2 = br_2.get('Z');

    % arrow properties
    color = pl.INIT_ARR_COLOR;
    SWIDTH = pl.INIT_ARR_SWIDTH;
    HLENGTH = pl.INIT_ARR_HLENGTH;
    HWIDTH = pl.INIT_ARR_HWIDTH;
    HNODE = pl.INIT_ARR_HNODE;
    N = pl.INIT_ARR_N;

    if ~ishandle(pl.edges.arr(i, j))

        [X, Y, Z] = arrow3d(X1, Y1, Z1, X2, Y2, Z2,...
            'StemWidth', SWIDTH, ...
            'HeadLength', HLENGTH, ...
            'HeadWidth', HWIDTH, ...
            'HeadNode', HNODE, ...
            'N', N);

        pl.edges.arr(i, j) = surf(X, Y, Z,...
            'EdgeColor', color,...
            'FaceColor', color,...
            'Parent', pl.get_axes());
    else
        x1 = pl.edges.X1(i, j);
        y1 = pl.edges.Y1(i, j);
        z1 = pl.edges.Z1(i, j);

        x2 = pl.edges.X2(i, j);
        y2 = pl.edges.Y2(i, j);
        z2 = pl.edges.Z2(i, j);

        if x1 ~= X1 || y1 ~= Y1 || z1 ~= Z1 ...
                || x2 ~= X2 || y2 ~= Y2 || z2 ~= Z2

            [X, Y, Z] = arrow3d(X1, Y1, Z1, X2, Y2, Z2,...
                'StemWidth', SWIDTH, ...
                'HeadLength', HLENGTH, ...
                'HeadWidth', HWIDTH, ...
                'HeadNode', HNODE, ...
                'N', N);

            set(pl.edges.arr(i, j), 'XData', X);
            set(pl.edges.arr(i, j), 'YData', Y);
            set(pl.edges.arr(i, j), 'ZData', Z);

        end
    end
    pl.edges.X1(i, j) = X1;
    pl.edges.Y1(i, j) = Y1;
    pl.edges.Z1(i, j) = Z1;

    pl.edges.X2(i, j) = X2;
    pl.edges.Y2(i, j) = Y2;
    pl.edges.Z2(i, j) = Z2;

    % sets properties
    for n = 1:2:length(varargin)
        switch lower(varargin{n})
            case 'color'
                set(pl.edges.arr(i, j), 'FaceColor', varargin{n + 1});
                set(pl.edges.arr(i, j), 'EdgeColor', varargin{n + 1});

            otherwise
                set(pl.edges.arr(i, j), varargin{n}, varargin{n + 1});
        end
    end

    if nargout>0
        h = pl.edges.arr(i, j);
    end
end
function arrow_edge_on(pl, i, j)
    % ARROW_EDGE_ON shows a edge link
    %
    % ARROW_EDGE_ON(BG, I, J) shows the edge link from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_off.

    if ishandle(pl.edges.arr(i, j))
        set(pl.edges.arr(i, j), 'Visible', 'on')
    end
end
function arrow_edge_off(pl, i, j)
    % ARROW_EDGE_OFF hides a edge link
    %
    % ARROW_EDGE_OFF(BG, I, J) hides the edge link from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if ishandle(pl.edges.arr(i, j))
        set(pl.edges.arr(i, j), 'Visible', 'off')
    end
end
function arrow_edges(pl, i_vec, j_vec, varargin)
    % ARROW_EDGES plots multiple edge links as lines
    %
    % ARROW_EDGES(BG, I_VEC, J_VEC) plots the edge links from the
    % brain regions specified in I_VEC to the ones specified in
    % J_VEC, if not plotted. I_VEC and J_VEC need not be the same
    % size.
    %
    % ARROW_EDGES(BG, [], []) plots the edge links between all
    % possible brain region combinations.
    %
    % ARROW_LINS(BG, I_VEC, J_VEC, PROPERTY, RULE) sets the property
    % of the multiple edge links' PROPERTY to RULE.
    % All standard plot properties of plot3 can be used.
    % The line properties can also be changed when hidden.
    %
    % See also PlotBrainGraph, plot3, link_edge.

    if nargin < 2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pl.get('ATLAS').get('BR_DICT').length()
            for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                pl.arrow_edge(i, j, varargin{:})
            end
        end
    else
        if length(i_vec) == 1
            i_vec = i_vec * ones(size(j_vec));
        end
        if length(j_vec) == 1
            j_vec = j_vec * ones(size(i_vec));
        end

        for m = 1:1:length(i_vec)
            pl.arrow_edge(i_vec(m), j_vec(m), varargin{:})
        end
    end
end
function arrow_edges_on(pl, i_vec, j_vec)
    % ARROW_EDGES_ON shows multiple edge link
    %
    % ARROW_EDGES_ON(BG, I, J) shows multiple edge link from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edges, link_edges_off.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pl.get('ATLAS').get('BR_DICT').length()
            for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                pl.arrow_edge_on(i, j)
            end
        end
    else
        if length(i_vec) == 1
            i_vec = i_vec * ones(size(j_vec));
        end
        if length(j_vec) == 1
            j_vec = j_vec * ones(size(i_vec));
        end

        for m = 1:1:length(i_vec)
            pl.arrow_edge_on(i_vec(m), j_vec(m))
        end
    end
end
function arrow_edges_off(pl, i_vec, j_vec)
    % ARROW_EDGES_OFF hides multiple edge links
    %
    % ARROW_EDGES_OFF(BG, I, J) hides multiple edge links from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pl.get('ATLAS').get('BR_DICT').length()
            for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                pl.arrow_edge_off(i, j)
            end
        end
    else
        if length(i_vec) == 1
            i_vec = i_vec * ones(size(j_vec));
        end
        if length(j_vec) == 1
            j_vec = j_vec * ones(size(i_vec));
        end

        for m = 1:1:length(i_vec)
            pl.arrow_edge_off(i_vec(m), j_vec(m))
        end
    end
end
function arrow_edges_settings(pl, i_vec, j_vec, varargin)
    % ARROW_EDGES_SETTINGS sets edges' properties
    %
    % ARROW_EDGES_SETTINGS(BG) allows the user to interractively
    % change the edges settings via a graphical user interface.
    %
    % ARROW_LINS_SETTINGS(BG, PROPERTY, VALUE, ...) sets the property
    % of the GUI's PROPERTY to VALUES.
    %   Admissible properties are:
    %       FigPosition  -   position of the GUI on the screen
    %       FigColor     -   background color of the GUI
    %       FigName      -   name of the GUI
    %
    % See also PlotBrainGraph.

    atlas_length = pl.get('ATLAS').get('BR_DICT').length();
    data = cell(atlas_length, atlas_length);

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        i_vec = 1:1:atlas_length;
        j_vec = 1:1:atlas_length;
    end
    if length(i_vec) == 1
        i_vec = i_vec * ones(size(j_vec));
    end
    if length(j_vec) == 1
        j_vec = j_vec * ones(size(i_vec));
    end
    for p = 1:1:length(i_vec)
        if i_vec(p) ~= j_vec(p)
            data{i_vec(p), j_vec(p)} = true;
        else
            data{i_vec(p), j_vec(p)} = false;
        end
    end

    set_color = pl.INIT_LIN_COLOR;

    % sets position of figure
    FigPosition = [.50 .30 .30 .30];
    FigColor = pl.BKGCOLOR;
    FigName = 'Brain Graph Arrows Settings';
    for n = 1:2:length(varargin)
        switch lower(varargin{n})
            case 'figposition'
                FigPosition = varargin{n + 1};
            case 'figcolor'
                FigColor = varargin{n + 1};
            case 'figname'
                FigName = varargin{n + 1};
        end
    end

    % create a figure
    if isempty(pl.f_arrs_settings) || ~ishandle(pl.f_arrs_settings)
        pl.f_arrs_settings = figure('Visible', 'off');
    end
    f = pl.f_arrs_settings;
    set(f, 'units', 'normalized')
    set(f, 'Position', FigPosition)
    set(f, 'Color', FigColor)
    set(f, 'Name', FigName)
    set(f, 'MenuBar', 'none')
    set(f, 'Toolbar', 'none')
    set(f, 'NumberTitle', 'off')
    set(f, 'DockControls', 'off')

    ui_table = uitable(f);
    set(ui_table, 'Units', 'normalized')
    set(ui_table, 'BackgroundColor', pl.TABBKGCOLOR)
    set(ui_table, 'Position', [.03 .215 .54 .71])
    set(ui_table, 'ColumnWidth', {40})
    [string{1:atlas_length}] = deal('logical');
    set(ui_table, 'ColumnFormat', string)
    set(ui_table, 'ColumnEditable', true)
    set(ui_table, 'Data', data)
    set(ui_table, 'CellEditCallback', {@cb_table_edit});

    ui_button_show = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized');
    set(ui_button_show, 'Position', [.60 .825 .18 .10])
    set(ui_button_show, 'String', 'Show lines')
    set(ui_button_show, 'TooltipString', 'Show selected arrows')
    set(ui_button_show, 'Callback', {@cb_show})

    ui_button_hide = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized');
    set(ui_button_hide, 'Position', [.80 .825 .18 .10])
    set(ui_button_hide, 'String', 'Hide lines')
    set(ui_button_hide, 'TooltipString', 'Hide selected arrows')
    set(ui_button_hide, 'Callback', {@cb_hide})

    ui_button_arrowcolor = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized');
    set(ui_button_arrowcolor, 'ForegroundColor', set_color)
    set(ui_button_arrowcolor, 'Position', [.62 .075 .35 .10])
    set(ui_button_arrowcolor, 'String', 'Link Color')
    set(ui_button_arrowcolor, 'TooltipString', 'Select arrow color')
    set(ui_button_arrowcolor, 'Callback', {@cb_arrowcolor})

    ui_button_clearselection = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized');
    set(ui_button_clearselection, 'Position', [.03 .075 .54 .10])
    set(ui_button_clearselection, 'String', 'Clear Selection')
    set(ui_button_clearselection, 'TooltipString', 'Clear selected links')
    set(ui_button_clearselection, 'Callback', {@cb_clearselection})

        function cb_table_edit(~, event)  % (src, event)
            i = event.Indices(1);
            j = event.Indices(2);

            if i~=j
                if data{i, j} == true
                    data{i, j} = false;
                else
                    data{i, j} = true;
                end
                set(ui_table, 'Data', data)
            end
        end
        function update_link_arrs()
            stemwidth = real(str2double(get(ui_edit_stemwidth, 'String')));
            headwidth = real(str2double(get(ui_edit_headwidth, 'String')));
            headlength = real(str2double(get(ui_edit_headlength, 'String')));
            headnode = real(str2double(get(ui_edit_headnode, 'String')));
            indices = find(~cellfun(@isempty, data));

            for m = 1:1:length(indices)
                if data{indices(m)} == 1
                    [i, j] = ind2sub(size(data), indices(m));
                    pl.arrow_edges(i, j, 'StemWidth', stemwidth, ...
                        'HeadWidth', headwidth, ...
                        'HeadLength', headlength, ...
                        'HeadNode', headnode, ...
                        'Color', set_color);
                end
            end
        end
        function cb_arrowcolor(~, ~)  % (src, event)
            set_color_prev = get(ui_button_arrowcolor, 'ForegroundColor');
            set_color = uisetcolor();
            if length(set_color) == 3
                set(ui_button_arrowcolor, 'ForegroundColor', set_color)
                update_link_arrs()
            else
                set_color = set_color_prev;
            end
        end
        function cb_show(~, ~)  % (src, event)
            indices = find(~cellfun(@isempty, data));

            for m = 1:1:length(indices)
                if data{indices(m)} == 1
                    [i, j] = ind2sub(size(data), indices(m));
                    update_link_arrs()
                    pl.arrow_edges_on(i, j)
                end
            end
        end
        function cb_hide(~, ~)  % (src, event)
            indices = find(~cellfun(@isempty, data));

            for m = 1:1:length(indices)
                if data{indices(m)}==1
                    [i, j] = ind2sub(size(data), indices(m));
                    pl.arrow_edges_off(i, j)
                end
            end
        end
        function cb_clearselection(~, ~)  % (src, event)
            [data{:}] = deal(zeros(1));
            set(ui_table, 'Data', data)
        end
    set(f, 'Visible', 'on')
end
function bool = arrow_edge_is_on(pl, i, j)
    % ARROW_EDGE_IS_ON checks if line link is visible
    %
    % BOOL = ARROW_EDGE_IS_ON(BG, I, J) returns true if the line arrow link
    % from the brain regions I to J is visible and false otherwise.
    %
    % See also PlotBrainGraph.

    bool = ishandle(pl.edges.arr(i, j)) && strcmpi(get(pl.edges.arr(i, j), 'Visible'), 'on');
end

function h = cylinder_edge(pl, i, j, varargin)
    % CYLINDER_EDGE plots edge link as an cylinder
    %
    % CYLINDER_EDGE(BG, I, J) plots the edge link from the brain regions
    % I to J as a line, if not plotted.
    %
    % H = CYLINDER_EDGE(BG, I, J) returns the handle to the edge link
    % from the brain region I to J.
    %
    % CYLINDER_EDGE(BG, I, J, PROPERTY, VALUE, ...) sets the property
    % of the edge link line PROPERTY to VALUE.
    % All standard plot properties of plot3 can be used.
    % The line properties can also be changed when hidden.
    %
    % See also PlotBrainGraph, plot3, link_edges.

    if i == j  % removes diagonal
        return;
    end
    
    % get brain regions
    br_1 = pl.get('ATLAS').get('BR_DICT').getItem(i);
    br_2 = pl.get('ATLAS').get('BR_DICT').getItem(j);
    % get coordinates
    X1 = br_1.get('X');
    Y1 = br_1.get('Y');
    Z1 = br_1.get('Z');

    X2 = br_2.get('X');
    Y2 = br_2.get('Y');
    Z2 = br_2.get('Z');

    % cylinder properties
    color = pl.INIT_CYL_COLOR;
    R = pl.INIT_CYL_R;
    N = pl.INIT_CYL_N;

    if ~ishandle(pl.edges.cyl(i, j))

        [X, Y, Z] = cylinder3d(X1, Y1, Z1, X2, Y2, Z2,...
            'R', R, ...
            'N', N);

        pl.edges.cyl(i, j) = surf(X, Y, Z,...
            'EdgeColor', color, ...
            'FaceColor', color, ...
            'Parent', pl.get_axes());
    else
        x1 = pl.edges.X1(i, j);
        y1 = pl.edges.Y1(i, j);
        z1 = pl.edges.Z1(i, j);

        x2 = pl.edges.X2(i, j);
        y2 = pl.edges.Y2(i, j);
        z2 = pl.edges.Z2(i, j);

        if x1 ~= X1 || y1 ~= Y1 || z1 ~= Z1 ...
                || x2 ~= X2 || y2 ~= Y2 || z2 ~= Z2

            [X, Y, Z] = cylinder3d(X1, Y1, Z1, X2, Y2, Z2,...
                'Color', color,...
                'LineStyle', '-');

            set(pl.edges.cyl(i, j), 'XData', X);
            set(pl.edges.cyl(i, j), 'YData', Y);
            set(pl.edges.cyl(i, j), 'ZData', Z);

        end
    end
    pl.edges.X1(i, j) = X1;
    pl.edges.Y1(i, j) = Y1;
    pl.edges.Z1(i, j) = Z1;

    pl.edges.X2(i, j) = X2;
    pl.edges.Y2(i, j) = Y2;
    pl.edges.Z2(i, j) = Z2;

    % sets properties
    for n = 1:2:length(varargin)
        switch lower(varargin{n})
            case 'color'
                set(pl.edges.cyl(i, j), 'FaceColor', varargin{n + 1});
                set(pl.edges.cyl(i, j), 'EdgeColor', varargin{n + 1});

            otherwise
                set(pl.edges.cyl(i, j), varargin{n}, varargin{n + 1});
        end
    end

    if nargout>0
        h = pl.edges.cyl(i, j);
    end
end
function cylinder_edge_on(pl, i, j)
    % CYLINDER_EDGE_ON shows a edge link
    %
    % CYLINDER_EDGE_ON(BG, I, J) shows the edge link from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_off.

    if ishandle(pl.edges.cyl(i, j))
        set(pl.edges.cyl(i, j), 'Visible', 'on')
    end
end
function cylinder_edge_off(pl, i, j)
    % CYLINDER_EDGE_OFF hides a edge link
    %
    % CYLINDER_EDGE_OFF(BG, I, J) hides the edge link from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if ishandle(pl.edges.cyl(i, j))
        set(pl.edges.cyl(i, j), 'Visible', 'off')
    end
end
function cylinder_edges(pl, i_vec, j_vec, varargin)
    % CYLINDER_EDGES plots multiple edge links as lines
    %
    % CYLINDER_EDGES(BG, I_VEC, J_VEC) plots the edge links from the
    % brain regions specified in I_VEC to the ones specified in
    % J_VEC, if not plotted. I_VEC and J_VEC need not be the same
    % size.
    %
    % CYLINDER_EDGES(BG, [], []) plots the edge links between all
    % possible brain region combinations.
    %
    % CYLINDER_LINS(BG, I_VEC, J_VEC, PROPERTY, RULE) sets the property
    % of the multiple edge links' PROPERTY to RULE.
    % All standard plot properties of plot3 can be used.
    % The line properties can also be changed when hidden.
    %
    % See also PlotBrainGraph, plot3, link_edge.

    if nargin < 2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pl.get('ATLAS').get('BR_DICT').length()
            for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                pl.cylinder_edge(i, j, varargin{:})
            end
        end
    else
        if length(i_vec) == 1
            i_vec = i_vec * ones(size(j_vec));
        end
        if length(j_vec) == 1
            j_vec = j_vec * ones(size(i_vec));
        end

        for m = 1:1:length(i_vec)
            pl.cylinder_edge(i_vec(m), j_vec(m), varargin{:})
        end
    end
end
function cylinder_edges_on(pl, i_vec, j_vec)
    % CYLINDER_EDGES_ON shows multiple edge link
    %
    % CYLINDER_EDGES_ON(BG, I, J) shows multiple edge link from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edges, link_edges_off.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pl.get('ATLAS').get('BR_DICT').length()
            for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                pl.cylinder_edge_on(i, j)
            end
        end
    else
        if length(i_vec) == 1
            i_vec = i_vec * ones(size(j_vec));
        end
        if length(j_vec) == 1
            j_vec = j_vec * ones(size(i_vec));
        end

        for m = 1:1:length(i_vec)
            pl.cylinder_edge_on(i_vec(m), j_vec(m))
        end
    end
end
function cylinder_edges_off(pl, i_vec, j_vec)
    % CYLINDER_EDGES_OFF hides multiple edge links
    %
    % CYLINDER_EDGES_OFF(BG, I, J) hides multiple edge links from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pl.get('ATLAS').get('BR_DICT').length()
            for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                pl.cylinder_edge_off(i, j)
            end
        end
    else
        if length(i_vec) == 1
            i_vec = i_vec * ones(size(j_vec));
        end
        if length(j_vec) == 1
            j_vec = j_vec * ones(size(i_vec));
        end

        for m = 1:1:length(i_vec)
            pl.cylinder_edge_off(i_vec(m), j_vec(m))
        end
    end
end
function cylinder_edges_settings(pl, i_vec, j_vec, varargin)
    % CYLINDER_EDGES_SETTINGS sets edges' properties
    %
    % CYLINDER_EDGES_SETTINGS(BG) allows the user to interractively
    % change the edges settings via a graphical user interface.
    %
    % CYLINDER_LINS_SETTINGS(BG, PROPERTY, VALUE, ...) sets the property
    % of the GUI's PROPERTY to VALUES.
    %   Admissible properties are:
    %       FigPosition  -   position of the GUI on the screen
    %       FigColor     -   background color of the GUI
    %       FigName      -   name of the GUI
    %
    % See also PlotBrainGraph.

    atlas_length = pl.get('ATLAS').get('BR_DICT').length();
    data = cell(atlas_length, atlas_length);

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        i_vec = 1:1:atlas_length;
        j_vec = 1:1:atlas_length;
    end
    if length(i_vec) == 1
        i_vec = i_vec * ones(size(j_vec));
    end
    if length(j_vec) == 1
        j_vec = j_vec * ones(size(i_vec));
    end
    for p = 1:1:length(i_vec)
        if i_vec(p) ~= j_vec(p)
            data{i_vec(p), j_vec(p)} = true;
        else
            data{i_vec(p), j_vec(p)} = false;
        end
    end

    set_color = pl.INIT_LIN_COLOR;

    % sets position of figure
    FigPosition = [.50 .30 .30 .30];
    FigColor = pl.TABBKGCOLOR;
    FigName = 'Brain Graph Arrows Settings';
    for n = 1:2:length(varargin)
        switch lower(varargin{n})
            case 'figposition'
                FigPosition = varargin{n + 1};
            case 'figcolor'
                FigColor = varargin{n + 1};
            case 'figname'
                FigName = varargin{n + 1};
        end
    end

    % create a figure
    if isempty(pl.f_cyls_settings) || ~ishandle(pl.f_cyls_settings)
        pl.f_cyls_settings = figure('Visible', 'off');
    end
    f = pl.f_cyls_settings;
    set(f, 'units', 'normalized')
    set(f, 'Position', FigPosition)
    set(f, 'Color', FigColor)
    set(f, 'Name', FigName)
    set(f, 'MenuBar', 'none')
    set(f, 'Toolbar', 'none')
    set(f, 'NumberTitle', 'off')
    set(f, 'DockControls', 'off')

    ui_table = uitable(f);
    set(ui_table, 'Units', 'normalized')
    set(ui_table, 'BackgroundColor', pl.TABBKGCOLOR)
    set(ui_table, 'Position', [.03 .215 .54 .71])
    set(ui_table, 'ColumnWidth', {40})
    [string{1:atlas_length}] = deal('logical');
    set(ui_table, 'ColumnFormat', string)
    set(ui_table, 'ColumnEditable', true)
    set(ui_table, 'Data', data)
    set(ui_table, 'CellEditCallback', {@cb_table_edit});

    ui_button_show = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized');
    set(ui_button_show, 'Position', [.60 .825 .18 .10])
    set(ui_button_show, 'String', 'Show lines')
    set(ui_button_show, 'TooltipString', 'Show selected cylinders')
    set(ui_button_show, 'Callback', {@cb_show})

    ui_button_hide = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized');
    set(ui_button_hide, 'Position', [.80 .825 .18 .10])
    set(ui_button_hide, 'String', 'Hide lines')
    set(ui_button_hide, 'TooltipString', 'Hide selected cylinders')
    set(ui_button_hide, 'Callback', {@cb_hide})

    ui_button_cylindercolor = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized');
    set(ui_button_cylindercolor, 'ForegroundColor', set_color)
    set(ui_button_cylindercolor, 'Position', [.62 .075 .35 .10])
    set(ui_button_cylindercolor, 'String', 'Link Color')
    set(ui_button_cylindercolor, 'TooltipString', 'Select cylinder color')
    set(ui_button_cylindercolor, 'Callback', {@cb_cylindercolor})

    ui_button_clearselection = uicontrol(f, 'Style',  'pushbutton', 'Units', 'normalized');
    set(ui_button_clearselection, 'Position', [.03 .075 .54 .10])
    set(ui_button_clearselection, 'String', 'Clear Selection')
    set(ui_button_clearselection, 'TooltipString', 'Clear selected links')
    set(ui_button_clearselection, 'Callback', {@cb_clearselection})

        function cb_table_edit(~, event)  % (src, event)
            i = event.Indices(1);
            j = event.Indices(2);

            if i~=j
                if data{i, j} == true
                    data{i, j} = false;
                else
                    data{i, j} = true;
                end
                set(ui_table, 'Data', data)
            end
        end
        function update_link_cyls()
            stemwidth = real(str2double(get(ui_edit_stemwidth, 'String')));
            headwidth = real(str2double(get(ui_edit_headwidth, 'String')));
            headlength = real(str2double(get(ui_edit_headlength, 'String')));
            headnode = real(str2double(get(ui_edit_headnode, 'String')));
            indices = find(~cellfun(@isempty, data));

            for m = 1:1:length(indices)
                if data{indices(m)} == 1
                    [i, j] = ind2sub(size(data), indices(m));
                    pl.cylinder_edges(i, j, 'StemWidth', stemwidth, ...
                        'HeadWidth', headwidth, ...
                        'HeadLength', headlength, ...
                        'HeadNode', headnode, ...
                        'Color', set_color);
                end
            end
        end
        function cb_cylindercolor(~, ~)  % (src, event)
            set_color_prev = get(ui_button_cylindercolor, 'ForegroundColor');
            set_color = uisetcolor();
            if length(set_color) == 3
                set(ui_button_cylindercolor, 'ForegroundColor', set_color)
                update_link_cyls()
            else
                set_color = set_color_prev;
            end
        end
        function cb_show(~, ~)  % (src, event)
            indices = find(~cellfun(@isempty, data));

            for m = 1:1:length(indices)
                if data{indices(m)} == 1
                    [i, j] = ind2sub(size(data), indices(m));
                    update_link_cyls()
                    pl.cylinder_edges_on(i, j)
                end
            end
        end
        function cb_hide(~, ~)  % (src, event)
            indices = find(~cellfun(@isempty, data));

            for m = 1:1:length(indices)
                if data{indices(m)}==1
                    [i, j] = ind2sub(size(data), indices(m));
                    pl.cylinder_edges_off(i, j)
                end
            end
        end
        function cb_clearselection(~, ~)  % (src, event)
            [data{:}] = deal(zeros(1));
            set(ui_table, 'Data', data)
        end
    set(f, 'Visible', 'on')
end
function bool = cylinder_edge_is_on(pl, i, j)
    % CYLINDER_EDGE_IS_ON checks if cylinder link is visible
    %
    % BOOL = CYLINDER_EDGE_IS_ON(BG, I, J) returns true if the cylinder link
    % from the brain regions I to J is visible and false otherwise.
    %
    % See also PlotBrainGraph.

    bool = ishandle(pl.edges.cyl(i, j)) && strcmpi(get(pl.edges.cyl(i, j), 'Visible'), 'on');
end

function h = text_edge(pl, graph_axes, i, j , text_value, varargin)
    % TEXT_EDGE plots the edge value as a text
    %
    % TEXT_EDGE(BG, I, J) plots the edge value as a text.
    %
    % H = TEXT_EDGE(BG, I, J) returns the handle to the edge value
    % from the brain region I to J.
    %
    % See also link_edge, arrow_edge, cylinder_edge.

    if i == j  % removes diagonal
        return;
    end

    
    br_1 = pl.get('ATLAS').get('BR_DICT').getItem(i);
    br_2 = pl.get('ATLAS').get('BR_DICT').getItem(j);
    % get coordinates
    X1 = br_1.get('X');
    Y1 = br_1.get('Y');
    Z1 = br_1.get('Z');

    X2 = br_2.get('X');
    Y2 = br_2.get('Y');
    Z2 = br_2.get('Z');

    % equidistant point
    X3 = (X1 + X2) / 2;
    Y3 = (Y1 + Y2) / 2;
    Z3 = (Z1 + Z2) / 2;
    pl.edges.texts(i, j) =  text(graph_axes, X3, Y3, Z3, text_value);

    if nargout > 0
        h = pl.edges.texts(i, j);
    end
end
function text_edge_on(pl, i, j)
    % TEXT_EDGE_ON shows a edge text
    %
    % TEXT_EDGE_ON(BG, I, J) shows the edge text from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, text_edge, text_edge_off.

    if ishandle(pl.edges.texts(i, j))
        set(pl.edges.texts(i, j), 'Visible', 'on')
    end
end
function text_edge_off(pl, i, j)
    % TEXT_EDGE_OFF hides a edge text
    %
    % TEXT_EDGE_OFF(BG, I, J) hides the edge text from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, text_edge, text_edge_on.

    if ishandle(pl.edges.texts(i, j))
        set(pl.edges.texts(i, j), 'Visible', 'off')
    end
end
function bool = text_edge_is_on(pl, i, j)
    % TEXT_EDGE_IS_ON checks if the edge text is visible
    %
    % BOOL = TEXT_EDGE_IS_ON(BG, I, J) returns true if the edge text
    % from the brain regions I to J is visible and false otherwise.
    %
    % See also PlotBrainGraph, text_edge, tex_edge_is_off.

    bool = ishandle(pl.edges.texts(i, j)) && strcmpi(get(pl.edges.texts(i, j), 'Visible'), 'on');
end
function bool = tex_edge_is_off(pl, i, j)
    % TEXT_EDGE_IS_Off checks if the edge text is not visible
    %
    % BOOL = TEXT_EDGE_IS_Off(BG, I, J) returns true if the edge text
    % from the brain regions I to J is not visible and false otherwise.
    %
    % See also PlotBrainGraph, text_edge, tex_edge_is_off.

    bool = ishandle(pl.edges.texts(i, j)) && strcmpi(get(pl.edges.texts(i, j), 'Visible'), 'off');
end

function h = get_axes(pl)
    % GET_AXES returns the panel axes
    %
    % H = GET_AXES(PL) returns the panel axes
    %
    % See also PlotBrainGraph.
    
    h = pl.h_axes;
end

function brain_graph_panel = getBrainGraphPanel(pl, ui_panel_graph)
    % GETBRAINGRAPHPANEL creates a braingraph panel
    %
    % BRAIN_GRAPH_PANEL = GETBRAINGRAPHPANEL(ANAlYSIS, AXES, PLOTBRAINGRAPH)
    % creates a brain graph panel to manage the type of
    % PLOTBRAINGRAPH that the GUIAnalysis plots in the AXES.
    %
    % See also getBrainView.

    % variables
    atlas = pl.get('ATLAS');
    br_axes = pl.h_axes; %#ok<NASGU>
    BKGCOLOR = [1 .9725 .929];
    pl.f_graph_settings = ui_panel_graph;
    fig_graph = pl.f_graph_settings;
    color = [1 1 1];
    
    ui_title = uicontrol(fig_graph, ...
        'Style', 'text', ...
        'String', 'Graph Panel', ...
        'Units', 'normalized', ...
        'BackgroundColor', BKGCOLOR, ...
        'HorizontalAlignment', 'left', ...
        'FontWeight', 'bold', ...
        'Position', [0.01 .91 0.3 0.08]);

    ui_checkbox_graph_lineweight = uicontrol(fig_graph, 'Style',  'checkbox', 'BackgroundColor', BKGCOLOR);
    ui_edit_graph_lineweight = uicontrol(fig_graph, 'Style', 'edit');
    ui_button_graph_show = uicontrol(fig_graph, 'Style', 'pushbutton');
    ui_button_graph_hide = uicontrol(fig_graph, 'Style', 'pushbutton');
    ui_button_graph_color = uicontrol(fig_graph, 'Style', 'pushbutton');
    ui_button_graph_edge_settings = uicontrol(fig_graph, 'Style', 'pushbutton');
    ui_link_type = uicontrol(fig_graph, 'Style', 'popup', 'String', {'line', 'arrow', 'cylinder'});

    init_graph()

    %% Make the GUI visible.
    set(fig_graph, 'Visible', 'on');

        function init_graph()
            
            set(ui_checkbox_graph_lineweight, 'Units', 'normalized')
            set(ui_checkbox_graph_lineweight, 'BackgroundColor',BKGCOLOR)
            set(ui_checkbox_graph_lineweight, 'Position', [.10 .61 .28 .10])
            set(ui_checkbox_graph_lineweight, 'String', ' Thickness ')
            set(ui_checkbox_graph_lineweight, 'Value', true)
            set(ui_checkbox_graph_lineweight, 'FontWeight', 'bold')
            set(ui_checkbox_graph_lineweight, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_graph_lineweight, 'Callback', {@cb_checkbox_lineweight})

            set(ui_edit_graph_lineweight, 'Units', 'normalized')
            set(ui_edit_graph_lineweight, 'Position', [.3 .62 .3 .08])
            set(ui_edit_graph_lineweight, 'String', '1');
            set(ui_edit_graph_lineweight, 'TooltipString', 'Set line weight.');
            set(ui_edit_graph_lineweight, 'FontWeight', 'bold')
            set(ui_edit_graph_lineweight, 'Callback', {@cb_edit_lineweight});
            
            set(ui_link_type, 'Units', 'normalized')
            set(ui_link_type, 'Position', [.62 .62 .3 .08])
            set(ui_link_type, 'Callback', {@cb_link_type});
            
            set(ui_button_graph_show, 'Units', 'normalized')
            set(ui_button_graph_show, 'Position', [.1 .45 .4 .08])
            set(ui_button_graph_show, 'String', ' Show ')
            set(ui_button_graph_show, 'HorizontalAlignment', 'center')
            set(ui_button_graph_show, 'FontWeight', 'bold')
            set(ui_button_graph_show, 'FontSize', 10)
            set(ui_button_graph_show, 'Callback', {@cb_graph_show})

            set(ui_button_graph_hide, 'Units', 'normalized')
            set(ui_button_graph_hide, 'Position', [.1 .3 .4 .08])
            set(ui_button_graph_hide, 'String', ' Hide ')
            set(ui_button_graph_hide, 'HorizontalAlignment', 'center')
            set(ui_button_graph_hide, 'FontWeight', 'bold')
            set(ui_button_graph_hide, 'FontSize', 10)
            set(ui_button_graph_hide, 'Callback', {@cb_graph_hide})

            set(ui_button_graph_color, 'Units', 'normalized')
            set(ui_button_graph_color, 'Position', [.52 .45 .4 .08])
            set(ui_button_graph_color, 'String', ' Color ')
            set(ui_button_graph_color, 'HorizontalAlignment', 'center')
            set(ui_button_graph_color, 'FontWeight', 'bold')
            set(ui_button_graph_color, 'FontSize', 10)
            set(ui_button_graph_color, 'Callback', {@cb_graph_color})

            set(ui_button_graph_edge_settings, 'Units', 'normalized')
            set(ui_button_graph_edge_settings, 'Position', [.52 .3 .4 .08])
            set(ui_button_graph_edge_settings, 'String', 'Edge Settings')
            set(ui_button_graph_edge_settings, 'HorizontalAlignment', 'center')
            set(ui_button_graph_edge_settings, 'FontWeight', 'bold')
            set(ui_button_graph_edge_settings, 'FontSize', 10)
            set(ui_button_graph_edge_settings, 'Callback', {@cb_graph_links_settings})

           
        end        
        function cb_checkbox_lineweight(~, ~)  % (src, event)
            if get(ui_checkbox_graph_lineweight, 'Value')
                set(ui_edit_graph_lineweight, 'Enable', 'on')
                update_graph()
            else
                set(ui_edit_graph_lineweight, 'Enable', 'off')

                weight = str2double(get(ui_edit_graph_lineweight, 'String'));
                n = atlas.get('BR_DICT').length();
                for i = 1:1:n
                    for j = 1:1:n
                        if i == j
                            continue;
                        end
                        pl.link_edges(i, j, 'LineWidth', weight)
                    end
                end
            end
        end
        function cb_edit_lineweight(~, ~)  % (src, event)
            weigth = real(str2double(get(ui_edit_graph_lineweight, 'String')));
            if isnan(weigth) || weigth <= 0
                set(ui_edit_graph_lineweight, 'String', '5');
            end
            update_graph()
        end
        function cb_graph_show(~, ~)  % (src, event)
            set(ui_edit_graph_lineweight, 'Enable', 'on')

            update_graph()
        end
        function cb_graph_hide(~, ~)  % (src, event)
            link_style = get(ui_link_type, 'Value');
            if  link_style == 1
                pl.link_edges_off([], [])
            elseif link_style == 2
                pl.arrow_edges_off([],[])
            else
                pl.cylinder_edges_off([],[])
            end
        end
        function cb_graph_color(~, ~)  % (src, event)
            color = uisetcolor();

            if length(color)==3
                n = atlas.get('BR_DICT').length();
                for i = 1:1:n
                    for j = 1:1:n
                        if i == j
                            continue;
                        end
                        pl.link_edge(i, j, 'Color', color)
                    end
                end
            end
        end
        function cb_link_type(~, ~)
            update_graph()
        end
        function update_graph()
            link_style = get(ui_link_type, 'Value');

            pl.link_edges_off([], [])
            pl.arrow_edges_off([],[])
            pl.cylinder_edges_off([],[])

            if get(ui_checkbox_graph_lineweight, 'Value')
                % get measure value
                n = atlas.get('BR_DICT').length();
                weight = str2double(get(ui_edit_graph_lineweight, 'String'));
                for i = 1:1:n
                    for j = 1:1:n
                        if i == j
                            continue;
                        end
                        if  link_style == 1
                            pl.link_edges(i, j, 'LineWidth', weight);
                            pl.link_edge_on(i, j);
                        elseif link_style == 2
                            pl.arrow_edges(i, j, 'LineWidth', weight);
                            pl.arrow_edge_on(i, j)
                        else
                            pl.cylinder_edges(i, j, 'LineWidth', weight);
                            pl.cylinder_edge_on(i, j)
                        end
                    end
                end
            end

        end
        function cb_graph_links_settings(~, ~)  % (src, event)
            link_style = get(ui_link_type, 'Value');
            if link_style == 1
                pl.link_edges_settings([], []);
            elseif link_style == 2
                pl.arrow_edges_settings([], []);
            else
                pl.cylinder_edges_settings([], []);
            end
        end

    if nargout > 0
        brain_graph_panel = fig_graph;
    end
end
function h = getMCRPanel(pl, ui_panel_mcr)
    % sets position of figure

    % variables
    atlas = pl.get('ATLAS');
    br_axes = pl.h_axes; %#ok<NASGU>
    FigColor = [.95 .94 .94];
    pl.f_measures_settings = ui_panel_mcr;
    f = pl.f_measures_settings;
    BKGCOLOR = [1 .9725 .929];

    measure_data = pl.get('ME').get('M');
    %layer dim
    layer_element_item = pl.get('me').get('a').get('g_dict').getItem(1);
    layer_element = layer_element_item.get('b');
    layer_check = 0;
    d_t_check = 0;
    layer_dim = 1;
    if size(measure_data, 1) > 1 % density or threshold
        d_t_check = 1;
        d_or_t = pl.get('type');
    end
    if iscell(layer_element) && size(layer_element, 2) > 1 % mp
        layer_check = 1;
        if Measure.is_superglobal(pl.get('ME').get('measureparam'))% superglobal
            layer_dim = 1;
        else
            layer_dim =  size(layer_element, 2);
        end

    end


    % initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % measure container panel
    ui_measure_container_panel = uipanel(f, 'Units', 'normalized', 'BackgroundColor', BKGCOLOR);

    ui_title = uicontrol(f, ...
        'Style', 'text', ...
        'String', 'Measure Panel', ...
        'Units', 'normalized', ...
        'BackgroundColor', BKGCOLOR, ...
        'HorizontalAlignment', 'left', ...
        'FontWeight', 'bold', ...
        'Position', [0.01 .91 0.3 0.08]);

    % nodal measure figure options
    if d_t_check
        d_t_text = uicontrol(ui_measure_container_panel, 'Style', 'text', 'BackgroundColor', BKGCOLOR);
        d_t_selector = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
    end
    if layer_check
        ui_layer_text = uicontrol(ui_measure_container_panel, 'Style', 'text', 'BackgroundColor', BKGCOLOR);
        ui_layer_selector = uicontrol(ui_measure_container_panel, 'Style', 'popup', 'String', {''});
    end
    ui_checkbox_meas_symbolsize = uicontrol(ui_measure_container_panel, 'Style',  'checkbox', 'BackgroundColor', BKGCOLOR);
    ui_edit_meas_symbolsize = uicontrol(ui_measure_container_panel, 'Style', 'edit');
    ui_checkbox_meas_sphereradius = uicontrol(ui_measure_container_panel, 'Style',  'checkbox', 'BackgroundColor', BKGCOLOR);
    ui_edit_meas_sphereradius = uicontrol(ui_measure_container_panel, 'Style', 'edit');
    ui_checkbox_meas_spheretransparency = uicontrol(ui_measure_container_panel, 'Style',  'checkbox', 'BackgroundColor', BKGCOLOR);
    ui_slider_meas_spheretransparency = uicontrol(ui_measure_container_panel, 'Style', 'slider');
    ui_checkbox_meas_labelsize = uicontrol(ui_measure_container_panel, 'Style',  'checkbox', 'BackgroundColor', BKGCOLOR);
    ui_edit_meas_labelsize = uicontrol(ui_measure_container_panel, 'Style', 'edit');

    %% Callback functions
        function init_measures_panel()

            % measure figure *******************************
            set(ui_measure_container_panel, 'Position', [.0 .01 1 .99])

            if d_t_check
                set(d_t_text, ...
                    'Units', 'normalized', ...
                    'Position', [.26 .91 .15 .08], ...
                    'FontWeight', 'bold', ...
                    'TooltipString', 'Select the layer of the Measure to be ploted.', ...
                    'String', d_or_t ...
                    )

                set(d_t_selector, ...
                    'Units', 'normalized', ...
                    'Position', [.41 .91 .2 .08], ...
                    'String', cellfun(@(x) num2str(x),  num2cell([1:size(measure_data, 1)/layer_dim]) , 'UniformOutput', false), ...
                    'Callback', {@cb_d_t_selector} ...
                    )
            end
            if layer_check
                set(ui_layer_text, ...
                    'Units', 'normalized', ...
                    'Position', [.61 .91 .15 .08], ...
                    'FontWeight', 'bold', ...
                    'TooltipString', 'Select the layer of the Measure to be ploted.', ...
                    'String', 'Layer' ...
                    )

                set(ui_layer_selector, ...
                    'Units', 'normalized', ...
                    'Position', [.76 .91 .2 .08], ...
                    'String', cellfun(@(x) num2str(x),  num2cell([1:layer_dim]) , 'UniformOutput', false), ...
                    'Callback', {@cb_layer_selector} ...
                    )
            end

            set(ui_checkbox_meas_symbolsize, 'Units', 'normalized')
            set(ui_checkbox_meas_symbolsize, 'Position', [.01 .7 .30 .08])
            set(ui_checkbox_meas_symbolsize, 'String', ' Symbol Size ')
            set(ui_checkbox_meas_symbolsize, 'Value', false)
            set(ui_checkbox_meas_symbolsize, 'FontWeight', 'bold')
            set(ui_checkbox_meas_symbolsize, 'TooltipString', 'Shows brain regions by points')
            set(ui_checkbox_meas_symbolsize, 'Callback', {@cb_checkbox_meas_symbolsize})

            set(ui_edit_meas_symbolsize, 'Units', 'normalized')
            set(ui_edit_meas_symbolsize, 'String', PlotBrainGraph.INIT_SYM_SIZE)
            set(ui_edit_meas_symbolsize, 'Enable', 'off')
            set(ui_edit_meas_symbolsize, 'Position', [.31 .7 .6 .08])
            set(ui_edit_meas_symbolsize, 'HorizontalAlignment', 'center')
            set(ui_edit_meas_symbolsize, 'FontWeight', 'bold')
            set(ui_edit_meas_symbolsize, 'Callback', {@cb_edit_meas_symbolsize})

            set(ui_checkbox_meas_sphereradius, 'Units', 'normalized')
            set(ui_checkbox_meas_sphereradius, 'Position', [.01 0.54 .3 .08])
            set(ui_checkbox_meas_sphereradius, 'String', ' Sphere Radius ')
            set(ui_checkbox_meas_sphereradius, 'Value', false)
            set(ui_checkbox_meas_sphereradius, 'FontWeight', 'bold')
            set(ui_checkbox_meas_sphereradius, 'TooltipString', 'Shows brain regions by spheres')
            set(ui_checkbox_meas_sphereradius, 'Callback', {@cb_checkbox_meas_sphereradius})

            set(ui_edit_meas_sphereradius, 'Units', 'normalized')
            set(ui_edit_meas_sphereradius, 'String', PlotBrainGraph.INIT_SPH_R)
            set(ui_edit_meas_sphereradius, 'Enable', 'off')
            set(ui_edit_meas_sphereradius, 'Position', [.31 0.54 .6 .08])
            set(ui_edit_meas_sphereradius, 'HorizontalAlignment', 'center')
            set(ui_edit_meas_sphereradius, 'FontWeight', 'bold')
            set(ui_edit_meas_sphereradius, 'Callback', {@cb_edit_meas_sphereradius})

            set(ui_checkbox_meas_spheretransparency, 'Units', 'normalized')
            set(ui_checkbox_meas_spheretransparency, 'Position', [.01 0.4 .3 .08])
            set(ui_checkbox_meas_spheretransparency, 'String', ' Sphere Transparency ')
            set(ui_checkbox_meas_spheretransparency, 'Value', false)
            set(ui_checkbox_meas_spheretransparency, 'FontWeight', 'bold')
            set(ui_checkbox_meas_spheretransparency, 'TooltipString', 'Adjust the transparency of spheres')
            set(ui_checkbox_meas_spheretransparency, 'Callback', {@cb_checkbox_meas_spheretransparency})

            set(ui_slider_meas_spheretransparency, 'Units', 'normalized')
            set(ui_slider_meas_spheretransparency, 'Min', 0, 'Max', 1, 'Value', PlotBrainGraph.INIT_SPH_FACE_ALPHA);
            set(ui_slider_meas_spheretransparency, 'Enable', 'off')
            set(ui_slider_meas_spheretransparency, 'Position', [.31 0.4 .6 .08])
            set(ui_slider_meas_spheretransparency, 'TooltipString', 'Brain region transparency (applied both to faces and edges)')
            set(ui_slider_meas_spheretransparency, 'Callback', {@cb_slider_meas_spheretransparency})

            set(ui_checkbox_meas_labelsize, 'Units', 'normalized')
            set(ui_checkbox_meas_labelsize, 'Position', [.01 .26 .3 .08])
            set(ui_checkbox_meas_labelsize, 'String', ' Value Size ')
            set(ui_checkbox_meas_labelsize, 'Value', false)
            set(ui_checkbox_meas_labelsize, 'FontWeight', 'bold')
            set(ui_checkbox_meas_labelsize, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_meas_labelsize, 'Callback', {@cb_checkbox_meas_labelsize})

            set(ui_edit_meas_labelsize, 'Units', 'normalized')
            set(ui_edit_meas_labelsize, 'String', PlotBrainGraph.INIT_LAB_FONT_SIZE)
            set(ui_edit_meas_labelsize, 'Enable', 'off')
            set(ui_edit_meas_labelsize, 'Position', [.31 .26 .6 .08])
            set(ui_edit_meas_labelsize, 'HorizontalAlignment', 'center')
            set(ui_edit_meas_labelsize, 'FontWeight', 'bold')
            set(ui_edit_meas_labelsize, 'Callback', {@cb_edit_meas_labelsize})

        end
        function cb_layer_selector(~, ~)
            update_brain_meas_plot()
        end
        function cb_d_t_selector(~, ~)
            update_brain_meas_plot()
        end
        function cb_checkbox_meas_symbolsize(~, ~)  %  (src, event)
            if get(ui_checkbox_meas_symbolsize, 'Value')
                set(ui_edit_meas_symbolsize, 'Enable', 'on')
                update_brain_meas_plot()
            else
                size = str2double(get(ui_edit_meas_symbolsize, 'String'));
                pl.set('SYMS_SIZE', size);
                pl.set('SYMS', 0);
                set(ui_edit_meas_symbolsize, 'Enable', 'off')
                update_brain_meas_plot()
            end
        end
        function cb_edit_meas_symbolsize(~, ~)  %  (src, event)
            size = real(str2double(get(ui_edit_meas_symbolsize, 'String')));
            if isempty(size) || size<=0
                set(ui_edit_meas_symbolsize, 'String', '1')
            end
            update_brain_meas_plot()
        end
        function cb_checkbox_meas_sphereradius(~, ~)  %  (src, event)
            if get(ui_checkbox_meas_sphereradius, 'Value')
                set(ui_edit_meas_sphereradius, 'Enable', 'on')
                update_brain_meas_plot()
            else
                R = str2double(get(ui_edit_meas_sphereradius, 'String'));
                pl.set('SPHS_SIZE', R);
                pl.set('SPHS', 0);
                set(ui_edit_meas_sphereradius, 'Enable', 'off')
                update_brain_meas_plot()
            end
        end
        function cb_edit_meas_sphereradius(~, ~)  %  (src, event)
            R = real(str2double(get(ui_edit_meas_sphereradius, 'String')));
            if isempty(R) || R<=0
                set(ui_edit_meas_sphereradius, 'String', '1')
            end
            update_brain_meas_plot()
        end
        function cb_checkbox_meas_spheretransparency(~, ~)  %  (src, event)
            if get(ui_checkbox_meas_spheretransparency, 'Value')
                set(ui_slider_meas_spheretransparency, 'Enable', 'on')

                update_brain_meas_plot()
            else
                alpha = get(ui_slider_meas_spheretransparency, 'Value');
                pl.set('SPHS_FACE_ALPHA', alpha);
                pl.set('SPHS_EDGE_ALPHA', alpha);

                set(ui_slider_meas_spheretransparency, 'Enable', 'off')
                update_brain_meas_plot()
            end
        end
        function cb_slider_meas_spheretransparency(~, ~)  %  (src, event)
            update_brain_meas_plot();
        end
        function cb_checkbox_meas_labelsize(~, ~)  %  (src, event)
            if get(ui_checkbox_meas_labelsize, 'Value')
                set(ui_edit_meas_labelsize, 'Enable', 'on')
                update_brain_meas_plot()
            else
                size = str2double(get(ui_edit_meas_labelsize, 'String'));
                pl.set('LABS_SIZE', size);
                pl.set('LABS', 0);
                set(ui_edit_meas_labelsize, 'Enable', 'off')
                update_brain_meas_plot()
            end
        end
        function cb_edit_meas_labelsize(~, ~)  %  (src, event)
            size = real(str2double(get(ui_edit_meas_labelsize, 'String')));
            if isempty(size) || size<=0
                set(ui_edit_meas_labelsize, 'String', '1')
                size = 5;
            end
            update_brain_meas_plot()
        end
        function update_brain_meas_plot()
            if ~isempty(measure_data)
                if  Measure.is_nodal(pl.get('ME').get('MEASURE'))
                    if d_t_check && ~layer_check %  d/t but not mp
                        measure_data_inner = measure_data{get(d_t_selector, 'Value')};
                    elseif layer_check && ~d_t_check % mp but no d/t
                        if Measure.is_superglobal(pl.get('ME').get('Measure'))
                            measure_data_inner = measure_data{1};
                        else
                            measure_data_inner = measure_data{get(ui_layer_selector, 'Value')};
                        end
                    elseif layer_check && d_t_check % mp and d/t
                        if Measure.is_superglobal(pl.get('ME').get('Measure'))
                            measure_data_inner = measure_data{get(d_t_selector, 'Value')};
                        else
                            tmp_diff = layer_dim-get(ui_layer_selector, 'Value');
                            measure_data_inner = measure_data{get(d_t_selector, 'Value')*layer_dim-tmp_diff};
                        end
                    else
                        measure_data_inner = measure_data{1};
                    end
                else
                    measure_warn_f = warndlg('BRAPH 2 only visualize nodal measures.');
                    set_braph2icon(measure_warn_f);
                end

                if any(isnan(measure_data_inner)) || any(isinf(measure_data_inner))
                    nan_warn_f = warndlg('A value is not a finite real number.');
                    set_braph2icon(nan_warn_f);
                    return
                end

                if get(ui_checkbox_meas_symbolsize, 'Value')

                    size_ = str2double(get(ui_edit_meas_symbolsize, 'String')) * measure_data_inner;
                    size_(isnan(size_)) = 0.1;
                    size_(size_ <= 0) = 0.1;
                    pl.set('SYMS_SIZE', size_);
                    pl.set('SYMS', 1);
                else
                    pl.set('SYMS', 0);
                end


                if get(ui_checkbox_meas_sphereradius, 'Value')

                    R = str2double(get(ui_edit_meas_sphereradius, 'String')) * measure_data_inner;
                    R(isnan(R)) = 0.1;
                    R(R <= 0) = 0.1;
                    pl.set('SPHS_SIZE', R);
                    pl.set('SPHS', 1);
                else
                    pl.set('SPHS', 0);
                end

                if get(ui_checkbox_meas_spheretransparency, 'Value')

                    alpha = get(ui_slider_meas_spheretransparency, 'Value');

                    alpha_vec = (measure_data_inner)*alpha;
                    alpha_vec(isnan(alpha_vec)) = 0;
                    alpha_vec(alpha_vec < 0) = 0;
                    alpha_vec(alpha_vec > 1) = 1;
                    pl.set('SPHS_EDGE_ALPHA', alpha_vec);
                    pl.set('SPHS_FACE_ALPHA', alpha_vec);
                    pl.set('SPHS', 1);
                end

                if get(ui_checkbox_meas_labelsize, 'Value')

                    size_ = str2double(get(ui_edit_meas_labelsize, 'String'));
                    size_(isnan(size_)) = 0.1;
                    size_(size_ <= 0) = 0.1;
                    pl.set( 'LABS_SIZE', size_);
                    pl.set('LABS', 1);
                else
                    pl.set('LABS', 0);
                end

            end
            if get(ui_checkbox_meas_labelsize, 'Value')
                % set labels to values
                new_labs = cellfun(@(x) num2str(x), num2cell(measure_data_inner), 'UniformOutput', false);
                brs_dict = pl.get('ATLAS').get('BR_DICT').get('IT_LIST');
                cellfun(@(x, y) x.set('LABEL', y), brs_dict, new_labs', 'UniformOutput', false)
            end
            % draw
            pl.draw();
        end

    % draw
    init_measures_panel()
    update_brain_meas_plot()
    set(f, 'Visible', 'on')
    if nargout > 0
        h = f;
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Plot
%%%% ¡code!
fig = figure();
br1 = BrainRegion('ID', 'BR ID1', 'Label', 'brain region label 1', 'Notes', 'brain region notes 1', 'x', 1, 'y', 10, 'z', 11);
br2 = BrainRegion('ID', 'BR ID2', 'Label', 'brain region label 2', 'Notes', 'brain region notes 2', 'x', 2, 'y', 20, 'z', 22);
br3 = BrainRegion('ID', 'BR ID3', 'Label', 'brain region label 3', 'Notes', 'brain region notes 3', 'x', 3, 'y', 30, 'z', 33);
br4 = BrainRegion('ID', 'BR ID4', 'Label', 'brain region label 4', 'Notes', 'brain region notes 4', 'x', 4, 'y', 40, 'z', 44);
br5 = BrainRegion('ID', 'BR ID5', 'Label', 'brain region label 5', 'Notes', 'brain region notes 5', 'x', 5, 'y', 50, 'z', 55);

bs = BrainSurface('ID', 'Human_Cerebellum.nv');
br_dict =  IndexedDictionary( ...
    'id', 'idict', ...
    'it_class', 'BrainRegion', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', {br1, br2, br3, br4, br5});
atlas = BrainAtlas('ID', 'BA ID', 'Label', 'Brain Atlas Label', 'Notes', 'Brain atlas notes', 'SURF', bs, 'BR_DICT', br_dict);
pl = PlotBrainGraph('atlas', atlas, ...
    'syms', 1, 'SYMS_SIZE', [1:5:25]', ...
    'SYMS_FACE_COLOR', [0 0 0], 'SYMS_EDGE_COLOR', [0 0 0], ...
    'SPHS', 1, 'SPHS_SIZE', [1:1:5]', ...
    'SPHS_FACE_ALPHA', .7, 'SPHS_FACE_COLOR', [0 1 0], ...
    'SPHS_EDGE_ALPHA', .4, 'SPHS_EDGE_COLOR', [1 1 1], ...
    'IDS', 1, 'IDS_SIZE', [11:1:15]', 'IDS_FONT_COLOR', [0 0 0], ...
    'LABS', 1, 'LABS_SIZE', [12:1:16]', 'LABS_FONT_COLOR', [0 0 0], ...
    'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));

close(gcf)

%% Init edges lines
br1 = BrainRegion('ID', 'BR ID1', 'Label', 'brain region label 1', 'Notes', 'brain region notes 1', 'x', 1, 'y', 10, 'z', 11);
br2 = BrainRegion('ID', 'BR ID2', 'Label', 'brain region label 2', 'Notes', 'brain region notes 2', 'x', 2, 'y', 20, 'z', 22);
br3 = BrainRegion('ID', 'BR ID3', 'Label', 'brain region label 3', 'Notes', 'brain region notes 3', 'x', 3, 'y', 30, 'z', 33);
br4 = BrainRegion('ID', 'BR ID4', 'Label', 'brain region label 4', 'Notes', 'brain region notes 4', 'x', 4, 'y', 40, 'z', 44);
br5 = BrainRegion('ID', 'BR ID5', 'Label', 'brain region label 5', 'Notes', 'brain region notes 5', 'x', 5, 'y', 50, 'z', 55);

bs = BrainSurface('ID', 'Human_Cerebellum.nv');
br_dict =  IndexedDictionary( ...
    'id', 'idict', ...
    'it_class', 'BrainRegion', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', {br1, br2, br3, br4, br5});

atlas = BrainAtlas('ID', 'BA ID', 'Label', 'Brain Atlas Label', 'Notes', 'Brain atlas notes', 'SURF', bs, 'BR_DICT', br_dict);

pl = PlotBrainGraph('atlas', atlas, ...
    'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
pl.draw();
pl.link_edges();
pl.link_edges_on();
pl.link_edges_settings();

close(gcf)
close(gcf)