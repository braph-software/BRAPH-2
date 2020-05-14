classdef PlotBrainSurf < handle & matlab.mixin.Copyable
    % PlotBrainSurf < handle & matlab.mixin.Copyable : Plot of a brain surface
    %   PlotBrainSurf plots and manages a brain surface.
    %   The brain surface is based on ICBM152
    %   and is loaded from the file BrainMesh_ICBM152.nv.
    %
    
    properties (Constant)
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
        h_axes  % handle for the axes
        Lighting
        Material
        CamLight
        
        h_brain  % handle for brain surface
        brain_surface_type  % type of the brain surface
        f_brain_settings  % brain setting figure handle
        
        % brain coordinates
        vertex_number  % number of vertices of brain surface
        coord  % coordinates of the vertices of brain surface
        ntri  % number of triangles of brain surface
        tri  % triangles of brain surface

        % settings
        settings
    end
    methods  % Basic Functions
        function bs = PlotBrainSurf(varargin)
            
            available_settings = PlotBrainSurf.getAvailableSettings();
            settings = cell(length(available_settings), length(available_settings{1, 1}) - 2);
            for i = 1:1:length(available_settings)
                a_s = available_settings{i};
                available_setting_code = a_s{1, 1};
                available_setting_default = a_s{1, 3};
                settings{i, 1} = available_setting_code;
                settings{i, 2} = get_from_varargin(available_setting_default, available_setting_code, varargin{:});
            end
            bs.settings = settings;

            brain_surface_type = get_from_varargin('BrainMesh_ICBM152.nv' , 'BrainSurfaceType', varargin(:));
            bs.setSurface(brain_surface_type);
        end
        function str = tostring(bs)
            str = ['Brain Surface of type: ' bs.brain_surface_type '.'];
        end
        function disp(bs)
            % DISP displays brain surface
            %
            % DISP(BS) displays the brain surface BP on the command line.
            %
            % See also PlotBrainSurf.
            
            disp(['<a href="matlab:help ' class(bs) '">' bs.getName() '</a>']);
        end
        function name = getName(bs)  % (bs)
            % NAME brain surface name
            %
            % TXT = NAME() gets the brain surface BS's name.
            %
            % See also PlotBrainSurf.
            
            name = bs.brain_surface_type;
        end
    end
    methods  % Inspection functions
        function res = getSettings(bs, setting_code)
            if nargin<2
                res = bs.settings;
            else
                for i = 1:1:length(bs.settings)
                    if isequal(bs.settings{i, 1}, setting_code)
                        res = get_from_varargin([], setting_code, bs.settings{i, :});
                    end
                end
            end
        end
        function brain_surface = getBrainSurface(bs)
            brain_surface = bs.h_brain;
        end
    end
    methods  % editing functions
        function setSurface(bs, brain_surface_type)
            
            bs.brain_surface_type =  brain_surface_type;
            bs.Lighting = bs.getSettings('PlotBrainSurf.Lighting');
            bs.Material = bs.getSettings('PlotBrainSurf.Material');
            bs.CamLight = bs.getSettings('PlotBrainSurf.CamLight');
            
            fid = fopen(['brainsurfs' filesep brain_surface_type]);
            bs.vertex_number = fscanf(fid, '%f', 1);
            bs.coord = fscanf(fid, '%f', [3, bs.vertex_number]);
            bs.ntri = fscanf(fid, '%f', 1);
            bs.tri = fscanf(fid, '%d', [3, bs.ntri])';
            fclose(fid);            
        
        end
        function h = set_axes(bs, ht)
            % SET_AXES sets current axes
            %
            % SET_AXES(BS,HT) set the axes to plot the brain surface BS.
            %   If an axes is not entered as an input argument HT, the
            %   current axes is used for plotting.
            %
            % H = SET_AXES(BS) returns a handle to the axes used to plot
            %   the brain surface BS.
            %
            % See also PlotBrainSurf, gca.
            
            if isempty(bs.h_axes) || ~ishandle(bs.h_axes)
                
                if nargin<2
                    ht = gca;
                end
                
                bs.h_axes = ht;
            end
            
            if nargout>0
                h = ht;
            end
        end
        function h = get_axes(bs)
            % GET_AXES gets current axes
            %
            % H = GET_AXES(BS) returns a handle to the axes used to plot
            %   the brain surface BS.
            %
            % See also PlotBrainSurf, axes.
            
            h = bs.h_axes;
        end
        function h = brain(bs, varargin)
            % BRAIN plots brain surface
            %
            % BRAIN(BS) plots the brain surface if not plotted.
            %
            % H = BRAIN(BS) returns the handle to the brain surface BS.
            %
            % BRAIN(BS,'PropertyName',PropertyValue) sets the property
            %   of the brain surface PropertyName to PropertyValue.
            %   All standard plot properties of trisurf can be used.
            %   The brain surface properties can also be changed when hidden.
            %
            % BRAIN(BS,'Color',COLOR) sets the color of the faces and
            %   edges of the brain surface to COLOR.
            %
            % See also PlotBrainSurf, trisurf.
            
            bs.set_axes()

            % plot brain surface
            if isempty(bs.h_brain) || ~ishandle(bs.h_brain)
                
                bs.h_brain = trisurf( ...
                    bs.tri, ...
                    bs.coord(1,:), ...
                    bs.coord(2,:), ...
                    bs.coord(3,:), ...
                    'Parent', bs.get_axes(), ...
                    'EdgeColor', 'none', ...
                    'EdgeAlpha', .5, ...
                    'FaceColor', [.5 .5 .5], ...
                    'FaceAlpha', .5 ...
                    );
            end
            
            % sets properties
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'color'
                        set(bs.h_brain,'FaceColor', varargin{n+1});
                        set(bs.h_brain,'EdgeColor', varargin{n+1});  
                    case 'alpha'
                        set(bs.h_brain,'FaceAlpha', varargin{n+1});
                        set(bs.h_brain,'EdgeAlpha', varargin{n+1});

                    otherwise
                        set(bs.h_brain,varargin{n},varargin{n+1});
                end
            end
            
            % output if needed
            if nargout>0
                h = bs.h_brain;
            end
        end
        function brain_on(bs)
            % BRAIN_ON shows brain surface
            %
            % BRAIN_ON(BS) shows the brain surface BS.
            %
            % See also PlotBrainSurf.
            
            if ~isempty(bs.h_brain)
                set(bs.h_brain, 'Visible', 'on')
            end
        end
        function brain_off(bs)
            % BRAIN_OFF hides brain surface
            %
            % BRAIN_OFF(BS) hides the brain surface BS.
            %
            % See also PlotBrainSurf.
            
            if ~isempty(bs.h_brain)
                set(bs.h_brain,'Visible','off')
            end
        end
        function brain_settings(bs, varargin)
            % BRAIN_SETTINGS sets brain surface's properties
            %
            % BRAIN_SETTINGS(BS) allows the user to specify the properties
            %   of the brain surface by opening a graphical user interface.
            %
            % BRAIN_SETTINGS(BS,'PropertyName',PropertyValue) sets the property
            %   of the user interface's PropertyName to PropertyValue.
            %   Admissible properties are:
            %       FigPosition   -  position of the user interface on the screen
            %       FigColor      -  background color of the user interface
            %       FigName       -  name of the user interface
            %
            % See also PlotBrainSurf, trisurf.
            
            % sets position of figure
            FigPosition = [.70 .50 .25 .25];
            FigColor = [.95 .95 .95];  % GUI.BKGCOLOR;
            FigName = 'Brain Surface Settings';
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'figposition'
                        FigPosition = varargin{n+1};
                    case 'figcolor'
                        FigColor = varargin{n+1};
                    case 'figname'
                        FigName = varargin{n+1};
                end
            end
            
            % create a figure
            if isempty(bs.f_brain_settings) || ~ishandle(bs.f_brain_settings)
                bs.f_brain_settings = figure('Visible','off');
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
            
            ui_text = uicontrol(f, 'Style', 'text');
            set(ui_text,'Units','normalized')
            set(ui_text,'BackgroundColor', [.95 .95 .95])
             
            set(ui_text, 'String', 'transparency')
            set(ui_text, 'Position', [.35 .70 .65 .15])
            set(ui_text, 'HorizontalAlignment', 'center')
            set(ui_text, 'FontWeight', 'bold')
            
            ui_button_color = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_color,'Units','normalized')
            set(ui_button_color,'BackgroundColor', [.95 .95 .95])            
            set(ui_button_color, 'Position', [.05 .50 .25 .15])
            set(ui_button_color, 'String', 'brain color')
            set(ui_button_color, 'HorizontalAlignment', 'center')
            set(ui_button_color, 'TooltipString', 'Brain surface color (applied both to faces and edges)')
            set(ui_button_color, 'Callback', {@cb_color})
            
            ui_slider_alpha = uicontrol(f, 'Style', 'slider');
            set(ui_slider_alpha,'Units','normalized')
            set(ui_slider_alpha,'BackgroundColor', [.95 .95 .95])
            set(ui_slider_alpha, 'Position', [.40 .50 .55 .15])
            set(ui_slider_alpha,'String', 'Brain transparency')
            set(ui_slider_alpha, 'Min', 0, 'Max', 1, 'Value', max(get(bs.brain, 'FaceAlpha'), get(bs.brain, 'EdgeAlpha')))
            set(ui_slider_alpha, 'TooltipString', 'Brain surface transparency (applied both to faces and edges)')
            set(ui_slider_alpha, 'Callback', {@cb_alpha})
            
            ui_button_facecolor = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_facecolor,'Units','normalized')
            set(ui_button_facecolor,'BackgroundColor', [.95 .95 .95])
            set(ui_button_facecolor, 'Position', [.05 .30 .25 .15])
            set(ui_button_facecolor, 'String', 'face color')
            set(ui_button_facecolor, 'HorizontalAlignment', 'center')
            set(ui_button_facecolor, 'TooltipString', 'Brain surface face color')
            set(ui_button_facecolor, 'Callback', {@cb_facecolor})
            
            ui_slider_facealpha = uicontrol(f, 'Style', 'slider');
            set(ui_slider_facealpha,'Units','normalized')
            set(ui_slider_facealpha,'BackgroundColor', [.95 .95 .95])
            set(ui_slider_facealpha, 'Position', [.40 .30 .55 .15])
            set(ui_slider_facealpha, 'String', 'Brain transparency')
            set(ui_slider_facealpha, 'Min', 0, 'Max', 1, 'Value', get(bs.brain,'FaceAlpha'))
            set(ui_slider_facealpha, 'TooltipString', 'Brain surface face transparency')
            set(ui_slider_facealpha, 'Callback', {@cb_facealpha})
            
            ui_button_edgecolor = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_edgecolor,'Units','normalized')
            set(ui_button_edgecolor,'BackgroundColor', [.95 .95 .95])
            set(ui_button_edgecolor, 'Position', [.05 .10 .25 .15])
            set(ui_button_edgecolor, 'String', 'edge color')
            set(ui_button_edgecolor, 'HorizontalAlignment', 'center')
            set(ui_button_edgecolor, 'TooltipString', 'Brain surface edge color')
            set(ui_button_edgecolor, 'Callback',{@cb_edgecolor})
            
            ui_slider_edgealpha = uicontrol(f, 'Style', 'slider');
            set(ui_slider_edgealpha,'Units','normalized')
            set(ui_slider_edgealpha,'BackgroundColor', [.95 .95 .95])
            set(ui_slider_edgealpha, 'Position', [.40 .10 .55 .15])
            set(ui_slider_edgealpha, 'String', 'Brain transparency')
            set(ui_slider_edgealpha, 'Min', 0, 'Max', 1, 'Value', get(bs.brain, 'EdgeAlpha'))
            set(ui_slider_edgealpha, 'TooltipString', 'Brain surface edge transparency')
            set(ui_slider_edgealpha, 'Callback', {@cb_edgealpha})

            set(f,'Visible','on')
            
            function cb_color(~,~)  % (src,event)
                color = uisetcolor;
                if length(color)==3
                    bs.brain('Color', color)
                end
            end
            
            function cb_alpha(~,~)  % (src,event)
                bs.brain('Alpha', get(ui_slider_alpha, 'Value'))
                set(ui_slider_facealpha, 'Value', get(ui_slider_alpha, 'Value'))
                set(ui_slider_edgealpha, 'Value', get(ui_slider_alpha, 'Value'))
            end
            
            function cb_facecolor(~,~)  % (src,event)
                color = uisetcolor;
                if length(color) == 3
                    bs.brain('FaceColor', color)
                end
            end
            
            function cb_facealpha(~,~)  % (src,event)
                bs.brain('FaceAlpha', get(ui_slider_facealpha, 'Value'))
            end
            
            function cb_edgecolor(~,~)  % (src,event)
                color = uisetcolor;
                if length(color) == 3
                    bs.brain('EdgeColor', color)
                end
            end
            
            function cb_edgealpha(~,~)  % (src,event)
                bs.brain('EdgeAlpha', get(ui_slider_edgealpha, 'Value'))
            end
            
        end
        function hold_on(bs)
            % HOLD_ON hold on
            %
            % HOLD_ON(BS) retains the brain surface BS if another graph is
            %   plotted in the current axes.
            %
            % See also PlotBrainSurf, hold.
            
            bs.set_axes()
            
            hold(bs.h_axes, 'on')
        end
        function hold_off(bs)
            % HOLD_OFF hold off
            %
            % HOLD_OFF(BS) clears the brain surface BS if another graph is
            %   plotted in the current axes.
            %
            % See also PlotBrainSurf, hold.
            
            bs.set_axes()
            
            hold(bs.h_axes, 'off')
        end
        function grid_on(bs)
            % GRID_ON grid on
            %
            % GRID_ON(BS) adds major grid lines to the current axes.
            %
            % See also PlotBrainSurf, grid.
            
            bs.set_axes()
            
            grid(bs.h_axes, 'on')
        end
        function grid_off(bs)
            % GRID_OFF grid off
            %
            % GRID_OFF(BS) removes grid lines from the current axes.
            %
            % See also PlotBrainSurf, grid.
            
            bs.set_axes()
            
            grid(bs.h_axes, 'off')
        end
        function axis_on(bs)
            % AXIS_ON axis on
            %
            % AXIS_ON(BS) turns on all axis lines, tick marks, and labels.
            %
            % See also PlotBrainSurf, axis.
            
            bs.set_axes()
            
            axis(bs.h_axes, 'on')
        end
        function axis_off(bs)
            % AXIS_OFF axis off
            %
            % AXIS_OFF(BS) turns off all axis lines, tick marks, and labels.
            %
            % See also PlotBrainSurf, axis.
            
            bs.set_axes()
            
            axis(bs.h_axes, 'off')
        end
        function axis_equal(bs)
            % AXIS_EQUAL axis equal
            %
            % AXIS_EQUAL(BS) sets the aspect ratio so that the data units
            %   are the same in every direction.
            %
            % See also PlotBrainSurf, axis.
            
            bs.set_axes()
            
            daspect(bs.h_axes, [1 1 1])
        end
        function axis_tight(bs)
            % AXIS_TIGHT axis tight
            %
            % AXIS_TIGHT(BS) sets the axis limits to the range of the data.
            %
            % See also PlotBrainSurf, axis.
            
            bs.set_axes()
            
            axis(bs.h_axes, 'tight')
        end
        function view(bs, v)
            % VIEW sets desired view
            %
            % VIEW(BS,V) sets the desired view of the brain surface BS by
            %   specifying the numeric code V of the predefined views.
            %   Acceptable values for V are:
            %       PlotBrainSurf.VIEW_3D   -   3D
            %       PlotBrainSurf.VIEW_SL   -   sagittal left
            %       PlotBrainSurf.VIEW_SR   -   sagittal right
            %       PlotBrainSurf.VIEW_AD   -   axial dorsal
            %       PlotBrainSurf.VIEW_AV   -   axial ventral
            %       PlotBrainSurf.VIEW_CA   -   coronal anterior
            %       PlotBrainSurf.VIEW_CP   -   coronal posterior
            %
            % See also PlotBrainSurf, view.
            
            bs.set_axes()
            
            view(bs.h_axes, PlotBrainSurf.VIEW_AZEL{v})
        end
        function update_light(bs, varargin)
            % UPDATE_LIGHT sets lighting properties
            %
            % UPDATE_LIGHT(BS) sets the algorithm used to calculate the
            %   effects of light on brain surface BS, sets the lighting
            %   characteristics of brain surface BS and creates light object
            %   in camera coordinates.
            %
            % UPDATE_LIGHT(BS,'PropertyName',PropertyValue) sets the light
            %   property PropertyName to PropertyValue.
            %   Admissible properties are:
            %       Lighting    -   'Gouraud' (default) | 'Flat' | 'Phong' | 'None'
            %       Material    -   'Dull' (default) | 'Shiny' | 'Metal'
            %       CamLight    -   'Headlight' (default) | 'Right' | 'Left'
            %
            % See also PlotBrainSurf, lighting, material, camlight.
            
            bs.set_axes()
            
            % sets properties
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'lighting'
                        bs.Lighting = varargin{n+1};
                    case 'material'
                        bs.Material = varargin{n+1};
                    case 'camlight'
                        bs.CamLight = varargin{n+1};
                end
            end
            
            delete(findall(bs.h_axes, 'Type', 'light'));
            lighting(bs.h_axes, bs.Lighting)
            material(bs.Material)
            camlight(bs.CamLight)
        end
        function rotate(bs,daz,del)
            % ROTATE rotates viewpoint
            %
            % ROTATE(BS,DAZ,DEL) rotates the viewpoint of a brain surface
            %   BS by DAZ degrees in the azimutal direction and DEL degrees
            %   in vertical elevation.
            %
            % See also PlotBrainSurf, view.
            
            bs.set_axes()
            
            camorbit(bs.h_axes, daz, del, 'camera')
            bs.update_light()
            drawnow
        end
        function brain_lighting(bs, varargin) 
            %get settings
            internal_set = PlotBrainSurf.getAvailableSettings();
            settings_lighting = internal_set{1};
            settings_material = internal_set{2};
            settings_camlight = internal_set{3};
            
            % sets position of figure
            FigPosition = [.70 .50 .20 .15];
            FigColor = [.95 .95 .95]; 
            FigName = 'Brain Lighting Settings';
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'figposition'
                        FigPosition = varargin{n+1};
                    case 'figcolor'
                        FigColor = varargin{n+1};
                    case 'figname'
                        FigName = varargin{n+1};
                end
            end
            
            % create a figure
            if isempty(bs.f_brain_settings) || ~ishandle(bs.f_brain_settings)
                bs.f_brain_settings = figure('Visible','off');
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
            
            ui_text = uicontrol(f, 'Style', 'text');
            set(ui_text,'Units','normalized')
            set(ui_text,'BackgroundColor', [.95 .95 .95])

            ui_button_backgroundcolor = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_backgroundcolor,'Units','normalized')
            set(ui_button_backgroundcolor,'BackgroundColor', [.95 .95 .95])
            set(ui_button_backgroundcolor, 'Position', [.05 .75 .30 .20])
            set(ui_button_backgroundcolor, 'String', 'background color')
            set(ui_button_backgroundcolor, 'HorizontalAlignment', 'center')
            set(ui_button_backgroundcolor, 'TooltipString', 'Brain surface edge color')
            set(ui_button_backgroundcolor, 'Callback',{@cb_backgroundcolor})
            
            ui_pop_up_lighting = uicontrol(f, 'Style', 'popupmenu');
            ui_pop_up_lighting.Units = 'normalized';
            ui_pop_up_lighting.Position = [.05 .15 .30 .20];
            ui_pop_up_lighting.String = settings_lighting{4};
            ui_pop_up_lighting.HorizontalAlignment = 'center';
            ui_pop_up_lighting.Callback = @cb_popLighting;
            
            ui_pop_up_material = uicontrol(f, 'Style', 'popupmenu');
            ui_pop_up_material.Units = 'normalized';
            ui_pop_up_material.Position = [.55 .75 .30 .20];
            ui_pop_up_material.String = settings_material{4};
            ui_pop_up_material.HorizontalAlignment = 'center';
            ui_pop_up_material.Callback = @cb_popMaterial;
            
            ui_pop_up_camlight = uicontrol(f, 'Style', 'popupmenu');
            ui_pop_up_camlight.Units = 'normalized';
            ui_pop_up_camlight.Position = [.55 .15 .30 .20];
            ui_pop_up_camlight.String = settings_camlight{4};
            ui_pop_up_camlight.HorizontalAlignment = 'center';
            ui_pop_up_camlight.Callback = @cb_popCamLight;
            
            ui_pop_up_facecolorstyle = uicontrol(f, 'Style', 'popupmenu');
            ui_pop_up_facecolorstyle.Units = 'normalized';
            ui_pop_up_facecolorstyle.Position = [.05 .45 .30 .20];
            ui_pop_up_facecolorstyle.String = {'interpolated', 'flat'};
            ui_pop_up_facecolorstyle.HorizontalAlignment = 'center';
            ui_pop_up_facecolorstyle.Callback = @cb_facecolorstyle;
            
            ui_pop_up_colormapoption = uicontrol(f, 'Style', 'popupmenu');
            ui_pop_up_colormapoption.Units = 'normalized';
            ui_pop_up_colormapoption.Position = [.55 .45 .30 .20];
            ui_pop_up_colormapoption.String = {'parula', 'jet', 'hsv', 'hot', ...
                'cool', 'spring', 'summer', 'autumn', 'winter', 'gray', 'bone', ...
                'copper', 'pink', 'lines', 'colorcube', 'prism', 'flag', 'white'};
            ui_pop_up_colormapoption.HorizontalAlignment = 'center';
            ui_pop_up_colormapoption.Callback = @cb_colormapoption;

            set(f,'Visible','on')      

            function cb_backgroundcolor(~,~)  % (src,event)
                color = uisetcolor;
                if length(color) == 3
                    set(bs.get_axes(), 'Color', color)
                end
            end
            
            function cb_popLighting(~,~)
                val = ui_pop_up_lighting.Value;
                str = ui_pop_up_lighting.String;                
                bs.Lighting = str{val};
                lighting(bs.get_axes(), bs.Lighting)
            end
            
            function cb_popMaterial(~,~)
                val = ui_pop_up_material.Value;
                str = ui_pop_up_material.String;                
                bs.Material = str{val};
                material(bs.get_axes(), bs.Material)
            end
            
            function cb_popCamLight(~,~)
                val = ui_pop_up_camlight.Value;
                str = ui_pop_up_camlight.String;
                cam_light_obj = findobj(bs.get_axes(), 'Type', 'Light');
                delete(cam_light_obj);
                delete(findall(bs.h_axes, 'Type', 'light'));  % double check, I feal it does not get all.
                bs.CamLight = str{val};
                camlight(bs.get_axes(), bs.CamLight);
            end
            
            function cb_facecolorstyle(~,~)  % (src,event)
                val = ui_pop_up_facecolorstyle.Value;
                str = ui_pop_up_facecolorstyle.String;
                if str{val} == 'interpolated' %#ok<BDSCA>
                    set(bs.getBrainSurface(), 'FaceColor', 'interp')
                else
                     set(bs.getBrainSurface(), 'FaceColor', [.5 .5 .5])
                end
            end
            
            function cb_colormapoption(~,~)
                val = ui_pop_up_colormapoption.Value;
                str = ui_pop_up_colormapoption.String;
                colormap(bs.get_axes(), str{val});
            end
            
        end
    end
    methods (Static)  % Load function
        function bs = loadBrainSurface(varargin)
            brain_surface_file = get_from_varargin('' , 'BrainSurfaceType', varargin(:));
            if isequal(brain_surface_file, '')  % select file
                msg = get_from_varargin(BRAPH2.BRAINSURFACE_MSG, 'MSG', varargin{:});
                [filename, ~, filterindex] = uigetfile(BRAPH2.BRAINSURFACE_EXTENSION, msg);
                brain_surface_file = filename;
                
                if ~filterindex
                    return
                end
            end
            
            % create a brain surface from the specified file
            
            bs = PlotBrainSurf('BrainSurfaceType', brain_surface_file);
        end
        function available_settings = getAvailableSettings(bs)
            available_settings = {
                {'PlotBrainSurf.Lighting', BRAPH2.STRING, 'none', {'none', 'flat', 'gouraud'}}, ...
                {'PlotBrainSurf.Material', BRAPH2.STRING, 'dull', {'dull', 'shiny', 'metal'}}, ...
                {'PlotBrainSurf.CamLight', BRAPH2.STRING, 'headlight', {'headlight', 'right', 'left'}} ...
                };
        end
    end
    methods (Access = protected)
        function cp = copyElement(bs)
            
            % Make a deep copy
            cp = copyElement@matlab.mixin.Copyable(bs);
            % resets the graphic handles
            cp.h_axes = NaN;
            cp.h_brain = NaN;
            cp.f_brain_settings = NaN;
        end
    end
end