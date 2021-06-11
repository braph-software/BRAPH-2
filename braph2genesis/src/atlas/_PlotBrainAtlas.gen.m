%% ¡header!
PlotBrainAtlas < PlotBrainSurface (pl, plot brain atlas) is a plot of a brain atlas.

%%% ¡description!
PlotBrainAtlas manages the plot of the brain regions symbols,
spheres, ids and labels. PlotBrainAtlas utilizes the surface created
from PlotBrainSurface to integrate the regions to a brain surface.

%%% ¡seealso!
Plot, BrainSurface, PlotBrainSurface

%% ¡constants!
PLOT_SYMBOL_NAME = { ...
    'point' ...
    'circle' ...
    'x-mark' ...
    'plus' ...
    'star' ...
    'square' ...
    'diamond' ...
    'triangle (down)' ...
    'triangle (up)' ...
    'triangle (left)' ...
    'triangle (right)' ...
    'pentagram' ...
    'hexagram' ...
    'none' ...
    }

PLOT_SYMBOL_TAG = { ...
    '.' ...
    'o' ...
    'x' ...
    '+' ...
    '*' ...
    's' ...
    'd' ...
    'v' ...
    '^' ...
    '>' ...
    '<' ...
    'p' ...
    'h' ...
    'none' ...
    }

PLOT_ID_FONT_INTREPETER = { ...
    'none' ...
    'latex' ...
    }

%% ¡properties!
h_syms % handle for the symbols 
h_sphs % handle for the spheres 
h_ids % handle for the id 
h_labs % handle for the labs 

f_settings
f_settings_buttons
f_syms_settings
f_sphs_settings
f_ids_settings
f_labs_settings

pp
%% ¡props!

%%% ¡prop!
ATLAS (metadata, item) is the brain atlas with the brain regions
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
Parent (data, item) is the plot parent figure

%%% ¡prop!
SYMS (metadata, cvector) is symbol visibility.
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
%%%% ¡default!
1

%%% ¡prop!
SYMS_SIZE (metadata, cvector) is the symbol size.
%%%% ¡conditioning!
value = abs(value);
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
if check 
    msg = 'All ok!';
else
    msg = ['SYMS_SIZE must have length 1 or (' num2str(pl.get('ATLAS').get('BR_DICT').length) ') length while its length ' num2str(length(value)) '.'];
end
%%%% ¡default!
10

%%% ¡prop!
SYMS_MARKER (metadata, cvector) is the symbol option.
%%%% ¡settings!
1:length(PlotBrainAtlas.PLOT_SYMBOL_TAG)
%%%% ¡check_value!
check = 1 <= value && value <= length(PlotBrainAtlas.PLOT_SYMBOL_TAG);
%%%% ¡default!
2

%%% ¡prop!
SYMS_FACE_COLOR (metadata, matrix) is the symbol face color.
%%%% ¡check_value!
check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
%%%% ¡default!
[0 0 0]

%%% ¡prop!
SYMS_EDGE_COLOR (metadata, matrix) is the symbol edge color.
%%%% ¡check_value!
check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
%%%% ¡default!
[0 0 0]

%%% ¡prop!
SPHS (metadata, cvector) is sphere visibility.
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
%%%% ¡default!
0

%%% ¡prop!
SPHS_SIZE (metadata, cvector) is the sphere size.
%%%% ¡conditioning!
value = abs(value);
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
if check 
    msg = 'All ok!';
else
    msg = ['SPHS_SIZE must have length 1 or (' num2str(pl.get('ATLAS').get('BR_DICT').length) ') length while its length ' num2str(length(value)) '.'];
end
%%%% ¡default!
1

%%% ¡prop!
SPHS_EDGE_COLOR (metadata, matrix) is the sphere edge color.
%%%% ¡check_value!
check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
%%%% ¡default!
[0 0 0]

%%% ¡prop!
SPHS_FACE_COLOR (metadata, matrix) is the sphere face color.
%%%% ¡check_value!
check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
%%%% ¡default!
[0 0 0]

%%% ¡prop!
SPHS_EDGE_ALPHA (metadata, cvector) is the sphere alpha.
%%%% ¡conditioning!
value = abs(value);
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
%%%% ¡default!
.5

%%% ¡prop!
SPHS_FACE_ALPHA (metadata, cvector) is the sphere alpha.
%%%% ¡conditioning!
value = abs(value);
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
%%%% ¡default!
.5

%%% ¡prop!
IDS (metadata, cvector) is the ids visibility.
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
%%%% ¡default!
0

%%% ¡prop!
IDS_SIZE (metadata, cvector) is the ids size.
%%%% ¡conditioning!
value = abs(value);
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
if check 
    msg = 'All ok!';
else
    msg = ['IDS_SIZE must have length 1 or (' num2str(pl.get('ATLAS').get('BR_DICT').length) ') length while its length ' num2str(length(value)) '.'];
end
%%%% ¡default!
1

%%% ¡prop!
IDS_FONT_COLOR (metadata, matrix) is the ids font color.
%%%% ¡check_value!
check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
%%%% ¡default!
[0 0 0]

%%% ¡prop!
IDS_FONT_NAME (metadata, string) is the ids font name.
%%%% ¡default!
'Helvetica'

%%% ¡prop!
IDS_FONT_INTERPRETER (metadata, cvector) is the ids font interpreter.
%%%% ¡settings!
1:length(PlotBrainAtlas.PLOT_ID_FONT_INTREPETER)
%%%% ¡check_value!
check = 1 <= value &&  value <= length(PlotBrainAtlas.PLOT_ID_FONT_INTREPETER);
%%%% ¡default!
1

%%% ¡prop!
LABS (metadata, cvector) is the labs visibility.
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
%%%% ¡default!
0

%%% ¡prop!
LABS_SIZE (metadata, cvector) is the labs size.
%%%% ¡conditioning!
value = abs(value);
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
if check 
    msg = 'All ok!';
else
    msg = ['LABS_SIZE must have length 1 or (' num2str(pl.get('ATLAS').get('BR_DICT').length) ') length while its length ' num2str(length(value)) '.'];
end
%%%% ¡default!
1

%%% ¡prop!
LABS_FONT_COLOR (metadata, matrix) is the labs font color.
%%%% ¡check_value!
check = (size(value, 1) == 1 && size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
%%%% ¡default!
[0 0 0]

%%% ¡prop!
LABS_FONT_NAME (metadata, string) is the labs font name.
%%%% ¡default!
'Helvetica'

%%% ¡prop!
LABS_FONT_INTERPRETER (metadata, cvector) is the labs font interpreter.
%%%% ¡settings!
1:length(PlotBrainAtlas.PLOT_ID_FONT_INTREPETER)
%%%% ¡check_value!
check = 1 <= value &&  value <= length(PlotBrainAtlas.PLOT_ID_FONT_INTREPETER);
%%%% ¡default!
1


%% ¡methods!
function h_panel = draw(pl, varargin)
%DRAW draws the brain atlas graphical panel.
%
% DRAW(PL) draws the brain atlas graphical panel.
%
% H = DRAW(PL) returns a handle to the brain atlas graphical panel.
%
% DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
%  panel with custom property-value couples.
%  All standard plot properties of uipanel can be used.
%
% It is possible to access the properties of the various graphical
%  objects from the handle to the brain atlas graphical panel H.
%
% see also settings, uipanel, isgraphics.

pl.pp = draw@PlotBrainSurface(pl, varargin{:});

h_axes = [];
if isempty(h_axes) || ~isgraphics(h_axes, 'axes')
    h_axes =  get(pl.pp, 'Children');
end

% close function
set(pl.pp, 'DeleteFcn', {@close_f_settings}, ...
    varargin{:})

    function close_f_settings(~, ~)
        if ~isempty(pl.f_settings) && isgraphics(pl.f_settings, 'figure')
            close(pl.f_settings)
        end
        if ~isempty(pl.f_settings_buttons) && isgraphics(pl.f_settings_buttons, 'figure')
            close(pl.f_settings_buttons)
        end
        if ~isempty(pl.f_syms_settings) && isgraphics(pl.f_syms_settings, 'figure')
            close(pl.f_syms_settings)
        end
        if ~isempty(pl.f_sphs_settings) && isgraphics(pl.f_sphs_settings, 'figure')
            close(pl.f_sphs_settings)
        end
        if ~isempty(pl.f_ids_settings) && isgraphics(pl.f_ids_settings, 'figure')
            close(pl.f_ids_settings)
        end
        if ~isempty(pl.f_labs_settings) && isgraphics(pl.f_labs_settings, 'figure')
            close(pl.f_labs_settings)
        end
    end

% initialization
if isempty(pl.h_syms) || length(pl.h_syms.h) ~= pl.get('ATLAS').get('BR_DICT').length
    pl.h_syms.h = NaN(1, pl.get('ATLAS').get('BR_DICT').length);
end

if isempty(pl.h_sphs) || length(pl.h_sphs.h) ~= pl.get('ATLAS').get('BR_DICT').length
    pl.h_sphs.h = NaN(1, pl.get('ATLAS').get('BR_DICT').length);
end

if isempty(pl.h_ids) || length(pl.h_ids.h) ~= pl.get('ATLAS').get('BR_DICT').length
    pl.h_ids.h = NaN(1, pl.get('ATLAS').get('BR_DICT').length);
end

if isempty(pl.h_labs) || length(pl.h_labs.h) ~= pl.get('ATLAS').get('BR_DICT').length
    pl.h_labs.h = NaN(1, pl.get('ATLAS').get('BR_DICT').length);
end

% get coordinates
X = cellfun(@(x) x.get('X'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
Y = cellfun(@(x) x.get('Y'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
Z = cellfun(@(x) x.get('Z'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
ID = cellfun(@(x) x.get('ID'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
LABS = cellfun(@(x) x.get('LABEL'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);

% get values & complete vector size
% symbols
SYMS_SHOW = pl.get('SYMS');
if SYMS_SHOW
    SYMS_SHOW = repmat(SYMS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
end

SYMS_SIZE = pl.get('SYMS_SIZE');
if length(SYMS_SIZE) == 1
    SYMS_SIZE = repmat(SYMS_SIZE, pl.get('ATLAS').get('BR_DICT').length, 1);
end

SYMS_FACE_COLOR = pl.get('SYMS_FACE_COLOR');
if  size(SYMS_FACE_COLOR, 1) == 1
    SYMS_FACE_COLOR = repmat(SYMS_FACE_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
end

SYMS_EDGE_COLOR = pl.get('SYMS_EDGE_COLOR');
if  size(SYMS_EDGE_COLOR, 1) == 1
    SYMS_EDGE_COLOR = repmat(SYMS_EDGE_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
end

% spheres
SPHS_SHOW = pl.get('SPHS');
if SPHS_SHOW
    SPHS_SHOW = repmat(SPHS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
else
    SPHS_SHOW = zeros(pl.get('ATLAS').get('BR_DICT').length, 1);
end

SPHS_SIZE = pl.get('SPHS_SIZE');
if length(SPHS_SIZE) == 1
    SPHS_SIZE = repmat(SPHS_SIZE, pl.get('ATLAS').get('BR_DICT').length, 1);
end

SPHS_FACE_COLOR = pl.get('SPHS_FACE_COLOR');
if  size(SPHS_FACE_COLOR, 1) == 1
    SPHS_FACE_COLOR = repmat(SPHS_FACE_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
end

SPHS_EDGE_COLOR = pl.get('SPHS_FACE_COLOR');
if  size(SPHS_EDGE_COLOR, 1) == 1
    SPHS_EDGE_COLOR = repmat(SPHS_EDGE_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
end

SPHS_EDGE_ALPHA = pl.get('SPHS_EDGE_ALPHA');
if length(SPHS_EDGE_ALPHA) == 1
    SPHS_EDGE_ALPHA = repmat(SPHS_EDGE_ALPHA, pl.get('ATLAS').get('BR_DICT').length, 1);
end

SPHS_FACE_ALPHA = pl.get('SPHS_FACE_ALPHA');
if length(SPHS_FACE_ALPHA) == 1
    SPHS_FACE_ALPHA = repmat(SPHS_FACE_ALPHA, pl.get('ATLAS').get('BR_DICT').length, 1);
end

% ids
IDS_SHOW = pl.get('IDS');
if IDS_SHOW
    IDS_SHOW = repmat(IDS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
else
    IDS_SHOW = zeros(pl.get('ATLAS').get('BR_DICT').length, 1);
end

IDS_SIZE = pl.get('IDS_SIZE');
if length(IDS_SIZE) == 1
    IDS_SIZE = repmat(IDS_SIZE, pl.get('ATLAS').get('BR_DICT').length, 1);
end

IDS_FONT_COLOR = pl.get('IDS_FONT_COLOR');
if  size(IDS_FONT_COLOR, 1) == 1
    IDS_FONT_COLOR = repmat(IDS_FONT_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
end

% labs
LABS_SHOW = pl.get('LABS');
if LABS_SHOW
    LABS_SHOW = repmat(LABS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
else
    LABS_SHOW = zeros(pl.get('ATLAS').get('BR_DICT').length, 1);
end

LABS_SIZE = pl.get('LABS_SIZE');
if length(LABS_SIZE) == 1
    LABS_SIZE = repmat(LABS_SIZE, pl.get('ATLAS').get('BR_DICT').length, 1);
end

LABS_FONT_COLOR = pl.get('LABS_FONT_COLOR');
if  size(LABS_FONT_COLOR, 1) == 1
    LABS_FONT_COLOR = repmat(LABS_FONT_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
end

% for loop for plots and sets
for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
    % symbols
    if SYMS_SHOW(i)
        % plotting
        if ~ishandle(pl.h_syms.h(i))
            pl.h_syms.h(i) = plot3(h_axes, X{i}, Y{i}, Z{i});
        else
            set(pl.h_syms.h(i), 'Xdata',X{i}, 'Ydata', Y{i}, 'Zdata', Z{i})
        end
        % set
        m = PlotBrainAtlas.PLOT_SYMBOL_TAG(pl.get('syms_marker'));
        set(pl.h_syms.h(i), ...
            'Visible', 'on', ...
            'Marker', m{1}, ...
            'MarkerSize', SYMS_SIZE(i), ...
            'MarkerFaceColor', SYMS_FACE_COLOR(i, :), ...
            'MarkerEdgeColor', SYMS_EDGE_COLOR(i, :) ...
            );
    else
        if ishandle(pl.h_syms.h(i))  && ~isempty(pl.h_syms.h(i))
            set(pl.h_syms.h(i), ...
                'Visible', 'off');
        end
    end
    
    % spheres
    if SPHS_SHOW(i)
        % plotting
        if ~ishandle(pl.h_sphs.h(i))
            [sx, sy, sz] = sphere();
            pl.h_sphs.h(i) = surf(h_axes, X{i} * SPHS_SIZE(i) *sx, Y{i} * SPHS_SIZE(i) * sy, ...
                Z{i} * SPHS_SIZE(i) * sz);
        end
        % set
        set(pl.h_sphs.h(i), ...
            'Visible', 'on', ...
            'EdgeColor', SPHS_EDGE_COLOR(i, :), ...
            'EdgeAlpha', SPHS_EDGE_ALPHA(i), ...
            'FaceColor', SPHS_FACE_COLOR(i, :), ...
            'FaceAlpha', SPHS_FACE_ALPHA(i) ...
            );
    else
        if ishandle(pl.h_sphs.h(i))  && ~isempty(pl.h_sphs.h(i))
            set(pl.h_sphs.h(i), ...
                'Visible', 'off');
        end
    end
    
    % ids
    if IDS_SHOW(i)
        % plotting
        if ~ishandle(pl.h_ids.h(i))
            pl.h_ids.h(i) = text(h_axes, X{i}, Y{i}, Z{i}, ID{i});
        end
        % set
        int_ids = PlotBrainAtlas.PLOT_ID_FONT_INTREPETER(pl.get('IDS_FONT_INTERPRETER'));
        set(pl.h_ids.h(i), ...
            'Visible', 'on', ...
            'FontSize', IDS_SIZE(i), ...
            'Color' , IDS_FONT_COLOR(i, :), ...
            'FontName', pl.get('IDS_FONT_NAME'), ...
            'Interpreter', int_ids{1} ...
            );
    else
        if ishandle(pl.h_ids.h(i))  && ~isempty(pl.h_ids.h(i))
            set(pl.h_ids.h(i), ...
                'Visible', 'off');
        end
    end
    
    % labs
    if LABS_SHOW(i)
        % plotting
        if ~ishandle(pl.h_labs.h(i))
            pl.h_labs.h(i) = text(h_axes, X{i}, Y{i}, Z{i}, LABS{i});
        end
        % set
        int_labs = PlotBrainAtlas.PLOT_ID_FONT_INTREPETER(pl.get('LABS_FONT_INTERPRETER'));
        set(pl.h_labs.h(i), ...
            'Visible', 'on', ...
            'FontSize', LABS_SIZE(i), ...
            'Color' , LABS_FONT_COLOR(i, :), ...
            'FontName', pl.get('LABS_FONT_NAME'), ...
            'Interpreter', int_labs{1} ...
            );
    else
        if ishandle(pl.h_labs.h(i))  && ~isempty(pl.h_labs.h(i))
            set(pl.h_labs.h(i), ...
                'Visible', 'off');
        end
    end
    
end

% output
if nargout > 0
    h_panel = pl.pp;
end
end
function f_settings = settings(pl, varargin)
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

    f_settings = settings@PlotBrainSurface(pl, varargin{:});     

    ui_toolbar = findall(f_settings, 'Tag', 'FigureToolBar');
    
    ui_toolbar_separator = uipushtool(ui_toolbar, 'Separator', 'on', 'Visible', 'off');
    ui_toolbar_separator = uipushtool(ui_toolbar, 'Separator', 'on', 'Visible', 'off');

    ui_toolbar_symbols = uipushtool(ui_toolbar, ...
        'Separator', 'off', ...
        'TooltipString', 'Symbols Panel', ...
        'CData', imread('icon_symbol.png'), ...
        'ClickedCallback', {@cb_syms_figure_settings});

    ui_toolbar_spheres = uipushtool(ui_toolbar, ...
        'Separator', 'off', ...
        'TooltipString', 'Spheres Panel', ...
        'CData', imread('icon_sphere.png'), ...
        'ClickedCallback', {@cb_sphs_figure_settings});

    ui_toolbar_labels = uipushtool(ui_toolbar, ...
        'Separator', 'off', ...
        'TooltipString', 'Labels Panel', ...
        'CData', imread('icon_label.png'), ...
        'ClickedCallback', {@cb_labs_figure_settings});

    ui_toolbar_ids = uipushtool(ui_toolbar, ...
        'Separator', 'off', ...
        'TooltipString', 'Ids Panel', ...
        'CData', imread('icon_id.png'), ...
        'ClickedCallback', {@cb_ids_figure_settings});
    
    pl.f_settings = f_settings;
    set(pl.f_settings, 'NAME', [pl.get('ATLAS').get('ID') ' - Plot Settings'])

    % callback functions
        function cb_syms_figure_settings(~, ~) % (src, event)
            pl.f_syms_settings = pl.syms_settings();
        end
        function cb_sphs_figure_settings(~, ~) % (src, event)
            pl.f_sphs_settings = pl.sphs_settings();
        end
        function cb_ids_figure_settings(~, ~) % (src, event)
            pl.f_ids_settings = pl.ids_settings();
        end
        function cb_labs_figure_settings(~, ~) % (src, event)
            pl.f_labs_settings = pl.labs_settings();
        end
end
function f_out = syms_settings(pl)
    % SYMS_SETTINGS panel to set symbols properties
    %
    % SYMS_SETTINGS(PL) allows the user to interactively
    % change the symbols settings via a graphical user interface.
    %
    % SYMS_SETTINGS(PL, 'Property', VALUE, ...) sets
    % the property of the GUI's Property to VALUE.
    % Admissible properties are:
    %     FigPosition  -   normalized position of the GUI on the screen
    %                      [X0 Y0 DX DY]
    %     FigColor     -   background color of the GUI
    %     FigName      -   name of the GUI
    %
    % see also settings, sphs_settings, ids_settings, las_settings.
    
        if isempty(pl.f_syms_settings) || ~isgraphics(pl.f_syms_settings, 'figure')
            pl.f_syms_settings = figure();
        end

        f = pl.f_syms_settings;

        set(f, 'units', 'normalized', ...
            'Position', [.60 .50 .30 .30], ...
            'Color', [1 0.9725 0.929], ...
            'Name','Brain Region Symbol Settings', ...
            'MenuBar', 'none', ...
            'Toolbar', 'none', ...
            'NumberTitle', 'off', ...
            'DockControls', 'off')

        % Initialization
        ui_list = uicontrol(f, 'Style', 'listbox');
        set(ui_list, 'Units', 'normalized')
        set(ui_list, 'BackgroundColor', [.95 .95 .95])
        set(ui_list, 'Value', [])
        set(ui_list, 'Max', 2, 'Min',0)
        set(ui_list, 'BackgroundColor', [1 1 1])
        set(ui_list, 'Position', [.05 .15 .40 .80])
        set(ui_list, 'TooltipString', 'Select brain regions');
        set(ui_list, 'Callback', {@cb_list});

        ui_checkbox_id = uicontrol(f, 'Style', 'checkbox');
        set(ui_checkbox_id, 'Units', 'normalized')
        set(ui_checkbox_id, 'BackgroundColor', [1 0.9725 0.929])
        set(ui_checkbox_id, 'Position', [.05 .05 .20 .10])
        set(ui_checkbox_id, 'String', 'id')
        set(ui_checkbox_id, 'Value', true)
        set(ui_checkbox_id, 'FontWeight', 'bold')
        set(ui_checkbox_id, 'TooltipString', 'Shows brain regions by id')
        set(ui_checkbox_id, 'Callback', {@cb_id})

        ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
        set(ui_checkbox_label, 'Units', 'normalized')
        set(ui_checkbox_label, 'BackgroundColor', [1 0.9725 0.929])
        set(ui_checkbox_label, 'Position', [.20 .05 .15 .10])
        set(ui_checkbox_label, 'String', 'label')
        set(ui_checkbox_label, 'Value', false)
        set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
        set(ui_checkbox_label, 'Callback', {@cb_label})

        ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
        set(ui_checkbox_xyz, 'Units', 'normalized')
        set(ui_checkbox_xyz, 'BackgroundColor', [1 0.9725 0.929])
        set(ui_checkbox_xyz, 'Position', [.35 .05 .15 .10])
        set(ui_checkbox_xyz, 'String', 'xyz')
        set(ui_checkbox_xyz, 'Value', false)
        set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by name')
        set(ui_checkbox_xyz, 'Callback', {@cb_xyz})

        ui_button_show = uicontrol(f, 'Style', 'pushbutton');
        set(ui_button_show, 'Units','normalized')
        set(ui_button_show, 'Position', [.50 .85 .45 .10])
        set(ui_button_show, 'String', 'Show Regions')
        set(ui_button_show, 'TooltipString', 'Show selected brain regions')
        set(ui_button_show, 'Callback', {@cb_show})

        ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
        set(ui_button_hide, 'Units', 'normalized')
        set(ui_button_hide, 'Position', [.50 .75 .45 .10])
        set(ui_button_hide, 'String', 'Hide Regions')
        set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
        set(ui_button_hide, 'Callback', {@cb_hide})

        ui_popup_marker = uicontrol(f, 'Style', 'popup', 'String', {''});
        set(ui_popup_marker, 'Units', 'normalized')
        set(ui_popup_marker, 'BackgroundColor', [1 0.9725 0.929])
        set(ui_popup_marker, 'Position', [.50 .50 .45 .10])
        set(ui_popup_marker, 'String', PlotBrainAtlas.PLOT_SYMBOL_NAME)
        set(ui_popup_marker, 'Value', 2)
        set(ui_popup_marker, 'TooltipString', 'Select symbol');
        set(ui_popup_marker, 'Callback', {@cb_marker})

        ui_text_size = uicontrol(f, 'Style', 'text');
        set(ui_text_size, 'Units', 'normalized')
        set(ui_text_size, 'BackgroundColor', [1 0.9725 0.929])
        set(ui_text_size, 'Position', [.50 .375 .20 .10])
        set(ui_text_size, 'String', 'symbol size ')
        set(ui_text_size, 'HorizontalAlignment', 'left')
        set(ui_text_size, 'FontWeight', 'bold')

        ui_edit_size = uicontrol(f, 'Style', 'edit');
        set(ui_edit_size, 'Units','normalized')
        set(ui_edit_size, 'BackgroundColor', [1 0.9725 0.929])
        set(ui_edit_size, 'Position', [.70 .40 .25 .10])
        set(ui_edit_size, 'HorizontalAlignment', 'center')
        set(ui_edit_size, 'FontWeight', 'bold')
        set(ui_edit_size, 'String', '1')
        set(ui_edit_size, 'Callback', {@cb_size})

        ui_button_facecolor = uicontrol(f, 'Style', 'pushbutton');
        set(ui_button_facecolor, 'Units', 'normalized')
        set(ui_button_facecolor, 'Position', [.50 .25 .45 .10])
        set(ui_button_facecolor, 'String', 'Symbol Color')
        set(ui_button_facecolor, 'TooltipString', 'Select symbol color')
        set(ui_button_facecolor, 'Callback', {@cb_facecolor})

        ui_button_edgecolor = uicontrol(f, 'Style', 'pushbutton');
        set(ui_button_edgecolor, 'Units', 'normalized')
        set(ui_button_edgecolor, 'Position', [.50 .15 .45 .10])
        set(ui_button_edgecolor, 'String', 'Edge Color')
        set(ui_button_edgecolor, 'TooltipString', 'Select symbol edge color')
        set(ui_button_edgecolor, 'Callback', {@cb_edgecolor})

        update_list()
        set(f, 'Visible', 'on')

            function update_list()
                % get info
                ids_ = cellfun(@(x) x.get('ID'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
                labels = cellfun(@(x) x.get('Label'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
                xs = cellfun(@(x) x.get('X'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
                ys = cellfun(@(x) x.get('Y'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
                zs = cellfun(@(x) x.get('Z'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);

                % Set list names
                if get(ui_checkbox_id, 'Value')
                    set(ui_list, 'String', ids_)
                elseif get(ui_checkbox_label, 'Value')
                    set(ui_list, 'String', labels)
                elseif get(ui_checkbox_xyz, 'Value')
                    xyz = cell(1, pl.get('ATLAS').get('BR_DICT').length());
                    for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                        xyz{j} = [num2str(xs{j}) '   ' ...
                            num2str(ys{j}) '   ' ...
                            num2str(zs{j})];
                    end
                    set(ui_list, 'String', xyz)
                end
            end
            function cb_list(~, ~)  % (src, event)
                update_list()
            end
            function cb_id(~,~)  % (src,event)
                set(ui_checkbox_id, 'Value', true)
                set(ui_checkbox_id, 'FontWeight', 'bold')

                set(ui_checkbox_label, 'Value', false)
                set(ui_checkbox_label, 'FontWeight', 'normal')

                set(ui_checkbox_xyz, 'Value', false)
                set(ui_checkbox_xyz, 'FontWeight', 'normal')

                update_list()
            end
            function cb_label(~, ~)  % (src, event)
                set(ui_checkbox_id, 'Value', false)
                set(ui_checkbox_id, 'FontWeight', 'normal')

                set(ui_checkbox_label, 'Value', true)
                set(ui_checkbox_label, 'FontWeight', 'bold')

                set(ui_checkbox_xyz, 'Value', false)
                set(ui_checkbox_xyz, 'FontWeight', 'normal')

                update_list()
            end
            function cb_xyz(~, ~)  % (src, event)
                set(ui_checkbox_id, 'Value', false)
                set(ui_checkbox_id, 'FontWeight', 'normal')

                set(ui_checkbox_label, 'Value', false)
                set(ui_checkbox_label, 'FontWeight', 'normal')

                set(ui_checkbox_xyz, 'Value', true)
                set(ui_checkbox_xyz, 'FontWeight', 'bold')

                update_list()
            end
            function cb_show(~, ~)  % (src, event)
                syms_to_show = get_br_list();
                all_brs_show = pl.get('SYMS');
                if length(all_brs_show) == 1
                    all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
                end
                syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
                if length(syms_to_show) ~= pl.get('ATLAS').get('BR_DICT').length
                    for i = 1:1:length(syms_to_show)
                        syms_to_(syms_to_show(i)) = syms_to_show(i);
                    end
                else
                    syms_to_ = syms_to_show;
                end
                for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                    if i == syms_to_(i)
                        all_brs_show(i) = 1;
                    end
                end
                pl.set('SYMS', all_brs_show);
                pl.draw();
            end
            function cb_hide(~, ~)  % (src, event)
                syms_to_show = get_br_list();
                all_brs_show = pl.get('SYMS');
                if length(all_brs_show) == 1
                    all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
                end
                syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
                if length(syms_to_show) ~= pl.get('ATLAS').get('BR_DICT').length
                    for i = 1:1:length(syms_to_show)
                        syms_to_(syms_to_show(i)) = syms_to_show(i);
                    end
                else
                    syms_to_ = syms_to_show;
                end
                for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                    if i == syms_to_(i)
                        all_brs_show(i) = 0;
                    end
                end
                pl.set('SYMS', all_brs_show);
                pl.draw();
            end
            function cb_marker(~, ~)  % (src, event)
                symbol = get(ui_popup_marker, 'Value');
                pl.set('syms_marker', symbol);
                pl.draw();
            end
            function cb_size(~, ~)  % (src, event)
                size = real(str2double(get(ui_edit_size, 'String')));

                if isempty(size) || size <= 1
                    set(ui_edit_size, 'String', '1')
                    size = 1;
                end

                syms_modified = get_br_list();
                all_brs_sizes = pl.get('SYMS_SIZE');
                if length(all_brs_sizes) == 1
                    all_brs_sizes = repmat(all_brs_sizes, pl.get('ATLAS').get('BR_DICT').length, 1);
                end
                syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
                if length(syms_modified) ~= pl.get('ATLAS').get('BR_DICT').length                    
                    for i = 1:1:length(syms_modified)
                        syms_to_(syms_modified(i)) = syms_modified(i);
                    end
                end
                for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                    if size ~= syms_to_(i)
                        all_brs_sizes(i) = size;
                    end
                end
                pl.set('SYMS_SIZE', all_brs_sizes);
                pl.draw();
            end
            function cb_facecolor(~, ~)  % (src, event)
                color = uisetcolor();
                original_color = pl.get('SYMS_FACE_COLOR');
                syms_to_change = get_br_list();
                if size(original_color, 1) == 1
                    original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
                end
                syms_to_ = zeros(pl.get('ATLAS').get('BR_DICT').length, 1);
                if length(syms_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                    for i = 1:1:length(syms_to_change)
                        syms_to_(syms_to_change(i)) = syms_to_change(i);
                    end
                else
                    syms_to_ = syms_to_change;
                end
                for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                    if i == syms_to_(i)
                        original_color(i, :) = color;
                    end
                end
                pl.set('SYMS_FACE_COLOR', original_color);
                pl.draw();
            end
            function cb_edgecolor(~, ~)  % (src, event)
                color = uisetcolor();
                original_color = pl.get('SYMS_EDGE_COLOR');
                syms_to_change = get_br_list();
                if size(original_color, 1) == 1
                    original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
                end
                syms_to_ = zeros(pl.get('ATLAS').get('BR_DICT').length, 1);
                if length(syms_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                    for i = 1:1:length(syms_to_change)
                        syms_to_(syms_to_change(i)) = syms_to_change(i);
                    end
                else
                    syms_to_ = syms_to_change;
                end
                for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                    if i == syms_to_(i)
                        original_color(i, :) = color;
                    end
                end
                pl.set('SYMS_EDGE_COLOR', original_color);
                pl.draw();
            end
            function bri = get_br_list()
                if pl.get('ATLAS').get('BR_DICT').length()>0
                    bri = get(ui_list, 'String');
                else
                    bri = [];
                end
            end

        if nargout > 0
            f_out = f;
        end
    end
function f_out = sphs_settings(pl)
    % SPHS_SETTINGS panel to set spheres properties
    %
    % SPHS_SETTINGS(PL) allows the user to interactively
    % change the spheres settings via a graphical user interface.
    %
    % SPHS_SETTINGS(PL, 'Property', VALUE, ...) sets
    % the property of the GUI's Property to VALUE.
    % Admissible properties are:
    %     FigPosition  -   normalized position of the GUI on the screen
    %                      [X0 Y0 DX DY]
    %     FigColor     -   background color of the GUI
    %     FigName      -   name of the GUI
    %
    % see also settings, symbols_settings, f_ids_settings, labels_settings.

    if isempty(pl.f_sphs_settings) || ~isgraphics(pl.f_sphs_settings, 'figure')
        pl.f_sphs_settings = figure();
    end

    f = pl.f_sphs_settings;

    set(f, 'units', 'normalized', ...
        'Position', [.60 .45 .30 .30], ...
        'Color', [1 0.9725 0.929], ...
        'Name','Brain Region Sphere Settings', ...
        'MenuBar', 'none', ...
        'Toolbar', 'none', ...
        'NumberTitle', 'off', ...
        'DockControls', 'off')

    % Initialization
    ui_list = uicontrol(f, 'Style', 'listbox');
    set(ui_list, 'Units','normalized')
    set(ui_list, 'BackgroundColor', [.95 .95 .95])
    set(ui_list, 'Value', [])
    set(ui_list, 'Max', 2, 'Min', 0)
    set(ui_list, 'BackgroundColor', [1 1 1])
    set(ui_list, 'Position', [.05 .15 .40 .80])
    set(ui_list, 'TooltipString', 'Select brain regions');
    set(ui_list, 'Callback', {@cb_list});

    ui_checkbox_id = uicontrol(f, 'Style', 'checkbox');
    set(ui_checkbox_id, 'Units','normalized')
    set(ui_checkbox_id, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_checkbox_id, 'Position', [.05 .05 .20 .10])
    set(ui_checkbox_id, 'String', 'id')
    set(ui_checkbox_id, 'Value', true)
    set(ui_checkbox_id, 'FontWeight', 'bold')
    set(ui_checkbox_id, 'TooltipString', 'Shows brain regions by name')
    set(ui_checkbox_id, 'Callback', {@cb_id})

    ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
    set(ui_checkbox_label, 'Units','normalized')
    set(ui_checkbox_label, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_checkbox_label, 'Position', [.20 .05 .15 .10])
    set(ui_checkbox_label, 'String', 'label')
    set(ui_checkbox_label, 'Value', false)
    set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
    set(ui_checkbox_label, 'Callback', {@cb_label})

    ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
    set(ui_checkbox_xyz, 'Units','normalized')
    set(ui_checkbox_xyz, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_checkbox_xyz, 'Position', [.35 .05 .15 .10])
    set(ui_checkbox_xyz, 'String', 'xyz')
    set(ui_checkbox_xyz, 'Value', false)
    set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by position')
    set(ui_checkbox_xyz, 'Callback', {@cb_xyz})

    ui_button_show = uicontrol(f, 'Style', 'pushbutton');
    set(ui_button_show, 'Units','normalized')
    set(ui_button_show, 'Position', [.50 .85 .45 .10])
    set(ui_button_show, 'String', 'Show Regions')
    set(ui_button_show, 'TooltipString', 'Show selected brain regions')
    set(ui_button_show, 'Callback', {@cb_show})

    ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
    set(ui_button_hide, 'Units','normalized')
    set(ui_button_hide, 'Position', [.50 .75 .45 .10])
    set(ui_button_hide, 'String', 'Hide Regions')
    set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
    set(ui_button_hide, 'Callback', {@cb_hide})

    ui_text = uicontrol(f, 'Style', 'text');
    set(ui_text, 'Units','normalized')
    set(ui_text, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_text, 'String', 'transparency')
    set(ui_text, 'Position', [.70 .60 .25 .10])
    set(ui_text, 'HorizontalAlignment', 'center')
    set(ui_text, 'FontWeight', 'bold')

    ui_button_color = uicontrol(f, 'Style', 'pushbutton');
    set(ui_button_color, 'Units','normalized')
    set(ui_button_color, 'Position', [.50 .50 .15 .10])
    set(ui_button_color, 'String', 'sphere color')
    set(ui_button_color, 'HorizontalAlignment', 'center')
    set(ui_button_color, 'TooltipString', 'Brain region color (applied both to faces and edges)')
    set(ui_button_color, 'Callback', {@cb_color})

    ui_slider_alpha = uicontrol(f, 'Style', 'slider');
    set(ui_slider_alpha, 'Units','normalized')
    set(ui_slider_alpha, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_slider_alpha, 'Position', [.70 .475 .25 .10])
    set(ui_slider_alpha, 'String', 'Brain region transparency')
    set(ui_slider_alpha, 'Min', 0, 'Max',1, 'Value',.5);
    set(ui_slider_alpha, 'TooltipString','Brain region transparency (applied both to faces and edges)')
    set(ui_slider_alpha, 'Callback',{@cb_alpha})

    ui_button_facecolor = uicontrol(f, 'Style', 'pushbutton');
    set(ui_button_facecolor, 'Units','normalized')
    set(ui_button_facecolor, 'Position', [.50 .35 .15 .10])
    set(ui_button_facecolor, 'String', 'face color')
    set(ui_button_facecolor, 'HorizontalAlignment', 'center')
    set(ui_button_facecolor, 'TooltipString', 'Brain region face color')
    set(ui_button_facecolor, 'Callback', {@cb_facecolor})

    ui_slider_facealpha = uicontrol(f, 'Style', 'slider');
    set(ui_slider_facealpha, 'Units', 'normalized')
    set(ui_slider_facealpha, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_slider_facealpha, 'Position', [.70 .325 .25 .10])
    set(ui_slider_facealpha, 'String', 'Brain region transparency')
    set(ui_slider_facealpha, 'Min', 0, 'Max', 1, 'Value', .5)
    set(ui_slider_facealpha, 'TooltipString', 'Brain region face transparency')
    set(ui_slider_facealpha, 'Callback', {@cb_facealpha})

    ui_button_edgecolor = uicontrol(f, 'Style', 'pushbutton');
    set(ui_button_edgecolor, 'Units', 'normalized')
    set(ui_button_edgecolor, 'Position', [.50 .20 .15 .10])
    set(ui_button_edgecolor, 'String', 'edge color')
    set(ui_button_edgecolor, 'HorizontalAlignment', 'center')
    set(ui_button_edgecolor, 'TooltipString', 'Brain region edge color')
    set(ui_button_edgecolor, 'Callback', {@cb_edgecolor})

    ui_slider_edgealpha = uicontrol(f, 'Style', 'slider');
    set(ui_slider_edgealpha, 'Units', 'normalized')
    set(ui_slider_edgealpha, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_slider_edgealpha, 'Position', [.70 .175 .25 .10])
    set(ui_slider_edgealpha, 'String', 'Brain transparency')
    set(ui_slider_edgealpha, 'Min', 0, 'Max', 1, 'Value', .5)
    set(ui_slider_edgealpha, 'TooltipString', 'Brain region edge transparency')
    set(ui_slider_edgealpha, 'Callback', {@cb_edgealpha})

    ui_text_radius = uicontrol(f, 'Style', 'text');
    set(ui_text_radius, 'Units', 'normalized')
    set(ui_text_radius, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_text_radius, 'Position', [.50 .025 .20 .10])
    set(ui_text_radius, 'String', 'sphere radius ')
    set(ui_text_radius, 'HorizontalAlignment', 'left')
    set(ui_text_radius, 'FontWeight', 'bold')

    ui_edit_radius = uicontrol(f, 'Style', 'edit');
    set(ui_edit_radius, 'Units', 'normalized')
    set(ui_edit_radius, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_edit_radius, 'Position', [.70 .05 .25 .10])
    set(ui_edit_radius, 'HorizontalAlignment', 'center')
    set(ui_edit_radius, 'FontWeight', 'bold')
    set(ui_edit_radius, 'TooltipString', 'Brain region sphere radius')
    set(ui_edit_radius, 'String', '1')
    set(ui_edit_radius, 'Callback', {@cb_radius})

    update_list()
    set(f,'Visible','on');

        function update_list()
            % get info
            ids_ = cellfun(@(x) x.get('ID'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            labels = cellfun(@(x) x.get('Label'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            xs = cellfun(@(x) x.get('X'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            ys = cellfun(@(x) x.get('Y'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            zs = cellfun(@(x) x.get('Z'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);

            % Set list names
            if get(ui_checkbox_id, 'Value')
                set(ui_list, 'String', ids_)
            elseif get(ui_checkbox_label, 'Value')
                set(ui_list, 'String', labels)
            elseif get(ui_checkbox_xyz, 'Value')
                xyz = cell(1, pl.get('ATLAS').get('BR_DICT').length());
                for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                    xyz{j} = [num2str(xs{j}) '   ' ...
                        num2str(ys{j}) '   ' ...
                        num2str(zs{j})];
                end
                set(ui_list, 'String', xyz)
            end
        end
        function cb_list(~, ~)  % (src, event)
            update_list()
        end
        function cb_id(~,~)  % (src,event)
            set(ui_checkbox_id, 'Value', true)
            set(ui_checkbox_id, 'FontWeight', 'bold')

            set(ui_checkbox_label, 'Value', false)
            set(ui_checkbox_label, 'FontWeight', 'normal')

            set(ui_checkbox_xyz, 'Value', false)
            set(ui_checkbox_xyz, 'FontWeight', 'normal')

            update_list()
        end
        function cb_label(~, ~)  % (src, event)
            set(ui_checkbox_id, 'Value', false)
            set(ui_checkbox_id, 'FontWeight', 'normal')

            set(ui_checkbox_label, 'Value', true)
            set(ui_checkbox_label, 'FontWeight', 'bold')

            set(ui_checkbox_xyz, 'Value', false)
            set(ui_checkbox_xyz, 'FontWeight', 'normal')

            update_list()
        end
        function cb_xyz(~, ~)  % (src, event)
            set(ui_checkbox_id, 'Value', false)
            set(ui_checkbox_id, 'FontWeight', 'normal')

            set(ui_checkbox_label, 'Value', false)
            set(ui_checkbox_label, 'FontWeight', 'normal')

            set(ui_checkbox_xyz, 'Value', true)
            set(ui_checkbox_xyz, 'FontWeight', 'bold')

            update_list()
        end
        function cb_show(~, ~)  % (src, event)
            sphs_to_show = get_br_list();
            all_brs_show = pl.get('SPHS');
            if length(all_brs_show) == 1
                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            sphs_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(sphs_to_show) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(sphs_to_show)
                    sphs_to_(sphs_to_show(i)) = sphs_to_show(i);
                end
            else
                sphs_to_ = sphs_to_show;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == sphs_to_(i)
                    all_brs_show(i) = 1;
                end
            end
            pl.set('SPHS', all_brs_show);
            pl.draw();
        end
        function cb_hide(~, ~)  % (src, event)
            syms_to_show = get_br_list();
            all_brs_show = pl.get('SPHS');
            if length(all_brs_show) == 1
                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(syms_to_show) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(syms_to_show)
                    syms_to_(syms_to_show(i)) = syms_to_show(i);
                end
            else
                syms_to_ = syms_to_show;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    all_brs_show(i) = 0;
                end
            end
            pl.set('SPHS', all_brs_show);
            pl.draw();
        end
        function cb_color(~, ~)  %  (src, event)
            color = uisetcolor();
            original_color = pl.get('SYMS_FACE_COLOR');
            syms_to_change = get_br_list();
            if size(original_color, 1) == 1
                original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(pl.get('ATLAS').get('BR_DICT').length, 1);
            if length(syms_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(syms_to_change)
                    syms_to_(syms_to_change(i)) = syms_to_change(i);
                end
            else
                syms_to_ = syms_to_change;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    original_color(i, :) = color;
                end
            end
            pl.set('SYMS_FACE_COLOR', original_color);
            pl.set('SYMS_EDGE_COLOR', original_color);
            pl.draw();
        end
        function cb_facecolor(~, ~)  % (src, event)
            color = uisetcolor();
            original_color = pl.get('SYMS_FACE_COLOR');
            syms_to_change = get_br_list();
            if size(original_color, 1) == 1
                original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(pl.get('ATLAS').get('BR_DICT').length, 1);
            if length(syms_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(syms_to_change)
                    syms_to_(syms_to_change(i)) = syms_to_change(i);
                end
            else
                syms_to_ = syms_to_change;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    original_color(i, :) = color;
                end
            end
            pl.set('SYMS_FACE_COLOR', original_color);
            pl.draw();
        end
        function cb_edgecolor(~, ~)  % (src, event)
            color = uisetcolor();
            original_color = pl.get('SYMS_EDGE_COLOR');
            syms_to_change = get_br_list();
            if size(original_color, 1) == 1
                original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(pl.get('ATLAS').get('BR_DICT').length, 1);
            if length(syms_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(syms_to_change)
                    syms_to_(syms_to_change(i)) = syms_to_change(i);
                end
            else
                syms_to_ = syms_to_change;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    original_color(i, :) = color;
                end
            end
            pl.set('SYMS_EDGE_COLOR', original_color);
            pl.draw();
        end
        function cb_alpha(~, ~)  % (src, event)
            new_value = get(ui_slider_alpha, 'Value');
            brs_to_change = get_br_list();
            all_alphas_show = pl.get('SPHS_FACE_ALPHA');
            if length(all_alphas_show) == 1
                all_alphas_show = repmat(all_alphas_show, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(brs_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(brs_to_change)
                    syms_to_(brs_to_change(i)) = brs_to_change(i);
                end
            else
                syms_to_ = brs_to_change;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    all_alphas_show(i) = new_value;
                end
            end
            pl.set('SPHS_FACE_ALPHA', all_alphas_show)
            pl.set('SPHS_EDGE_ALPHA', all_alphas_show)
            pl.draw();

            set(ui_slider_facealpha, 'Value', get(ui_slider_alpha, 'Value'))
            set(ui_slider_edgealpha, 'Value', get(ui_slider_alpha, 'Value'))
        end
        function cb_facealpha(~, ~)  % (src, event)
            new_value = get(ui_slider_alpha, 'Value');
            brs_to_change = get_br_list();
            all_alphas_show = pl.get('SPHS_FACE_ALPHA');
            if length(all_alphas_show) == 1
                all_alphas_show = repmat(all_alphas_show, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(brs_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(brs_to_change)
                    syms_to_(brs_to_change(i)) = brs_to_change(i);
                end
            else
                syms_to_ = brs_to_change;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    all_alphas_show(i) = new_value;
                end
            end
            pl.set('SPHS_FACE_ALPHA', all_alphas_show)
            pl.draw();
        end
        function cb_edgealpha(~, ~)  % (src, event)
            new_value = get(ui_slider_alpha, 'Value');
            brs_to_change = get_br_list();
            all_alphas_show = pl.get('SPHS_FACE_ALPHA');
            if length(all_alphas_show) == 1
                all_alphas_show = repmat(all_alphas_show, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(brs_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(brs_to_change)
                    syms_to_(brs_to_change(i)) = brs_to_change(i);
                end
            else
                syms_to_ = brs_to_change;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    all_alphas_show(i) = new_value;
                end
            end
            pl.set('SPHS_EDGE_ALPHA', all_alphas_show)
            pl.draw();
        end
        function cb_radius(~, ~)  % (src, event)
            R = real(str2double(get(ui_edit_radius, 'String')));

            if isempty(R) || R <= 0
                set(ui_edit_radius, 'String', '1')
                R = 1;
            end

            syms_to_show = get_br_list();
            all_brs_show = pl.get('SPHS_SIZE');
            if length(all_brs_show) == 1
                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(syms_to_show) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(syms_to_show)
                    syms_to_(syms_to_show(i)) = syms_to_show(i);
                end
            else
                syms_to_ = syms_to_show;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    all_brs_show(i) = R;
                end
            end
            pl.set('SPHS_SIZE', all_brs_show);
            pl.draw();
        end
        function bri = get_br_list()
            if pl.get('atlas').get('BR_DICT').length() > 0
                bri = get(ui_list, 'String');
            else
                bri = [];
            end
        end
    if nargout > 0
        f_out = f;
    end
end
function f_out = ids_settings(pl)
    % IDS_SETTINGS panel to set ids properties
    %
    % IDS_SETTINGS(PL) allows the user to interactively
    % change the ids settings via a graphical user interface.
    %
    % IDS_SETTINGS(PL, 'Property', VALUE, ...) sets
    % the property of the GUI's Property to VALUE.
    % Admissible properties are:
    %     FigPosition  -   normalized position of the GUI on the screen
    %                      [X0 Y0 DX DY]
    %     FigColor     -   background color of the GUI
    %     FigName      -   name of the GUI
    %
    % see also settings, symbols_settings, spheres_settings, labels_settings.

    if isempty(pl.f_ids_settings) || ~isgraphics(pl.f_ids_settings, 'figure')
        pl.f_ids_settings = figure();
    end

    f = pl.f_ids_settings;

    set(f, 'units', 'normalized', ...
        'Position', [.60 .35 .30 .30], ...
        'Color', [1 0.9725 0.929], ...
        'Name','Brain Region Ids Settings', ...
        'MenuBar', 'none', ...
        'Toolbar', 'none', ...
        'NumberTitle', 'off', ...
        'DockControls', 'off')

    % Initialization
    ui_list = uicontrol(f, 'Style', 'listbox');
    set(ui_list, 'Units', 'normalized')
    set(ui_list, 'BackgroundColor', [.95 .95 .95])
    set(ui_list, 'Value', [])
    set(ui_list, 'Max', 2, 'Min',0)
    set(ui_list, 'BackgroundColor', [1 1 1])
    set(ui_list, 'Position', [.05 .15 .40 .80])
    set(ui_list, 'TooltipString', 'Select brain regions');
    set(ui_list, 'Callback', {@cb_list});

    ui_checkbox_id = uicontrol(f, 'Style', 'checkbox');
    set(ui_checkbox_id, 'Units', 'normalized')
    set(ui_checkbox_id, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_checkbox_id, 'Position', [.05 .05 .20 .10])
    set(ui_checkbox_id, 'String', 'id')
    set(ui_checkbox_id, 'Value', true)
    set(ui_checkbox_id, 'FontWeight', 'bold')
    set(ui_checkbox_id, 'TooltipString', 'Shows brain regions by id')
    set(ui_checkbox_id, 'Callback', {@cb_id})

    ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
    set(ui_checkbox_label, 'Units', 'normalized')
    set(ui_checkbox_label, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_checkbox_label, 'Position', [.20 .05 .15 .10])
    set(ui_checkbox_label, 'String', 'label')
    set(ui_checkbox_label, 'Value', false)
    set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
    set(ui_checkbox_label, 'Callback', {@cb_label})

    ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
    set(ui_checkbox_xyz, 'Units', 'normalized')
    set(ui_checkbox_xyz, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_checkbox_xyz, 'Position', [.35 .05 .15 .10])
    set(ui_checkbox_xyz, 'String', 'xyz')
    set(ui_checkbox_xyz, 'Value', false)
    set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by name')
    set(ui_checkbox_xyz, 'Callback', {@cb_xyz})

    ui_button_show = uicontrol(f, 'Style', 'pushbutton');
    set(ui_button_show, 'Units','normalized')
    set(ui_button_show, 'Position', [.50 .85 .45 .10])
    set(ui_button_show, 'String', 'Show Regions')
    set(ui_button_show, 'TooltipString', 'Show selected brain regions')
    set(ui_button_show, 'Callback', {@cb_show})

    ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
    set(ui_button_hide, 'Units', 'normalized')
    set(ui_button_hide, 'Position', [.50 .75 .45 .10])
    set(ui_button_hide, 'String', 'Hide Regions')
    set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
    set(ui_button_hide, 'Callback', {@cb_hide})

    ui_button_font = uicontrol(f,'Style', 'pushbutton');
    set(ui_button_font, 'Units', 'normalized')
    set(ui_button_font,'Position',[.50 .50 .45 .10])
    set(ui_button_font,'String','Font')
    set(ui_button_font,'TooltipString','Brain regions ids font')
    set(ui_button_font,'Callback',{@cb_font})

    ui_button_color = uicontrol(f, 'Style', 'pushbutton');
    set(ui_button_color, 'Units', 'normalized')
    set(ui_button_color, 'Position' ,[.50 .35 .45 .10])
    set(ui_button_color, 'String', 'Font Color')
    set(ui_button_color, 'TooltipString', 'Brain regions ids color')
    set(ui_button_color, 'Callback', {@cb_color})

    ui_text_interpreter = uicontrol(f, 'Style', 'text');
    set(ui_text_interpreter, 'Units', 'normalized')
    set(ui_text_interpreter, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_text_interpreter, 'Position', [.50 .175 .20 .10])
    set(ui_text_interpreter, 'String', 'interpreter')
    set(ui_text_interpreter, 'HorizontalAlignment', 'left')
    set(ui_text_interpreter, 'FontWeight', 'bold')

    ui_popup_interpreter = uicontrol(f, 'Style', 'popup', 'String', {''});
    set(ui_popup_interpreter, 'Units', 'normalized')
    set(ui_popup_interpreter, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_popup_interpreter, 'Position', [.75 .20 .20 .10])
    set(ui_popup_interpreter, 'String', {'none', 'tex', 'latex'})
    set(ui_popup_interpreter, 'Value', 2)
    set(ui_popup_interpreter, 'TooltipString', 'Brain regions ids interpreter');
    set(ui_popup_interpreter, 'Callback', {@cb_interpreter})

    update_list()
    set(f,'Visible','on')

        function update_list()
            % get info
            ids_ = cellfun(@(x) x.get('ID'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            labels = cellfun(@(x) x.get('Label'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            xs = cellfun(@(x) x.get('X'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            ys = cellfun(@(x) x.get('Y'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            zs = cellfun(@(x) x.get('Z'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);

            % Set list names
            if get(ui_checkbox_id, 'Value')
                set(ui_list, 'String', ids_)
            elseif get(ui_checkbox_label, 'Value')
                set(ui_list, 'String', labels)
            elseif get(ui_checkbox_xyz, 'Value')
                xyz = cell(1, pl.get('ATLAS').get('BR_DICT').length());
                for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                    xyz{j} = [num2str(xs{j}) '   ' ...
                        num2str(ys{j}) '   ' ...
                        num2str(zs{j})];
                end
                set(ui_list, 'String', xyz)
            end
        end
        function cb_list(~, ~)  % (src, event)
            update_list()
        end
        function cb_id(~,~)  % (src,event)
            set(ui_checkbox_id, 'Value', true)
            set(ui_checkbox_id, 'FontWeight', 'bold')

            set(ui_checkbox_label, 'Value', false)
            set(ui_checkbox_label, 'FontWeight', 'normal')

            set(ui_checkbox_xyz, 'Value', false)
            set(ui_checkbox_xyz, 'FontWeight', 'normal')

            update_list()
        end
        function cb_label(~, ~)  % (src, event)
            set(ui_checkbox_id, 'Value', false)
            set(ui_checkbox_id, 'FontWeight', 'normal')

            set(ui_checkbox_label, 'Value', true)
            set(ui_checkbox_label, 'FontWeight', 'bold')

            set(ui_checkbox_xyz, 'Value', false)
            set(ui_checkbox_xyz, 'FontWeight', 'normal')

            update_list()
        end
        function cb_xyz(~, ~)  % (src, event)
            set(ui_checkbox_id, 'Value', false)
            set(ui_checkbox_id, 'FontWeight', 'normal')

            set(ui_checkbox_label, 'Value', false)
            set(ui_checkbox_label, 'FontWeight', 'normal')

            set(ui_checkbox_xyz, 'Value', true)
            set(ui_checkbox_xyz, 'FontWeight', 'bold')

            update_list()
        end
        function cb_show(~, ~)  % (src, event)
            ids_to_show = get_br_list();
            all_brs_show = pl.get('IDS');
            if length(all_brs_show) == 1
                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            sphs_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(ids_to_show) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(ids_to_show)
                    sphs_to_(ids_to_show(i)) = ids_to_show(i);
                end
            else
                sphs_to_ = ids_to_show;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == sphs_to_(i)
                    all_brs_show(i) = 1;
                end
            end
            pl.set('IDS', all_brs_show);
            pl.draw();
        end
        function cb_hide(~, ~)  % (src, event)
            syms_to_show = get_br_list();
            all_brs_show = pl.get('IDS');
            if length(all_brs_show) == 1
                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(syms_to_show) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(syms_to_show)
                    syms_to_(syms_to_show(i)) = syms_to_show(i);
                end
            else
                syms_to_ = syms_to_show;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    all_brs_show(i) = 0;
                end
            end
            pl.set('IDS', all_brs_show);
            pl.draw();
        end
        function cb_color(~, ~)  % (src, event)
            color = uisetcolor();
            original_color = pl.get('IDS_FONT_COLOR');
            syms_to_change = get_br_list();
            if size(original_color, 1) == 1
                original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(pl.get('ATLAS').get('BR_DICT').length, 1);
            if length(syms_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(syms_to_change)
                    syms_to_(syms_to_change(i)) = syms_to_change(i);
                end
            else
                syms_to_ = syms_to_change;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    original_color(i, :) = color;
                end
            end
            pl.set('IDS_FONT_COLOR', original_color);
            pl.draw();
        end
        function cb_font(~,~)  % (src,event)
            font = uisetfont;

            pl.set('IDS_FONT_NAME', font.FontName);
            pl.draw();
        end
        function cb_interpreter(~,~)  %  (src,event)
            string = get(ui_popup_interpreter, 'Value');

            brs_to_change = get_br_list();
            all_ints = pl.get('IDS_FONT_INTERPRETER');
            if length(all_ints) == 1
                all_ints = repmat(all_ints, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(brs_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(brs_to_change)
                    syms_to_(brs_to_change(i)) = brs_to_change(i);
                end
            else
                syms_to_ = brs_to_change;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    all_ints(i) = string;
                end
            end
            pl.set('IDS_FONT_INTERPRETER', all_ints)
            pl.draw();
        end
        function bri = get_br_list()
            if pl.get('atlas').get('BR_DICT').length() > 0
                bri = get(ui_list, 'String');
            else
                bri = [];
            end
        end
    if nargout > 0
        f_out = f;
    end
end
function f_out = labs_settings(pl)
    % LABS_SETTINGS panel to set labels properties
    %
    % LABS_SETTINGS(PL) allows the user to interactively
    % change the label settings via a graphical user interface.
    %
    % LABS_SETTINGS(PL, 'Property', VALUE, ...) sets
    % the property of the GUI's Property to VALUE.
    % Admissible properties are:
    %     FigPosition  -   normalized position of the GUI on the screen
    %                      [X0 Y0 DX DY]
    %     FigColor     -   background color of the GUI
    %     FigName      -   name of the GUI
    %
    % see also settings, symbols_settings, spheres_settings, identificators_settings.
    
    if isempty(pl.f_labs_settings) || ~isgraphics(pl.f_labs_settings, 'figure')
        pl.f_labs_settings = figure();
    end

    f = pl.f_labs_settings;

    set(f, 'units', 'normalized', ...
        'Position', [.60 .40 .30 .30], ...
        'Color', [1 0.9725 0.929], ...
        'Name','Brain Region Labels Settings', ...
        'MenuBar', 'none', ...
        'Toolbar', 'none', ...
        'NumberTitle', 'off', ...
        'DockControls', 'off')

    % Initialization
    ui_list = uicontrol(f, 'Style', 'listbox');
    set(ui_list, 'Units', 'normalized')
    set(ui_list, 'BackgroundColor', [.95 .95 .95])
    set(ui_list, 'Value', [])
    set(ui_list, 'Max', 2, 'Min',0)
    set(ui_list, 'BackgroundColor', [1 1 1])
    set(ui_list, 'Position', [.05 .15 .40 .80])
    set(ui_list, 'TooltipString', 'Select brain regions');
    set(ui_list, 'Callback', {@cb_list});

    ui_checkbox_id = uicontrol(f, 'Style', 'checkbox');
    set(ui_checkbox_id, 'Units', 'normalized')
    set(ui_checkbox_id, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_checkbox_id, 'Position', [.05 .05 .20 .10])
    set(ui_checkbox_id, 'String', 'id')
    set(ui_checkbox_id, 'Value', true)
    set(ui_checkbox_id, 'FontWeight', 'bold')
    set(ui_checkbox_id, 'TooltipString', 'Shows brain regions by id')
    set(ui_checkbox_id, 'Callback', {@cb_id})

    ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
    set(ui_checkbox_label, 'Units', 'normalized')
    set(ui_checkbox_label, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_checkbox_label, 'Position', [.20 .05 .15 .10])
    set(ui_checkbox_label, 'String', 'label')
    set(ui_checkbox_label, 'Value', false)
    set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
    set(ui_checkbox_label, 'Callback', {@cb_label})

    ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
    set(ui_checkbox_xyz, 'Units', 'normalized')
    set(ui_checkbox_xyz, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_checkbox_xyz, 'Position', [.35 .05 .15 .10])
    set(ui_checkbox_xyz, 'String', 'xyz')
    set(ui_checkbox_xyz, 'Value', false)
    set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by name')
    set(ui_checkbox_xyz, 'Callback', {@cb_xyz})

    ui_button_show = uicontrol(f, 'Style', 'pushbutton');
    set(ui_button_show, 'Units','normalized')
    set(ui_button_show, 'Position', [.50 .85 .45 .10])
    set(ui_button_show, 'String', 'Show Regions')
    set(ui_button_show, 'TooltipString', 'Show selected brain regions')
    set(ui_button_show, 'Callback', {@cb_show})

    ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
    set(ui_button_hide, 'Units', 'normalized')
    set(ui_button_hide, 'Position', [.50 .75 .45 .10])
    set(ui_button_hide, 'String', 'Hide Regions')
    set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
    set(ui_button_hide, 'Callback', {@cb_hide})

    ui_button_font = uicontrol(f,'Style', 'pushbutton');
    set(ui_button_font, 'Units', 'normalized')
    set(ui_button_font,'Position',[.50 .50 .45 .10])
    set(ui_button_font,'String','Font')
    set(ui_button_font,'TooltipString','Brain regions labels font')
    set(ui_button_font,'Callback',{@cb_font})

    ui_button_color = uicontrol(f, 'Style', 'pushbutton');
    set(ui_button_color, 'Units', 'normalized')
    set(ui_button_color, 'Position' ,[.50 .35 .45 .10])
    set(ui_button_color, 'String', 'Font Color')
    set(ui_button_color, 'TooltipString', 'Brain regions labels color')
    set(ui_button_color, 'Callback', {@cb_color})

    ui_text_interpreter = uicontrol(f, 'Style', 'text');
    set(ui_text_interpreter, 'Units', 'normalized')
    set(ui_text_interpreter, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_text_interpreter, 'Position', [.50 .175 .20 .10])
    set(ui_text_interpreter, 'String', 'interpreter')
    set(ui_text_interpreter, 'HorizontalAlignment', 'left')
    set(ui_text_interpreter, 'FontWeight', 'bold')

    ui_popup_interpreter = uicontrol(f, 'Style', 'popup', 'String', {''});
    set(ui_popup_interpreter, 'Units', 'normalized')
    set(ui_popup_interpreter, 'BackgroundColor', [1 0.9725 0.929])
    set(ui_popup_interpreter, 'Position', [.75 .20 .20 .10])
    set(ui_popup_interpreter, 'String', {'none', 'tex', 'latex'})
    set(ui_popup_interpreter, 'Value', 2)
    set(ui_popup_interpreter, 'TooltipString', 'Brain regions labels interpreter');
    set(ui_popup_interpreter, 'Callback', {@cb_interpreter})

    update_list()
    set(f,'Visible','on')

        function update_list()
            % get info
            ids_ = cellfun(@(x) x.get('ID'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            labels = cellfun(@(x) x.get('Label'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            xs = cellfun(@(x) x.get('X'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            ys = cellfun(@(x) x.get('Y'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);
            zs = cellfun(@(x) x.get('Z'), pl.get('ATLAS').get('BR_DICT').getItems(), 'UniformOutput', false);

            % Set list names
            if get(ui_checkbox_id, 'Value')
                set(ui_list, 'String', ids_)
            elseif get(ui_checkbox_label, 'Value')
                set(ui_list, 'String', labels)
            elseif get(ui_checkbox_xyz, 'Value')
                xyz = cell(1, pl.get('ATLAS').get('BR_DICT').length());
                for j = 1:1:pl.get('ATLAS').get('BR_DICT').length()
                    xyz{j} = [num2str(xs{j}) '   ' ...
                        num2str(ys{j}) '   ' ...
                        num2str(zs{j})];
                end
                set(ui_list, 'String', xyz)
            end
        end
        function cb_list(~, ~)  % (src, event)
            update_list()
        end
        function cb_id(~,~)  % (src,event)
            set(ui_checkbox_id, 'Value', true)
            set(ui_checkbox_id, 'FontWeight', 'bold')

            set(ui_checkbox_label, 'Value', false)
            set(ui_checkbox_label, 'FontWeight', 'normal')

            set(ui_checkbox_xyz, 'Value', false)
            set(ui_checkbox_xyz, 'FontWeight', 'normal')

            update_list()
        end
        function cb_label(~, ~)  % (src, event)
            set(ui_checkbox_id, 'Value', false)
            set(ui_checkbox_id, 'FontWeight', 'normal')

            set(ui_checkbox_label, 'Value', true)
            set(ui_checkbox_label, 'FontWeight', 'bold')

            set(ui_checkbox_xyz, 'Value', false)
            set(ui_checkbox_xyz, 'FontWeight', 'normal')

            update_list()
        end
        function cb_xyz(~, ~)  % (src, event)
            set(ui_checkbox_id, 'Value', false)
            set(ui_checkbox_id, 'FontWeight', 'normal')

            set(ui_checkbox_label, 'Value', false)
            set(ui_checkbox_label, 'FontWeight', 'normal')

            set(ui_checkbox_xyz, 'Value', true)
            set(ui_checkbox_xyz, 'FontWeight', 'bold')

            update_list()
        end
        function cb_show(~, ~)  % (src, event)
            ids_to_show = get_br_list();
            all_brs_show = pl.get('LABS');
            if length(all_brs_show) == 1
                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            sphs_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(ids_to_show) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(ids_to_show)
                    sphs_to_(ids_to_show(i)) = ids_to_show(i);
                end
            else
                sphs_to_ = ids_to_show;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == sphs_to_(i)
                    all_brs_show(i) = 1;
                end
            end
            pl.set('LABS', all_brs_show);
            pl.draw();
        end
        function cb_hide(~, ~)  % (src, event)
            syms_to_show = get_br_list();
            all_brs_show = pl.get('LABS');
            if length(all_brs_show) == 1
                all_brs_show = repmat(all_brs_show, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(syms_to_show) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(syms_to_show)
                    syms_to_(syms_to_show(i)) = syms_to_show(i);
                end
            else
                syms_to_ = syms_to_show;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    all_brs_show(i) = 0;
                end
            end
            pl.set('LABS', all_brs_show);
            pl.draw();
        end
        function cb_color(~, ~)  % (src, event)
            color = uisetcolor();
            original_color = pl.get('LABS_FONT_COLOR');
            syms_to_change = get_br_list();
            if size(original_color, 1) == 1
                original_color = repmat(original_color, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(pl.get('ATLAS').get('BR_DICT').length, 1);
            if length(syms_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(syms_to_change)
                    syms_to_(syms_to_change(i)) = syms_to_change(i);
                end
            else
                syms_to_ = syms_to_change;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    original_color(i, :) = color;
                end
            end
            pl.set('LABS_FONT_COLOR', original_color);
            pl.draw();
        end
        function cb_font(~,~)  % (src,event)
            font = uisetfont;

            pl.set('LABS_FONT_NAME', font.FontName);
            pl.draw();
        end
        function cb_interpreter(~,~)  %  (src,event)
            string = get(ui_popup_interpreter, 'String');
            brs_to_change = get_br_list();
            all_ints = pl.get('LABS_FONT_INTERPRETER');
            if length(all_ints) == 1
                all_ints = repmat(all_ints, pl.get('ATLAS').get('BR_DICT').length, 1);
            end
            syms_to_ = zeros(1, pl.get('ATLAS').get('BR_DICT').length);
            if length(brs_to_change) ~= pl.get('ATLAS').get('BR_DICT').length
                for i = 1:1:length(brs_to_change)
                    syms_to_(brs_to_change(i)) = brs_to_change(i);
                end
            else
                syms_to_ = brs_to_change;
            end
            for i = 1:1:pl.get('ATLAS').get('BR_DICT').length
                if i == syms_to_(i)
                    all_ints(i) = string;
                end
            end
            pl.set('LABS_FONT_INTERPRETER', all_ints)
            pl.draw();
        end
        function bri = get_br_list()
            if pl.get('atlas').get('BR_DICT').length() > 0
                bri = get(ui_list, 'String');
            else
                bri = [];
            end
        end

    if nargout > 0
        f_out = f;
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
pl = PlotBrainAtlas('atlas', atlas, ...
    'syms', 1, 'SYMS_SIZE', [1:5:25]', ...
    'SYMS_FACE_COLOR', [0 0 0], 'SYMS_EDGE_COLOR', [0 0 0], ...
    'SPHS', 1, 'SPHS_SIZE', [1:1:5]', ...
    'SPHS_FACE_ALPHA', .7, 'SPHS_FACE_COLOR', [0 1 0], ...
    'SPHS_EDGE_ALPHA', .4, 'SPHS_EDGE_COLOR', [1 1 1], ...
    'IDS', 1, 'IDS_SIZE', [11:1:15]', 'IDS_FONT_COLOR', [0 0 0], ...
    'LABS', 1, 'LABS_SIZE', [12:1:16]', 'LABS_FONT_COLOR', [0 0 0], ...
    'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
pl.draw();
pl.settings();

close(fig)