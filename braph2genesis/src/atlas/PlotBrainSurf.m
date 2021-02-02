classdef PlotBrainSurf < handle & matlab.mixin.Copyable
    % PlotBrainSurf Plot and manage a brain surface
    % PlotBrainSurf plots and manages a brain surface.
    % It is a subclass of handle and matlab.mixin.Copyable.
    %
    % PlotBrainSurf manages the brain surface choosen by the user from a
    % collection of surfaces. These brain surfaces are in nv format and
    % in the folder ./braph2/atlas/brainsurfs/.
    % This class provides the common methods needed to manage the plot of 
    % the surface, via a custom panel called 'Brain Surface Settings' where
    % the user can change lighting, material, camlight, shadning, colormap,
    % facecolor, brain color, face color, edge color, and background color. 
    %
    % PlotBrainSurf properties (Constants):
    %   VIEW_3D         -   3D view numeric code
    %   VIEW_3D_CMD     -   3D view name
    %   VIEW_3D_AZEL    -   3D view azimutal and polar angles
    %
    %   VIEW_SL         -   sagittal left view numeric code
    %   VIEW_SL_CMD     -   sagittal left view name
    %   VIEW_SL_AZEL    -   sagittal left view azimutal and polar angles
    %
    %   VIEW_SR         -   sagittal right view numeric code
    %   VIEW_SR_CMD     -   sagittal right view name
    %   VIEW_SR_AZEL    -   Sagittal right view azimutal and polar angles 
    %
    %   VIEW_AD         -   axial dorsal view numeric code
    %   VIEW_AD_CMD     -   axial dorsal view name
    %   VIEW_AD_AZEL    -   axial dorsal view azimutal and polar angles
    %
    %   VIEW_AV         -   axial ventral view numeric code
    %   VIEW_AV_CMD     -   axial ventral view name
    %   VIEW_AV_AZEL    -   axial ventral view azimutal and polar angles
    %
    %   VIEW_CA         -   coronal anterior view numeric code
    %   VIEW_CA_CMD     -   coronal anterior view name
    %   VIEW_CA_AZEL    -   coronal anterior view azimutal and polar angles
    %
    %   VIEW_CP         -   coronal posterior view numeric code
    %   VIEW_CP_CMD     -   coronal posterior view name
    %   VIEW_CP_AZEL    -   coronal posterior view azimutal and polar angles
    %
    %   VIEW_CMD        -   vector of view names
    %
    %   VIEW_AZEL       -   vector of view azimutal and polar angle
    % 
    % PlotBrainSurf basic methods:
    %   PlotBrainSurf        - constructor
    %   tostring             - returns a string representing the surface
    %   disp                 - displays the plot brain surface
    % 
    % PlotBrainSurf graphic methods: 
    %   set_axes             - sets the handle of the axes
    %   get_axes             - gets the handle of the axes
    %   brain                - plots the brain surface
    %   brain_on             - shows the brain surface
    %   brain_off            - hides the brain surface
    %   brain_settings       - creates a panel to control brain surface
    %   hold_on              - retains the brain surface
    %   hold_off             - clears the bran surface
    %   grid_on              - turns the grid visible
    %   grid_off             - turns the grid invisible
    %   axis_on              - turns the axis visible
    %   axis_off             - turns the axis invisible
    %   axis_equal           - turns the axis aspect ratio equal to the data
    %   axis_tight           - turns the axis limit to the range of data
    %   view                 - sets the desired angle of view
    %   lighting             - sets the light configuration
    %   material             - sets the material configuration
    %   camlight             - sets the camlight configuration
    %   shading              - sets the shading configuration 
    %   colormap             - sets the colormap configuration
    %
    % See also handle, matlab.mixin.Copyable, BrainAtlas, PlotBrainAtlas, PlotBrainGraph.
    
    properties (Constant)
        % fixed 3d view
        VIEW_3D	= 1
        VIEW_3D_CMD = '3D'
        VIEW_3D_AZEL = [-37.5 30]
        
        % sagittal left view
        VIEW_SL	= 2
        VIEW_SL_CMD = 'Sagittal left'
        VIEW_SL_AZEL = [-90 0]
        
        % sagittal right view
        VIEW_SR	= 3
        VIEW_SR_CMD = 'Sagittal right'
        VIEW_SR_AZEL = [90 0]
        
        % axial dorsal view
        VIEW_AD = 4
        VIEW_AD_CMD = 'Axial dorsal'
        VIEW_AD_AZEL = [0 90]
        
        % axial ventral view
        VIEW_AV = 5
        VIEW_AV_CMD = 'Axial ventral'
        VIEW_AV_AZEL = [0 -90]
        
        % coronal anterior view
        VIEW_CA = 6
        VIEW_CA_CMD = 'Coronal anterior'
        VIEW_CA_AZEL = [180 0]
        
        % coronal posterior view
        VIEW_CP = 7
        VIEW_CP_CMD = 'Coronal posterior'
        VIEW_CP_AZEL = [0 0]
        
        VIEW_CMD = { ...
            PlotBrainSurf.VIEW_3D_CMD ...
            PlotBrainSurf.VIEW_SL_CMD ...
            PlotBrainSurf.VIEW_SR_CMD ...
            PlotBrainSurf.VIEW_AD_CMD ...
            PlotBrainSurf.VIEW_AV_CMD ...
            PlotBrainSurf.VIEW_CA_CMD ...
            PlotBrainSurf.VIEW_CP_CMD ...
            }
        
        VIEW_AZEL = { ...
            PlotBrainSurf.VIEW_3D_AZEL ...
            PlotBrainSurf.VIEW_SL_AZEL ...
            PlotBrainSurf.VIEW_SR_AZEL ...
            PlotBrainSurf.VIEW_AD_AZEL ...
            PlotBrainSurf.VIEW_AV_AZEL ...
            PlotBrainSurf.VIEW_CA_AZEL ...
            PlotBrainSurf.VIEW_CP_AZEL ...
            }
    end
    properties (Access = protected)
        % brain surf
        brain_surface
        
        h_axes  % handle for the axes
        h_brain  % handle for brain surface
        f_brain_settings  % brain setting figure handle
        
        Lighting  % lighting value
        Material  % material value
        CamLight  % camlight value
        Shading  % shading value
        Colormap  % colormap value
    end
    methods  % Basic functions
        function bs = PlotBrainSurf(brain_surf, varargin)
            % PLOTBRAINSURF constructor 
            %
            % PLOTBRAINSURF(BRAIN_SURF_FILE) construct the brain surface
            % object, with default settings.
            %            
            % PLOTBRAINSURF(BRAIN_SURF_FILE, 'Property', VALUE, ...) construct
            % the brain surface object with custom property-value couples.
            % Admissible properties and values are:
            % Lighting  = 'phong' (default) 'none' 'flat' 'gouraud'
            % Material  = 'shiny' (default) 'dull' 'metal'
            % CamLight  = 'headlight' (default) 'right' 'left'
            % Shading   = 'interp' (default) 'none' 'flat' 'faceted'
            % Colormap  = 'jet' (default) 'parula' 'jet' 'hsv' 'hot' 'cool'
            %             'spring' 'summer' 'autumn' 'winter' 'gray' 'bone'
            %             'copper' 'pink' 'lines' 'colorcube' 'prism'
            %             'flag' 'white'
            %
            % See also BrainAtlas, PlotBrainAtlas, PlotBrainGraph. 
            
            bs.setBrainSurf(brain_surf);
            bs.Lighting = get_from_varargin('Phong', 'Lighting', varargin);  % 'none', 'flat', 'phong', 'gouraud'
            bs.Material = get_from_varargin('Shiny', 'Material', varargin);  % 'dull', 'shiny', 'metal'
            bs.CamLight = get_from_varargin('HeadLight', 'CamLight', varargin);  % 'headlight', 'right', 'left'
            bs.Shading = get_from_varargin('Interp', 'Shading', varargin);  % 'none', 'flat', 'faceted', 'interp'
            bs.Colormap = get_from_varargin('Jet', 'Colormap', varargin);
        end
        function str = tostring(bs)
            % TOSTRING string with information about brain surface properties
            %
            % STR = TOSTRING(BS) returns string with the brain surface file
            % and the number of vertices and triangles.
            %
            % See also disp.
            
            str = [class(bs) ': ' bs.getBrainSurfFile() ' with ' tostring(bs.brain_surface.get('vertex_number')) ' vertices and ' tostring(bs.brain_surface.get('triangles_number')) ' triangles.'];
        end
        function disp(bs)
            % DISP displays brain surface properties
            %
            % DISP(BS) displays the brain surface class, brain surf file,
            % and the number of vertices and triangles.
            %
            % See also tostring.
            
            disp(['<a href="matlab:help ' class(bs) '">' class(bs) '</a>']);
            disp(['Surface file: ' bs.getBrainSurfFile()]);
            disp(['Number of vertices: ' tostring(bs.brain_surface.get('vertex_number'))]);
            disp(['Number of triangles: ' tostring(bs.brain_surface.get('triangles_number'))]);
        end  
        function brain_surf_file = getBrainSurfFile(bs)
            % GETBRAINSURFFILE returns the brain surface file
            %
            % BRAIN_SURF_FILE = GETBRAINSURFFILE(BS) gets the name of the
            % brain surface file.
            
            brain_surf_file = bs.brain_surf.get('ID');
        end 
    end
    methods (Access = protected) % Set Brain Surf File
        function setBrainSurf(bs, brain_surf)
            % SETBRAINSURF reads the brain surf file and sets the data
            %
            % SETBRAINSURFFILE(BS, BRAIN_SURF_FILE) reads the brain surf
            % file and loads the data.
            %
            % See getBrainSurfFile.
            
            bs.brain_surface = brain_surf;   
            
            if bs.brain_surface.get('vertex_number') == 0
                im = ImporterBrainSurfaceNV('File', [fileparts(which('braph2')) filesep 'brainsurfs' filesep bs.brain_surface.get('id')]); 
                bs.brain_surface = im.get('bs');
            end           
        end
    end
    methods  % Graphic functions
        function h = set_axes(bs, ht)
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
            
            if isempty(bs.h_axes) || ~ishandle(bs.h_axes)
                if nargin < 2
                    ht = gca;
                end
                bs.h_axes = ht;
            end
            
            if nargout > 0
                h = ht;
            end
        end
        function h = get_axes(bs)
            % GET_AXES gets current axes
            %
            % H = GET_AXES(BS) returns a handle to the axes used to plot
            % the brain surf.
            %
            % See also set_axes.
            
            h = bs.h_axes;
        end
        function h = brain(bs, varargin)
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
            
            bs.set_axes()
            
            % plot brain surface
            if isempty(bs.h_brain) || ~ishandle(bs.h_brain)
                
                coords = bs.brain_surface.get('coordinates');
                
                bs.h_brain = trisurf( ...
                    bs.brain_surface.get('triangles'), ...
                    coords(1, :), ...
                    coords(2, :), ...
                    coords(3, :), ...
                    'Parent', bs.get_axes(), ...
                    'EdgeColor', 'none', ...
                    'EdgeAlpha', .5, ...
                    'FaceColor', [.5 .5 .5], ...
                    'FaceAlpha', .5 ...
                    );
                bs.lighting(bs.Lighting);
                bs.material(bs.Material);
                bs.camlight(bs.CamLight);
                bs.shading(bs.Shading);
                bs.colormap(bs.Colormap);
            end
            
            % sets properties
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'color'
                        set(bs.h_brain, 'FaceColor', varargin{n + 1});
                        set(bs.h_brain, 'EdgeColor', varargin{n + 1});
                    case 'alpha'
                        set(bs.h_brain, 'FaceAlpha', varargin{n + 1});
                        set(bs.h_brain, 'EdgeAlpha', varargin{n + 1});
                    case 'lighting'
                        bs.lighting(varargin{n + 1});
                    case 'material'
                        bs.material(varargin{n + 1});
                    case 'camlight'
                        bs.camlight(varargin{n + 1});
                    case 'shading'
                        bs.shading(varargin{n + 1});
                    case 'colormap'
                        bs.colormap(varargin{n + 1});
                    otherwise
                        set(bs.h_brain, varargin{n}, varargin{n + 1});
                end
            end
            
            % output if needed
            if nargout > 0
                h = bs.h_brain;
            end
        end
        function brain_on(bs)
            % BRAIN_ON shows brain surf
            %
            % BRAIN_ON(BS) shows the brain surf BS.
            %
            % See also brain, brain_off.
            
            if ~isempty(bs.h_brain)
                set(bs.h_brain, 'Visible', 'on')
            end
        end
        function brain_off(bs)
            % BRAIN_OFF hides brain surf
            %
            % BRAIN_OFF(BS) hides the brain surf BS.
            %
            % See also brain, brain_on.
            
            if ~isempty(bs.h_brain)
                set(bs.h_brain,'Visible','off')
            end
        end
        function brain_settings(bs, varargin)
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
            FigColor = get_from_varargin([.95 .95 .95], 'figcolor', varargin);
            FigName = get_from_varargin('Brain Surface Settings', 'figname', varargin);
            
            % create a figure
            if isempty(bs.f_brain_settings) || ~ishandle(bs.f_brain_settings)
                bs.f_brain_settings = figure('Visible', 'off');
            end
            f = bs.f_brain_settings;
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
                    set(bs.get_axes(), 'Color', color)
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
            set(ui_slider_alpha, 'Min', 0, 'Max', 1, 'Value', max(get(bs.brain, 'FaceAlpha'), get(bs.brain, 'EdgeAlpha')))
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
            set(ui_slider_facealpha, 'Min', 0, 'Max', 1, 'Value', get(bs.brain,'FaceAlpha'))
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
            set(ui_slider_edgealpha, 'Min', 0, 'Max', 1, 'Value', get(bs.brain, 'EdgeAlpha'))
            set(ui_slider_edgealpha, 'TooltipString', 'Brain surface edge transparency')
            set(ui_slider_edgealpha, 'Callback', {@cb_edgealpha})
            
            function cb_color(~, ~)  % (src, event)
                color = uisetcolor;
                if length(color) == 3
                    bs.brain('Color', color)
                end
            end
            function cb_alpha(~, ~)  % (src, event)
                bs.brain('Alpha', get(ui_slider_alpha, 'Value'))
                set(ui_slider_facealpha, 'Value', get(ui_slider_alpha, 'Value'))
                set(ui_slider_edgealpha, 'Value', get(ui_slider_alpha, 'Value'))
            end
            function cb_facecolor(~, ~)  % (src, event)
                color = uisetcolor;
                if length(color) == 3
                    bs.brain('FaceColor', color)
                end
            end
            function cb_facealpha(~, ~)  % (src, event)
                bs.brain('FaceAlpha', get(ui_slider_facealpha, 'Value'))
            end
            function cb_edgecolor(~, ~)  % (src, event)
                color = uisetcolor;
                if length(color) == 3
                    bs.brain('EdgeColor', color)
                end
            end
            function cb_edgealpha(~, ~)  % (src, event)
                bs.brain('EdgeAlpha', get(ui_slider_edgealpha, 'Value'))
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
            set(ui_popup_lighting, 'Value', find(strcmpi(bs.Lighting, get(ui_popup_lighting, 'String'))))
            set(ui_popup_lighting, 'HorizontalAlignment', 'center')
            set(ui_popup_lighting, 'Callback', {@cb_lighting})
            
            function cb_lighting(~, ~)  % (src, event)
                val = ui_popup_lighting.Value;
                str = ui_popup_lighting.String;
                bs.lighting(str{val});
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
            set(ui_popup_material, 'Value', find(strcmpi(bs.Material, get(ui_popup_material, 'String'))))
            set(ui_popup_material, 'HorizontalAlignment', 'center')
            set(ui_popup_material, 'Callback', {@cb_material})

            function cb_material(~, ~)  % (src, event)
                val = ui_popup_material.Value;
                str = ui_popup_material.String;
                bs.material(str{val});
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
            set(ui_popup_camlight, 'Value', find(strcmpi(bs.CamLight, get(ui_popup_camlight, 'String'))))
            set(ui_popup_camlight, 'HorizontalAlignment', 'center')
            set(ui_popup_camlight, 'Callback', {@cb_camlight})
            
            function cb_camlight(~, ~)  % (src, event)
                val = ui_popup_camlight.Value;
                str = ui_popup_camlight.String;
                bs.camlight(str{val});
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
            set(ui_popup_shading, 'Value', find(strcmpi(bs.Shading, get(ui_popup_shading, 'String'))))
            set(ui_popup_shading, 'HorizontalAlignment', 'center')
            set(ui_popup_shading, 'Callback', {@cb_shading})
            
            function cb_shading(~, ~)  % (src, event)
                val = ui_popup_shading.Value;
                str = ui_popup_shading.String;
                bs.shading(str{val});
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
            set(ui_popup_colormap, 'Value', find(strcmpi(bs.Colormap, get(ui_popup_colormap, 'String'))))
            set(ui_popup_colormap, 'HorizontalAlignment', 'center')
            set(ui_popup_colormap, 'Callback', {@cb_colormap})
            
            function cb_colormap(~, ~)  % (src, event)
                val = ui_popup_colormap.Value;
                str = ui_popup_colormap.String;
                bs.colormap(str{val});
            end
            
            set(f, 'Visible', 'on')
        end
        function hold_on(bs)
            % HOLD_ON hold on
            %
            % HOLD_ON(BS) retains the brain surf BS if another graph is
            % plotted in the current axes.
            %
            % See also hold_off.
            
            bs.set_axes()
            
            hold(bs.h_axes, 'on')
        end
        function hold_off(bs)
            % HOLD_OFF hold off
            %
            % HOLD_OFF(BS) clears the brain surf BS if another graph is
            % plotted in the current axes.
            %
            % See also hold_on.
            
            bs.set_axes()
            
            hold(bs.h_axes, 'off')
        end
        function grid_on(bs)
            % GRID_ON grid on
            %
            % GRID_ON(BS) adds major grid lines to the current axes.
            %
            % See also grid_off.
            
            bs.set_axes()
            
            grid(bs.h_axes, 'on')
        end
        function grid_off(bs)
            % GRID_OFF grid off
            %
            % GRID_OFF(BS) removes grid lines from the current axes.
            %
            % See also grid_on.
            
            bs.set_axes()
            
            grid(bs.h_axes, 'off')
        end
        function axis_on(bs)
            % AXIS_ON axis on
            %
            % AXIS_ON(BS) turns on all axis lines, tick marks, and labels.
            %
            % See also axis_off.
            
            bs.set_axes()
            
            axis(bs.h_axes, 'on')
        end
        function axis_off(bs)
            % AXIS_OFF axis off
            %
            % AXIS_OFF(BS) turns off all axis lines, tick marks, and labels.
            %
            % See also axis_on.
            
            bs.set_axes()
            
            axis(bs.h_axes, 'off')
        end
        function axis_equal(bs)
            % AXIS_EQUAL axis equal
            %
            % AXIS_EQUAL(BS) sets the aspect ratio so that the data units
            % are the same in every direction.
            %
            % See also axis_on, axis_off, axis_tight.
            
            bs.set_axes()
            
            daspect(bs.h_axes, [1 1 1])
        end
        function axis_tight(bs)
            % AXIS_TIGHT axis tight
            %
            % AXIS_TIGHT(BS) sets the axis limits to the range of the data.
            %
            % See also axis_on, axis_off, axis_equal.
            
            bs.set_axes()
            
            axis(bs.h_axes, 'tight')
        end
        function view(bs, v)
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
            
            bs.set_axes()
            
            if isnumeric(v) && numel(v) == 1
                view(bs.h_axes, PlotBrainSurf.VIEW_AZEL{v})
            else
                view(bs.h_axes, v)
            end
        end
        function lighting(bs, Lighting)
            % LIGHTING sets the lighting value
            %
            % LIGHTING(BS, LIGHTING) sets the value of lighting to Lighting.
            % Lighting  = 'phong' 'none' 'flat' 'gouraud'
            %
            % See also material, camlight, shading, colormap.
            
            bs.Lighting = Lighting;
            lighting(bs.get_axes(), bs.Lighting)
        end
        function material(bs, Material)
            % MATERIAL sets the material value
            %
            % MATERIAL(BS, Material) sets the value material to Material.
            % Material  = 'shiny' 'dull' 'metal'
            %
            % See also lighting, camlight, shading, colormap.
            
            bs.Material = Material;
            material(bs.get_axes(), bs.Material)
        end
        function camlight(bs, CamLight)
            % CAMLIGHT sets the camlight value
            %
            % CAMLIGHT(BS, CamLight) sets the value of the camera light to CamLight.
            % CamLight  = 'headlight' 'right' 'left'
            %
            % See also lighting, material, shading, colormap.
            
            bs.CamLight = CamLight;
            delete(findall(bs.h_axes, 'Type', 'light'));
            camlight(bs.get_axes(), bs.CamLight)
        end
        function shading(bs, Shading)
            % SHADING sets the shading value
            %
            % SHADING(BS, Shading) sets the value of shading to Shading.
            % Shading   = 'interp' 'none' 'flat' 'faceted'
            %
            % See also lighting, material, camlight, colormap.
            
            bs.Shading = Shading;
            shading(bs.get_axes(), bs.Shading)
        end
        function colormap(bs, Colormap)
            % COLORMAP sets the colormap value
            %
            % COLORMAP(BS, Colormap) sets the value of colormap to Colormap.
            % Colormap  = 'jet' 'parula' 'jet' 'hsv' 'hot' 'cool'
            %             'spring' 'summer' 'autumn' 'winter' 'gray' 'bone'
            %             'copper' 'pink' 'lines' 'colorcube' 'prism'
            %             'flag' 'white'
            %
            % See also lighting, material, camlight, shading.
            
            bs.Colormap= Colormap;
            colormap(bs.get_axes(), bs.Colormap);
        end
    end
end