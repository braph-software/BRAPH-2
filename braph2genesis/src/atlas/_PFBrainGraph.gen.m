%% ¡header!
PFBrainGraph < PFBrainAtlas (pl, plot brain graph) is a plot of a brain graph.

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

% Symbols
INIT_SYM_MARKER = 'o';
INIT_SYM_SIZE = 1;
INIT_SYM_EDGE_COLOR = 'b';
INIT_SYM_FACE_COLOR = 'b';

% Spheres
INIT_SPH_EDGE_COLOR = 'none';
INIT_SPH_EDGE_ALPHA = .5;
INIT_SPH_FACE_COLOR = [.9 .4 .1];
INIT_SPH_FACE_ALPHA = .5;
INIT_SPH_R = 1;

% IDs
INIT_ID_FONT_SIZE = 1;
INIT_ID_FONT_NAME = 'helvetica';
INIT_ID_FONT_COLOR = [0 0 0];
INIT_ID_FONT_INTERPRETER = 'none';

% Labels
INIT_LAB_FONT_SIZE = 1;
INIT_LAB_FONT_NAME = 'helvetica';
INIT_LAB_FONT_COLOR = [0 0 0];
INIT_LAB_FONT_INTERPRETER = 'none';

%% ¡properties!
p % handle for panel
h_axes % handle for axes
h_links % handle for link edges
h_arrows % handle for arrow edges
h_cylinders % handle for cylinder edge

toolbar
toolbar_measure
toolbar_links
toolbar_arrows
toolbar_cylinders

%% ¡props!
%%% ¡prop!
ME (metadata, item) is the measure.

%%% ¡prop!
MEASURES (figure, logical) determines whether the measures affect the brain region.
%%%% ¡default!
true
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('MEASURES', varargin)) && ~braph2_testing
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
    
    % triggers the update of SPH_DICT
    pf.set('SPH_DICT', pf.get('SPH_DICT'))
    pf.set('SYM_DICT', pf.get('SYM_DICT'))
    
    % update state of toggle tool
    set(pf.toolbar_measure, 'State', pf.get('MEASURES'))
end

%%% ¡prop!
LINKS (figure, logical) determines whether the edges are shown as a link.
%%%% ¡default!
true
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('LINKS', varargin)) && ~braph2_testing
    if ~pf.get('LINKS')
        for i = 1:length(pf.h_links)
            set(pf.h_links{i}, 'Visible', false)
        end
    end
    
    % triggers the update of SPH_DICT
    pf.set('LINK_DICT', pf.get('LINK_DICT'))
    
    % update state of toggle tool
    set(pf.toolbar_edges, 'State', pf.get('LINKS'))
end

%%% ¡prop!
LINK_DICT (figure, idict) contains the edge connections between brain regions.
%%%% ¡settings!
'SettingsLinks'
%%%% ¡postprocessing!
if pf.get('LINKS') && ~isa(pf.getr('BA'), 'NoValue')
    if ~isa(pf.getr('LINK_DICT'), 'NoValue')

        br_dict = pf.get('BA').get('BR_DICT');

        if pf.get('LINK_DICT').length() == 0 && br_dict.length()

            for i = 1:1:br_dict.length()
                br = br_dict.getItem(i);

                edges{i} = SettingsLinks( ...
                    'VISIBLE', true, ...
                    'ID', [ij], ...
                    'H', 0, ...                    
                    'XDATA', 0, ... % Callback('EL', br, 'TAG', 'X1'), ...
                    'YDATA', 0, ... % Callback('EL', br, 'TAG', 'Y1'), ...
                    'Z1', 0, ... % Callback('EL', br, 'TAG', 'Z1') ...
                    'X2', 0, ... % Callback('EL', br, 'TAG', 'X2'), ...
                    'Y2', 0, ... % Callback('EL', br, 'TAG', 'Y2'), ...
                    'Z2', 0, ... % Callback('EL', br, 'TAG', 'Z2') ...
                    'FACECOLOR', BRAPH2.COL, ...
                    'FACEALPHA', 1 ...
                    );
            end

            pf.get('LINK_DICT').set('IT_LIST', edges)
        end
        
        if ~isempty(pf.h_sphs)
            for i = 1:1:br_dict.length()
                if pf.get('SPH_DICT').containsIndex(i) && check_graphics(pf.h_sphs{i}, 'surface')
                    pf.get('SPH_DICT').getItem(i).h(pf.h_sphs{i}).set( ...
                        'PANEL', pf, ...
                        'UITAG', ['h_sphs{' int2str(i) '}'] ... % same as in h_sphs{i}
                        );
                end
            end
        end
        
        % reset the ambient lighting
        pf.get('ST_AMBIENT').set()
    end
end
%%%% ¡gui!
pr = PanelPropIDictTable('EL', pf, 'PROP', PFBrainAtlas.SPH_DICT, ...
    'COLS', [PanelPropIDictTable.SELECTOR SettingsSphere.VISIBLE SettingsSphere.X SettingsSphere.Y SettingsSphere.Z SettingsSphere.SPHERESIZE SettingsSphere.FACECOLOR SettingsSphere.FACEALPHA SettingsSphere.EDGECOLOR SettingsSphere.EDGEALPHA], ...
    varargin{:});

%% ¡methods!
function h_panel = draw(pl, varargin)
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

    pl.p = draw@PFBrainAtlas(pl, varargin{:});

    % get axes
    if ~check_graphics(pf.h_axes, 'axes')
        pl.h_axes =  pf.p.Children(1);
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
        pf.toolbar_links = uitoggletool(pf.toolbar, ...
            'Tag', 'toolbar_links', ...
            'Separator', 'on', ...
            'State', pf.get('LINKS'), ...
            'Tooltip', 'Show Edges', ...
            'CData', imread('icon_graph_panel.png'), ...
            'OnCallback', {@cb_links, true}, ...
            'OffCallback', {@cb_links, false});
    end
    
    function cb_measures(~, ~, measures) % (src, event)
        pf.set('MEASURES', measures)
    end
    function cb_links(~, ~, edges) % (src, event)
        pf.set('LINKS', edges)
    end

    % output
    if nargout > 0
        h_panel = pl.p;
    end
end