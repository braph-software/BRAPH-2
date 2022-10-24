%% ¡header!
PFBrainGraphComparison < PFBrainGraph (pf, plot brain multigraph) is a plot of a brain multigraph.

%%% ¡description!
PFBrainGraphComparison manages the plot of the graph edges, arrows and cylinders.
PFBrainGraphComparison utilizes the surface created from PFBrainAtlas to
integrate the regions to a brain surface.

%%% ¡seealso!
Plot, BrainAtlas, PFBrainGraphComparison, Measure


%% ¡properties!
p % handle for panel
h_axes % handle for axes

toolbar
% toolbar_measure
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
        comparison = pf.get('ME'); % this is a comparison        
        val = comparison.get('DIFF');
        val = val{1};
        % increase br size by measure value
        if isequal(comparison.get('MEASURE_TEMPLATE'), 'CommunityStructure')
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
            lim_min = min(abs(val));  % minimum difference
            lim_max = max(abs(val));  % maximum difference
            % Blue color for group 1 > group 2
            % Red color for group 2 > group 1
            index_neg = find(val<0);
            val(val == 0) = 0.01;
            C_plot = zeros(length(val), 3);
            C_plot(:, 1) = ones(length(val), 1); % red (RED difference G2 > G1);
            C_temp(:, 3) =  ones(length(val), 1);  % blue;
            % for the negative index, substitute red colors with blue (BLUE NEGATIVE difference G1 > G2)
            C_plot(index_neg, :) = C_temp(index_neg, :);
            
            if pf.get('SPHS')
                sph_dict = pf.get('SPH_DICT');
                for i = 1:sph_dict.length
                    sph = sph_dict.getItem(i);
                    default_value = sph.getPropDefault('SPHERESIZE');
                    diff_val = val(i);
                    if diff_val ~= 0.01
                        diff_val = (abs(val(i)) - lim_min) / (lim_max - lim_min) + 1;  % size normalized by minimum and maximum value of the measure result
                        diff_val(isnan(diff_val)) = 0.01;
                    end
                    sph.set('SPHERESIZE', default_value * diff_val);
                    sph.set('FaceColor',  C_plot(i, :));
                end
                pf.update_gui_tbl_sph()
            end
            if pf.get('SYMS')
                sym_dict = pf.get('SYM_DICT');
                for i = 1:sym_dict.length
                    sym = sym_dict.getItem(i);
                    default_value = sym.getPropDefault('SYMBOLSIZE');
                    diff_val = val(i);
                    if diff_val ~= 0.01
                        diff_val = (abs(val(i)) - lim_min) / (lim_max - lim_min) + 1;  % size normalized by minimum and maximum value of the measure result
                        diff_val(isnan(diff_val)) = 0.01;
                    end
                    sym.set('SPHERESIZE', default_value * diff_val);
                    sym.set('FaceColor',  C_plot(i, :));
                end
                pf.update_gui_tbl_sym()
            end
        end
    else
        % restore default values
        if  size(varargin, 2) > 0 && (strcmp(pf.getPropTag(varargin{1}), 'measures')) && pf.get('SPHS')
            sph_dict = pf.get('SPH_DICT');
            for i = 1:sph_dict.length
                sph = sph_dict.getItem(i);
                default_value = sph.getPropDefault('SPHERESIZE');
                sph.set('SPHERESIZE', default_value);
                sph.set('FaceColor',  BRAPH2.COL);
            end
             pf.update_gui_tbl_sph()
        end
        if size(varargin, 2) > 0 && (strcmp(pf.getPropTag(varargin{1}), 'measures')) && pf.get('SYMS')
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
FDRSHOW (figure, logical) determines whether the nodes are shown based on fdr correction.
%%%% ¡default!
false
%%%% ¡postprocessing!
if ~braph2_testing
    if pf.get('FDRSHOW')
        % remove values that do no pass fdr
        % get fdr q value.
        measure = pf.get('ME'); % comparison
        q_val = pf.get('QVAL');
        val = measure.get('P2');
        val = val{1};
        
        if size(val, 1) > size(val, 2)
            val = val';
        end
        
        [~, mask] = fdr(val, q_val);
        
        if pf.get('SPHS')
            sph_dict = pf.get('SPH_DICT');
            for i = 1:sph_dict.length
                sph = sph_dict.getItem(i);
                if ~mask(i)
                    set(sph, 'Visible', false);
                end
            end
        end
        if pf.get('SYMS')
            sym_dict = pf.get('SYM_DICT');
            for i = 1:sym_dict.length
                sym = sym_dict.getItem(i);
                if ~mask(i)
                    set(sym, 'Visible', false);
                end
            end
        end
    else
        % show everything
        if pf.get('SPHS')
            sph_dict = pf.get('SPH_DICT');
            for i = 1:sph_dict.length
                sph = sph_dict.getItem(i);
                set(sph, 'Visible', true);
            end
        end
        if pf.get('SYMS')
            sym_dict = pf.get('SYM_DICT');
            for i = 1:sym_dict.length
                sym = sym_dict.getItem(i);
                set(sym, 'Visible', true);
            end
        end        
    end
end

%%% ¡prop!
QVAL (figure, scalar) determines the value of the qval for the fdr
%%%% ¡default!
0.05

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
%         pf.toolbar_measure = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'toolbar_measure');
        pf.toolbar_edges = findobj(ancestor(pf.p, 'Figure'), 'Tag', 'toolbar_edges');
    end

    % output
    if nargout > 0
        h_panel = pf.p;
    end
end
function plotAdjacency(pf)
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

    str = 'Plot Brain Multi Graph';
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
    if isa(pf.get('me').get('c').get('a1'), 'AnalyzeGroup')
        b = pf.get('me').get('C').get('A1').get('G');
    else
        b = pf.get('me').get('C').get('A1').get('g_dict').getItem(1);
    end
    
    a = b.get('A');
    [r, c] = find(a{1});
end