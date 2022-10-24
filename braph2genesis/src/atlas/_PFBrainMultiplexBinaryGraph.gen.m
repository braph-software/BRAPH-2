%% ¡header!
PFBrainMultiplexBinaryGraph < PFBrainMultiGraph (pf, plot brain multiplex binary graph) is a plot of a brain multiplex.

%%% ¡description!
PFBrainMultiplexBinaryGraph manages the plot of the graph edges, arrows and cylinders.
PFBrainMultiplexBinaryGraph utilizes the surface created from PFBrainAtlas to
integrate the regions to a brain surface.

%%% ¡seealso!
Plot, BrainAtlas, PFBrainMultiplexBinaryGraph, Measure


%% ¡properties!
p % handle for panel
h_axes % handle for axes

toolbar
toolbar_measure
toolbar_edges
% community color
community_colors
%% ¡props_update!

%%% ¡prop!
MEASURES (figure, logical) determines whether the measures affect the brain region.
%%%% ¡default!
false
%%%% ¡postprocessing!
if ~braph2_testing
    if pf.get('MEASURES')
        measure = pf.get('ME');
        val = measure.get('M');
        index_d = str2double(pf.get('DT'));
        index_l = str2double(pf.get('LAYER'));
        if isa(measure,  'Measure')
            [l, ls] = measure.get('G').layernumber();
        else
            [l, ls] = measure.get('A').get('G_DICT').getItem(1).layernumber();
        end
        total_l = ls(1);
        val = val{(total_l * (index_d - 1)) + index_l };
        % increase br size by measure value
        if isa(measure, 'MultilayerCommunityStructure')  || (isa(measure, 'MeasureEnsemble') && isa(measure.get('Measure_Template') , 'MultilayerCommunityStructure'))
            unique_vals = unique(val);
            n_unique_vals = length(unique_vals);
            % produce enough colors
            if isempty(pf.community_colors)                
                pf.community_colors = BRAPH2.COMMUNITY_COLORS(n_unique_vals);               
            end
            % set spheres or syms with colors
            if pf.get('SPHS')
                sph_dict = pf.get('SPH_DICT');
                for i = 1:sph_dict.length
                    sph = sph_dict.getItem(i);
                    index_of_color = find(unique_vals == val(i));
                    sph.set('FaceColor',  pf.community_colors{index_of_color});
                end
                pf.update_gui_tbl_sph()
            end
            if pf.get('SYMS')
                sym_dict = pf.get('SYM_DICT');
                for i = 1:sym_dict.length
                    sym = sym_dict.getItem(i);
                    index_of_color = find(unique_vals == val(i));
                    sym.set('FaceColor',  pf.community_colors{index_of_color});
                end
                pf.update_gui_tbl_sym()
            end
        else
            % Make colorbar
            lim_min = min(val);  % minimum of measure result
            lim_max = max(val);  % maximum of measure result
            if lim_min == 0 && lim_max == 0
                caxis auto
                cmap_temp = colormap(jet);
                rgb_meas = zeros(size(cmap_temp));
            else
                caxis([lim_min lim_max]);
                cmap_temp = colormap(jet);
                rgb_meas = interp1(linspace(lim_min, lim_max, size(cmap_temp, 1)), ...
                    cmap_temp, val); % colorbar from minimum to maximum value of the measure result
            end
            
            if pf.get('SPHS')
                sph_dict = pf.get('SPH_DICT');
                for i = 1:sph_dict.length
                    sph = sph_dict.getItem(i);
                    default_value = sph.getPropDefault('SPHERESIZE');
                    meas_val = (val(i) - lim_min) / (lim_max - lim_min);  % size normalized by minimum and maximum value of the measure result
                    meas_val(isnan(meas_val)) = 0.1;
                    meas_val(meas_val <= 0) = 0.1;
                    sph.set('SPHERESIZE', default_value * (meas_val + 1));
                    sph.set('FaceColor',  rgb_meas(i, :));
                end
                pf.update_gui_tbl_sph()
            end
            if pf.get('SYMS')
                sym_dict = pf.get('SYM_DICT');
                for i = 1:sym_dict.length
                    sym = sym_dict.getItem(i);
                    default_value = sym.getPropDefault('SYMBOLSIZE');
                    meas_val = (val(i) - lim_min) / (lim_max - lim_min);  % size normalized by minimum and maximum value of the measure result
                    meas_val(isnan(meas_val)) = 0.1;
                    meas_val(meas_val <= 0) = 0.1;
                    sym.set('SYMBOLSIZE', default_value * (meas_val + 1));
                    sym.set('FaceColor',  rgb_meas(i, :));
                end
                pf.update_gui_tbl_sym()
            end
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
    
    % update state of toggle tool
%     set(pf.toolbar_measure, 'State', pf.get('MEASURES'))
end

%% ¡props!

%%% ¡prop!
LAYER (figure, string) is the id of the selected layer.
%%%% ¡default!
'1'
%%%% ¡gui!
me = pf.get('ME');
if isa(me, 'Measure')
    g = pf.get('ME').get('G');
    
else % ensemble
    g_dict = me.get('A').get('g_dict');
    g = g_dict.getItem(1);   
end
pr = PP_LayerID('EL', pf, 'PROP', PFBrainMultiplexBinaryGraph.LAYER, ...
    'G', g, ...
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

    pf.p = draw@PFBrainMultiGraph(pf, varargin{:});

    
    % get axes
    if ~check_graphics(pf.h_axes, 'axes')
        pf.h_axes =  pf.p.Children(1);
    end
    
    % get toolbars
    if ~check_graphics(pf.h_axes, 'uitoolbar')        
        pf.toolbar = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'ToolBar');
%         pf.toolbar_measure = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'toolbar_measure');
        pf.toolbar_edges = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'toolbar_edges');
    end

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

    str = 'Plot Brain Multiplex Binary Graph';
    str = tostring(str, varargin{:});
    str = str(2:1:end-1);
end
function update_gui_tbl_sph(pf)
    update_gui_tbl_sph@PFBrainAtlas(pf);
end
function update_gui_tbl_sym(pf)
    update_gui_tbl_sym@PFBrainAtlas(pf);
end
function [r, c] = obtain_connections(pf)
    % obtain true connections
    if isa(pf.get('me'), 'MeasureEnsemble')
        b = pf.get('me').get('A').get('g_dict').getItem(1);
        [l, ls] = b.layernumber();
    else
        b = pf.get('me').get('g');
        [l, ls] = b.layernumber();
    end
    a = b.get('A');
    index_d = str2double(pf.get('DT'));
    index_l = str2double(pf.get('LAYER'));
    total_l = ls(1);
    [r, c] = find(a{(total_l * (index_d - 1)) + index_l , (total_l * (index_d - 1)) + index_l });
end