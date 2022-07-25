%% ¡header!
PFBrainGraphNN < PFBrainGraph (pf, plot brain graph) is a plot of a brain graph.

%%% ¡description!
PFBrainGraphNN manages the plot of the graph edges, arrows and cylinders.
PFBrainGraphNN utilizes the surface created from PFBrainAtlas to
integrate the regions to a brain surface.

%%% ¡seealso!
Plot, BrainAtlas, PFBrainSurface, PFBrainAtlas.

%% ¡properties!
p % handle for panel
h_axes % handle for axes

toolbar
toolbar_measure
toolbar_edges

%% ¡props_update!

%%% ¡prop!
MEASURES (figure, logical) determines whether the measures affect the brain region.
%%%% ¡default!
false
%%%% ¡postprocessing!
if ~braph2_testing
    % do nothing
end

%%% ¡prop!
EDGES (figure, logical) determines whether the edges are shown as a edge.
%%%% ¡default!
false
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('EDGES', varargin)) && ~braph2_testing
    if ~pf.get('EDGES') && ~isempty(pf.edges)        
        pf.link_edges_off([], [])
        pf.arrow_edges_off([], [])
        pf.cylinder_edges_off([],[])        
    else
        % trigger listener
        nn = pf.get('NNE');
        cell_var = nn.get('FEATURE_PERMUTATION_IMPORTANCE');
        conn_matrix = cell_var{TMP_VAR};
        t = pf.get('THRESHOLD');
        
        if pf.get('ST_EDGES').get('LINKS')
            for i = 1:size(conn_matrix, 1)
                for j = 1:size(conn_matrix, 2)
                    tmp_val = conn_matrix(i, j);
                    tmp_val(tmp_val <= t) = 0;
                    conn_matrix(i, j) = tmp_val;
                    if conn_matrix(i, j) == 0
                        pf.link_edge_off(i, j)
                    else
                        % do nothing 
                    end
                end
            end
        elseif pf.get('ST_EDGES').get('ARROWS')
            for i = 1:size(conn_matrix, 1)
                for j = 1:size(conn_matrix, 2)
                    tmp_val = conn_matrix(i, j);
                    tmp_val(tmp_val <= t) = 0;
                    conn_matrix(i, j) = tmp_val;
                    if conn_matrix(i, j) == 0
                        pf.arrow_edge_off(i, j)
                    else
                        % do nothing 
                    end
                end
            end
        elseif pf.get('ST_EDGES').get('CYLINDERS')
            for i = 1:size(conn_matrix, 1)
                for j = 1:size(conn_matrix, 2)
                    tmp_val = conn_matrix(i, j);
                    tmp_val(tmp_val <= t) = 0;
                    conn_matrix(i, j) = tmp_val;
                    if conn_matrix(i, j) == 0
                        pf.cylinder_edge_off(i, j)
                    else
                        % do nothing 
                    end
                end
            end
        elseif pf.get('ST_EDGES').get('TEXTS')            
            for i = 1:size(conn_matrix, 1)
                for j = 1:size(conn_matrix, 2)
                    tmp_val = conn_matrix(i, j);
                    tmp_val(tmp_val <= t) = 0;
                    conn_matrix(i, j) = tmp_val;
                    if conn_matrix(i, j) == 0
                        pf.text_edge_off(i, j)
                    else
                        % do nothing 
                    end
                end
            end
        end

    end
    
    % update state of toggle tool
    set(pf.toolbar_edges, 'State', pf.get('EDGES'))
end

%% ¡props!

%%% ¡prop!
NNE (metadata, item) is the evaluator.

%%% ¡prop!
TMP_VAR (figure, string) is the id of the selected layer.
%%%% ¡default!
'1'
%%%% ¡gui!
nn = pf.get('NNE');
cell_var = nn.get('FEATURE_PERMUTATION_IMPORTANCE');
pr = PP_TMP_VAR('EL', pf, 'PROP', PFBrainGraphNN.TMP_VAR, ...
    'tmp_var', cell_var, ...
    varargin{:});

%%% ¡prop!
THRESHOLD (figure, string) is the thesgold of the selected layer.
%%%% ¡default!
'1'
%%%% ¡gui!
nn = pf.get('NNE');
cell_var = nn.get('FEATURE_PERMUTATION_IMPORTANCE');
pr = PP_THRESHOLD('EL', pf, 'PROP', PFBrainGraphNN.THRESHOLD, ...    
    varargin{:});

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

    pf.p = draw@PFBrainGraph(pf, varargin{:});

    % get axes
    if ~check_graphics(pf.h_axes, 'axes')
        pf.h_axes =  pf.p.Children(1);
    end
    
     % get toolbars
    if ~check_graphics(pf.h_axes, 'uitoolbar')        
        pf.toolbar = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'ToolBar');
        pf.toolbar_measure = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'toolbar_measure');
        set(pf.toolbar_measure, 'ENABLE', false);        
        pf.toolbar_edges = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'toolbar_edges');
    end    
  
    % output
    if nargout > 0
        h_panel = pf.p;
    end
end
function plot_TMP_VAR(pf)
    pf.set('MEASURES', pf.get('MEASURES'))
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

    str = 'Plot Brain Graph NN';
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end