%% ¡header!
PFFeatureImportance < PFBrainGraph (pf, plot brain graph) is a plot of a brain graph.

%%% ¡description!
PFFeatureImportance manages the plot of the graph edges, arrows and cylinders.
PFFeatureImportance utilizes the surface created from PFBrainAtlas to
integrate the regions to a brain surface.

%%% ¡seealso!
Plot, BrainAtlas, PFBrainSurface, PFBrainAtlas.

%% ¡properties!
p % handle for panel
h_axes % handle for axes
edges
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
    if pf.get('MEASURES')
        nn = pf.get('NNE');
        prop = pf.get('PROP');
        fi = nn.memorize(prop);
        if isempty(fi)
            fi = {zeros(pf.get('BA').get('BR_DICT').length)};
        end
        index_layer = str2double(pf.get('INDEX_LAYER'));
        val = fi{index_layer};
        
        % Make colorbar
        lim_min = min(val);  % minimum of measure result
        lim_max = max(val);  % maximum of measure result
        if lim_min == lim_max
            caxis auto
            cmap_temp = colormap(jet);
            rgb_meas = zeros(size(cmap_temp));
            meas_val = val./val;
            meas_val(isnan(meas_val)) = 0.1;
        else
            caxis([lim_min lim_max]);
            cmap_temp = colormap(jet);
            rgb_meas = interp1(linspace(lim_min, lim_max, size(cmap_temp, 1)), ...
                cmap_temp, val); % colorbar from minimum to maximum value of the measure result
            meas_val = (val - lim_min)./(lim_max - lim_min) + 1;  % size normalized by minimum and maximum value of the measure result
            meas_val(isnan(meas_val)) = 0.1;
            meas_val(meas_val <= 0) = 0.1;
        end

        if pf.get('SPHS')
            sph_dict = pf.get('SPH_DICT');
            for i = 1:sph_dict.length
                sph = sph_dict.getItem(i);
                default_value = sph.getPropDefault('SPHERESIZE');
                sph.set('SPHERESIZE', default_value * meas_val(i));
                sph.set('FaceColor',  rgb_meas(i, :));
            end
            pf.update_gui_tbl_sph()
        end
        if pf.get('SYMS')
            sym_dict = pf.get('SYM_DICT');
            for i = 1:sym_dict.length
                sym = sym_dict.getItem(i);
                default_value = sym.getPropDefault('SYMBOLSIZE');
                sym.set('SYMBOLSIZE', default_value * meas_val(i));
                sym.set('FaceColor',  rgb_meas(i, :));
            end
            pf.update_gui_tbl_sym()
        end
    else
        % restore default values
        if size(varargin, 2) > 0 && (strcmp(pf.getPropTag(varargin{1}), 'measures')) && pf.get('SPHS')
            sph_dict = pf.get('SPH_DICT');
            for i = 1:sph_dict.length
                sph = sph_dict.getItem(i);
                default_value = sph.getPropDefault('SPHERESIZE');
                sph.set('SPHERESIZE', default_value);
                sph.set('FaceColor',  BRAPH2.COL);
            end
            pf.update_gui_tbl_sph()
        end
        if  size(varargin, 2) > 0 && (strcmp(pf.getPropTag(varargin{1}), 'measures')) && pf.get('SYMS')
            sym_dict = pf.get('SYM_DICT');
            for i = 1:sym_dict.length
                sym = sym_dict.getItem(i);
                default_value = sym.getPropDefault('SYMBOLSIZE');
                sym.set('SYMBOLSIZE', default_value);
                sym.set('FaceColor',  BRAPH2.COL);
            end
            pf.update_gui_tbl_sym()
        end
    end
end

%%% ¡prop!
EDGES (figure, logical) determines whether the edges are shown as a edge.
%%%% ¡default!
false
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('EDGES', varargin)) && ~braph2_testing
    if ~pf.get('EDGES') && ~isempty(pf.retrieve_edges())        
        pf.link_edges_off([], [])
        pf.arrow_edges_off([], [])
        pf.cylinder_edges_off([],[])        
    else
        if ~isempty(pf.retrieve_edges())
            nn = pf.get('NNE');
            prop = pf.get('PROP');
            fi = nn.memorize(prop);
            if isempty(fi)
                fi = {zeros(pf.get('BA').get('BR_DICT').length)};
            end
            index_layer = str2double(pf.get('INDEX_LAYER'));
            fi_current = fi{index_layer};
            t = str2double(pf.get('THRESHOLD'));
            [~, idx_all] = sort(fi_current(:), 'descend');
            num_top_idx = ceil(t * numel(fi_current));
            fi_current(idx_all(num_top_idx + 1:end)) = 0;
            pf.edges = pf.retrieve_edges();
            
            if pf.get('ST_EDGES').get('LINKS')
                for i = 1:size(fi_current, 1)
                    for j = 1:size(fi_current, 2)
                        if fi_current(i, j) == 0
                            pf.link_edge_off(i, j)
                        else
                            pf.link_edge(i,j)
                            pf.link_edge_on(i, j)
                        end
                    end
                end
            elseif pf.get('ST_EDGES').get('ARROWS')
                for i = 1:size(fi_current, 1)
                    for j = 1:size(fi_current, 2)
                        if fi_current(i, j) == 0
                            pf.arrow_edge_off(i, j)
                        else
                            pf.arrow_edge_on(i, j)
                        end
                    end
                end
            elseif pf.get('ST_EDGES').get('CYLINDERS')
                for i = 1:size(fi_current, 1)
                    for j = 1:size(fi_current, 2)
                        if fi_current(i, j) == 0
                            pf.cylinder_edge_off(i, j)
                        else
                           pf.cylinder_edge_on(i, j)
                        end
                    end
                end
            elseif pf.get('ST_EDGES').get('TEXTS')
                for i = 1:size(fi_current, 1)
                    for j = 1:size(fi_current, 2)
                        if fi_current(i, j) == 0
                            pf.text_edge_off(i, j)
                        else
                            % do nothing
                        end
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
PROP (metadata, scalar) is the property number. 

%%% ¡prop!
INDEX_LAYER (figure, string) is the index of the selected layer.
%%%% ¡default!
'1'
%%%% ¡gui!
nn = pf.get('NNE');
prop = pf.get('PROP');
fi = nn.memorize(prop);
pr = PP_INDEX_LAYER('EL', pf, 'PROP', PFFeatureImportance.INDEX_LAYER, ...
    'FEATURE_IMPORTANCE', fi, ...
    varargin{:});

%%% ¡prop!
THRESHOLD (figure, string) is the thesgold of the selected layer.
%%%% ¡default!
'0.1'
%%%% ¡gui!
nn = pf.get('NNE');
prop = pf.get('PROP');
pr = PP_THRESHOLD('EL', pf, 'PROP', PFFeatureImportance.THRESHOLD, ...    
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
function plot_EDGES(pf)
    pf.set('EDGES', pf.get('EDGES'))
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

    str = 'Plot Brain Feature Importance';
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end
function update_gui_tbl_sym(pf)
    update_gui_tbl_sym@PFBrainAtlas(pf);
end