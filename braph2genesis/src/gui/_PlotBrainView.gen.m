%% ¡header!
PlotBrainView < PlotGraph (pl, plot brain view) is a plot of a brain view.

%%% ¡description!
Plot is the plot of a graph of a function.
It is a graphical figure with empty axes, which should be filled by derived element.
To generate the plot, call pl.draw().

%%% ¡seealso!
uipanel, ishandle, isgraphics, figure, PlotGraph

%% ¡properties!
h_figure % panel graphical handle
h_axes % axes handle
bg % plot brain graph

%% ¡props!
%%% ¡prop!
ME (metadata, item) is the measure.

%%% ¡prop!
COMP (metadata, item) is the comparison.

%%% ¡prop!
ATLAS(metadata, item) is a brain atlas.

%%% ¡prop!
TYPE(metadata, string) is the type of measure.

%% ¡methods!
function h_panel = draw(pl, varargin)
    [pl.h_figure, pl.h_axes] = draw@PlotGraph(pl, ...
        varargin{:});

    pl.getBrainView();

    % output
    if nargout > 0
        h_panel = pl.pp;
    end
end
function p = getBrainView(pl)
    % GETBRAINVIEW creates a brain view panel for GUIAnalysis
    %
    % P = GETBRAINVIEW(ANALYSIS, PROPERTY, RULE, ...) creates a
    % brain view panel for GUIAnalysis.
    %
    % See also getGlobalPanel, getNodalPanel, getBinodalPanel.
    uiparent = pl.h_figure;
    atlas = pl.get('ATLAS');
    
    if isempty(pl.get('ME')) && ~isempty(pl.get('COMP'))
        pl.bg =  PlotBrainGraphComparison('ATLAS', atlas, ...
        'COMP', pl.get('COMP'), ...
        'Surf', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
    else
        pl.bg =  PlotBrainGraph('ATLAS', atlas, ...
        'ME',  pl.get('ME'), ...
        'Surf', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
    end
    
    function create_figure()
        pl.bg.draw('Parent', uiparent);
    end

    create_figure()

    if nargout > 0
        p = ui_brainview_panel;
    end
end
function f_settings = settings(pl, varargin)
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
    
    pl.bg.set(varargin{1}, varargin{2}); 
    pl.bg.settings();
end