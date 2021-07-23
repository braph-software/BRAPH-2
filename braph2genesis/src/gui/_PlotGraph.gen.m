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
    
    f = figure( ...
        'Visible', 'off', ...
        'NumberTitle', 'off', ...
        'Name', ['PlotGraph - ' BRAPH2.STR], ...
        'Units', 'normalized', ...
        'Position', [.3 .4 .4 .5], ...
        'Units', 'character', ...
        'MenuBar', 'none', ...
        'DockControls', 'off', ...
        'Color', [.94 .94 .94] ...
        );		    
    
    set_icon(f);
    
    ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
    delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
    delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
    delete(findall(ui_toolbar, 'Tag', 'Standard.SaveFigure'))
    delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
    delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))
    delete(findall(ui_toolbar, 'Tag', 'Standard.OpenInspector'))
    delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
    delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
    delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertColorbar'))
    delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertLegend'))
    delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOff'))
    delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOn'))
    
    pl.pp = draw@Plot(pl, 'Parent', f, varargin{:});
    
    set(f, 'Visible', 'on')

    pl.h_figure = get(pl.pp, 'Parent');
    
    if pl.get('SUBMENU')
        subpanel = uipanel(pl.h_figure, ...
            'BackGroundColor', 'w', ...
            'Units', 'normalized', ...
            'Position', [.0 .25 1 .85] ...
            );
        
        pl.h_axes = axes(subpanel);
        
    else
        pl.h_axes = axes(pl.h_figure);
    end
        
    if nargout > 0
        h_figure = pl.h_figure;
    end
    if nargout > 1
        h_axes = pl.h_axes;
    end
end

%% ¡staticmethods!
function r = x0(h)
    %X0 returns the position of the left edge of a graphical element.
    %
    % R = X0(H) is the distance from the inner left edge of the parent
    %  container to the outer left edge of the graphical element H.
    % 
    % See also y0, w, h.

    r = get(h, 'Position');
    r = r(1);
end
function r = y0(h)
    %Y0 returns the position of the bottom edge of a graphical element.
    %
    % R = Y0(H) is the distance from the inner bottom edge of the parent 
    %  container to the outer bottom edge of the graphical element H.
    %
    % See also x0, w, h.

    r = get(h, 'Position');
    r = r(2);
end
function r = w(h)
    %W returns the width of a graphical element.
    %
    % R = W(H) is the distance between the right and left outer edges of the
    %   graphical element H.
    % 
    % See also x0, y0, h.

    r = get(h, 'Position');
    r = r(3);
end
function r = h(h)
    %H returns the height of a graphical element.
    %
    % R = H(H) is the distance between the top and bottom outer edges of the
    %  graphical element H.
    % 
    % See also x0, y0, w.

    r = get(h, 'Position');
    r = r(4);
end