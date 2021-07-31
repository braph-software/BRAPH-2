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