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
symbols % handle for the symbols structure
spheres % handle for the spheres structure
ids % handle for the id structure
labs % handle for the labs structure
f_settings % handle for draw panel 
f_settings_buttons % handle for settings panel 
syms_settings % handle for symbols panel 
sphs_settings % handle for spheres panel 
ids_settings % handle for ids panel 
labs_settings % handle for labs panel 

%% ¡props!

%%% ¡prop!
ATLAS (metadata, item) is the brain atlas with the brain regions
%%%% ¡settings!
'BrainAtlas'

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
%%%% ¡default!
10

%%% ¡prop!
SYMS_MARKER (metadata, cvector) is the symbol option.
%%%% ¡settings!
1:length(PlotBrainAtlas.PLOT_SYMBOL_TAG)
%%%% ¡check_value!
check = 1 <= value &&  value <= length(PlotBrainAtlas.PLOT_SYMBOL_TAG);
%%%% ¡default!
2

%%% ¡prop!
SYMS_FACE_COLOR (metadata, matrix) is the symbol face color.
%%%% ¡check_value!
check = (size(value, 1) == 1 &&  size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
%%%% ¡default!
[0 0 0]

%%% ¡prop!
SYMS_EDGE_COLOR (metadata, matrix) is the symbol edge color.
%%%% ¡check_value!
check = (size(value, 1) == 1 &&  size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
%%%% ¡default!
[0 0 0]

%%% ¡prop!
SPHS (metadata, cvector) is sphere visibility.
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
%%%% ¡default!
1

%%% ¡prop!
SPHS_SIZE (metadata, cvector) is the sphere size.
%%%% ¡conditioning!
value = abs(value);
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
%%%% ¡default!
1

%%% ¡prop!
SPHS_EDGE_COLOR (metadata, matrix) is the sphere edge color.
%%%% ¡check_value!
check = (size(value, 1) == 1 &&  size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
%%%% ¡default!
[0 0 0]

%%% ¡prop!
SPHS_FACE_COLOR (metadata, matrix) is the sphere face color.
%%%% ¡check_value!
check = (size(value, 1) == 1 &&  size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
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
1

%%% ¡prop!
IDS_SIZE (metadata, cvector) is the ids size.
%%%% ¡conditioning!
value = abs(value);
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
%%%% ¡default!
1

%%% ¡prop!
IDS_FONT_COLOR (metadata, matrix) is the ids font color.
%%%% ¡check_value!
check = (size(value, 1) == 1 &&  size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
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
1

%%% ¡prop!
LABS_SIZE (metadata, cvector) is the labs size.
%%%% ¡conditioning!
value = abs(value);
%%%% ¡check_value!
check = length(value) == 1 || length(value) == pl.get('ATLAS').get('BR_DICT').length();
%%%% ¡default!
1

%%% ¡prop!
LABS_FONT_COLOR (metadata, matrix) is the labs font color.
%%%% ¡check_value!
check = (size(value, 1) == 1 &&  size(value, 2) == 3)|| (size(value, 1) == pl.get('ATLAS').get('BR_DICT').length() &&  size(value, 2) == 3);
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
       
    h = draw@PlotBrainSurface(pl, varargin{:});
    % close function
    set(h, 'DeleteFcn', {@close_f_settings}, ...
        varargin{:})
    function close_f_settings(~, ~)
        if ~isempty(pl.f_settings) && isgraphics(pl.f_settings, 'figure')
            close(pl.f_settings)
        end
        if ~isempty(pl.f_settings_buttons) && isgraphics(pl.f_settings_buttons, 'figure')
            close(pl.f_settings_buttons)
        end
        if ~isempty(pl.syms_settings) && isgraphics(pl.syms_settings, 'figure')
            close(pl.syms_settings)
        end
        if ~isempty(pl.sphs_settings) && isgraphics(pl.sphs_settings, 'figure')
            close(pl.sphs_settings)
        end
        if ~isempty(pl.ids_settings) && isgraphics(pl.ids_settings, 'figure')
            close(pl.ids_settings)
        end
        if ~isempty(pl.labs_settings) && isgraphics(pl.labs_settings, 'figure')
            close(pl.labs_settings)
        end
    end
    
    % initialization
    if isempty(pl.symbols)
        pl.symbols = cell(1, pl.get('ATLAS').get('BR_DICT').length);
    end
    
    if isempty(pl.spheres)
        pl.spheres = cell(1, pl.get('ATLAS').get('BR_DICT').length);
    end
    
    if isempty(pl.ids)
        pl.ids = cell(1, pl.get('ATLAS').get('BR_DICT').length);
    end
    
    if isempty(pl.labs)
        pl.labs = cell(1, pl.get('ATLAS').get('BR_DICT').length);
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
    if length(SYMS_SHOW) == 1
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
    if length(SPHS_SHOW) == 1
        SPHS_SHOW = repmat(SPHS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
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
    if length(IDS_SHOW) == 1
        IDS_SHOW = repmat(IDS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
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
    if length(LABS_SHOW) == 1
        LABS_SHOW = repmat(LABS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
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
            if ~ishandle(pl.symbols(i))
                pl.symbols{i} = plot3(X{i}, Y{i}, Z{i});
            end
            % set
            m = PlotBrainAtlas.PLOT_SYMBOL_TAG(pl.get('syms_marker'));
            set(pl.symbols{i}, ...
                'Visible', 'on', ...
                'Marker', m{1}, ...
                'MarkerSize', SYMS_SIZE(i), ...
                'MarkerFaceColor', SYMS_FACE_COLOR(i, :), ...
                'MarkerEdgeColor', SYMS_EDGE_COLOR(i, :) ...
                );
        else
            set(pl.symbols{i}, ...
                'Visible', 'off');
        end
        
        % spheres
        if SPHS_SHOW(i)
            % plotting
            if ~ishandle(pl.spheres(i))
                [sx, sy, sz] = sphere();
                pls.spheres{i} = surf(X{i} * SPHS_SIZE(i) *sx, Y{i} * SPHS_SIZE(i) * sy, ...
                    Z{i} * SPHS_SIZE(i) * sz);
            end
            % set
            set(pl.spheres{i}, ...
                'Visible', 'on', ...
                'EdgeColor', SPHS_EDGE_COLOR(i, :), ...
                'EdgeAlpha', SPHS_EDGE_ALPHA(i), ...
                'FaceColor', SPHS_FACE_COLOR(i, :), ...
                'FaceAlpha', SPHS_FACE_ALPHA(i) ...
                );
        else
            set(pl.spheres{i}, ...
                'Visible', 'off');
        end
        
        % ids
        if IDS_SHOW(i)
            % plotting
            if ~ishandle(pl.ids(i))                
                pls.ids{i} = text(X{i}, Y{i}, Z{i}, ID{i});
            end
            % set            
            set(pl.ids{i}, ...
                'Visible', 'on', ...
                'FontSize', IDS_SIZE(i), ...
                'Color' , IDS_FONT_COLOR(i, :), ...  
                'FontName', pl.get('IDS_FONT_NAME'), ...
                'Interpreter', pl.get('IDS_FONT_INTERPRETER') ...
                );
        else
            set(pl.ids{i}, ...
                'Visible', 'off');
        end
        
        % labs
        if LABS_SHOW(i)
            % plotting
            if ~ishandle(pl.labs(i))                
                pls.labs{i} = text(X{i}, Y{i}, Z{i}, ID{i});
            end
            % set            
            set(pl.labs{i}, ...
                'Visible', 'on', ...
                'FontSize', LABS_SIZE(i), ...
                'Color' , LABS_FONT_COLOR(i, :), ...  
                'FontName', pl.get('LABS_FONT_NAME'), ...
                'Interpreter', pl.get('LABS_FONT_INTERPRETER') ...
                );
        else
            set(pl.labs{i}, ...
                'Visible', 'off');
        end
        
    end
    
    % output
    if nargout > 0
        h_panel = h;
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
    pl.f_settings = f_settings;
    
    % create small buttons figure
    f_settings_position = f_settings.Position;
    new_position = [f_settings_position(1) f_settings_position(2)-.2 f_settings_position(3)-.2 f_settings_position(4)-.1];
    f_settings_buttons = figure('Units', 'normalized', ...
        'Position', new_position, ...
        'Color', [.95 .95 .95], ...
        'Name','Brain Region Symbol Settings', ...
        'MenuBar', 'none', ...
        'Toolbar', 'none', ...
        'NumberTitle', 'off', ...
        'DockControls', 'off');
    
    pl.f_settings_buttons = f_settings_buttons;
    
    % initiliaze buttons for individual settings
    ui_button_syms_pushbutton = uicontrol(f_settings_buttons, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.02 .5 .45 .3], ...
        'String', 'Symbols Settings', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Symbols Settings', ...
        'Callback', {@cb_syms_figure_settings});
    
    ui_button_sphs_pushbutton = uicontrol(f_settings_buttons, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.52 .5 .45 .3], ...
        'String', 'Spheres Settings', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Spheres Settings', ...
        'Callback', {@cb_sphs_figure_settings});
    
    ui_button_ids_pushbutton = uicontrol(f_settings_buttons, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.02 .02 .45 .3], ...
        'String', 'Ids Settings', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Ids Settings', ...
        'Callback', {@cb_ids_figure_settings});
    
    ui_button_labs_pushbutton = uicontrol(f_settings_buttons, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.52 .02 .45 .3], ...
        'String', 'Labs Settings', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Labs Settings', ...
        'Callback', {@cb_labs_figure_settings});
    
    % callback functions
    function cb_sphs_figure_settings(~, ~) % (src, event)
        pl.syms_settings = pl.symbols_settings();
    end
    function cb_syms_figure_settings(~, ~) % (src, event)
        pl.sphs_settings = pl.spheres_settings();
    end
    function cb_ids_figure_settings(~, ~) % (src, event)
        pl.ids_settings = pl.identificators_settings();
    end
    function cb_labs_figure_settings(~, ~) % (src, event)
        pl.labs_settings = pl.labels_settings();
    end
end
function f_out = symbols_settings(pl)
f = figure();
set(f, 'units', 'normalized', ...
    'Position', [.50 .30 .30 .30], ...
    'Color', [.95 .95 .95], ...
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
set(ui_checkbox_id, 'BackgroundColor', [.95 .95 .95])
set(ui_checkbox_id, 'Position', [.05 .05 .20 .10])
set(ui_checkbox_id, 'String', 'id')
set(ui_checkbox_id, 'Value', true)
set(ui_checkbox_id, 'FontWeight', 'bold')
set(ui_checkbox_id, 'TooltipString', 'Shows brain regions by id')
set(ui_checkbox_id, 'Callback', {@cb_id})

ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
set(ui_checkbox_label, 'Units', 'normalized')
set(ui_checkbox_label, 'BackgroundColor', [.95 .95 .95])
set(ui_checkbox_label, 'Position', [.20 .05 .15 .10])
set(ui_checkbox_label, 'String', 'label')
set(ui_checkbox_label, 'Value', false)
set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
set(ui_checkbox_label, 'Callback', {@cb_label})

ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
set(ui_checkbox_xyz, 'Units', 'normalized')
set(ui_checkbox_xyz, 'BackgroundColor', [.95 .95 .95])
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
set(ui_popup_marker, 'BackgroundColor', [.95 .95 .95])
set(ui_popup_marker, 'Position', [.50 .50 .45 .10])
set(ui_popup_marker, 'String', PlotBrainAtlas.PLOT_SYMBOL_NAME)
set(ui_popup_marker, 'Value', 2)
set(ui_popup_marker, 'TooltipString', 'Select symbol');
set(ui_popup_marker, 'Callback', {@cb_marker})

ui_text_size = uicontrol(f, 'Style', 'text');
set(ui_text_size, 'Units', 'normalized')
set(ui_text_size, 'BackgroundColor', [.95 .95 .95])
set(ui_text_size, 'Position', [.50 .375 .20 .10])
set(ui_text_size, 'String', 'symbol size ')
set(ui_text_size, 'HorizontalAlignment', 'left')
set(ui_text_size, 'FontWeight', 'bold')

ui_edit_size = uicontrol(f, 'Style', 'edit');
set(ui_edit_size, 'Units','normalized')
set(ui_edit_size, 'BackgroundColor', [.95 .95 .95])
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

%             update_list()

set(f, 'Visible', 'on')

    function update_list()
        % get info
        ids = cellfun(@(br) br.get('ID'), ba.getBrainAtlas().get('BR_DICT').getItems(), 'UniformOutput', false); %#ok<PROPLC>
        labels = cellfun(@(br) br.get('Label'), ba.getBrainAtlas().get('BR_DICT').getItems(), 'UniformOutput', false);
        xs = cellfun(@(br) br.get('X'), ba.getBrainAtlas().get('BR_DICT').getItems(), 'UniformOutput', false);
        ys = cellfun(@(br) br.get('Y'), ba.getBrainAtlas().get('BR_DICT').getItems(), 'UniformOutput', false);
        zs = cellfun(@(br) br.get('Z'), ba.getBrainAtlas().get('BR_DICT').getItems(), 'UniformOutput', false);
        
        % Set list names
        if get(ui_checkbox_id, 'Value')
            set(ui_list, 'String', ids) %#ok<PROPLC>
        elseif get(ui_checkbox_label, 'Value')
            set(ui_list, 'String', labels)
        elseif get(ui_checkbox_xyz, 'Value')
            xyz = cell(1, ba.getBrainAtlas().get('BR_DICT').length());
            for j = 1:1:ba.getBrainAtlas().get('BR_DICT').length()
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
        ba.br_syms(get_br_list())
        ba.br_syms_on(get_br_list())
    end
    function cb_hide(~, ~)  % (src, event)
        ba.br_syms_off(get_br_list())
    end
    function cb_marker(~, ~)  % (src, event)
        symbol = PlotBrainAtlas.PLOT_SYMBOL_TAG{get(ui_popup_marker, 'Value')};
        ba.br_syms(get_br_list(), 'Marker', symbol)
    end
    function cb_size(~, ~)  % (src, event)
        size = real(str2double(get(ui_edit_size, 'String')));
        
        if isempty(size) || size <= 1
            set(ui_edit_size, 'String', '1')
            size = 1;
        end
        ba.br_syms(get_br_list(), 'MarkerSize', size)
    end
    function cb_facecolor(~, ~)  % (src, event)
        color = uisetcolor();
        
        if length(color) == 3
            ba.br_syms(get_br_list(), 'MarkerFaceColor', color)
        end
    end
    function cb_edgecolor(~, ~)  % (src, event)
        color = uisetcolor();
        
        if length(color) == 3
            ba.br_syms(get_br_list(), 'MarkerEdgeColor', color)
        end
    end
    function bri = get_br_list()
        if ba.getBrainAtlas().get('BR_DICT').length()>0
            bri = get(ui_list, 'Value');
        else
            bri = [];
        end
    end

if nargout > 0
    f_out = f;
end
end
function f_out = spheres_settings(pl)
end
function f_out = identificators_settings(pl)
end
function f_out = labels_settings(pl)
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
pl.draw()
pl.settings()

close(fig)