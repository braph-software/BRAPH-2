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
NNE (metadata, item) is the evaluator.

%%% ¡prop!
MEASURES (figure, logical) determines whether the measures affect the brain region.
%%%% ¡default!
false
%%%% ¡postprocessing!
if ~braph2_testing
    if pf.get('MEASURES')
        nn = pf.get('NNE');
        val = nn.get('FEATURE_PERMUTATION_IMPORTANCE'); 
        index = pf.get('TMP_VAR');
        thrshold = pf.get('THRESHOLD');
        val = val{index};
        val(isnan(val)) = 0.1;
        val(val <= 0) = 0.1;
        val(val <= thrshold) = 0;
        % increase br size by measure value
        if pf.get('SPHS')
            sph_dict = pf.get('SPH_DICT');
            for i = 1:sph_dict.length
                sph = sph_dict.getItem(i);
                default_value = sph.get('SPHERESIZE');
                sph.set('SPHERESIZE', default_value * val(i));
            end
        end
        if pf.get('SYMS')
            sym_dict = pf.get('SYM_DICT');            
            for i = 1:sym_dict.length
                sym = sym_dict.getItem(i);
                default_value = sym.get('SYMBOLSIZE');
                sym.set('SYMBOLSIZE', default_value * val(i));
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
                default_value = sym.get('SYMBOLSIZE');
                sym.set('SYMBOLSIZE', default_value);
            end            
        end        
    end    
    
    % update state of toggle tool
    set(pf.toolbar_measure, 'State', pf.get('MEASURES'))
end

%% ¡props!

%%% ¡prop!
TMP_VAR (figure, string) is the id of the selected layer.
%%%% ¡default!
'1'
%%%% ¡gui!
nn = pf.get('NNE');
cell_var = nn.get('FEATURE_PERMUTATION_IMPORTANCE');
pr = PP_TMP_VAR('EL', pf, 'PROP', PFBrainGraphNN.TMP_VAR, ...
    'ME', cell_var, ...
    varargin{:});

%%% ¡prop!
THRESHOLD (figure, scalar) is the thesgold of the selected layer.

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
        pf.toolbar_edges = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'toolbar_edges');
    end
    
    listener(pf.get('THRESHOLD'), 'PropSet', @cb_st_threshold);
    function cb_st_threshold(~, ~) % (src, event)
        if pf.get('MEASURES')
            set('MEASURES', pf.get('MEASURES'))
        end
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