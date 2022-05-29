%% ¡header!
PFBrainSurface < PanelFig (pf, panel figure brain surface) is a plot of a brain surfce.

%%% ¡description!
PFBrainSurface manages the plot of the brain surface choosen by the user. 
A collection of brain surfaces in NV format can be found in the folder 
./braph2/brainsurfs/.
This class provides the common methods needed to manage the plot of 
the surface. In particualr, the user can change lighting, material, 
camlight, shadning, colormap, facecolor, brain color, face color, 
edge color, and background color. 

%%% ¡seealso!
PanelFig, BrainSurface

%% ¡constants!
% fixed 3d view
VIEW_3D	= 1 % 3D view numeric code
VIEW_3D_CMD = '3D' % 3D view name
VIEW_3D_AZEL = [-37.5 30] % 3D view azimutal and polar angles

% sagittal left view
VIEW_SL	= 2 % sagittal left view numeric code
VIEW_SL_CMD = 'Sagittal left' % sagittal left view name
VIEW_SL_AZEL = [-90 0] % sagittal left view azimutal and polar angles

% sagittal right view
VIEW_SR	= 3 % sagittal right view numeric code
VIEW_SR_CMD = 'Sagittal right' % sagittal right view name
VIEW_SR_AZEL = [90 0] % sagittal right view azimutal and polar angles 

% axial dorsal view
VIEW_AD = 4 % axial dorsal view numeric code
VIEW_AD_CMD = 'Axial dorsal' % axial dorsal view name
VIEW_AD_AZEL = [0 90] % axial dorsal view azimutal and polar angles

% axial ventral view
VIEW_AV = 5 % axial ventral view numeric code
VIEW_AV_CMD = 'Axial ventral' % axial ventral view name
VIEW_AV_AZEL = [0 -90] % axial ventral view azimutal and polar angles

% coronal anterior view
VIEW_CA = 6 % coronal anterior view numeric code
VIEW_CA_CMD = 'Coronal anterior' % coronal anterior view name
VIEW_CA_AZEL = [180 0] % coronal anterior view azimutal and polar angles

% coronal posterior view
VIEW_CP = 7 % coronal posterior view numeric code
VIEW_CP_CMD = 'Coronal posterior' % coronal posterior view name
VIEW_CP_AZEL = [0 0] % coronal posterior view azimutal and polar angles

VIEW_CMD = { ... % vector of view names
    PFBrainSurface.VIEW_3D_CMD ...
    PFBrainSurface.VIEW_SL_CMD ...
    PFBrainSurface.VIEW_SR_CMD ...
    PFBrainSurface.VIEW_AD_CMD ...
    PFBrainSurface.VIEW_AV_CMD ...
    PFBrainSurface.VIEW_CA_CMD ...
    PFBrainSurface.VIEW_CP_CMD ...
    }

VIEW_AZEL = { ... % vector of view azimutal and polar angle
    PFBrainSurface.VIEW_3D_AZEL ...
    PFBrainSurface.VIEW_SL_AZEL ...
    PFBrainSurface.VIEW_SR_AZEL ...
    PFBrainSurface.VIEW_AD_AZEL ...
    PFBrainSurface.VIEW_AV_AZEL ...
    PFBrainSurface.VIEW_CA_AZEL ...
    PFBrainSurface.VIEW_CP_AZEL ...
    }

%% ¡properties!
p  % handle for panel
h_axes % handle for the axes
h_brain % handle for brain surface

toolbar
tool_brain
tool_axis
tool_grid
tool_view3D
tool_viewSL 
tool_viewSR
tool_viewAD
tool_viewAV
tool_viewCA
tool_viewCP

%% ¡props!

%%% ¡prop!
SURF (metadata, item) is the brain surface to be plotted.
%%%% ¡settings!
'BrainSurface'
%%%% ¡default!
BrainAtlas.getPropDefault('SURF')

%%% ¡prop!
VIEW (figure, rvector) sets the desired view.
%%%% ¡check_prop!
check = length(value) == 2;
%%%% ¡default!
PFBrainSurface.VIEW_SL_AZEL
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('VIEW', varargin)) && check_graphics(pf.h_axes, 'axes')
    view(pf.h_axes, pf.get('VIEW'))
    
    % update state of toggle tools
    set(pf.tool_view3D, 'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_3D_AZEL))
    set(pf.tool_viewSL, 'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_SL_AZEL))
    set(pf.tool_viewSR, 'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_SR_AZEL))
    set(pf.tool_viewAD, 'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_AD_AZEL))
    set(pf.tool_viewAV, 'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_AV_AZEL))
    set(pf.tool_viewCA, 'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_CA_AZEL))
    set(pf.tool_viewCP, 'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_CP_AZEL))
end

%%% ¡prop!
AXISCOLOR (figure, color) is the axis background color.
%%%% ¡default!
[1 1 1]
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('AXISCOLOR', varargin)) && check_graphics(pf.h_axes, 'axes')
    if ~isequal(set(pf.h_axes, 'Color'), pf.get('AXISCOLOR'))
        set(pf.h_axes, 'Color', pf.get('AXISCOLOR'))
    end
end

%%% ¡prop!
HOLD (figure, logical) determines whether hold is on or off.
%%%% ¡default!
true
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('HOLD', varargin)) && check_graphics(pf.h_axes, 'axes')
    if pf.get('HOLD')
        hold(pf.h_axes, 'on')
    else
        hold(pf.h_axes, 'off')
    end
end

%%% ¡prop!
GRID (figure, logical) determines whether the grid is shown.
%%%% ¡default!
false
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('GRID', varargin)) && check_graphics(pf.h_axes, 'axes')
    if pf.get('GRID')
        grid(pf.h_axes, 'on')
    else
        grid(pf.h_axes, 'off')
    end

    % update state of toggle tool
    set(pf.tool_grid, 'State', pf.get('GRID'))
end

%%% ¡prop!
AXIS (figure, logical) determines whether the axis is shown.
%%%% ¡default!
false
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('AXIS', varargin)) && check_graphics(pf.h_axes, 'axes')
    if pf.get('AXIS')
        axis(pf.h_axes, 'on')
    else
        axis(pf.h_axes, 'off')
    end
    
    % update state of toggle tool
    set(pf.tool_axis, 'State', pf.get('AXIS'))
end

%%% ¡prop!
EQUAL (figure, logical) determines whether the axis are equal.
%%%% ¡default!
true
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('EQUAL', varargin)) && check_graphics(pf.h_axes, 'axes')
    if pf.get('EQUAL')
        daspect(pf.h_axes, [1 1 1])
    end
end

%%% ¡prop!
TIGHT (figure, logical) determines whether the axis are tight.
%%%% ¡default!
false
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('TIGHT', varargin)) && check_graphics(pf.h_axes, 'axes')
    if pf.get('TIGHT')
        axis(pf.h_axes, 'tight')
    end
end

%%% ¡prop!
BRAIN (figure, logical) determines whether the brain surface is shown.
%%%% ¡default!
true
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('BRAIN', varargin)) && check_graphics(pf.h_axes, 'axes')
    if pf.get('BRAIN')
        if ~check_graphics(pf.h_brain, 'patch')
            
            triangles = pf.get('SURF').get('TRIANGLES');
            coordinates = pf.get('SURF').get('COORDINATES');
            pf.h_brain = trisurf( ...
                triangles, ...
                coordinates(:, 1), ...
                coordinates(:, 2), ...
                coordinates(:, 3), ...
                'Parent', pf.h_axes ...
                );
            xlabel(pf.h_axes, 'Sagittal')
            ylabel(pf.h_axes, 'Axial')
            zlabel(pf.h_axes, 'Coronal')
            
        elseif ~get(pf.h_brain, 'Visible')
            
            set(pf.h_brain, 'Visible', 'on')
            
        end
    else % ~pf.get('BRAIN') 
        if check_graphics(pf.h_brain, 'patch') && get(pf.h_brain, 'Visible')
            set(pf.h_brain, 'Visible', 'off')
        end
    end
    
    % update state of toggle tool
    set(pf.tool_brain, 'State', pf.get('BRAIN'))
end

%%% ¡prop!
EDGECOLOR (figure, color) is the RGB edge color.
%%%% ¡default!
[0 0 0]
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('EDGECOLOR', varargin)) && check_graphics(pf.h_axes, 'axes') && check_graphics(pf.h_brain, 'patch')
% % %     if ~isequal(set(pf.h_brain, 'EdgeColor'), pf.get('EDGECOLOR'))
        set(pf.h_brain, 'EdgeColor', pf.get('EDGECOLOR'))
% % %     end
end

%%% ¡prop!
EDGEALPHA (figure, alpha) is the edge transparency.
%%%% ¡default!
0
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('EDGEALPHA', varargin)) && check_graphics(pf.h_axes, 'axes') && check_graphics(pf.h_brain, 'patch')
% % %     if ~isequal(set(pf.h_brain, 'EdgeAlpha'), pf.get('EDGEALPHA'))
        set(pf.h_brain, 'EdgeAlpha', pf.get('EDGEALPHA'))
% % %     end
end

%%% ¡prop!
FACECOLOR (figure, color) is the RGB face color.
%%%% ¡default!
[.5 .5 .5]
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('FACECOLOR', varargin)) && check_graphics(pf.h_axes, 'axes') && check_graphics(pf.h_brain, 'patch')
% % %     if ~isequal(set(pf.h_brain, 'FaceColor'), pf.get('FACECOLOR'))
        set(pf.h_brain, 'FaceColor', pf.get('FACECOLOR'))
% % %     end
end

%%% ¡prop!
FACEALPHA (figure, alpha) is the face transparency.
%%%% ¡default!
1
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set('FACEALPHA', varargin)) && check_graphics(pf.h_axes, 'axes') && check_graphics(pf.h_brain, 'patch')
% % %     if ~isequal(set(pf.h_brain, 'FaceAlpha'), pf.get('FACEALPHA'))
        set(pf.h_brain, 'FaceAlpha', pf.get('FACEALPHA'))
% % %     end
end

%%% ¡prop!
LIGHTING (figure, option) is the lighting value.
%%%% ¡settings!
{'none' 'phong' 'flat' 'gouraud'}
%%%% ¡default!
'gouraud'
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set({'LIGHTING', 'MATERIAL', 'CAMLIGHT', 'SHADING', 'COLORMAP'}, varargin)) && check_graphics(pf.h_axes, 'axes')
    lighting(pf.h_axes, pf.get('LIGHTING'))
end

%%% ¡prop!
MATERIAL (figure, option) is the material value.
%%%% ¡settings!
{'shiny' 'dull' 'metal'}
%%%% ¡default!
'shiny'
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set({'LIGHTING', 'MATERIAL', 'CAMLIGHT', 'SHADING', 'COLORMAP'}, varargin)) && check_graphics(pf.h_axes, 'axes')
    material(pf.h_axes, pf.get('MATERIAL'))
end

%%% ¡prop!
CAMLIGHT (figure, option) is the camlight value.
%%%% ¡settings!
{'none' 'headlight' 'right' 'left'}
%%%% ¡default!
'headlight'
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set({'LIGHTING', 'MATERIAL', 'CAMLIGHT', 'SHADING', 'COLORMAP'}, varargin)) && check_graphics(pf.h_axes, 'axes')
    delete(findall(pf.h_axes, 'Type', 'light'));
    if ~strcmpi(pf.get('CAMLIGHT'), 'none')
        camlight(pf.h_axes, pf.get('CAMLIGHT'))
    end
end

%%% ¡prop!
SHADING (figure, option) is the shading value.
%%%% ¡settings!
{'none' 'interp' 'flat' 'faceted'}
%%%% ¡default!
'interp'
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set({'LIGHTING', 'MATERIAL', 'CAMLIGHT', 'SHADING', 'COLORMAP'}, varargin)) && check_graphics(pf.h_axes, 'axes')
    if ~strcmpi(pf.get('SHADING'), 'none')
        shading(pf.h_axes, pf.get('SHADING'))
    end
end

%%% ¡prop!
COLORMAP (figure, option) is the colormap.
%%%% ¡settings!
{'white', 'parula', 'jet', 'hsv', 'hot', 'cool', 'spring', 'summer', 'autumn', 'winter', 'gray', 'bone', 'copper', 'pink', 'lines', 'colorcube', 'prism', 'flag'}
%%%% ¡postprocessing!
if (isempty(varargin) || pf.prop_set({'LIGHTING', 'MATERIAL', 'CAMLIGHT', 'SHADING', 'COLORMAP'}, varargin)) && check_graphics(pf.h_axes, 'axes')
    if ~strcmpi(pf.get('SHADING'), 'none')
        colormap(pf.h_axes, pf.get('COLORMAP'))
    end
end
        
%% ¡methods!
function p_out = draw(pf, varargin)
    %DRAW draws the brain surface graphical panel.
    %
    % DRAW(PF) draws the brain surface graphical panel.
    %
    % P = DRAW(PF) returns a handle to the brain surface graphical panel.
    %
    % DRAW(PF, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel F.
    %
    % see also uipanel.

    pf.p = draw@PanelFig(pf, varargin{:});

    % axes
    if ~check_graphics(pf.h_axes, 'axes')
        pf.h_axes = uiaxes( ...
            'Parent', pf.p, ...
            'Tag', 'h_axes', ...
            'Units', 'normalized', ...
            'OuterPosition', [0 0 1 1] ...
            );
        pf.h_axes.Toolbar.Visible = 'off';
        pf.h_axes.Interactions = [];
% % %         h_3d = rotate3d(pl.h_axes);
% % %         h_3d.ActionPostCallback = @cb_rotate_3d;   
% % %         function cb_rotate_3d(~, ~)
% % %             view_3d = get(pf.h_axes, 'view');
% % %             pf.set('View', view_3d);
% % %         end
    end
    
    % Toolbar
    pf.toolbar = findall(ancestor(pf.p, 'Figure'), 'Tag', 'ToolBar');
    
    if check_graphics(pf.toolbar, 'uitoolbar')
        
        uipushtool(pf.toolbar, 'Separator', 'on', 'Visible', 'off')

        % Brain
        pf.tool_brain = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_brain', ...
            'Separator', 'on', ...
            'State', pf.get('BRAIN'), ...
            'Tooltip', 'Show Brain', ...
            'CData', imresize(imread('icon_brain.png'), [16 16]), ...
            'OnCallback', {@cb_brain, true}, ...
            'OffCallback', {@cb_brain, false});
        
        % Axis
        pf.tool_axis = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_axis', ...
            'State', pf.get('AXIS'), ...
            'Tooltip', 'Show axis', ...
            'CData', imresize(imread('icon_axis.png'), [16 16]), ...
            'OnCallback', {@cb_axis, true}, ...
            'OffCallback', {@cb_axis, false});
        
        % Grid
        pf.tool_grid = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_grid', ...
            'State', pf.get('GRID'), ...
            'Tooltip', 'Show grid', ...
            'CData', imresize(imread('icon_grid.png'), [16 16]), ...
            'OnCallback', {@cb_grid, true}, ...
            'OffCallback', {@cb_grid, false});
    end
    function cb_brain(~, ~, brain) % (src, event)
        pf.set('BRAIN', brain)
    end
    function cb_axis(~, ~, axis) % (src, event)
        pf.set('axis', axis);
    end
    function cb_grid(~, ~, grid) % (src, event)
        pf.set('grid', grid);
    end
    
    if check_graphics(pf.toolbar, 'uitoolbar')

        uipushtool(pf.toolbar, 'Separator', 'on', 'Visible', 'off')
        
        % View 3D
        pf.tool_view3D = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_view3D', ...
            'Separator', 'on', ... 
            'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_3D_AZEL), ...
            'Tooltip', PFBrainSurface.VIEW_3D_CMD, ...
            'CData', imresize(imread('icon_view_3d.png'), [16 16]), ...
            'ClickedCallback', {@cb_view, PFBrainSurface.VIEW_3D_AZEL});

        % View SL
        pf.tool_viewSL = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_viewSL', ...
            'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_SL_AZEL), ...
            'Tooltip', PFBrainSurface.VIEW_SL_CMD, ...
            'CData', imresize(imread('icon_view_sl.png'), [16 16]), ...
            'ClickedCallback', {@cb_view, PFBrainSurface.VIEW_SL_AZEL});

        % View SR
        pf.tool_viewSR = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_viewSR', ...
            'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_SR_AZEL), ...
            'Tooltip', PFBrainSurface.VIEW_SR_CMD, ...
            'CData', imresize(imread('icon_view_sr.png'), [16 16]), ...
            'ClickedCallback', {@cb_view, PFBrainSurface.VIEW_SR_AZEL});

        % View AD
        pf.tool_viewAD = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_viewAD', ...
            'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_AD_AZEL), ...
            'Tooltip', PFBrainSurface.VIEW_AD_CMD, ...
            'CData', imresize(imread('icon_view_ad.png'), [16 16]), ...
            'ClickedCallback', {@cb_view, PFBrainSurface.VIEW_AD_AZEL});

        % View AV
        pf.tool_viewAV = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_viewAV', ...
            'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_AV_AZEL), ...
            'Tooltip', PFBrainSurface.VIEW_AV_CMD, ...
            'CData', imresize(imread('icon_view_av.png'), [16 16]), ...
            'ClickedCallback', {@cb_view, PFBrainSurface.VIEW_AV_AZEL});

        % View CA
        pf.tool_viewCA = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_viewCA', ...
            'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_CA_AZEL), ...
            'Tooltip', PFBrainSurface.VIEW_CA_CMD, ...
            'CData', imresize(imread('icon_view_ca.png'), [16 16]), ...
            'ClickedCallback', {@cb_view, PFBrainSurface.VIEW_CA_AZEL});

        % View CP
        pf.tool_viewCP = uitoggletool(pf.toolbar, ...
            'Tag', 'tool_viewCP', ...
            'State', isequal(pf.get('VIEW'), PFBrainSurface.VIEW_CP_AZEL), ...
            'Tooltip', PFBrainSurface.VIEW_CP_CMD, ...
            'CData', imresize(imread('icon_view_cp.png'), [16 16]), ...
            'ClickedCallback', {@cb_view, PFBrainSurface.VIEW_CP_AZEL});

    end
    function cb_view(~, ~, azel) % (src, event)
        pf.set('VIEW', azel)
    end

    % output
    if nargout > 0
        p_out = pf.p;
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basics
%%%% ¡code!
pf = PFBrainSurface('SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
gui = GUIFig('PF', pf, 'FILE', 'xxx sss', 'CLOSEREQ', false);
f = gui.draw('Units', 'normalized', 'Position', [.1 .1 .8 .8]);

pf.set('FACECOLOR', [1 0 0 ])

pf.set('BRAIN', false)

pf.set('BRAIN', true)

pf.set('GRID', false)

pf.set('GRID', true)

pf.set('AXIS', false)

pf.set('EQUAL', true)

pf.set('TIGHT', true)

pf.set('view', [45 45])

pf.set(...
    'LIGHTING', 'phong', ...
    'MATERIAL', 'shiny', ...
    'CAMLIGHT', 'left', ...
    'SHADING', 'interp', ...
    'COLORMAP', 'autumn')

close(f)