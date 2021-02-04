%% ¡header!
Plot < Element (pl, plot) is a plot.

%%% ¡description!
Plot is the basic element to manage graphical representations of elements.
It is an empty graphical panel, which should be filled by derived element.

%%% ¡seealso!
uipanel, ishandle, isgraphics

%% ¡properties!
h_panel % panel graphical handle
f_settings % setting figure handle 

%% ¡props!

%%% ¡prop!
BKGCOLOR (metadata, rvector) is background color of the setting interface.
%%%% ¡check_prop!
check = (length(value) == 3) && all(value >= 0 & value <= 1);
%%%% ¡default!
[.95 .95 .95]

%%% ¡prop!
SETPOS (metadata, rvector) is the normalized position of the setting interface on the screen.
%%%% ¡check_prop!
check = (length(value) == 4) && all(value >= 0 & value <= 1);
%%%% ¡default!
[.70 .50 .40 .20]

%%% ¡prop!
SETNAME (metadata, string) is the name of the setting interface.
%%%% ¡default!
'Plot Settings'

%% ¡methods!
function h_panel = draw(pl, varargin)
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
    % see also uipanel, ishandle, isgraphics.

    if isempty(pl.h_panel) || ~isgraphics(pl.h_panel, 'uipanel')
        pl.h_panel = uipanel(varargin{:});
    end
    
    if nargout > 0
        h_panel = pl.h_panel;
    end
end
function f_settings = settings(pl, varargin)
%     % BRAIN_SETTINGS opens the GUI property editor
%     %
%     % BRAIN_SETTINGS(BS) allows the user to specify the properties
%     % of the brain surf by opening a GUI property editor.
%     %
%     % BRAIN_SETTINGS(BS, 'Property', VALUE, ...) allows the user to specify the 
%     % properties of the brain surf by opening a GUI property editor.
%     % sets the property of the user interface's Property to VALUE.
%     % Admissible properties are:
%     % FigPosition   -  position of the user interface on the screen
%     % FigColor      -  background color of the user interface
%     % FigName       -  name of the user interface
%     %
%     % See also brain, trisurf.

    % create a figure
    if isempty(pl.f_settings) || ~isgraphics(pl.f_settings, 'figure')
        pl.f_settings = figure('Visible', 'off');
    end
    f = pl.f_settings;
    set(f, 'units', 'normalized')
    set(f, 'Position', pl.get('SETPOS'))
    set(f, 'Color', pl.get('BKGCOLOR'))
    set(f, 'Name', pl.get('SETNAME'))
    set(f, 'MenuBar', 'none')
    set(f, 'Toolbar', 'none')
    set(f, 'NumberTitle', 'off')
    set(f, 'DockControls', 'off')

%     % background color
%     ui_button_backgroundcolor = uicontrol(f, 'Style', 'pushbutton');
%     set(ui_button_backgroundcolor, 'Units','normalized')
%     set(ui_button_backgroundcolor, 'Position', [.05 .80 .20 .20])
%     set(ui_button_backgroundcolor, 'String', 'background color')
%     set(ui_button_backgroundcolor, 'HorizontalAlignment', 'center')
%     set(ui_button_backgroundcolor, 'TooltipString', 'Image background color')
%     set(ui_button_backgroundcolor, 'Callback', {@cb_backgroundcolor})
% 
%     function cb_backgroundcolor(~, ~)  % (src, event)
%         color = uisetcolor;
%         if length(color) == 3
%             set(bs.get_axes(), 'Color', color)
%         end
%     end
% 
%     % brain color and transparency
%     ui_text_transparency = uicontrol(f, 'Style', 'text');
%     set(ui_text_transparency, 'Units', 'normalized')
%     set(ui_text_transparency, 'BackgroundColor', FigColor)
%     set(ui_text_transparency, 'String', 'transparency')
%     set(ui_text_transparency, 'Position', [.25 .60 .35 .20])
%     set(ui_text_transparency, 'HorizontalAlignment', 'center')
%     set(ui_text_transparency, 'FontWeight', 'bold')
% 
%     ui_button_color = uicontrol(f, 'Style', 'pushbutton');
%     set(ui_button_color, 'Units', 'normalized')
%     set(ui_button_color, 'Position', [.05 .50 .15 .20])
%     set(ui_button_color, 'String', 'brain color')
%     set(ui_button_color, 'HorizontalAlignment', 'center')
%     set(ui_button_color, 'TooltipString', 'Brain surface color (applied both to faces and edges)')
%     set(ui_button_color, 'Callback', {@cb_color})
% 
%     ui_slider_alpha = uicontrol(f, 'Style', 'slider');
%     set(ui_slider_alpha, 'Units', 'normalized')
%     set(ui_slider_alpha, 'BackgroundColor', FigColor)
%     set(ui_slider_alpha, 'Position', [.25 .50 .35 .15])
%     set(ui_slider_alpha, 'String', 'Brain transparency')
%     set(ui_slider_alpha, 'Min', 0, 'Max', 1, 'Value', max(get(bs.brain, 'FaceAlpha'), get(bs.brain, 'EdgeAlpha')))
%     set(ui_slider_alpha, 'TooltipString', 'Brain surface transparency (applied both to faces and edges)')
%     set(ui_slider_alpha, 'Callback', {@cb_alpha})
% 
%     ui_button_facecolor = uicontrol(f, 'Style', 'pushbutton');
%     set(ui_button_facecolor, 'Units', 'normalized')
%     set(ui_button_facecolor, 'Position', [.05 .30 .15 .20])
%     set(ui_button_facecolor, 'String', 'face color')
%     set(ui_button_facecolor, 'HorizontalAlignment', 'center')
%     set(ui_button_facecolor, 'TooltipString', 'Brain surface face color')
%     set(ui_button_facecolor, 'Callback', {@cb_facecolor})
% 
%     ui_slider_facealpha = uicontrol(f, 'Style', 'slider');
%     set(ui_slider_facealpha, 'Units', 'normalized')
%     set(ui_slider_facealpha, 'BackgroundColor', FigColor)
%     set(ui_slider_facealpha, 'Position', [.25 .30 .35 .15])
%     set(ui_slider_facealpha, 'String', 'Brain transparency')
%     set(ui_slider_facealpha, 'Min', 0, 'Max', 1, 'Value', get(bs.brain,'FaceAlpha'))
%     set(ui_slider_facealpha, 'TooltipString', 'Brain surface face transparency')
%     set(ui_slider_facealpha, 'Callback', {@cb_facealpha})
% 
%     ui_button_edgecolor = uicontrol(f, 'Style', 'pushbutton');
%     set(ui_button_edgecolor, 'Units', 'normalized')
%     set(ui_button_edgecolor, 'Position', [.05 .10 .15 .20])
%     set(ui_button_edgecolor, 'String', 'edge color')
%     set(ui_button_edgecolor, 'HorizontalAlignment', 'center')
%     set(ui_button_edgecolor, 'TooltipString', 'Brain surface edge color')
%     set(ui_button_edgecolor, 'Callback', {@cb_edgecolor})
% 
%     ui_slider_edgealpha = uicontrol(f, 'Style', 'slider');
%     set(ui_slider_edgealpha, 'Units', 'normalized')
%     set(ui_slider_edgealpha, 'BackgroundColor', FigColor)
%     set(ui_slider_edgealpha, 'Position', [.25 .10 .35 .15])
%     set(ui_slider_edgealpha, 'String', 'Brain transparency')
%     set(ui_slider_edgealpha, 'Min', 0, 'Max', 1, 'Value', get(bs.brain, 'EdgeAlpha'))
%     set(ui_slider_edgealpha, 'TooltipString', 'Brain surface edge transparency')
%     set(ui_slider_edgealpha, 'Callback', {@cb_edgealpha})
% 
%     function cb_color(~, ~)  % (src, event)
%         color = uisetcolor;
%         if length(color) == 3
%             bs.brain('Color', color)
%         end
%     end
%     function cb_alpha(~, ~)  % (src, event)
%         bs.brain('Alpha', get(ui_slider_alpha, 'Value'))
%         set(ui_slider_facealpha, 'Value', get(ui_slider_alpha, 'Value'))
%         set(ui_slider_edgealpha, 'Value', get(ui_slider_alpha, 'Value'))
%     end
%     function cb_facecolor(~, ~)  % (src, event)
%         color = uisetcolor;
%         if length(color) == 3
%             bs.brain('FaceColor', color)
%         end
%     end
%     function cb_facealpha(~, ~)  % (src, event)
%         bs.brain('FaceAlpha', get(ui_slider_facealpha, 'Value'))
%     end
%     function cb_edgecolor(~, ~)  % (src, event)
%         color = uisetcolor;
%         if length(color) == 3
%             bs.brain('EdgeColor', color)
%         end
%     end
%     function cb_edgealpha(~, ~)  % (src, event)
%         bs.brain('EdgeAlpha', get(ui_slider_edgealpha, 'Value'))
%     end
% 
%     % lightining
%     ui_text_lighting = uicontrol(f, 'Style', 'text');
%     set(ui_text_lighting, 'Units','normalized')
%     set(ui_text_lighting, 'BackgroundColor', FigColor)
%     set(ui_text_lighting, 'String', 'lighting')
%     set(ui_text_lighting, 'Position', [.65 .70 .10 .15])
%     set(ui_text_lighting, 'HorizontalAlignment', 'center')
%     set(ui_text_lighting, 'FontWeight', 'bold')
% 
%     ui_popup_lighting = uicontrol(f, 'Style', 'popupmenu');
%     set(ui_popup_lighting, 'Units', 'normalized')
%     set(ui_popup_lighting, 'Position', [.75 .70 .20 .15])
%     set(ui_popup_lighting, 'String', {'none', 'flat', 'phong', 'gouraud'})
%     set(ui_popup_lighting, 'Value', find(strcmpi(bs.Lighting, get(ui_popup_lighting, 'String'))))
%     set(ui_popup_lighting, 'HorizontalAlignment', 'center')
%     set(ui_popup_lighting, 'Callback', {@cb_lighting})
% 
%     function cb_lighting(~, ~)  % (src, event)
%         val = ui_popup_lighting.Value;
%         str = ui_popup_lighting.String;
%         bs.lighting(str{val});
%     end
% 
%     % material
%     ui_text_material = uicontrol(f, 'Style', 'text');
%     set(ui_text_material, 'Units', 'normalized')
%     set(ui_text_material, 'BackgroundColor', FigColor)
%     set(ui_text_material, 'String', 'material')
%     set(ui_text_material, 'Position', [.65 .55 .10 .15])
%     set(ui_text_material, 'HorizontalAlignment', 'center')
%     set(ui_text_material, 'FontWeight', 'bold')            
% 
%     ui_popup_material = uicontrol(f, 'Style', 'popupmenu');
%     set(ui_popup_material, 'Units', 'normalized')
%     set(ui_popup_material, 'Position', [.75 .55 .20 .15])
%     set(ui_popup_material, 'String', {'dull', 'shiny', 'metal'})
%     set(ui_popup_material, 'Value', find(strcmpi(bs.Material, get(ui_popup_material, 'String'))))
%     set(ui_popup_material, 'HorizontalAlignment', 'center')
%     set(ui_popup_material, 'Callback', {@cb_material})
% 
%     function cb_material(~, ~)  % (src, event)
%         val = ui_popup_material.Value;
%         str = ui_popup_material.String;
%         bs.material(str{val});
%     end
% 
%     % camlight
%     ui_text_camlight = uicontrol(f, 'Style', 'text');
%     set(ui_text_camlight, 'Units', 'normalized')
%     set(ui_text_camlight, 'BackgroundColor', FigColor)
%     set(ui_text_camlight, 'String', 'camlight')
%     set(ui_text_camlight, 'Position', [.65 .40 .10 .15])
%     set(ui_text_camlight, 'HorizontalAlignment', 'center')
%     set(ui_text_camlight, 'FontWeight', 'bold') 
% 
%     ui_popup_camlight = uicontrol(f, 'Style', 'popupmenu');
%     set(ui_popup_camlight, 'Units', 'normalized')
%     set(ui_popup_camlight, 'Position', [.75 .40 .20 .15])
%     set(ui_popup_camlight, 'String', {'headlight', 'right', 'left'})
%     set(ui_popup_camlight, 'Value', find(strcmpi(bs.CamLight, get(ui_popup_camlight, 'String'))))
%     set(ui_popup_camlight, 'HorizontalAlignment', 'center')
%     set(ui_popup_camlight, 'Callback', {@cb_camlight})
% 
%     function cb_camlight(~, ~)  % (src, event)
%         val = ui_popup_camlight.Value;
%         str = ui_popup_camlight.String;
%         bs.camlight(str{val});
%     end
% 
%     % shading
%     ui_text_shading = uicontrol(f, 'Style', 'text');
%     set(ui_text_shading, 'Units', 'normalized')
%     set(ui_text_shading, 'BackgroundColor', FigColor)
%     set(ui_text_shading, 'String', 'shading')
%     set(ui_text_shading, 'Position', [.65 .25 .10 .15])
%     set(ui_text_shading, 'HorizontalAlignment', 'center')
%     set(ui_text_shading, 'FontWeight', 'bold') 
% 
%     ui_popup_shading = uicontrol(f, 'Style', 'popupmenu');
%     set(ui_popup_shading, 'Units', 'normalized')
%     set(ui_popup_shading, 'Position', [.75 .25 .20 .15])
%     set(ui_popup_shading, 'String', {'flat', 'faceted', 'interp'})
%     set(ui_popup_shading, 'Value', find(strcmpi(bs.Shading, get(ui_popup_shading, 'String'))))
%     set(ui_popup_shading, 'HorizontalAlignment', 'center')
%     set(ui_popup_shading, 'Callback', {@cb_shading})
% 
%     function cb_shading(~, ~)  % (src, event)
%         val = ui_popup_shading.Value;
%         str = ui_popup_shading.String;
%         bs.shading(str{val});
%     end
% 
%     % colormap
%     ui_text_colormap = uicontrol(f, 'Style', 'text');
%     set(ui_text_colormap, 'Units', 'normalized')
%     set(ui_text_colormap, 'BackgroundColor', FigColor)
%     set(ui_text_colormap, 'String', 'colormap')
%     set(ui_text_colormap, 'Position', [.65 .10 .10 .15])
%     set(ui_text_colormap, 'HorizontalAlignment', 'center')
%     set(ui_text_colormap, 'FontWeight', 'bold') 
% 
%     ui_popup_colormap = uicontrol(f, 'Style', 'popupmenu');
%     set(ui_popup_colormap, 'Units', 'normalized')
%     set(ui_popup_colormap, 'Position', [.75 .10 .20 .15])
%     set(ui_popup_colormap, 'String', {'parula', 'jet', 'hsv', 'hot', ...
%         'cool', 'spring', 'summer', 'autumn', 'winter', 'gray', 'bone', ...
%         'copper', 'pink', 'lines', 'colorcube', 'prism', 'flag', 'white'})
%     set(ui_popup_colormap, 'Value', find(strcmpi(bs.Colormap, get(ui_popup_colormap, 'String'))))
%     set(ui_popup_colormap, 'HorizontalAlignment', 'center')
%     set(ui_popup_colormap, 'Callback', {@cb_colormap})
% 
%     function cb_colormap(~, ~)  % (src, event)
%         val = ui_popup_colormap.Value;
%         str = ui_popup_colormap.String;
%         bs.colormap(str{val});
%     end

    set(f, 'Visible', 'on')
    
    if nargout > 0
        f_settings = pl.f_settings;
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
fig = figure();

pl1 = Plot();
pl1.draw()
pl1.settings()

pl2 = Plot();
h2 = pl2.draw('Units', 'normalized', 'Position', [.25 .25 .50 .50]);
f2 = pl2.settings();

close(pl1.settings())
close(pl2.settings())
close(fig)