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

%% ¡properties!
symbols % handle for the symbols structure
spheres % handle for the spheres structure

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
check = 1 < value &&  value < length(PlotBrainAtlas.PLOT_SYMBOL_TAG);
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

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the brain surface graphical panel.
    %
    % DRAW(PL) draws the brain surface graphical panel.
    %
    % H = DRAW(PL) returns a handle to the brain surface graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
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
    
    % get coordinates
    X = cellfun(@(x) x.get('X'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
    Y = cellfun(@(x) x.get('Y'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
    Z = cellfun(@(x) x.get('Z'), pl.get('ATLAS').get('BR_DICT').get('IT_LIST'), 'UniformOutput', false);
    
    % get values & complete vector size
    SYMS_SIZE = pl.get('syms_size');
    if length(SYMS_SIZE) == 1
        SYMS_SIZE = repmat(SYMS_SIZE, pl.get('ATLAS').get('BR_DICT').length, 1);
    end
    
    SYMS_SHOW = pl.get('syms');
    if length(SYMS_SHOW) == 1
        SYMS_SHOW = repmat(SYMS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
    end
    
    SYMS_FACE_COLOR = pl.get('syms_face_color');
    if  size(SYMS_FACE_COLOR, 1) == 1        
        SYMS_FACE_COLOR = repmat(SYMS_FACE_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
    end
    
    SYMS_EDGE_COLOR = pl.get('syms_edge_color');
    if  size(SYMS_EDGE_COLOR, 1) == 1
        SYMS_EDGE_COLOR = repmat(SYMS_EDGE_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
    end
    
    SPHS_SHOW = pl.get('sphs');
    if length(SPHS_SHOW) == 1
        SPHS_SHOW = repmat(SPHS_SHOW, pl.get('ATLAS').get('BR_DICT').length, 1);
    end
    
    SPHS_SIZE = pl.get('SPHS_SIZE'); 
    if length(SPHS_SIZE) == 1
        SPHS_SIZE = repmat(SPHS_SIZE, pl.get('ATLAS').get('BR_DICT').length, 1);
    end  
    
    SPHS_FACE_COLOR = pl.get('sphs_face_color');
    if  size(SPHS_FACE_COLOR, 1) == 1        
        SPHS_FACE_COLOR = repmat(SPHS_FACE_COLOR, pl.get('ATLAS').get('BR_DICT').length, 1);
    end
    
    SPHS_EDGE_COLOR = pl.get('sphs_edge_color');
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
    end
    
    % output
    if nargout > 0
        h_panel = h;
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
    'syms', 1, 'SYMS_SIZE', [20:10:60]', ...
    'SYMS_FACE_COLOR', [0 0 0], 'SYMS_EDGE_COLOR', [0 0 0], ...
    'SPHS', 1, 'SPHS_SIZE', [1:2:10]', ...
    'SPHS_FACE_ALPHA', .7, 'SPHS_FACE_COLOR', [0 1 0], ...
    'SPHS_EDGE_ALPHA', .4, 'SPHS_EDGE_COLOR', [1 1 1], ...
    'SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
pl.draw()

close(fig)