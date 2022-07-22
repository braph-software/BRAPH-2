%% ¡header!
PFBrainGraph < PFBrainAtlas (pf, plot brain graph) is a plot of a brain graph.

%%% ¡description!
PFBrainGraph manages the plot of the graph edges, arrows and cylinders.
PFBrainGraph utilizes the surface created from PFBrainAtlas to
integrate the regions to a brain surface.

%%% ¡seealso!
Plot, BrainAtlas, PFBrainSurface, PFBrainAtlas.

%% ¡constants!
PLOT_LINESTYLE_TAG = { ...
    '-' ...
    ':' ...
    '-.' ...
    '--' ...
    'none' ...
    };

PLOT_LINESTYLE_NAME = { ...
    'solid' ...
    'dotted' ...
    'dashdot' ...
    'dashed' ...
    'none' ...
    };

% edge line
INIT_LIN_COLOR = [0 0 0];
INIT_LIN_STYLE = PFBrainGraph.PLOT_LINESTYLE_TAG{1};
INIT_LIN_WIDTH  = .1;

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


%% ¡properties!
p % handle for panel
h_axes % handle for axes

edges % struct for edges

toolbar
toolbar_measure
toolbar_edges

%% ¡props!
%%% ¡prop!
ME (metadata, item) is the measure.

%%% ¡prop!
MEASURES (figure, logical) determines whether the measures affect the brain region.
%%%% ¡default!
false
%%%% ¡postprocessing!
if ~braph2_testing
    if pf.get('MEASURES')
        measures = pf.get('ME');
        % increase br size by measure value
        if pf.get('SPHS')
            sph_dict = pf.get('SPH_DICT');
            for i = 1:sph_dict.length
                sph = sph_dict.getItem(i);
                m = measures(i);
                default_value = sph.get('SPHERESIZE');
                sph.set('SPHERESIZE', default_value * m);
            end
        end
        if pf.get('SYMS')
            sym_dict = pf.get('SYM_DICT');            
            for i = 1:sym_dict.length
                sym = sym_dict.getItem(i);
                m = measures(i);
                default_value = sym.get('SYMSIZE');
                sym.set('SYMSIZE', default_value * m);
            end            
        end
    else
        % restore default values
        if pf.get('SPHS')
            sph_dict = pf.get('SPH_DICT');
            for i = 1:sph_dict.length
                sph = sph_dict.getItem(i);
                default_value = sph.get('SPHERESIZE');
                sph.set('SPHERESIZE', default_value);
            end
        end
        if pf.get('SYMS')
            sym_dict = pf.get('SYM_DICT');
            for i = 1:sym_dict.length
                sym = sym_dict.getItem(i);
                default_value = sym.get('SYMSIZE');
                sym.set('SYMSIZE', default_value);
            end            
        end        
    end
    
    % triggers the update of SPH_DICT this causes loop
    %pf.set('SPH_DICT', pf.get('SPH_DICT'))
    %pf.set('SYM_DICT', pf.get('SYM_DICT'))
    
    % update state of toggle tool
    set(pf.toolbar_measure, 'State', pf.get('MEASURES'))
end

%%% ¡prop!
EDGES (figure, logical) determines whether the edges are shown as a edge.
%%%% ¡default!
false
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('EDGES', varargin)) && ~braph2_testing
    if ~pf.get('EDGES') && ~isempty(pf.edges)
        for i = 1:size(pf.edges.links)
            pf.link_edges_off([], [])
            pf.arrow_edges_off([], [])
            pf.cylinder_edges_off([],[])
        end
    else
        % trigger listener
        pf.set('ST_EDGES', pf.get('ST_EDGES'));        
    end
    
    % update state of toggle tool
    set(pf.toolbar_edges, 'State', pf.get('EDGES'))
end

%%% ¡prop!
ST_EDGES (figure, item) determines the edge settings.
%%%% ¡settings!
'SettingsEdges'
%%%% ¡default!
SettingsEdges('LINKS', false, 'LINKSCOLOR', PFBrainGraph.INIT_LIN_COLOR, 'LINKLINESTYLE', PFBrainGraph.INIT_LIN_STYLE, 'LINKLINEWIDTH', PFBrainGraph.INIT_LIN_WIDTH, ...
    'ARROWS', false, 'ARROWCOLOR', PFBrainGraph.INIT_ARR_COLOR, 'ARROWSWIDTH', PFBrainGraph.INIT_ARR_SWIDTH, 'ARROWHLENGTH', PFBrainGraph.INIT_ARR_HLENGTH, 'ARROWHWIDTH', PFBrainGraph.INIT_ARR_HWIDTH, 'ARROWHNODE', PFBrainGraph.INIT_ARR_HNODE, 'ARROWN', PFBrainGraph.INIT_ARR_N, ...
    'CYLINDERS', false, 'CYLCOLOR', PFBrainGraph.INIT_CYL_COLOR, 'CYLR', PFBrainGraph.INIT_CYL_R,'CYLN', PFBrainGraph.INIT_CYL_N, ...
    'TEXTS', false)

%%%% ¡gui!
pr = SettingsEdgesPP('EL', pf, 'PROP', PFBrainGraph.ST_EDGES, varargin{:});

%% ¡methods!
function h_panel = draw(pf, varargin)
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

    pf.p = draw@PFBrainAtlas(pf, varargin{:});
    
    % init edge struct
    brain_regions_length = pf.get('BA').get('BR_DICT').length();
    pf.edges.links = NaN(brain_regions_length);
    pf.edges.arr = NaN(brain_regions_length);
    pf.edges.cyl = NaN(brain_regions_length);
    pf.edges.texts = NaN(brain_regions_length);
    pf.edges.X1 = zeros(brain_regions_length, 1);
    pf.edges.Y1 = zeros(brain_regions_length, 1);
    pf.edges.Z1 = zeros(brain_regions_length, 1);
    pf.edges.X2 = zeros(brain_regions_length, 1);
    pf.edges.Y2 = zeros(brain_regions_length, 1);
    pf.edges.Z2 = zeros(brain_regions_length, 1);

    % get axes
    if ~check_graphics(pf.h_axes, 'axes')
        pf.h_axes =  pf.p.Children(1);
    end
    
    pf.memorize('ST_EDGES').h(pf.h_axes).set('PANEL', pf, 'UITAG', 'h_axes')
    listener(pf.get('ST_EDGES'), 'PropSet', @cb_st_edges);
        function cb_st_edges(~, ~) % (src, event)
            if pf.get('ST_EDGES').get('LINKS')
                pf.link_edges([], [])
                pf.set('EDGES', true)
            elseif pf.get('ST_EDGES').get('ARROWS')
                pf.arrow_edges([], [])
                pf.set('EDGES', true)
            elseif pf.get('ST_EDGES').get('CYLINDERS')
                pf.cylinder_edges([], [])
                pf.set('EDGES', true)
            elseif pf.get('ST_EDGES').get('TEXTS')% texts
                pf.text_edges([], [])
                pf.set('EDGES', true)
            else
                pf.set('EDGES', false)
            end
        end

    % get toolbar
    if ~check_graphics(pf.toolbar, 'uitoolbar')
        pf.toolbar = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'ToolBar');
    end
    
    % set new toogletools
    if ~check_graphics(pf.toolbar_measure, 'uitoggletool') 
        
        uipushtool(pf.toolbar, 'Separator', 'on', 'Visible', 'off')

        % measures
        pf.toolbar_measure = uitoggletool(pf.toolbar, ...
            'Tag', 'toolbar_measure', ...
            'Separator', 'on', ...
            'State', pf.get('MEASURES'), ...
            'Tooltip', 'Show Measures', ...
            'CData', imread('icon_measure_panel.png'), ...
            'OnCallback', {@cb_measures, true}, ...
            'OffCallback', {@cb_measures, false});
        
        % links
        pf.toolbar_edges = uitoggletool(pf.toolbar, ...
            'Tag', 'toolbar_edges', ...
            'Separator', 'on', ...
            'State', pf.get('EDGES'), ...
            'Tooltip', 'Show Edges', ...
            'CData', imread('icon_graph_panel.png'), ...
            'OnCallback', {@cb_edges, true}, ...
            'OffCallback', {@cb_edges, false});
    end
    
    function cb_measures(~, ~, measures) % (src, event)
        pf.set('MEASURES', measures)
    end
    function cb_edges(~, ~, edges) % (src, event)
        pf.set('EDGES', edges)
    end

    % listener to changes in 

    % output
    if nargout > 0
        h_panel = pf.p;
    end
end
function str = tostring(pf, varargin)
    %TOSTRING string with information about the brain atlas.
    %
    % STR = TOSTRING(PF) returns a string with information about the brain atlas.
    %
    % STR = TOSTRING(PF, N) trims the string to the first N characters.
    %
    % STR = TOSTRING(PF, N, ENDING) ends the string with ENDING if it has
    %  been trimmed.
    %
    % See also disp, tree.

    str = 'Plot Brain Graph';
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end

function h = link_edge(pf, i, j)
    % LINK_EDGE plots edge edge as line
    %
    % LINK_EDGE(BG, I, J) plots the edge edge from the brain regions
    % I to J as a line, if not plotted.
    %
    % H = LINK_EDGE(BG, I, J) returns the handle to the edge edge
    % from the brain region I to J.
    %
    % LINK_EDGE(BG, I, J, PROPERTY, VALUE, ...) sets the property
    % of the edge edge line PROPERTY to VALUE.
    % All standard plot properties of plot3 can be used.
    % The line properties can also be changed when hidden.
    %
    % See also PlotBrainGraph, plot3, link_edges, text_edge.

    if i == j  % removes diagonal
        return;
    end
    % get brain regions

    br_1 = pf.get('BA').get('BR_DICT').getItem(i);
    br_2 = pf.get('BA').get('BR_DICT').getItem(j);
    % get coordinates
    X1 = br_1.get('X');
    Y1 = br_1.get('Y');
    Z1 = br_1.get('Z');

    X2 = br_2.get('X');
    Y2 = br_2.get('Y');
    Z2 = br_2.get('Z');

    if ~ishandle(pf.edges.links(j, i))
        if ~ishandle(pf.edges.links(i, j))

            pf.edges.links(i, j) = plot3( ...
                pf.get_axes(), ...
                [X1 X2], ...
                [Y1 Y2], ...
                [Z1 Z2], ...
                'Color', pf.get('ST_EDGES').get('LINKSCOLOR'), ...
                'LineStyle', pf.get('ST_EDGES').get('LINKLINESTYLE'), ...
                'LineWidth', pf.get('ST_EDGES').get('LINKLINEWIDTH'));
        else
            x1 = pf.edges.X1(i, j);
            y1 = pf.edges.Y1(i, j);
            z1 = pf.edges.Z1(i, j);

            x2 = pf.edges.X2(i, j);
            y2 = pf.edges.Y2(i, j);
            z2 = pf.edges.Z2(i, j);

            if x1 ~= X1 || y1 ~= Y1 || z1 ~= Z1 ...
                    || x2 ~= X2 || y2 ~= Y2 || z2 ~= Z2

                set(pf.edges.links(i, j), 'XData', [X1 X2]);
                set(pf.edges.links(i, j), 'YData', [Y1 Y2]);
                set(pf.edges.links(i, j), 'ZData', [Z1 Z2]);
            end
        end
    else
        pf.edges.links(i, j) = pf.edges.links(j, i);
    end
    pf.edges.X1(i, j) = X1;
    pf.edges.Y1(i, j) = Y1;
    pf.edges.Z1(i, j) = Z1;

    pf.edges.X2(i, j) = X2;
    pf.edges.Y2(i, j) = Y2;
    pf.edges.Z2(i, j) = Z2;

    % sets properties
    set(pf.edges.links(i, j), 'LineStyle', pf.get('ST_EDGES').get('LINKLINESTYLE'));
    set(pf.edges.links(i, j),'LineWidth', pf.get('ST_EDGES').get('LINKLINEWIDTH'));
    set(pf.edges.links(i, j),'Color', pf.get('ST_EDGES').get('LINKSCOLOR'));

    if nargout>0
        h = pf.edges.links(i, j);
    end
end
function link_edge_on(pf, i, j)
    % LINK_EDGE_ON shows a edge edge
    %
    % LINK_EDGE_ON(BG, I, J) shows the edge edge from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_off.

    if ishandle(pf.edges.links(i, j))
        set(pf.edges.links(i, j), 'Visible', 'on')
    end
end
function link_edge_off(pf, i, j)
    % LINK_EDGE_OFF hides a edge edge
    %
    % LINK_EDGE_OFF(BG, I, J) hides the edge edge from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if ishandle(pf.edges.links(i, j))
        set(pf.edges.links(i, j), 'Visible', 'off')
    end
end
function link_edges(pf, i_vec, j_vec, varargin)
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
        for i = 1:1:pf.get('BA').get('BR_DICT').length()
            for j = 1:1:pf.get('BA').get('BR_DICT').length()
                pf.link_edge(i, j, varargin{:})
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
            pf.link_edge(i_vec(m), j_vec(m), varargin{:})
        end
    end
end
function link_edges_on(pf, i_vec, j_vec)
    % LINK_EDGES_ON shows multiple edge edge
    %
    % LINK_EDGES_ON(BG, I, J) shows multiple edge edge from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edges, link_edges_off.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pf.get('BA').get('BR_DICT').length()
            for j = 1:1:pf.get('BA').get('BR_DICT').length()
                pf.link_edge_on(i, j)
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
            pf.link_edge_on(i_vec(m), j_vec(m))
        end
    end
end
function link_edges_off(pf, i_vec, j_vec)
    % LINK_EDGES_OFF hides multiple edge links
    %
    % LINK_EDGES_OFF(BG, I, J) hides multiple edge links from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pf.get('BA').get('BR_DICT').length()
            for j = 1:1:pf.get('BA').get('BR_DICT').length()
                pf.link_edge_off(i, j)
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
            pf.link_edge_off(i_vec(m), j_vec(m))
        end
    end
end
function bool = link_edge_is_on(pf, i, j)
    % LINK_EDGE_IS_ON checks if line edge is visible
    %
    % BOOL = LINK_EDGE_IS_ON(BG, I, J) returns true if the line edge
    % from the brain regions I to J is visible and false otherwise.
    %
    % See also PlotBrainGraph.

    bool = ishandle(pf.edges.links(i, j)) && strcmpi(get(pf.edges.links(i, j), 'Visible'), 'on');
end

function h = arrow_edge(pf, i, j, varargin)
    % ARROW_EDGE plots edge edge as an arrow
    %
    % ARROW_EDGE(BG, I, J) plots the edge edge from the brain regions
    % I to J as a line, if not plotted.
    %
    % H = ARROW_EDGE(BG, I, J) returns the handle to the edge edge
    % from the brain region I to J.
    %
    % ARROW_EDGE(BG, I, J, PROPERTY, VALUE, ...) sets the property
    % of the edge edge line PROPERTY to VALUE.
    % All standard plot properties of plot3 can be used.
    % The line properties can also be changed when hidden.
    %
    % See also PlotBrainGraph, plot3, link_edges.

    if i == j  % removes diagonal
        return;
    end
    
    % get brain regions
    br_1 = pf.get('BA').get('BR_DICT').getItem(i);
    br_2 = pf.get('BA').get('BR_DICT').getItem(j);
    % get coordinates
    X1 = br_1.get('X');
    Y1 = br_1.get('Y');
    Z1 = br_1.get('Z');

    X2 = br_2.get('X');
    Y2 = br_2.get('Y');
    Z2 = br_2.get('Z');

    % arrow properties
    color = pf.get('ST_EDGES').get('ARROWCOLOR');
    SWIDTH = pf.get('ST_EDGES').get('ARROWSWIDTH');
    HLENGTH = pf.get('ST_EDGES').get('ARROWHLENGTH');
    HWIDTH = pf.get('ST_EDGES').get('ARROWHWIDTH');
    HNODE = pf.get('ST_EDGES').get('ARROWHNODE');
    N = pf.get('ST_EDGES').get('ARROWN');

    if ~ishandle(pf.edges.arr(i, j))

        [X, Y, Z] = arrow3d(X1, Y1, Z1, X2, Y2, Z2,...
            'StemWidth', SWIDTH, ...
            'HeadLength', HLENGTH, ...
            'HeadWidth', HWIDTH, ...
            'HeadNode', HNODE, ...
            'N', N);

        pf.edges.arr(i, j) = surf(X, Y, Z,...
            'EdgeColor', color,...
            'FaceColor', color,...
            'Parent', pf.get_axes());
    else
        x1 = pf.edges.X1(i, j);
        y1 = pf.edges.Y1(i, j);
        z1 = pf.edges.Z1(i, j);

        x2 = pf.edges.X2(i, j);
        y2 = pf.edges.Y2(i, j);
        z2 = pf.edges.Z2(i, j);

        if x1 ~= X1 || y1 ~= Y1 || z1 ~= Z1 ...
                || x2 ~= X2 || y2 ~= Y2 || z2 ~= Z2

            [X, Y, Z] = arrow3d(X1, Y1, Z1, X2, Y2, Z2,...
                'StemWidth', SWIDTH, ...
                'HeadLength', HLENGTH, ...
                'HeadWidth', HWIDTH, ...
                'HeadNode', HNODE, ...
                'N', N);

            set(pf.edges.arr(i, j), 'XData', X);
            set(pf.edges.arr(i, j), 'YData', Y);
            set(pf.edges.arr(i, j), 'ZData', Z);

        end
    end
    pf.edges.X1(i, j) = X1;
    pf.edges.Y1(i, j) = Y1;
    pf.edges.Z1(i, j) = Z1;

    pf.edges.X2(i, j) = X2;
    pf.edges.Y2(i, j) = Y2;
    pf.edges.Z2(i, j) = Z2;

    % sets properties
    set(pf.edges.arr(i, j), 'FACECOLOR', pf.get('ST_EDGES').get('ARROWFACECOLOR'));
    set(pf.edges.arr(i, j), 'LINKSCOLOR', pf.get('ST_EDGES').get('ARROWEDGECOLOR'));
    
    if nargout>0
        h = pf.edges.arr(i, j);
    end
end
function arrow_edge_on(pf, i, j)
    % ARROW_EDGE_ON shows a edge edge
    %
    % ARROW_EDGE_ON(BG, I, J) shows the edge edge from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_off.

    if ishandle(pf.edges.arr(i, j))
        set(pf.edges.arr(i, j), 'Visible', 'on')
    end
end
function arrow_edge_off(pf, i, j)
    % ARROW_EDGE_OFF hides a edge edge
    %
    % ARROW_EDGE_OFF(BG, I, J) hides the edge edge from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if ishandle(pf.edges.arr(i, j))
        set(pf.edges.arr(i, j), 'Visible', 'off')
    end
end
function arrow_edges(pf, i_vec, j_vec, varargin)
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
        for i = 1:1:pf.get('BA').get('BR_DICT').length()
            for j = 1:1:pf.get('BA').get('BR_DICT').length()
                pf.arrow_edge(i, j, varargin{:})
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
            pf.arrow_edge(i_vec(m), j_vec(m), varargin{:})
        end
    end
end
function arrow_edges_on(pf, i_vec, j_vec)
    % ARROW_EDGES_ON shows multiple edge edge
    %
    % ARROW_EDGES_ON(BG, I, J) shows multiple edge edge from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edges, link_edges_off.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pf.get('BA').get('BR_DICT').length()
            for j = 1:1:pf.get('BA').get('BR_DICT').length()
                pf.arrow_edge_on(i, j)
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
            pf.arrow_edge_on(i_vec(m), j_vec(m))
        end
    end
end
function arrow_edges_off(pf, i_vec, j_vec)
    % ARROW_EDGES_OFF hides multiple edge links
    %
    % ARROW_EDGES_OFF(BG, I, J) hides multiple edge links from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pf.get('BA').get('BR_DICT').length()
            for j = 1:1:pf.get('BA').get('BR_DICT').length()
                pf.arrow_edge_off(i, j)
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
            pf.arrow_edge_off(i_vec(m), j_vec(m))
        end
    end
end
function bool = arrow_edge_is_on(pf, i, j)
    % ARROW_EDGE_IS_ON checks if line edge is visible
    %
    % BOOL = ARROW_EDGE_IS_ON(BG, I, J) returns true if the line arrow edge
    % from the brain regions I to J is visible and false otherwise.
    %
    % See also PlotBrainGraph.

    bool = ishandle(pf.edges.arr(i, j)) && strcmpi(get(pf.edges.arr(i, j), 'Visible'), 'on');
end

function h = cylinder_edge(pf, i, j, varargin)
    % CYLINDER_EDGE plots edge edge as an cylinder
    %
    % CYLINDER_EDGE(BG, I, J) plots the edge edge from the brain regions
    % I to J as a line, if not plotted.
    %
    % H = CYLINDER_EDGE(BG, I, J) returns the handle to the edge edge
    % from the brain region I to J.
    %
    % CYLINDER_EDGE(BG, I, J, PROPERTY, VALUE, ...) sets the property
    % of the edge edge line PROPERTY to VALUE.
    % All standard plot properties of plot3 can be used.
    % The line properties can also be changed when hidden.
    %
    % See also PlotBrainGraph, plot3, link_edges.

    if i == j  % removes diagonal
        return;
    end
    
    % get brain regions
    br_1 = pf.get('BA').get('BR_DICT').getItem(i);
    br_2 = pf.get('BA').get('BR_DICT').getItem(j);
    % get coordinates
    X1 = br_1.get('X');
    Y1 = br_1.get('Y');
    Z1 = br_1.get('Z');

    X2 = br_2.get('X');
    Y2 = br_2.get('Y');
    Z2 = br_2.get('Z');

    % cylinder properties
    color = pf.get('ST_EDGES').get('CYLCOLOR');
    R = pf.get('ST_EDGES').get('CYLR');
    N = pf.get('ST_EDGES').get('CYLN');

    if ~ishandle(pf.edges.cyl(i, j))

        [X, Y, Z] = cylinder3d(X1, Y1, Z1, X2, Y2, Z2,...
            'R', R, ...
            'N', N);

        pf.edges.cyl(i, j) = surf(X, Y, Z,...
            'EdgeColor', color, ...
            'FaceColor', color, ...
            'Parent', pf.get_axes());
    else
        x1 = pf.edges.X1(i, j);
        y1 = pf.edges.Y1(i, j);
        z1 = pf.edges.Z1(i, j);

        x2 = pf.edges.X2(i, j);
        y2 = pf.edges.Y2(i, j);
        z2 = pf.edges.Z2(i, j);

        if x1 ~= X1 || y1 ~= Y1 || z1 ~= Z1 ...
                || x2 ~= X2 || y2 ~= Y2 || z2 ~= Z2

            [X, Y, Z] = cylinder3d(X1, Y1, Z1, X2, Y2, Z2,...
                'Color', color,...
                'LineStyle', '-');

            set(pf.edges.cyl(i, j), 'XData', X);
            set(pf.edges.cyl(i, j), 'YData', Y);
            set(pf.edges.cyl(i, j), 'ZData', Z);
        end
    end
    pf.edges.X1(i, j) = X1;
    pf.edges.Y1(i, j) = Y1;
    pf.edges.Z1(i, j) = Z1;

    pf.edges.X2(i, j) = X2;
    pf.edges.Y2(i, j) = Y2;
    pf.edges.Z2(i, j) = Z2;

    % sets properties
    set(pf.edges.cyl(i, j), 'FaceColor', color);
    set(pf.edges.cyl(i, j), 'EdgeColor', color);
   
    if nargout>0
        h = pf.edges.cyl(i, j);
    end
end
function cylinder_edge_on(pf, i, j)
    % CYLINDER_EDGE_ON shows a edge edge
    %
    % CYLINDER_EDGE_ON(BG, I, J) shows the edge edge from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_off.

    if ishandle(pf.edges.cyl(i, j))
        set(pf.edges.cyl(i, j), 'Visible', 'on')
    end
end
function cylinder_edge_off(pf, i, j)
    % CYLINDER_EDGE_OFF hides a edge edge
    %
    % CYLINDER_EDGE_OFF(BG, I, J) hides the edge edge from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if ishandle(pf.edges.cyl(i, j))
        set(pf.edges.cyl(i, j), 'Visible', 'off')
    end
end
function cylinder_edges(pf, i_vec, j_vec, varargin)
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
        for i = 1:1:pf.get('BA').get('BR_DICT').length()
            for j = 1:1:pf.get('BA').get('BR_DICT').length()
                pf.cylinder_edge(i, j, varargin{:})
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
            pf.cylinder_edge(i_vec(m), j_vec(m), varargin{:})
        end
    end
end
function cylinder_edges_on(pf, i_vec, j_vec)
    % CYLINDER_EDGES_ON shows multiple edge edge
    %
    % CYLINDER_EDGES_ON(BG, I, J) shows multiple edge edge from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edges, link_edges_off.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pf.get('BA').get('BR_DICT').length()
            for j = 1:1:pf.get('BA').get('BR_DICT').length()
                pf.cylinder_edge_on(i, j)
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
            pf.cylinder_edge_on(i_vec(m), j_vec(m))
        end
    end
end
function cylinder_edges_off(pf, i_vec, j_vec)
    % CYLINDER_EDGES_OFF hides multiple edge links
    %
    % CYLINDER_EDGES_OFF(BG, I, J) hides multiple edge links from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, link_edge, link_edge_on.

    if nargin<2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pf.get('BA').get('BR_DICT').length()
            for j = 1:1:pf.get('BA').get('BR_DICT').length()
                pf.cylinder_edge_off(i, j)
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
            pf.cylinder_edge_off(i_vec(m), j_vec(m))
        end
    end
end
function bool = cylinder_edge_is_on(pf, i, j)
    % CYLINDER_EDGE_IS_ON checks if cylinder edge is visible
    %
    % BOOL = CYLINDER_EDGE_IS_ON(BG, I, J) returns true if the cylinder edge
    % from the brain regions I to J is visible and false otherwise.
    %
    % See also PlotBrainGraph.

    bool = ishandle(pf.edges.cyl(i, j)) && strcmpi(get(pf.edges.cyl(i, j), 'Visible'), 'on');
end

function h = text_edge(pf, graph_axes, i, j , text_value, varargin)
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

    
    br_1 = pf.get('BA').get('BR_DICT').getItem(i);
    br_2 = pf.get('BA').get('BR_DICT').getItem(j);
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
    pf.edges.texts(i, j) =  text(graph_axes, X3, Y3, Z3, text_value);

    if nargout > 0
        h = pf.edges.texts(i, j);
    end
end
function text_edges(pf, i_vec, j_vec)
    % TEXTS_EDGES plots multiple edge texts as lines
    %
    % TEXTS_EDGES(BG, I_VEC, J_VEC) plots the edge texts from the
    % brain regions specified in I_VEC to the ones specified in
    % J_VEC, if not plotted. I_VEC and J_VEC need not be the same
    % size.
    %
    % TEXTS_EDGES(BG, [], []) plots the edge texts between all
    % possible brain region combinations.
    %
    % TEXTS_LINS(BG, I_VEC, J_VEC, PROPERTY, RULE) sets the property
    % of the multiple edge texts' PROPERTY to RULE.
    % All standard plot properties of plot3 can be used.
    % The line properties can also be changed when hidden.
    %
    % See also PlotBrainGraph, plot3, link_edge.
    
    if nargin < 2 || isempty(i_vec) || isempty(j_vec)
        for i = 1:1:pf.get('BA').get('BR_DICT').length()
            for j = 1:1:pf.get('BA').get('BR_DICT').length()
                pf.text_edge(i, j)
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
            pf.text_edge(i_vec(m), j_vec(m))
        end
    end
end
function text_edge_on(pf, i, j)
    % TEXT_EDGE_ON shows a edge text
    %
    % TEXT_EDGE_ON(BG, I, J) shows the edge text from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, text_edge, text_edge_off.

    if ishandle(pf.edges.texts(i, j))
        set(pf.edges.texts(i, j), 'Visible', 'on')
    end
end
function text_edge_off(pf, i, j)
    % TEXT_EDGE_OFF hides a edge text
    %
    % TEXT_EDGE_OFF(BG, I, J) hides the edge text from the brain
    % region I to J.
    %
    % See also PlotBrainGraph, text_edge, text_edge_on.

    if ishandle(pf.edges.texts(i, j))
        set(pf.edges.texts(i, j), 'Visible', 'off')
    end
end
function bool = text_edge_is_on(pf, i, j)
    % TEXT_EDGE_IS_ON checks if the edge text is visible
    %
    % BOOL = TEXT_EDGE_IS_ON(BG, I, J) returns true if the edge text
    % from the brain regions I to J is visible and false otherwise.
    %
    % See also PlotBrainGraph, text_edge, tex_edge_is_off.

    bool = ishandle(pf.edges.texts(i, j)) && strcmpi(get(pf.edges.texts(i, j), 'Visible'), 'on');
end
function bool = tex_edge_is_off(pf, i, j)
    % TEXT_EDGE_IS_Off checks if the edge text is not visible
    %
    % BOOL = TEXT_EDGE_IS_Off(BG, I, J) returns true if the edge text
    % from the brain regions I to J is not visible and false otherwise.
    %
    % See also PlotBrainGraph, text_edge, tex_edge_is_off.

    bool = ishandle(pf.edges.texts(i, j)) && strcmpi(get(pf.edges.texts(i, j), 'Visible'), 'off');
end