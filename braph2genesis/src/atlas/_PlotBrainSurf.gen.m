%% ¡header!
PlotBrainSurf < Element (pbs, plot brainsurf) plots the brain surfaces.

%%% ¡description!
PlotBrainSurf plots the brain surfaces.
It provides the methods necessary to handle the brain surface data.
    
%%% ¡seealso!
Element, BrainAtlas, BrainRegion, BrainSurface.

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the brain surface.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain surface.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain surface.

%%% ¡prop!
BrainSurface (data, item) 
%%%% ¡settings!
'BrainSurface'

%%% ¡prop!
h_axes (data, scalar) % change format

%%% ¡prop!
h_brain (data, scalar) % same

%%% ¡prop!
f_brain_setings (data, item) 

%%% ¡prop!
Lighting (data, string) 

%%% ¡prop!
Material (data, string) 

%%% ¡prop!
CamLight (data, string) 

%%% ¡prop!
Shading (data, string) 

%%% ¡prop!
Colormap (data, string) 



%% ¡methods!
% Graphic
function h = set_axes(pbs, ht)
% SET_AXES sets current axes
%
% SET_AXES(BS, HT) sets the axes to plot brain surf to HT.
% If an axes is not entered as an input argument HT, the
% current axes is used for plotting.
%
% H = SET_AXES(BS) returns a handle to the axes used to plot
% brain surf.
%
% See also get_axes, gca.

if isequal(pbs.get('h_axes'), NoValue.getNoValue()) || ~ishandle(pbs.get('h_axes'))
    if nargin < 2
        ht = gca;
    end
    pbs.set('h_axes') = ht;
end

if nargout > 0
    h = ht;
end
end
function h = get_axes(pbs)
% GET_AXES gets current axes
%
% H = GET_AXES(BS) returns a handle to the axes used to plot
% the brain surf.
%
% See also set_axes.

h = pbs.get('h_axes');
end
function h = brain(pbs, varargin)
% BRAIN plots brain surf
%
% BRAIN(BS) plots the brain surf, if not already plotted.
%
% H = BRAIN(BS) sets the handle of the trisurf plot of the
% brain surf BS class.
%
% BRAIN(BS, 'Property', VALUE, ...) sets the properties of the
% surface object with custom property-value couples.
% All standard plot properties of trisurf can be used, and
% additional admissible properties and values are:
% Lighting  = 'phong' (default) 'none' 'flat' 'gouraud'
% Material  = 'shiny' (default) 'dull' 'metal'
% CamLight  = 'headlight' (default) 'right' 'left'
% Shading   = 'interp' (default) 'none' 'flat' 'faceted'
% Colormap  = 'jet' (default) 'parula' 'jet' 'hsv' 'hot' 'cool'
%             'spring' 'summer' 'autumn' 'winter' 'gray' 'bone'
%             'copper' 'pink' 'lines' 'colorcube' 'prism'
%             'flag' 'white'
% The brain surface properties can also be changed when hidden.
%
% See also brain_on, brain_off, brain_settings, trisurf.

pbs.set_axes()

% plot brain surface
if isequal(pbs.get('h_brain'), NoValue.getNoValue()) || ~ishandle(pbs.get('h_brain'))
    c = pbs.get('brainsurface').get('coordinates');
    
    pbs.set('h_brain', trisurf( ...
        pbs.get('brainsurface').get('triangles'), ...
        c(1, :), ...
        c(2, :), ...
        c(3, :), ...
        'Parent', pbs.get_axes(), ...
        'EdgeColor', 'none', ...
        'EdgeAlpha', .5, ...
        'FaceColor', [.5 .5 .5], ...
        'FaceAlpha', .5 ...
        ));
    pbs.lighting(pbs.get('Lighting'));
    pbs.material(pbs.get('Material'));
    pbs.camlight(pbs.get('CamLight'));
    pbs.shading(pbs.get('Shading'));
    pbs.colormap(pbs.get('Colormap'));
end

% sets properties
for n = 1:2:length(varargin)
    switch lower(varargin{n})
        case 'color'
            set(pbs.h_brain, 'FaceColor', varargin{n + 1});
            set(pbs.h_brain, 'EdgeColor', varargin{n + 1});
        case 'alpha'
            set(pbs.h_brain, 'FaceAlpha', varargin{n + 1});
            set(pbs.h_brain, 'EdgeAlpha', varargin{n + 1});
        case 'lighting'
            pbs.lighting(varargin{n + 1});
        case 'material'
            pbs.material(varargin{n + 1});
        case 'camlight'
            pbs.camlight(varargin{n + 1});
        case 'shading'
            pbs.shading(varargin{n + 1});
        case 'colormap'
            pbs.colormap(varargin{n + 1});
        otherwise
            set(pbs.h_brain, varargin{n}, varargin{n + 1});
    end
end

% output if needed
if nargout > 0
    h = pbs.h_brain;
end
end
function brain_on(pbs)
% BRAIN_ON shows brain surf
%
% BRAIN_ON(BS) shows the brain surf BS.
%
% See also brain, brain_off.

if ~isempty(pbs.get('h_brain'))
    set(pbs.h_brain, 'Visible', 'on')
end
end
function brain_off(pbs)
% BRAIN_OFF hides brain surf
%
% BRAIN_OFF(BS) hides the brain surf BS.
%
% See also brain, brain_on.

if ~isempty(pbs.h_brain)
    set(pbs.h_brain,'Visible','off')
end
end
function brain_settings(pbs, varargin)
% BRAIN_SETTINGS opens the GUI property editor
%
% BRAIN_SETTINGS(BS) allows the user to specify the properties
% of the brain surf by opening a GUI property editor.
%
% BRAIN_SETTINGS(BS, 'Property', VALUE, ...) allows the user to specify the
% properties of the brain surf by opening a GUI property editor.
% sets the property of the user interface's Property to VALUE.
% Admissible properties are:
% FigPosition   -  position of the user interface on the screen
% FigColor      -  background color of the user interface
% FigName       -  name of the user interface
%
% See also brain, trisurf.

FigPosition = get_from_varargin([.70 .50 .40 .20], 'figposition', varargin);
FigColor = get_from_varargin(GUI.BKGCOLOR, 'figcolor', varargin);
FigName = get_from_varargin('Brain Surface Settings', 'figname', varargin);

% create a figure
if isempty(pbs.f_brain_settings) || ~ishandle(pbs.f_brain_settings)
    pbs.f_brain_settings = figure('Visible', 'off');
end
f = pbs.f_brain_settings;
set(f, 'units', 'normalized')
set(f, 'Position', FigPosition)
set(f, 'Color', FigColor)
set(f, 'Name', FigName)
set(f, 'MenuBar', 'none')
set(f, 'Toolbar', 'none')
set(f, 'NumberTitle', 'off')
set(f, 'DockControls', 'off')

% background color
ui_button_backgroundcolor = uicontrol(f, 'Style', 'pushbutton');
set(ui_button_backgroundcolor, 'Units','normalized')
set(ui_button_backgroundcolor, 'Position', [.05 .80 .20 .20])
set(ui_button_backgroundcolor, 'String', 'background color')
set(ui_button_backgroundcolor, 'HorizontalAlignment', 'center')
set(ui_button_backgroundcolor, 'TooltipString', 'Image background color')
set(ui_button_backgroundcolor, 'Callback', {@cb_backgroundcolor})

    function cb_backgroundcolor(~, ~)  % (src, event)
        color = uisetcolor;
        if length(color) == 3
            set(pbs.get_axes(), 'Color', color)
        end
    end

% brain color and transparency
ui_text_transparency = uicontrol(f, 'Style', 'text');
set(ui_text_transparency, 'Units', 'normalized')
set(ui_text_transparency, 'BackgroundColor', FigColor)
set(ui_text_transparency, 'String', 'transparency')
set(ui_text_transparency, 'Position', [.25 .60 .35 .20])
set(ui_text_transparency, 'HorizontalAlignment', 'center')
set(ui_text_transparency, 'FontWeight', 'bold')

ui_button_color = uicontrol(f, 'Style', 'pushbutton');
set(ui_button_color, 'Units', 'normalized')
set(ui_button_color, 'Position', [.05 .50 .15 .20])
set(ui_button_color, 'String', 'brain color')
set(ui_button_color, 'HorizontalAlignment', 'center')
set(ui_button_color, 'TooltipString', 'Brain surface color (applied both to faces and edges)')
set(ui_button_color, 'Callback', {@cb_color})

ui_slider_alpha = uicontrol(f, 'Style', 'slider');
set(ui_slider_alpha, 'Units', 'normalized')
set(ui_slider_alpha, 'BackgroundColor', FigColor)
set(ui_slider_alpha, 'Position', [.25 .50 .35 .15])
set(ui_slider_alpha, 'String', 'Brain transparency')
set(ui_slider_alpha, 'Min', 0, 'Max', 1, 'Value', max(get(pbs.brain, 'FaceAlpha'), get(pbs.brain, 'EdgeAlpha')))
set(ui_slider_alpha, 'TooltipString', 'Brain surface transparency (applied both to faces and edges)')
set(ui_slider_alpha, 'Callback', {@cb_alpha})

ui_button_facecolor = uicontrol(f, 'Style', 'pushbutton');
set(ui_button_facecolor, 'Units', 'normalized')
set(ui_button_facecolor, 'Position', [.05 .30 .15 .20])
set(ui_button_facecolor, 'String', 'face color')
set(ui_button_facecolor, 'HorizontalAlignment', 'center')
set(ui_button_facecolor, 'TooltipString', 'Brain surface face color')
set(ui_button_facecolor, 'Callback', {@cb_facecolor})

ui_slider_facealpha = uicontrol(f, 'Style', 'slider');
set(ui_slider_facealpha, 'Units', 'normalized')
set(ui_slider_facealpha, 'BackgroundColor', FigColor)
set(ui_slider_facealpha, 'Position', [.25 .30 .35 .15])
set(ui_slider_facealpha, 'String', 'Brain transparency')
set(ui_slider_facealpha, 'Min', 0, 'Max', 1, 'Value', get(pbs.brain,'FaceAlpha'))
set(ui_slider_facealpha, 'TooltipString', 'Brain surface face transparency')
set(ui_slider_facealpha, 'Callback', {@cb_facealpha})

ui_button_edgecolor = uicontrol(f, 'Style', 'pushbutton');
set(ui_button_edgecolor, 'Units', 'normalized')
set(ui_button_edgecolor, 'Position', [.05 .10 .15 .20])
set(ui_button_edgecolor, 'String', 'edge color')
set(ui_button_edgecolor, 'HorizontalAlignment', 'center')
set(ui_button_edgecolor, 'TooltipString', 'Brain surface edge color')
set(ui_button_edgecolor, 'Callback', {@cb_edgecolor})

ui_slider_edgealpha = uicontrol(f, 'Style', 'slider');
set(ui_slider_edgealpha, 'Units', 'normalized')
set(ui_slider_edgealpha, 'BackgroundColor', FigColor)
set(ui_slider_edgealpha, 'Position', [.25 .10 .35 .15])
set(ui_slider_edgealpha, 'String', 'Brain transparency')
set(ui_slider_edgealpha, 'Min', 0, 'Max', 1, 'Value', get(pbs.brain, 'EdgeAlpha'))
set(ui_slider_edgealpha, 'TooltipString', 'Brain surface edge transparency')
set(ui_slider_edgealpha, 'Callback', {@cb_edgealpha})

    function cb_color(~, ~)  % (src, event)
        color = uisetcolor;
        if length(color) == 3
            pbs.brain('Color', color)
        end
    end
    function cb_alpha(~, ~)  % (src, event)
        pbs.brain('Alpha', get(ui_slider_alpha, 'Value'))
        set(ui_slider_facealpha, 'Value', get(ui_slider_alpha, 'Value'))
        set(ui_slider_edgealpha, 'Value', get(ui_slider_alpha, 'Value'))
    end
    function cb_facecolor(~, ~)  % (src, event)
        color = uisetcolor;
        if length(color) == 3
            pbs.brain('FaceColor', color)
        end
    end
    function cb_facealpha(~, ~)  % (src, event)
        pbs.brain('FaceAlpha', get(ui_slider_facealpha, 'Value'))
    end
    function cb_edgecolor(~, ~)  % (src, event)
        color = uisetcolor;
        if length(color) == 3
            pbs.brain('EdgeColor', color)
        end
    end
    function cb_edgealpha(~, ~)  % (src, event)
        pbs.brain('EdgeAlpha', get(ui_slider_edgealpha, 'Value'))
    end

% lightining
ui_text_lighting = uicontrol(f, 'Style', 'text');
set(ui_text_lighting, 'Units','normalized')
set(ui_text_lighting, 'BackgroundColor', FigColor)
set(ui_text_lighting, 'String', 'lighting')
set(ui_text_lighting, 'Position', [.65 .70 .10 .15])
set(ui_text_lighting, 'HorizontalAlignment', 'center')
set(ui_text_lighting, 'FontWeight', 'bold')

ui_popup_lighting = uicontrol(f, 'Style', 'popupmenu');
set(ui_popup_lighting, 'Units', 'normalized')
set(ui_popup_lighting, 'Position', [.75 .70 .20 .15])
set(ui_popup_lighting, 'String', {'none', 'flat', 'phong', 'gouraud'})
set(ui_popup_lighting, 'Value', find(strcmpi(pbs.Lighting, get(ui_popup_lighting, 'String'))))
set(ui_popup_lighting, 'HorizontalAlignment', 'center')
set(ui_popup_lighting, 'Callback', {@cb_lighting})

    function cb_lighting(~, ~)  % (src, event)
        val = ui_popup_lighting.Value;
        str = ui_popup_lighting.String;
        pbs.lighting(str{val});
    end

% material
ui_text_material = uicontrol(f, 'Style', 'text');
set(ui_text_material, 'Units', 'normalized')
set(ui_text_material, 'BackgroundColor', FigColor)
set(ui_text_material, 'String', 'material')
set(ui_text_material, 'Position', [.65 .55 .10 .15])
set(ui_text_material, 'HorizontalAlignment', 'center')
set(ui_text_material, 'FontWeight', 'bold')

ui_popup_material = uicontrol(f, 'Style', 'popupmenu');
set(ui_popup_material, 'Units', 'normalized')
set(ui_popup_material, 'Position', [.75 .55 .20 .15])
set(ui_popup_material, 'String', {'dull', 'shiny', 'metal'})
set(ui_popup_material, 'Value', find(strcmpi(pbs.Material, get(ui_popup_material, 'String'))))
set(ui_popup_material, 'HorizontalAlignment', 'center')
set(ui_popup_material, 'Callback', {@cb_material})

    function cb_material(~, ~)  % (src, event)
        val = ui_popup_material.Value;
        str = ui_popup_material.String;
        pbs.material(str{val});
    end

% camlight
ui_text_camlight = uicontrol(f, 'Style', 'text');
set(ui_text_camlight, 'Units', 'normalized')
set(ui_text_camlight, 'BackgroundColor', FigColor)
set(ui_text_camlight, 'String', 'camlight')
set(ui_text_camlight, 'Position', [.65 .40 .10 .15])
set(ui_text_camlight, 'HorizontalAlignment', 'center')
set(ui_text_camlight, 'FontWeight', 'bold')

ui_popup_camlight = uicontrol(f, 'Style', 'popupmenu');
set(ui_popup_camlight, 'Units', 'normalized')
set(ui_popup_camlight, 'Position', [.75 .40 .20 .15])
set(ui_popup_camlight, 'String', {'headlight', 'right', 'left'})
set(ui_popup_camlight, 'Value', find(strcmpi(pbs.CamLight, get(ui_popup_camlight, 'String'))))
set(ui_popup_camlight, 'HorizontalAlignment', 'center')
set(ui_popup_camlight, 'Callback', {@cb_camlight})

    function cb_camlight(~, ~)  % (src, event)
        val = ui_popup_camlight.Value;
        str = ui_popup_camlight.String;
        pbs.camlight(str{val});
    end

% shading
ui_text_shading = uicontrol(f, 'Style', 'text');
set(ui_text_shading, 'Units', 'normalized')
set(ui_text_shading, 'BackgroundColor', FigColor)
set(ui_text_shading, 'String', 'shading')
set(ui_text_shading, 'Position', [.65 .25 .10 .15])
set(ui_text_shading, 'HorizontalAlignment', 'center')
set(ui_text_shading, 'FontWeight', 'bold')

ui_popup_shading = uicontrol(f, 'Style', 'popupmenu');
set(ui_popup_shading, 'Units', 'normalized')
set(ui_popup_shading, 'Position', [.75 .25 .20 .15])
set(ui_popup_shading, 'String', {'flat', 'faceted', 'interp'})
set(ui_popup_shading, 'Value', find(strcmpi(pbs.Shading, get(ui_popup_shading, 'String'))))
set(ui_popup_shading, 'HorizontalAlignment', 'center')
set(ui_popup_shading, 'Callback', {@cb_shading})

    function cb_shading(~, ~)  % (src, event)
        val = ui_popup_shading.Value;
        str = ui_popup_shading.String;
        pbs.shading(str{val});
    end

% colormap
ui_text_colormap = uicontrol(f, 'Style', 'text');
set(ui_text_colormap, 'Units', 'normalized')
set(ui_text_colormap, 'BackgroundColor', FigColor)
set(ui_text_colormap, 'String', 'colormap')
set(ui_text_colormap, 'Position', [.65 .10 .10 .15])
set(ui_text_colormap, 'HorizontalAlignment', 'center')
set(ui_text_colormap, 'FontWeight', 'bold')

ui_popup_colormap = uicontrol(f, 'Style', 'popupmenu');
set(ui_popup_colormap, 'Units', 'normalized')
set(ui_popup_colormap, 'Position', [.75 .10 .20 .15])
set(ui_popup_colormap, 'String', {'parula', 'jet', 'hsv', 'hot', ...
    'cool', 'spring', 'summer', 'autumn', 'winter', 'gray', 'bone', ...
    'copper', 'pink', 'lines', 'colorcube', 'prism', 'flag', 'white'})
set(ui_popup_colormap, 'Value', find(strcmpi(pbs.Colormap, get(ui_popup_colormap, 'String'))))
set(ui_popup_colormap, 'HorizontalAlignment', 'center')
set(ui_popup_colormap, 'Callback', {@cb_colormap})

    function cb_colormap(~, ~)  % (src, event)
        val = ui_popup_colormap.Value;
        str = ui_popup_colormap.String;
        pbs.colormap(str{val});
    end

set(f, 'Visible', 'on')
end
function hold_on(pbs)
% HOLD_ON hold on
%
% HOLD_ON(BS) retains the brain surf BS if another graph is
% plotted in the current axes.
%
% See also hold_off.

pbs.set_axes()

hold(pbs.h_axes, 'on')
end
function hold_off(pbs)
% HOLD_OFF hold off
%
% HOLD_OFF(BS) clears the brain surf BS if another graph is
% plotted in the current axes.
%
% See also hold_on.

pbs.set_axes()

hold(pbs.h_axes, 'off')
end
function grid_on(pbs)
% GRID_ON grid on
%
% GRID_ON(BS) adds major grid lines to the current axes.
%
% See also grid_off.

pbs.set_axes()

grid(pbs.h_axes, 'on')
end
function grid_off(pbs)
% GRID_OFF grid off
%
% GRID_OFF(BS) removes grid lines from the current axes.
%
% See also grid_on.

pbs.set_axes()

grid(pbs.h_axes, 'off')
end
function axis_on(pbs)
% AXIS_ON axis on
%
% AXIS_ON(BS) turns on all axis lines, tick marks, and labels.
%
% See also axis_off.

pbs.set_axes()

axis(pbs.h_axes, 'on')
end
function axis_off(pbs)
% AXIS_OFF axis off
%
% AXIS_OFF(BS) turns off all axis lines, tick marks, and labels.
%
% See also axis_on.

pbs.set_axes()

axis(pbs.h_axes, 'off')
end
function axis_equal(pbs)
% AXIS_EQUAL axis equal
%
% AXIS_EQUAL(BS) sets the aspect ratio so that the data units
% are the same in every direction.
%
% See also axis_on, axis_off, axis_tight.

pbs.set_axes()

daspect(pbs.h_axes, [1 1 1])
end
function axis_tight(pbs)
% AXIS_TIGHT axis tight
%
% AXIS_TIGHT(BS) sets the axis limits to the range of the data.
%
% See also axis_on, axis_off, axis_equal.

pbs.set_axes()

axis(pbs.h_axes, 'tight')
end
function view(pbs, v)
% VIEW sets desired view
%
% VIEW(BS, V) sets the desired view of the brain surf BS by
% specifying the numeric code V of the predefined views.
% Acceptable values for V are:
%       PlotBrainSurf.VIEW_3D   -   3D
%       PlotBrainSurf.VIEW_SL   -   sagittal left
%       PlotBrainSurf.VIEW_SR   -   sagittal right
%       PlotBrainSurf.VIEW_AD   -   axial dorsal
%       PlotBrainSurf.VIEW_AV   -   axial ventral
%       PlotBrainSurf.VIEW_CA   -   coronal anterior
%       PlotBrainSurf.VIEW_CP   -   coronal posterior

pbs.set_axes()

if isnumeric(v) && numel(v) == 1
    view(pbs.h_axes, PlotBrainSurf.VIEW_AZEL{v})
else
    view(pbs.h_axes, v)
end
end
function lighting(pbs, Lighting)
% LIGHTING sets the lighting value
%
% LIGHTING(BS, LIGHTING) sets the value of lighting to Lighting.
% Lighting  = 'phong' 'none' 'flat' 'gouraud'
%
% See also material, camlight, shading, colormap.

pbs.Lighting = Lighting;
lighting(pbs.get_axes(), pbs.Lighting)
end
function material(pbs, Material)
% MATERIAL sets the material value
%
% MATERIAL(BS, Material) sets the value material to Material.
% Material  = 'shiny' 'dull' 'metal'
%
% See also lighting, camlight, shading, colormap.

pbs.Material = Material;
material(pbs.get_axes(), pbs.Material)
end
function camlight(pbs, CamLight)
% CAMLIGHT sets the camlight value
%
% CAMLIGHT(BS, CamLight) sets the value of the camera light to CamLight.
% CamLight  = 'headlight' 'right' 'left'
%
% See also lighting, material, shading, colormap.

pbs.CamLight = CamLight;
delete(findall(pbs.h_axes, 'Type', 'light'));
camlight(pbs.get_axes(), pbs.CamLight)
end
function shading(pbs, Shading)
% SHADING sets the shading value
%
% SHADING(BS, Shading) sets the value of shading to Shading.
% Shading   = 'interp' 'none' 'flat' 'faceted'
%
% See also lighting, material, camlight, colormap.

pbs.Shading = Shading;
shading(pbs.get_axes(), pbs.Shading)
end
function colormap(pbs, Colormap)
% COLORMAP sets the colormap value
%
% COLORMAP(BS, Colormap) sets the value of colormap to Colormap.
% Colormap  = 'jet' 'parula' 'jet' 'hsv' 'hot' 'cool'
%             'spring' 'summer' 'autumn' 'winter' 'gray' 'bone'
%             'copper' 'pink' 'lines' 'colorcube' 'prism'
%             'flag' 'white'
%
% See also lighting, material, camlight, shading.

pbs.Colormap= Colormap;
colormap(pbs.get_axes(), pbs.Colormap);
end