%% ¡header!
PlotGraph < Plot (pr, plot graph) is a plot of a graph of a function.

%%% ¡description!
Plot is the plot of a graph of a function.
It is a graphical figure with empty axes, which should be filled by derived element.
To generate the plot, call pr.draw().

%%% ¡seealso!
uipanel, ishandle, isgraphics, figure

%% ¡properties!
h_figure % panel graphical handle
h_axes % axes handle
h_plot % plot handle
pp
h_settings
h_settings_line % settings panel handle
h_settings_adj % settings panel for adjacency matrix

%% ¡props!

%%% ¡prop!
SUBMENU (metadata, logical) to set a submenu
%%%% ¡default!
false

%%% ¡prop!
GRAPH (data, item) is the graph which is been ploted
%%%% ¡default!
Graph()

%%% ¡prop!
LAYER (metadata, scalar) is the layer to be ploted
%%%% ¡default!
1

%% ¡methods!
function [h_figure, h_axes, subpanel] = draw(pr, varargin)
    %DRAW draws the graphical panel.
    %
    % DRAW(PL) draws the graphical panel.
    %
    % H = DRAW(PL) returns a handle to the graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % see also settings, uipanel, isgraphics.    
        
    pr.pp = draw@Plot(pr, varargin{:});

    pr.h_figure = get(pr.pp, 'Parent');
    
    % overwrite close req
    set(pr.pp, 'DeleteFcn', {@cb_close_fs})
    
    function cb_close_fs(~, ~)
        if ~isempty(pr.h_settings) && check_graphics(pr.h_settings, 'figure')
            close(pr.h_settings)
        end
    end
    
    if pr.get('SUBMENU')
        subpanel = uipanel(pr.h_figure, ...
            'BackGroundColor', 'w', ...
            'Units', 'normalized', ...
            'Position', [.0 .15 1 .85] ...
            );
        
        pr.h_axes = axes(subpanel);
        set(pr.h_figure, 'Color', 'w')
        set(pr.pp, 'BackGroundColor', 'w');
        
    else
        pr.h_axes = axes(pr.pp);
    end
        
    if nargout > 0
        h_figure = pr.h_figure;
    end
    if nargout > 1
        h_axes = pr.h_axes;
    end
end
function f_settings = settings(pr, varargin)
    %SETTINGS opens the property editor GUI.
    %
    % SETTINGS(PL) allows the user to specify the properties of the plot
    %  by opening a GUI property editor.
    %
    % F = SETTINGS(PL) returns a handle to the property editor GUI.
    %
    % SETTINGS(PL, 'Property', VALUE, ...) sets the properties of the
    %  property editor GUI with custom property-value couples. 
    %  All standard plot properties of figure can be used.
    %
    % See also draw, figure, isgraphics.
    
    f = settings@Plot(pr, varargin{:});
    pr.h_settings = f;
    
    if nargin > 0 
        f_settings = pr.h_settings;
    end
end