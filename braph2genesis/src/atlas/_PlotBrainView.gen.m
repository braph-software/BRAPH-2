%% ¡header!
PlotBrainView < Plot (pr, plot brain view) is a plot of a brain view.

%%% ¡description!
Plot is the plot of a graph of a function.
It is a graphical figure with empty axes, which should be filled by derived element.
To generate the plot, call pr.draw().

%%% ¡seealso!
uipanel, ishandle, isgraphics, figure, PlotGraph

%% ¡properties!
h_figure % panel graphical handle
h_axes % axes handle
bg % plot brain graph
p
f_settings
m

%% ¡props!
%%% ¡prop!
ME (metadata, item) is the measure.

%%% ¡prop!
COMP (metadata, item) is the comparison.

%%% ¡prop!
ATLAS(metadata, item) is a brain atlas.

%%% ¡prop!
PROPTAG(metadata, string) is a prop tag.

%%% ¡prop!
TYPE(metadata, string) is the type of measure.

%% ¡methods!
function h_panel = draw(pr, varargin)
    pr.p = draw@Plot(pr, ...
        varargin{:});
    pr.h_figure = get(pr.p, 'Parent');
    subpanel = uipanel(pr.h_figure, ...
        'BackGroundColor', 'w', ...
        'Units', 'normalized', ...
        'Position', [.0 .0 1 1] ...
        );
    
    pr.h_axes = axes(subpanel);

    pr.getBrainView();

    % output
    if nargout > 0
        h_panel = pr.pp;
    end
end
function p = getBrainView(pr)
    % GETBRAINVIEW creates a brain view panel for GUIAnalysis
    %
    % P = GETBRAINVIEW(ANALYSIS, PROPERTY, RULE, ...) creates a
    % brain view panel for GUIAnalysis.
    %
    % See also getGlobalPanel, getNodalPanel, getBinodalPanel.
    uiparent = pr.h_figure;
    atlas = pr.get('ATLAS');
    
    % get surf or set default
    if isempty(atlas.get('SURF').get('Triangles'))
        selected_surface = 'human_ICBM152';
        atlas.set('SURF', ImporterBrainSurfaceNV('FILE', [selected_surface '.nv']).get('SURF'));
        surf =  atlas.get('SURF');
    else
        surf = atlas.get('SURF');
    end
    
    prop_tag = pr.get('PROPTAG');
    
    if isequal(pr.get('ME'), Element()) && ~isempty(pr.get('COMP'))
        tmp_comp = pr.get('COMP');
        if isa(tmp_comp, 'ComparisonGroup')
            pr.bg =  PlotBrainGraphComparison('ATLAS', atlas, ...
                'COMP', pr.get('COMP'), ...
                'PROPTAG', prop_tag, ...
                'Surf', surf, ...
                'TYPE', pr.get('TYPE'));
        else % ensemble
            pr.bg =  PlotBrainGraphComparisonEnsemble('ATLAS', atlas, ...
                'COMP', pr.get('COMP'), ...
                'PROPTAG', prop_tag, ...
                'Surf', surf, ...
                'TYPE', pr.get('TYPE'));
        end       
    else
        tmp_me = pr.get('ME');
        if isa(tmp_me, 'Measure') % group
            pr.bg =  PlotBrainGraph('ATLAS', atlas, ...
                'ME',  pr.get('ME'), ...
                'Surf', surf, ...
                'TYPE', pr.get('TYPE'));
        else % ensemble
            pr.bg =  PlotBrainGraphEnsemble('ATLAS', atlas, ...
                'ME',  pr.get('ME'), ...
                'Surf', surf, ...
                'TYPE', pr.get('TYPE'));
        end       
    end
    
    function create_figure()
        pr.bg.draw('Parent', uiparent);
    end

    create_figure()

    if nargout > 0
        p = ui_brainview_panel;
    end
end
function f_settings = settings(pr, varargin)
    %SETTINGS opens the brain surface property editor GUI.
    %
    % SETTINGS(PL) allows the user to specify the properties of the brain
    %  atlas plot by opening a GUI property editor.
    %
    % F = SETTINGS(PL) returns a handle to the brain atlas property editor GUI.
    %
    % SETTINGS(PL, 'Property', VALUE, ...) sets the properties of the brain
    %  atlas property editor GUI with custom property-value couples.
    %  All standard plot properties of figure can be used.
    %
    % See also draw, figure, isgraphics.

    f_settings = pr.bg.settings();
    pl.f_settings = f_settings;
end