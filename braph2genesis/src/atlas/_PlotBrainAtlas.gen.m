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
    
    % I need a check to see which figure to create or which controls to
    % show. cant use varargin, figure will crash. I propose turning on and
    % uicontrols and add a new property to see which setting we using.

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