%% ¡header!
PlotGraph < Element (pl, plot graph) is a plot of a graph of a function.

%%% ¡description!
Plot is the plot of a graph of a function.
It is a graphical figure with empty axes, which should be filled by derived element.
To generate the plot, call pl.draw().

%%% ¡seealso!
uipanel, ishandle, isgraphics, figure

%% ¡properties!
h_figure % panel graphical handle
h_axes % axes handle

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the plot.

%%% ¡prop!
BKGCOLOR (metadata, rvector) is background color.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
[1 .9725 .929]

%%% ¡prop!
SETPOS (metadata, rvector) is the normalized position of the setting interface on the screen.
%%%% ¡check_prop!
check = (length(value) == 4) && all(value >= 0 & value <= 1);
%%%% ¡default!
[.70 .50 .40 .20]

%%% ¡prop!
SETNAME (metadata, string) is the name of the setting interface.
%%%% ¡default!
'Graph Plot'

%% ¡methods!
function [h_figure, h_axes] = draw(pl, varargin)
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

    if isempty(pl.h_figure) || ~isgraphics(pl.h_figure, 'figure')
        pl.h_figure = figure( ...
            varargin{:}, ...
            'DockControls', 'off', ...
            'MenuBar', 'none', ...
            'Toolbar', 'figure', ...
            'Name', pl.get('SETNAME'), ...
            'Color', 'w', ...
            'Units', 'normalized', ...
            'DeleteFcn', {@close_f_settings} ...
            );
        pl.h_axes = axes(pl.h_figure);
        set_icon(pl.h_figure);
        
        ui_toolbar = findall(plot_figure, 'Tag', 'FigureToolBar');
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
        
        % menu
        ui_menu_figure = uimenu(f, 'Label', 'Figure');
        uimenu(ui_menu_figure, ...
            'Label', 'Save ...', ...
            'Accelerator', 'S', ...
            'Callback', {@cb_save})
    else
        set(pl.h_figure, ...
            varargin{:}, ...
            'DeleteFcn', {@close_f_settings} ...
            )
    end

    function close_f_settings(~, ~) % (src, event)
        % do nothing
    end
    function cb_save(~, ~)
        [file, path, filterindex] = uiputfile();
        % save file
        if filterindex
            filename = fullfile(path, file);
            save(filename);
        end
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