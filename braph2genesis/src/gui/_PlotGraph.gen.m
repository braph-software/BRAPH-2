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
    
    % panel
    line_style = {'-', '--', ':', ':.', 'none'};
    marker_style = {'o', '+', '*', '.', 'x', ...
        '_', '|', 'square', 'diamond', '^', ...
        '>', '<', 'pentagram', 'hexagram', 'none'};
    
    ui_plot_properties_panel = uicontrol(f, ...
        'Units', 'normalized', ...
        'BackgroundColor', [1 .9725 .929], ...
        'Position', [0 0 1 1]);
    
    % line properties
    ui_line_color = uicontrol(ui_plot_properties_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.05 .75 .4 .20], ...
        'String', 'Line Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Plot Line Color', ...
        'Callback', {@cb_line_color});
    
        function cb_line_color(~, ~) % (src, event)
        color = uisetcolor;
        if length(color) == 3
            pl.set('COLOR', color)
            update()
        end
    end

    ui_line_style = uicontrol(ui_plot_properties_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.05 .55 .4 .18], ...
        'String', line_style, ...
        'TooltipString', 'Plot Line Style', ...
        'Callback', {@cb_line_style});
    
        function cb_line_style(~, ~)  % (src, event)
            val = ui_line_style.Value;
            str = ui_line_style.String;
            pl.set('LINESTYLE', str{val})
            update()
        end
    
     ui_line_width = uicontrol(ui_plot_properties_panel, ...
        'Style', 'edit', ...
        'Units', 'normalized', ...
        'Position', [.05 .35 .4 .18], ...
        'String', '5', ...
        'TooltipString', 'Plot Line Width', ...
        'Callback', {@cb_line_width});
    
        function cb_line_width(~, ~)  % (src, event)
            value = str2num(ui_line_width.String);
            pl.set('LINEWIDTH', value)
            update()
        end
    
    % markers
     ui_marker_style = uicontrol(ui_plot_properties_panel, ...
        'Style', 'popupmenu', ...
        'Units','normalized', ...
        'Position', [.55 .75 .4 .18], ...
        'String', marker_style, ...
        'TooltipString', 'Plot Marker Style', ...
        'Callback', {@cb_marker_style});
    
        function cb_marker_style(~, ~)  % (src, event)
            val = ui_marker_style.Value;
            str = ui_marker_style.String;
            pl.set('MARKER', str{val})
            update()
        end
    
     ui_marker_size = uicontrol(ui_plot_properties_panel, ...
        'Style', 'edit', ...
        'Units', 'normalized', ...
        'Position', [.55 .55 .4 .18], ...
        'String', '5', ...
        'TooltipString', 'Plot Line Width', ...
        'Callback', {@cb_marker_size});
    
        function cb_marker_size(~, ~)  % (src, event)
            value = str2num(ui_line_width.String);
            pl.set('MARKERSIZE', value)
            update()
        end
    ui_marker_edge_color = uicontrol(ui_plot_properties_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.55 .35 .4 .20], ...
        'String', 'Marker Edge Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Marker Edge Color', ...
        'Callback', {@cb_marker_edge_color});
    
        function cb_marker_edge_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pl.set('MARKEREDGECOLOR', color)
                update()
            end
        end
    ui_marker_face_color = uicontrol(ui_plot_properties_panel, ...
        'Style', 'pushbutton', ...
        'Units','normalized', ...
        'Position', [.55 .35 .4 .20], ...
        'String', 'Marker Face Color', ...
        'HorizontalAlignment', 'center', ...
        'TooltipString', 'Marker Edge Color', ...
        'Callback', {@cb_marker_face_color});
    
        function cb_marker_face_color(~, ~) % (src, event)
            color = uisetcolor;
            if length(color) == 3
                pl.set('MARKERFACECOLOR', color)
                update()
            end
        end

    function update()
        plot_object = pl.h_axes.Children;
        if isgraphics(plot_object)
            set(plot_object, ...
                'COLOR', pl.get('COLOR'), ...
                'LINESTYLE', pl.get('LINESTYLE'), ...
                'LINESWIDTH', pl.get('LINEWIDTH'), ...
                'MARKER', pl.get('MARKER'), ...
                'MARKERSIZE', pl.get('MARKERSIZE'), ...
                'MARKEREDGECOLOR', pl.get('MARKEREDGECOLOR'), ...
                'MARKERFACECOLOR', pl .get('MARKERFACECOLOR'));
        end
    end
    
    if nargin > 0 
        f_settings = f;
    end
end