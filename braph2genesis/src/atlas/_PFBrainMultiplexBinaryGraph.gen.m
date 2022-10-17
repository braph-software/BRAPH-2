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
        % this is missing layer selection but I cant find a measure that involves layer
        val = val{index_d, index_l}; % have to check with more measures
        val(isnan(val)) = 0.1;
        val(val <= 0) = 0.1;
        % increase br size by measure value
        if isa(measure, 'CommunityStructure')
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
        if size(varargin, 2) > 0 && (strcmp(pf.getPropTag(varargin{1}), 'measures')) && pf.get('SPHS')
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