%% ¡header!
PlotGraph < Plot (pl, plot graph) is a plot of a graph of a function.

%%% ¡description!
Plot is the plot of a graph of a function.
It is a graphical figure with empty axes, which should be filled by derived element.
To generate the plot, call pl.draw().

%%% ¡seealso!
uipanel, ishandle, isgraphics, figure

%% ¡properties!
h_figure % panel graphical handle
h_axes % axes handle
pp

%% ¡props!

%%% ¡prop!
SUBMENU (metadata, logical) to set a submenu
%%%% ¡default!
false

%%% ¡prop!
COLOR (metadata, rvector) to set plot line color
%%%% ¡default!
[0 0 0]

%%% ¡prop!
LINESTYLE (metadata, string) to set plot line style
%%%% ¡default!
'-'

%%% ¡prop!
LINEWIDTH (metadata, scalar) to set plot line width
%%%% ¡default!
0.5

%%% ¡prop!
MARKER (metadata, string) to set plot marker style
%%%% ¡default!
'none'

%%% ¡prop!
MARKERSIZE (metadata, scalar) to set plot marker size
%%%% ¡default!
6

%%% ¡prop!
MARKEREDGECOLOR (metadata, rvector) to set plot marker edge color
%%%% ¡default!
[0 0 0]

%%% ¡prop!
MARKERFACECOLOR (metadata, rvector) to set plot marker face color
%%%% ¡default!
[0 0 0]

%% ¡methods!
function [h_figure, h_axes, subpanel] = draw(pl, varargin)
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
        
    pl.pp = draw@Plot(pl, varargin{:});

    pl.h_figure = get(pl.pp, 'Parent');
    
    if pl.get('SUBMENU')
        subpanel = uipanel(pl.h_figure, ...
            'BackGroundColor', 'w', ...
            'Units', 'normalized', ...
            'Position', [.0 .2 1 .8] ...
            );
        
        pl.h_axes = axes(subpanel);
        
    else
        pl.h_axes = axes(pl.pp);
    end
        
    if nargout > 0
        h_figure = pl.h_figure;
    end
    if nargout > 1
        h_axes = pl.h_axes;
    end
end
function  f_settings = settings(pl, varargin)
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
    
    f = settings@Plot(pl, varargin{:});
    set_icon(f);
end