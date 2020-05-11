classdef PlotBrainSurf < handle & matlab.mixin.Copyable
    % PlotBrainSurf < handle & matlab.mixin.Copyable : Plot of a brain surface
    %   PlotBrainSurf plots and manages a brain surface.
    %   The brain surface is based on ICBM152 
    %   and is loaded from the file BrainMesh_ICBM152.nv.
    %
    % PlotBrainSurf properties (Constants):
    %   INIT_LIGHTING           -   effect of light on objects
    %                               (default = 'gouraud')
    %   INIT_MATERIAL           -   lighting characteristics of objects
    %                               (default = 'dull')
    %   INIT_CAMLIGHT           -   creates a light at given position
    %                               (default = 'Headlight')
    %   
    %   INIT_BRAIN_EDGE_COLOR   -   edge color of brain surface
    %                               (default = 'none')
    %   INIT_BRAIN_EDGE_ALPHA   -   edge transparency of brain surface
    %                               (default = 0.5)
    %   INIT_BRAIN_FACE_COLOR   -   face color of brain surface
    %                               (default = [0.5 0.5 0.5])
    %   INIT_BRAIN_FACE_ALPHA   -   face transparency of brain surface
    %                               (default = 0.5)
    %
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
    %   VIEW_AZEL       -   vector of view azimutal and polar angle
    %
    % PlotBrainSurf properties (protected):
    %   h_axes              -   handle for axes
    %   Lighting            -   current lighting setting
    %   Material            -   current material setting
    %   CamLight            -   current camera light
    %
    %   h_brain             -   handle for brain surface
    %   f_brain_settings    -   brain setting figure handle
    %
    %   vertex_number       -   number of vertices of brain surface
    %   coord               -   coordinates of the vertices of brain surface
    %   ntri                -   number of triangles of brain surface
    %   tri                 -   triangles of brain surface
    %
    % PlotBrainSurf methods:
    %   PlotBrainSurf   -   constructor
    %   disp            -   displays brain surface 
    %   name            -   brain surface name 
    %   set_axes        -   sets current axes
    %   get_axes        -   gets current axes
    %
    %   brain           -   plots brain surface
    %   brain_on        -   shows brain surface
    %   brain_off       -   hides brain surface
    %   brain_settings  -   sets brain surface's properties
    %
    %   hold_on         -   hold on
    %   hold_off        -   hold off
    %   grid_on         -   grid on
    %   grid_off        -   grid off
    %   axis_on         -   axis on
    %   axis_off        -   axis off
    %   axis_equal      -   axis equal
    %   axis_tight      -   axis tight
    %   view            -   sets desired view
    %   update_light    -   sets lighting properties
    %   rotate          -   rotates viewpoint
    %
    % See also trisurf, PlotBrainGraph, hadle, matlab.mixin.Copyable.

    % Author: Mite Mijalkov & Giovanni Volpe
    % Date: 2016/01/01
    
    properties (Constant)
        
        % initialization constants
        INIT_LIGHTING = 'gouraud'
        INIT_MATERIAL = 'dull'
        INIT_CAMLIGHT = 'Headlight'
        INIT_BRAIN_EDGE_COLOR = 'none'
        INIT_BRAIN_EDGE_ALPHA = .5
        INIT_BRAIN_FACE_COLOR = [.5 .5 .5]
        INIT_BRAIN_FACE_ALPHA = .5
        
        % 3D view
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
        f_brain_settings  % brain setting figure handle

        % brain coordinates
        vertex_number  % number of vertices of brain surface
        coord  % coordinates of the vertices of brain surface
        ntri  % number of triangles of brain surface
        tri  % triangles of brain surface
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
	methods
        function bs = PlotBrainSurf()
            % PLOTBRAINSURF() constructs a plot of a brain surface 
            %   The brain surface is based on ICBM152 
            %   and is loaded from the file BrainMesh_ICBM152.nv.
            %
            % See also PlotBrainSurf.

            bs.Lighting = PlotBrainSurf.INIT_LIGHTING;
            bs.Material = PlotBrainSurf.INIT_MATERIAL;
            bs.CamLight = PlotBrainSurf.INIT_CAMLIGHT;

            fid = fopen('BrainMesh_ICBM152.nv');
            bs.vertex_number = fscanf(fid,'%f',1);
            bs.coord = fscanf(fid,'%f',[3,bs.vertex_number]);
            bs.ntri = fscanf(fid,'%f',1);
            bs.tri = fscanf(fid,'%d',[3,bs.ntri])';
            fclose(fid);
        end
        function disp(bs)
            % DISP displays brain surface
            %
            % DISP(BS) displays the brain surface BP on the command line.
            %
            % See also PlotBrainSurf.
            
            disp(['<a href="matlab:help PlotBrainSurf">BrainSurf</a> : ' bs.name()]);
        end
        function txt = name(~)  % (bs)
            % NAME brain surface name
            %
            % TXT = NAME() gets the brain surface BS's name.
            %
            % See also PlotBrainSurf.

            txt = 'BrainMesh_ICBM152.nv';
        end
        function h = set_axes(bs,ht)
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
        
        function h = brain(bs,varargin)
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
                    'EdgeColor',PlotBrainSurf.INIT_BRAIN_EDGE_COLOR, ...
                    'EdgeAlpha',PlotBrainSurf.INIT_BRAIN_EDGE_ALPHA, ...
                    'FaceColor',PlotBrainSurf.INIT_BRAIN_FACE_COLOR, ...
                    'FaceAlpha',PlotBrainSurf.INIT_BRAIN_FACE_ALPHA ...
                    );
            end
            
            % sets properties
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'color'
                        set(bs.h_brain,'FaceColor',varargin{n+1});
                        set(bs.h_brain,'EdgeColor',varargin{n+1});                        
                    case 'alpha'
                        set(bs.h_brain,'FaceAlpha',varargin{n+1});
                        set(bs.h_brain,'EdgeAlpha',varargin{n+1});                        
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
                set(bs.h_brain,'Visible','on')
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
        function brain_settings(bs,varargin)
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
            FigPosition = [.70 .50 .25 .20];
            FigColor = GUI.BKGCOLOR;
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
            set(f,'units','normalized')
            set(f,'Position',FigPosition)
            set(f,'Color',FigColor)
            set(f,'Name',FigName)
            set(f,'MenuBar','none')
            set(f,'Toolbar','none')
            set(f,'NumberTitle','off')
            set(f,'DockControls','off')
            
            ui_text = uicontrol(f,'Style','text');
            GUI.setUnits(ui_text)
            GUI.setBackgroundColor(ui_text)
            set(ui_text,'String','transparency')
            set(ui_text,'Position',[.35 .85 .65 .10])
            set(ui_text,'HorizontalAlignment','center')
            set(ui_text,'FontWeight','bold')
            
            ui_button_color = uicontrol(f,'Style','pushbutton');
            GUI.setUnits(ui_button_color)
            GUI.setBackgroundColor(ui_button_color)
            set(ui_button_color,'Position',[.05 .70 .25 .15])
            set(ui_button_color,'String','brain color')
            set(ui_button_color,'HorizontalAlignment','center')
            set(ui_button_color,'TooltipString','Brain surface color (applied both to faces and edges)')
            set(ui_button_color,'Callback',{@cb_color})
           
            ui_slider_alpha = uicontrol(f,'Style','slider');
            GUI.setUnits(ui_slider_alpha)
            GUI.setBackgroundColor(ui_slider_alpha)
            set(ui_slider_alpha,'Position',[.40 .70 .55 .10])
            set(ui_slider_alpha,'String','Brain transparency')
            set(ui_slider_alpha,'Min',0,'Max',1,'Value',max(get(bs.brain,'FaceAlpha'),get(bs.brain,'EdgeAlpha')))
            set(ui_slider_alpha,'TooltipString','Brain surface transparency (applied both to faces and edges)')
            set(ui_slider_alpha,'Callback',{@cb_alpha})

            ui_button_facecolor = uicontrol(f,'Style','pushbutton');
            GUI.setUnits(ui_button_facecolor)
            GUI.setBackgroundColor(ui_button_facecolor)
            set(ui_button_facecolor,'Position',[.05 .40 .25 .15])
            set(ui_button_facecolor,'String','face color')
            set(ui_button_facecolor,'HorizontalAlignment','center')
            set(ui_button_facecolor,'TooltipString','Brain surface face color')
            set(ui_button_facecolor,'Callback',{@cb_facecolor})
            
            ui_slider_facealpha = uicontrol(f,'Style','slider');
            GUI.setUnits(ui_slider_facealpha)
            GUI.setBackgroundColor(ui_slider_facealpha)
            set(ui_slider_facealpha,'Position',[.40 .40 .55 .10])
            set(ui_slider_facealpha,'String','Brain transparency')
            set(ui_slider_facealpha,'Min',0,'Max',1,'Value',get(bs.brain,'FaceAlpha'))
            set(ui_slider_facealpha,'TooltipString','Brain surface face transparency')
            set(ui_slider_facealpha,'Callback',{@cb_facealpha})

            ui_button_edgecolor = uicontrol(f,'Style','pushbutton');
            GUI.setUnits(ui_button_edgecolor)
            GUI.setBackgroundColor(ui_button_edgecolor)
            set(ui_button_edgecolor,'Position',[.05 .10 .25 .15])
            set(ui_button_edgecolor,'String','edge color')
            set(ui_button_edgecolor,'HorizontalAlignment','center')
            set(ui_button_edgecolor,'TooltipString','Brain surface edge color')
            set(ui_button_edgecolor,'Callback',{@cb_edgecolor})
            
            ui_slider_edgealpha = uicontrol(f,'Style','slider');
            GUI.setUnits(ui_slider_edgealpha)
            GUI.setBackgroundColor(ui_slider_edgealpha)
            set(ui_slider_edgealpha,'Position',[.40 .10 .55 .10])
            set(ui_slider_edgealpha,'String','Brain transparency')
            set(ui_slider_edgealpha,'Min',0,'Max',1,'Value',get(bs.brain,'EdgeAlpha'))
            set(ui_slider_edgealpha,'TooltipString','Brain surface edge transparency')
            set(ui_slider_edgealpha,'Callback',{@cb_edgealpha})
            
            set(f,'Visible','on')

            function cb_color(~,~)  % (src,event)
                color = uisetcolor;
                if length(color)==3
                    bs.brain('Color',color)
                end
            end
            
            function cb_alpha(~,~)  % (src,event)
               bs.brain('Alpha',get(ui_slider_alpha,'Value'))
               set(ui_slider_facealpha,'Value',get(ui_slider_alpha,'Value'))
               set(ui_slider_edgealpha,'Value',get(ui_slider_alpha,'Value'))
            end
            
            function cb_facecolor(~,~)  % (src,event)
                color = uisetcolor;
                if length(color) == 3
                    bs.brain('FaceColor',color)
                end
            end
            
            function cb_facealpha(~,~)  % (src,event)
               bs.brain('FaceAlpha',get(ui_slider_facealpha,'Value'))
            end
            
            function cb_edgecolor(~,~)  % (src,event)
                color = uisetcolor;
                if length(color) == 3
                    bs.brain('EdgeColor',color)
                end
            end
            
            function cb_edgealpha(~,~)  % (src,event)
               bs.brain('EdgeAlpha',get(ui_slider_edgealpha,'Value'))
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
            
            hold(bs.h_axes,'on')
        end
        function hold_off(bs)
            % HOLD_OFF hold off
            %
            % HOLD_OFF(BS) clears the brain surface BS if another graph is
            %   plotted in the current axes.
            %
            % See also PlotBrainSurf, hold.
            
            bs.set_axes()

            hold(bs.h_axes,'off')
        end
        function grid_on(bs)
            % GRID_ON grid on
            %
            % GRID_ON(BS) adds major grid lines to the current axes.
            %
            % See also PlotBrainSurf, grid.
            
            bs.set_axes()

            grid(bs.h_axes,'on')
        end
        function grid_off(bs)
            % GRID_OFF grid off
            %
            % GRID_OFF(BS) removes grid lines from the current axes.
            %
            % See also PlotBrainSurf, grid.
            
            bs.set_axes()

            grid(bs.h_axes,'off')
        end
        function axis_on(bs)
            % AXIS_ON axis on
            %
            % AXIS_ON(BS) turns on all axis lines, tick marks, and labels.
            %
            % See also PlotBrainSurf, axis.
            
            bs.set_axes()

            axis(bs.h_axes,'on')
        end
        function axis_off(bs)
            % AXIS_OFF axis off
            %
            % AXIS_OFF(BS) turns off all axis lines, tick marks, and labels.
            %
            % See also PlotBrainSurf, axis.
            
            bs.set_axes()

            axis(bs.h_axes,'off')
        end
        function axis_equal(bs)
            % AXIS_EQUAL axis equal
            %
            % AXIS_EQUAL(BS) sets the aspect ratio so that the data units 
            %   are the same in every direction.
            %
            % See also PlotBrainSurf, axis.
            
            bs.set_axes()

            daspect(bs.h_axes,[1 1 1])
        end
        function axis_tight(bs)
            % AXIS_TIGHT axis tight
            %
            % AXIS_TIGHT(BS) sets the axis limits to the range of the data. 
            %
            % See also PlotBrainSurf, axis.
            
            bs.set_axes()

            axis(bs.h_axes,'tight')
        end
        function view(bs,v)
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
            
            view(bs.h_axes,PlotBrainSurf.VIEW_AZEL{v})
        end
        function update_light(bs,varargin)
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

            delete(findall(bs.h_axes,'Type','light'));
            lighting(bs.h_axes,bs.Lighting)
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
            
            camorbit(bs.h_axes,daz,del,'camera')
            bs.update_light()
            drawnow
        end
    end    
end