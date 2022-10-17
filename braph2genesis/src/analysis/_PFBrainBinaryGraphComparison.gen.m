%% ¡header!
PFBrainBinaryGraphComparison < PFBrainGraphComparison (pf, plot brain multigraph) is a plot of a brain multigraph.

%%% ¡description!
PFBrainBinaryGraphComparison manages the plot of the graph edges, arrows and cylinders.
PFBrainBinaryGraphComparison utilizes the surface created from PFBrainAtlas to
integrate the regions to a brain surface.

%%% ¡seealso!
Plot, BrainAtlas, PFBrainBinaryGraphComparison, Measure


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
        index = str2double(pf.get('DT'));
        val = val{index};
        val(isnan(val)) = 0.1;
        val(val <= 0) = 0.1;
        % increase br size by measure value
        if isequal(comparison.get('MEASURE_TEMPLATE'), 'CommunityStructure')
            unique_vals = unique(val);
            n_unique_vals = length(unique_vals);
            % produce enough colors
            if isempty(pf.community_colors)
                for cc = 1:n_unique_vals
                    pf.community_colors{cc} = [randi(256)/256 randi(256)/256 randi(256)/256];
                end
            end
            % set spheres or syms with colors
            if pf.get('SPHS')
                sph_dict = pf.get('SPH_DICT');
                for i = 1:sph_dict.length
                    sph = sph_dict.getItem(i);
                    index_of_color = find(unique_vals == val(i));
                    set(sph, 'FaceColor', pf.community_colors{index_of_color}); %#ok<FNDSB>
                end
            end
            if pf.get('SYMS')
                sym_dict = pf.get('SYM_DICT');
                for i = 1:sym_dict.length
                    sym = sym_dict.getItem(i);
                    index_of_color = find(unique_vals == val(i));
                    set(sym, 'FaceColor', pf.community_colors{index_of_color}); %#ok<FNDSB>
                end
            end
        else
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
        end
    else
        % restore default values
        if  size(varargin, 2) > 0 && (strcmp(pf.getPropTag(varargin{1}), 'measures')) && pf.get('SPHS')
            sph_dict = pf.get('SPH_DICT');
            for i = 1:sph_dict.length
                sph = sph_dict.getItem(i);
                default_value = sph.getPropDefault('SPHERESIZE');
                sph.set('SPHERESIZE', default_value);
            end
        end
        if  size(varargin, 2) > 0 && (strcmp(pf.getPropTag(varargin{1}), 'measures')) && pf.get('SYMS')
            sym_dict = pf.get('SYM_DICT');
            for i = 1:sym_dict.length
                sym = sym_dict.getItem(i);
                default_value = sym.getPropDefault('SYMBOLSIZE');
                sym.set('SYMBOLSIZE', default_value);
            end            
        end        
    end
    
    % update state of toggle tool
%     set(pf.toolbar_measure, 'State', pf.get('MEASURES'))
end

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
        val = measure.get('P1');
        index = str2double(pf.get('DT'));
        val = val{index};
        
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

%% ¡props!

%%% ¡prop!
DT (figure, string) is the id of the selected density or layer.
%%%% ¡default!
'1'
%%%% ¡gui!
me = pf.get('ME');
if isa(me, 'Measure')
    g = pf.get('ME').get('G');
    
else % comparison
    if me.get('C').get('A1').existsTag('g')
        g =  me.get('C').get('a1').get('g');
    else
        g_dict = me.get('C').get('a1').get('g_dict');
        g = g_dict.getItem(1);
    end
   
end

pr = PP_DTID('EL', pf, 'PROP', PFBrainBinaryGraphComparison.DT, ...
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

    pf.p = draw@PFBrainGraphComparison(pf, varargin{:});

    
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