classdef PlotBrainAtlas < PlotBrainSurf
    % PlotBrainAtlas < PlotBrainSurf : Plot of a brain atlas
    % PlotBrainAtlas plots and manages the brain regions that make up a
    % a brain atlas. The brain regions can be plotted by using symbols,
    % spheres or labels.
    % It is a subclass of PlotBrainSurf.
    %
    % PlotBrainAtlas properties (Constants):
    %   INIT_SYM_MARKER           -   symbol type
    %                                 (default = 'o')
    %   INIT_SYM_SIZE             -   symbol size
    %                                 (default = 10)
    %   INIT_SYM_EDGE_COLOR       -   symbol edge color
    %                                 (default = 'none')
    %   INIT_SYM_FACE_COLOR       -   symbol face color
    %                                 (default = 'b')
    %
    %   INIT_SPH_EDGE_COLOR       -   sphere edge color
    %                                 (default = 'none')
    %   INIT_SPH_EDGE_ALPHA       -   sphere edge transparency
    %                                 (default = 0.5)
    %   INIT_SPH_FACE_COLOR       -   sphere face color
    %                                 (default = [.9 .4 .1])
    %   INIT_SPH_FACE_ALPHA       -   sphere face transparency
    %                                 (default = 0.5)
    %   INIT_SPH_R                -   sphere radius
    %                                 (default = 1)
    %
    %   INIT_LAB_FONT_SIZE        -   label font size
    %                                 (default = 13)
    %   INIT_LAB_FONT_NAME        -   label font name
    %                                 (default = 'Helvetica')
    %   INIT_LAB_FONT_COLOR       -   label font color
    %                                 (default = [0 0 0])
    %   INIT_LAB_FONT_INTERPRETER -   label font interpreter
    %                                 (default = 'none')
    %   PLOT_SYMBOL_NAME          -   list with symbols options name
    %   PLOT_SYMBOL_TAG           -   list with symbols options
    %
    % PlotBrainAtlas methods:
    %   PlotBrainAtlas    -   constructor
    %   br_sym            -   displays brain region as symbol
    %   br_sym_on         -   shows a symbol
    %   br_sym_off        -   hides a symbol
    %   br_sym_is_on      -   checks if symbol is visible
    %   br_syms           -   displays multiple brain regions as symbols
    %   br_syms_on        -   shows multiple symbols
    %   br_syms_off       -   hides multiple symbols
    %   get_sym_i         -   order number of brain region corresponding to a symbol
    %   get_sym_br        -   properties of brain region corresponding to a symbol
    %   br_syms_settings  -   sets symbols' properties
    %
    %   br_sph            -   displays brain region as sphere
    %   br_sph_on         -   shows a sphere
    %   br_sph_off        -   hides a sphere
    %   br_sph_is_on      -   checks if sphere is visible
    %   br_sphs           -   displays multiple brain regions as spheres
    %   br_sphs_on        -   shows multiple spheres
    %   br_sphs_off       -   hides multiple spheres
    %   get_sph_i         -   order number of brain region corresponding to a sphere
    %   get_sph_br        -   properties of brain region corresponding to a sphere
    %   br_sphs_settings  -   sets spheres' properties
    %
    %   br_lab            -   displays brain region as label
    %   br_lab_on         -   shows a label
    %   br_lab_off        -   hides a label
    %   br_lab_is_on      -   checks if label is visible
    %   br_labs           -   displays multiple brain regions as label
    %   br_labs_on        -   shows multiple labels
    %   br_labs_off       -   hides multiple labels
    %   get_lab_i         -   order number of brain region corresponding to a label
    %   get_lab_br        -   properties of brain region corresponding to a label
    %   br_labs_settings  -   sets labels' properties
    %
    % See also PlotBrainSurf, BrainAtlas, BrainRegion.
    
    properties (Constant)
        % Symbols
        INIT_SYM_MARKER = 'o'
        INIT_SYM_SIZE = 10
        INIT_SYM_EDGE_COLOR = 'b'
        INIT_SYM_FACE_COLOR = 'b'
        
        % Spheres
        INIT_SPH_EDGE_COLOR = 'none'
        INIT_SPH_EDGE_ALPHA = .5
        INIT_SPH_FACE_COLOR = [.9 .4 .1]
        INIT_SPH_FACE_ALPHA = .5
        INIT_SPH_R = 1
        
        % Labels
        INIT_LAB_FONT_SIZE = 13
        INIT_LAB_FONT_NAME = GUI.FONT
        INIT_LAB_FONT_COLOR = [0 0 0]
        INIT_LAB_FONT_INTERPRETER = 'none'
        
        PLOT_SYMBOL_NAME = { ...
            'point' ...
            'circle' ...
            'x-mark' ...
            'plus' ...
            'star' ...
            'square' ...
            'diamond' ...
            'triangle (down)' ...
            'triangle (up)' ...
            'triangle (left)' ...
            'triangle (right)' ...
            'pentagram' ...
            'hexagram' ...
            'none' ...
            }
        
        PLOT_SYMBOL_TAG = { ...
            '.' ...
            'o' ...
            'x' ...
            '+' ...
            '*' ...
            's' ...
            'd' ...
            'v' ...
            '^' ...
            '>' ...
            '<' ...
            'p' ...
            'h' ...
            'none' ...
            }
    end
    properties (Access = protected)
        atlas  % BrainAtlas
        
        % syms is a cell array containing the symbols' properties
        % syms{n}.h     -   graphic handle
        % syms{n}.X     -   x-coordinate
        % syms{n}.Y     -   y-coordinate
        % syms{n}.Z     -   z-coordinate
        syms
        f_syms_settings  % symbols settings figure handle
        
        % sphs is a cell array containing the spheres' properties
        % sphs{n}.h     -   graphic handle
        % sphs{n}.X     -   x-coordinate
        % sphs{n}.Y     -   y-coordinate
        % sphs{n}.Z     -   z-coordinate
        % sphs{n}.R     -   sphere radius
        sphs
        f_sphs_settings  % spheres setting figure handle
        
        % labs is a cell array containing the labels' properties
        % labs{n}.h     -   graphic handle
        % labs{n}.X     -   x-coordinate
        % labs{n}.Y     -   y-coordinate
        % labs{n}.Z     -   z-coordinate
        % labs{n}.LAB   -   label string
        labs
        f_labs_settings  % labels setting figure handle
    end
    methods  % basic functions
        function ba = PlotBrainAtlas(atlas, varargin)
            % PLOTBRAINATLAS(ATLAS) constructs the brain atlas plot, it
            % assigns the nodes of atlas to a PlotBrainSurf region.
            %
            % See also PlotBrainSurf, BrainAtlas.
            
            assert(isa(atlas, 'BrainAtlas'), ...
                [BRAPH2.STR ':' class(atlas) ':' BRAPH2.WRONG_INPUT], ...
                'Argument is not a BrainAtlas.')
            
            ba = ba@PlotBrainSurf(atlas.getBrainSurfFile(), varargin{:});
            
            ba.atlas = atlas;
            ba.setRegions(atlas);
        end
    end
    methods  % setRegions
        function setRegions(ba, atlas)
            for i = 1:1:atlas.getBrainRegions().length()
                brain_region = atlas.getBrainRegions().getValue(i);
                x_coordinates{i} = brain_region.getX(); %#ok<AGROW>
                y_coordinates{i} = brain_region.getY(); %#ok<AGROW>
                z_coordinates{i} = brain_region.getZ(); %#ok<AGROW>
                labels{i} = brain_region.getLabel(); %#ok<AGROW>
            end
            
            if atlas.getBrainRegions().length() > 0
                
                ba.syms.h = NaN(1, atlas.getBrainRegions().length());
                ba.syms.X = x_coordinates;
                ba.syms.Y = y_coordinates;
                ba.syms.Z = z_coordinates;
                
                ba.sphs.h = NaN(1,  atlas.getBrainRegions().length());
                ba.sphs.X = x_coordinates;
                ba.sphs.Y = y_coordinates;
                ba.sphs.Z = z_coordinates;
                ba.sphs.R = PlotBrainAtlas.INIT_SPH_R * ones(1, atlas.getBrainRegions().length());
                
                ba.labs.h = NaN(1,  atlas.getBrainRegions().length());
                ba.labs.X = x_coordinates;
                ba.labs.Y = y_coordinates;
                ba.labs.Z = z_coordinates;
                ba.labs.LAB = labels;
            end
        end
    end
    methods  % editign functions sym
        function h = br_sym(ba, i, varargin)
            % BR_SYM displays brain region as symbol
            %
            % BR_SYM(BA, I) denotes the brain regions I as a symbol, if not plotted.
            %
            % H = BR_SYM(BA, I) returns the handle to the symbol denoting the brain
            %   region I.
            %
            % BR_SYM(BA, I, 'PropertyName', PropertyValue) sets the property
            %   of the symbol's PropertyName to PropertyValue.
            %   All standard plot properties of plot3 can be used.
            %   The symbol properties can also be changed when hidden.
            %
            % See also plot3.
            
            ba.set_axes()
            
            % center coordinates
            X = ba.atlas.getBrainRegions().getValue(i).getX();
            Y = ba.atlas.getBrainRegions().getValue(i).getY();
            Z = ba.atlas.getBrainRegions().getValue(i).getZ();
            
            if ~ishandle(ba.syms.h(i))
                
                ba.syms.h(i) = plot3(...
                    ba.get_axes(), ...
                    X,...
                    Y,...
                    Z,...
                    'Marker', PlotBrainAtlas.INIT_SYM_MARKER,...
                    'MarkerSize', PlotBrainAtlas.INIT_SYM_SIZE,...
                    'MarkerEdgeColor', PlotBrainAtlas.INIT_SYM_EDGE_COLOR,...
                    'MarkerFaceColor', PlotBrainAtlas.INIT_SYM_FACE_COLOR);
                
            else
                if ~isequal(ba.syms.X(i), X) || ~isequal(ba.syms.Y(i), Y) || ~isequal(ba.syms.Z(i), Z)
                    
                    set(ba.syms.h(i), 'XData', X);
                    set(ba.syms.h(i), 'YData', Y);
                    set(ba.syms.h(i), 'ZData', Z);
                end
            end
            
            % saves new data
            ba.syms.X(i) = num2cell(X);
            ba.syms.Y(i) = num2cell(Y);
            ba.syms.Z(i) = num2cell(Z);
            
            % sets properties
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'color'
                        set(ba.syms.h(i),'MarkerFaceColor',varargin{n+1});
                        set(ba.syms.h(i),'MarkerEdgeColor',varargin{n+1});
                    case 'size'
                        set(ba.syms.h(i),'MarkerSize',varargin{n+1});
                    otherwise
                        set(ba.syms.h(i),varargin{n},varargin{n+1});
                end
            end
            
            % output if needed
            if nargout>0
                h = ba.syms.h(i);
            end
        end
        function br_sym_on(ba, i)
            % BR_SYM_ON shows a symbol
            %
            % BR_SYM_ON(BA,I) shows the symbol denoting the brain region I.
            %
            % See also PlotBrainAtlas.
            
            if  ishandle(ba.syms.h(i))
                set(ba.syms.h(i), 'Visible', 'on')
            end
        end
        function br_sym_off(ba, i)
            % BR_SYM_OFF hides a symbol
            %
            % BR_SYM_OFF(BA,I) hides the symbol denoting the brain region I.
            %
            % See also PlotBrainAtlas.
            
            if  ishandle(ba.syms.h(i))
                set(ba.syms.h(i), 'Visible', 'off')
            end
        end
        function bool = br_sym_is_on(ba, i)
            % BR_SYM_IS_ON checks if symbol is visible
            %
            % BOOL = BR_SYM_IS_ON(BA,I) returns true if the symbol denoting
            %   the brain region I is visible and false otherwise.
            %
            % See also br_syms.
            
            bool = ishandle(ba.syms.h(i)) && strcmpi(get(ba.syms.h(i), 'Visible'), 'on');
        end
        function br_syms(ba, i_vec, varargin)
            % BR_SYMS displays multiple brain regions as symbols
            %
            % BR_SYMS(BA,I_VEC) plots the symbols denoting the brain regions
            %   specified in I_VEC, if not plotted.
            %
            % BR_SYMS(BA,[]) plots the symbols for all possible brain regions.
            %
            % BR_SYMS(BA,I_VEC,'PropertyName',PropertyValue) sets the property
            %   of the multiple symbols' PropertyName to PropertyValue.
            %   All standard plot properties of plot3 can be used.
            %   The symbols properties can also be changed when hidden.
            %
            % See also br_sym,  plot3.
            
            % Marker - MarkerEdgeColor - MarkerFaceColor - Color - Size
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'marker'
                        Marker = varargin{n+1};
                        nmarker = n+1;
                    case 'markeredgecolor'
                        MarkerEdgeColor = varargin{n+1};
                        nmarkeredgecolor = n+1;
                    case 'markerfacecolor'
                        MarkerFaceColor = varargin{n+1};
                        nmarkerfacecolor = n+1;
                    case 'color'
                        Color = varargin{n+1};
                        ncolor = n+1;
                    case 'size'
                        Size = varargin{n+1};
                        nsize = n+1;
                end
            end
            
            if nargin<2 || isempty(i_vec)
                i_vec = 1:1:ba.atlas.getBrainRegions().length();
            end
            
            for m = 1:1:length(i_vec)
                if exist('Marker', 'var') && numel(Marker)==length(i_vec)
                    varargin{nmarker} = Marker(m);
                end
                if exist('MarkerEdgeColor','var') && size(MarkerEdgeColor,1)==length(i_vec) && size(MarkerEdgeColor,2)==3
                    varargin{nmarkeredgecolor} = MarkerEdgeColor(m,:);
                end
                if exist('MarkerFaceColor','var') && size(MarkerFaceColor,1)==length(i_vec) && size(MarkerFaceColor,2)==3
                    varargin{nmarkerfacecolor} = MarkerFaceColor(m,:);
                end
                if exist('Color','var') && size(Color,1)==length(i_vec) && size(Color,2)==3
                    varargin{ncolor} = Color(m,:);
                end
                if exist('Size','var') && numel(Size)==length(i_vec)
                    varargin{nsize} = Size(m);
                end
                
                ba.br_sym(i_vec(m), varargin{:})
            end
        end
        function br_syms_on(ba, i_vec)
            % BR_SYMS_ON shows multiple symbols
            %
            % BR_SYMS_ON(BA,I_VEC) shows multiple symbols denoting the
            %   brain regions specified in I_VEC.
            %
            % BR_SYMS_ON(BA,[]) shows the symbols denoting all possible
            %   brain region combinations.
            %
            % See also PlotBrainAtlas.
            
            if nargin<2 || isempty(i_vec)
                i_vec = 1:1:ba.atlas.getBrainRegions().length();
            end
            
            for m = 1:1:length(i_vec)
                ba.br_sym_on(i_vec(m))
            end
        end
        function br_syms_off(ba, i_vec)
            % BR_SYMS_OFF hides multiple symbols
            %
            % BR_SYMS_OFF(BA,I_VEC) hides multiple symbols denoting the
            %   brain regions specified in I_VEC.
            %
            % BR_SYMS_OFF(BA,[]) hides the symbols denoting all possible
            %   brain region combinations.
            %
            % See also PlotBrainAtlas.
            
            if nargin<2 || isempty(i_vec)
                i_vec = 1:1:ba.atlas.getBrainRegions().length();
            end
            
            for m = 1:1:length(i_vec)
                ba.br_sym_off(i_vec(m))
            end
        end
        function i = get_sym_i(ba, h)
            % GET_SYM_I order number of brain region corresponding to a symbol
            %
            % I = GET_SYM_I(BA,H) returns the order number of the brain regions
            %   corresponding to the symbol with handle H.
            %
            % See also PlotBrainAtlas.
            
            i = NaN;
            if ~isempty(h)
                for j = 1:1:ba.atlas.getBrainRegions().length()
                    if h==ba.syms.h(j)
                        i = j;
                    end
                end
            end
        end
        function br = get_sym_br(ba, h)
            % GET_SYM_BR properties of brain region corresponding to a symbol
            %
            % BR = GET_SYM_BR(BA,H) returns the properties of the brain region
            %   BR corresponding to the symbol with handle H.
            %
            % See also PlotBrainAtlas.
            
            i = ba.get_sym_i(h);
            br = ba.atlas.getBrainRegions().getValue(i);
        end
        function br_syms_settings(ba, i_vec, varargin)
            % BR_SYMS_SETTINGS sets symbols' properties
            %
            % BR_SYMS_SETTINGS(BA) allows the user to interractively
            %   change the symbols settings via a graphical user interface.
            %
            % BR_SYMS_SETTINGS(BA,'PropertyName',PropertyValue) sets the property
            %   of the GUI's PropertyName to PropertyValue.
            %   Admissible properties are:
            %       FigPosition  -   position of the GUI on the screen
            %       FigColor     -   background color of the GUI
            %       FigName      -   name of the GUI
            %
            % See also PlotBrainAtlas.
            
            if nargin<2
                i_vec = [];
            end
            
            % sets position of figure
            FigPosition = [.50 .30 .30 .30];
            FigColor = GUI.BKGCOLOR;
            FigName = 'Brain Region Symbol Settings';
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
            if isempty(ba.f_syms_settings) || ~ishandle(ba.f_syms_settings)
                ba.f_syms_settings = figure('Visible', 'off');
            end
            f = ba.f_syms_settings;
            set(f, 'units', 'normalized')
            set(f, 'Position', FigPosition)
            set(f, 'Color', FigColor)
            set(f, 'Name', FigName)
            set(f, 'MenuBar', 'none')
            set(f, 'Toolbar', 'none')
            set(f, 'NumberTitle', 'off')
            set(f, 'DockControls', 'off')
            
            % Initialization
            ui_list = uicontrol(f, 'Style', 'listbox');
            set(ui_list, 'Units', 'normalized')
            set(ui_list, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_list, 'Value', i_vec)
            set(ui_list, 'Max', 2, 'Min',0)
            set(ui_list, 'BackgroundColor', [1 1 1])
            set(ui_list, 'Position', [.10 .25 .40 .70])
            set(ui_list, 'TooltipString', 'Select brain regions');
            set(ui_list, 'Callback', {@cb_list});
            
            ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_label, 'Units', 'normalized')
            set(ui_checkbox_label, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_checkbox_label, 'Position', [.10 .15 .15 .10])
            set(ui_checkbox_label, 'String', 'label')
            set(ui_checkbox_label, 'Value', true)
            set(ui_checkbox_label, 'FontWeight', 'bold')
            set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_label, 'Callback', {@cb_label})
            
            ui_checkbox_name = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_name, 'Units', 'normalized')
            set(ui_checkbox_name, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_checkbox_name, 'Position', [.30 .15 .20 .10])
            set(ui_checkbox_name, 'String', 'name')
            set(ui_checkbox_name, 'Value', false)
            set(ui_checkbox_name, 'TooltipString', 'Shows brain regions by name')
            set(ui_checkbox_name, 'Callback', {@cb_name})
            
            ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_xyz, 'Units', 'normalized')
            set(ui_checkbox_xyz, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_checkbox_xyz, 'Position', [.10 .05 .15 .10])
            set(ui_checkbox_xyz, 'String', 'xyz')
            set(ui_checkbox_xyz, 'Value', false)
            set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by name')
            set(ui_checkbox_xyz, 'Callback', {@cb_xyz})
            
            ui_button_show = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_show, 'Units','normalized')
            set(ui_button_show, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_show, 'Position', [.55 .85 .15 .10])
            set(ui_button_show, 'String', 'Show Regions')
            set(ui_button_show, 'TooltipString', 'Show selected brain regions')
            set(ui_button_show, 'Callback', {@cb_show})
            
            ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_hide, 'Units', 'normalized')
            set(ui_button_hide, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_hide, 'Position', [.75 .85 .15 .10])
            set(ui_button_hide, 'String', 'Hide Regions')
            set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
            set(ui_button_hide, 'Callback', {@cb_hide})
            
            ui_popup_marker = uicontrol(f, 'Style', 'popup', 'String',{''});
            set(ui_popup_marker, 'Units','normalized')
            set(ui_popup_marker, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_popup_marker, 'Position', [.55 .65 .35 .10])
            set(ui_popup_marker, 'String', ba.PLOT_SYMBOL_NAME)
            set(ui_popup_marker, 'Value', 2)
            set(ui_popup_marker, 'TooltipString', 'Select symbol');
            set(ui_popup_marker, 'Callback', {@cb_marker})
            
            ui_text_size = uicontrol(f, 'Style', 'text');
            set(ui_text_size, 'Units', 'normalized')
            set(ui_text_size, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_text_size, 'Position', [.55 .425 .10 .10])
            set(ui_text_size, 'String', 'size ')
            set(ui_text_size, 'HorizontalAlignment', 'left')
            set(ui_text_size, 'FontWeight', 'bold')
            
            ui_edit_size = uicontrol(f, 'Style', 'edit');
            set(ui_edit_size, 'Units','normalized')
            set(ui_edit_size, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_edit_size, 'Position', [.65 .45 .25 .10])
            set(ui_edit_size, 'HorizontalAlignment', 'center')
            set(ui_edit_size, 'FontWeight', 'bold')
            set(ui_edit_size, 'String', '1')
            set(ui_edit_size, 'Callback', {@cb_size})
            
            ui_button_facecolor = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_facecolor, 'Units', 'normalized')
            set(ui_button_facecolor, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_facecolor, 'Position', [.55 .25 .15 .10])
            set(ui_button_facecolor, 'String', 'Symbol Color')
            set(ui_button_facecolor, 'TooltipString', 'Select symbol color')
            set(ui_button_facecolor, 'Callback', {@cb_facecolor})
            
            ui_button_edgecolor = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_edgecolor, 'Units', 'normalized')
            set(ui_button_edgecolor, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_edgecolor, 'Position', [.75 .25 .15 .10])
            set(ui_button_edgecolor, 'String', 'Edge Color')
            set(ui_button_edgecolor, 'TooltipString', 'Select symbol edge color')
            set(ui_button_edgecolor, 'Callback', {@cb_edgecolor})
            
            update_list()
            set(f, 'Visible', 'on')
            
            function update_list()
                % get info
                for j = 1:1:ba.atlas.getBrainRegions().length()
                    labels{j} =  ba.atlas.getBrainRegions().getValue(j).getLabel(); %#ok<AGROW>
                    ids{j} = ba.atlas.getBrainRegions().getValue(j).getID(); %#ok<AGROW>
                    xs{j} =  ba.atlas.getBrainRegions().getValue(j).getX(); %#ok<AGROW>
                    ys{j} =  ba.atlas.getBrainRegions().getValue(j).getY(); %#ok<AGROW>
                    zs{j} =  ba.atlas.getBrainRegions().getValue(j).getZ(); %#ok<AGROW>
                end
                
                % Set list names
                if get(ui_checkbox_label,'Value')
                    set(ui_list,'String', labels)
                elseif get(ui_checkbox_name,'Value')
                    set(ui_list,'String', ids)
                elseif get(ui_checkbox_xyz,'Value')
                    xyz = cell(1, ba.atlas.getBrainRegions().length());
                    for j = 1:1:ba.atlas.getBrainRegions().length()
                        xyz{j} = [num2str(xs{j}) '   ' ...
                            num2str(ys{j}) '   ' ...
                            num2str(zs{j})];
                    end
                    set(ui_list,'String', xyz)
                elseif get(ui_checkbox_hs, 'Value')
                    %  set(ui_list, 'String',
                    %  ba.atlas.getProps(BrainRegion.HS))   % we dont have hs
                    %  now
                end
            end
            function cb_list(~,~)  % (src,event)
                update_list()
            end
            function cb_label(~,~)  % (src,event)
                set(ui_checkbox_label,'Value',true)
                set(ui_checkbox_label,'FontWeight','bold')
                
                set(ui_checkbox_name,'Value',false)
                set(ui_checkbox_name,'FontWeight','normal')
                
                %                 set(ui_checkbox_hs,'Value',false)
                %                 set(ui_checkbox_hs,'FontWeight','normal')
                
                set(ui_checkbox_xyz,'Value',false)
                set(ui_checkbox_xyz,'FontWeight','normal')
                
                update_list()
            end
            function cb_name(~,~)  % (src,event)
                set(ui_checkbox_label,'Value',false)
                set(ui_checkbox_label,'FontWeight','normal')
                
                set(ui_checkbox_name,'Value',true)
                set(ui_checkbox_name,'FontWeight','bold')
                
                %                 set(ui_checkbox_hs,'Value',false)
                %                 set(ui_checkbox_hs,'FontWeight','normal')
                
                set(ui_checkbox_xyz,'Value',false)
                set(ui_checkbox_xyz,'FontWeight','normal')
                
                update_list()
            end
            %             function cb_hs(~,~)  % (src,event)
            %                 set(ui_checkbox_label,'Value',false)
            %                 set(ui_checkbox_label,'FontWeight','normal')
            %
            %                 set(ui_checkbox_name,'Value',false)
            %                 set(ui_checkbox_name,'FontWeight','normal')
            %
            %                 set(ui_checkbox_hs,'Value',true)
            %                 set(ui_checkbox_hs,'FontWeight','bold')
            %
            %                 set(ui_checkbox_xyz,'Value',false)
            %                 set(ui_checkbox_xyz,'FontWeight','normal')
            %
            %                 update_list()
            %             end
            function cb_xyz(~,~)  % (src,event)
                set(ui_checkbox_label,'Value',false)
                set(ui_checkbox_label,'FontWeight','normal')
                
                set(ui_checkbox_name,'Value',false)
                set(ui_checkbox_name,'FontWeight','normal')
                
                %                 set(ui_checkbox_hs,'Value',false)
                %                 set(ui_checkbox_hs,'FontWeight','normal')
                
                set(ui_checkbox_xyz,'Value',true)
                set(ui_checkbox_xyz,'FontWeight','bold')
                
                update_list()
            end
            function cb_show(~,~)  % (src,event)
                ba.br_syms(get_br_list())
                ba.br_syms_on(get_br_list())
            end
            function cb_hide(~,~)  % (src,event)
                ba.br_syms_off(get_br_list())
            end
            function cb_marker(~,~)  % (src,event)
                symbol = PlotBrainAtlas.PLOT_SYMBOL_TAG{get(ui_popup_marker, 'Value')};
                ba.br_syms(get_br_list(),'Marker',symbol)
            end
            function cb_size(~,~)  % (src,event)
                size = real(str2num(get(ui_edit_size, 'String')));
                
                if isempty(size) || size<=1
                    set(ui_edit_size, 'String', '1')
                    size = 5;
                end
                ba.br_syms(get_br_list(),'MarkerSize',size)
            end
            function cb_facecolor(~,~)  % (src,event)
                color = uisetcolor();
                
                if length(color)==3
                    ba.br_syms(get_br_list(),'MarkerFaceColor',color)
                end
            end
            function cb_edgecolor(~,~)  % (src,event)
                color = uisetcolor();
                
                if length(color)==3
                    ba.br_syms(get_br_list(),'MarkerEdgeColor',color)
                end
            end
            function bri = get_br_list()
                if ba.atlas.getBrainRegions().length()>0
                    bri = get(ui_list,'Value');
                else
                    bri = [];
                end
            end
            
        end
        function br_syms_delete(ba)
            for i = 1:ba.atlas.getBrainRegions().length()
                delete(ba.syms.h(i))
            end
        end
        function syms_handles = getSymsHandles(ba)
            syms_handles = ba.syms;
        end
        function answer = checkIfSymsNotEmpty(ba)
            answer = any(ba.syms.h, 'all');
        end
    end
    methods  % editing functions sph
        function h = br_sph(ba, i, varargin)
            % BR_SPH displays brain region as sphere
            %
            % BR_SPH(BA,I) denotes the brain regions I as a sphere, if not plotted.
            %
            % H = BR_SPH(BA,I) returns the handle to the sphere denoting the brain
            %   region I.
            %
            % BR_SPH(BA,I,'PropertyName',PropertyValue) sets the property
            %   of the sphere's PropertyName to PropertyValue.
            %   All standard plot properties of surf can be used and also the sphere
            %   properties listed below.
            % SPHERE properties:
            %   Color  -   sphere color both edges and faces [default = 'k']
            %   Alpha  -   sphere transparency both edges and faces [default = 0.5]
            %   R      -   sphere radius [default = 1]
            %   The sphere properties can also be changed when hidden.
            %
            % See also PlotBrainAtlas, surf.
            
            ba.set_axes()
            
            % radius
            R = ba.sphs.R(i);
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'r'
                        R = varargin{n + 1};
                end
            end            
            
            % center coordinates
            X = ba.atlas.getBrainRegions().getValue(i).getX();
            Y = ba.atlas.getBrainRegions().getValue(i).getY();
            Z = ba.atlas.getBrainRegions().getValue(i).getZ();
            
            % plot sphere
            if ~ishandle(ba.sphs.h(i))
                color = PlotBrainAtlas.INIT_SPH_FACE_COLOR;
                alpha = PlotBrainAtlas.INIT_SPH_FACE_ALPHA;
                
                [sx, sy, sz] = sphere();
                ba.sphs.h(i) = surf( ...
                    ba.get_axes(), ...
                    X + R * sx, ...
                    Y + R * sy, ...
                    Z + R * sz, ...
                    'EdgeColor', color, ...
                    'EdgeAlpha', alpha, ...
                    'FaceColor', color, ...
                    'FaceAlpha', alpha ...
                    );
            else
                if ~isequal(ba.sphs.X(i), num2cell(X)) || ~isequal(ba.sphs.Y(i), num2cell(Y)) || ~isequal(ba.sphs.Z(i), num2cell(Z)) || ba.sphs.R(i)~= (R)
                    
                    [sx,sy,sz] = sphere();
                    set(ba.sphs.h(i), 'XData',X + R * sx);
                    set(ba.sphs.h(i), 'YData',Y + R * sy);
                    set(ba.sphs.h(i), 'ZData',Z + R * sz);
                end
            end
            
            % saves new data
            ba.sphs.X(i) = num2cell(X);
            ba.sphs.Y(i) = num2cell(Y);
            ba.sphs.Z(i) = num2cell(Z);
            ba.sphs.R(i) = R;
            
            % sets properties
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'r'
                        [sx, sy, sz] = sphere();
                        set(ba.sphs.h(i), 'XData', X + R * sx);
                        set(ba.sphs.h(i), 'YData', Y + R * sy);
                        set(ba.sphs.h(i), 'ZData', Z + R * sz);
                    case 'color'
                        color = varargin{n+1};
                        set(ba.sphs.h(i), 'FaceColor', color);
                        set(ba.sphs.h(i), 'EdgeColor', color);
                    case 'alpha'
                        alpha = varargin{n+1};
                        set(ba.sphs.h(i), 'FaceAlpha', alpha);
                        set(ba.sphs.h(i), 'EdgeAlpha', alpha);
                    otherwise
                        set(ba.sphs.h(i), varargin{n}, varargin{n + 1});
                end
            end
            
            % output if needed
            if nargout>0
                h = ba.sphs.h(i);
            end
        end
        function br_sph_on(ba, i)
            % BR_SPH_ON shows a sphere
            %
            % BR_SPH_ON(BA,I) shows the sphere denoting the brain region I.
            %
            % See also PlotBrainAtlas.
            
            if ishandle(ba.sphs.h(i))
                set(ba.sphs.h(i), 'Visible', 'on')
            end
        end
        function br_sph_off(ba, i)
            % BR_SPH_OFF hides a sphere
            %
            % BR_SPH_OFF(BA,I) hides the sphere denoting the brain region I.
            %
            % See also PlotBrainAtlas.
            
            if ishandle(ba.sphs.h(i))
                set(ba.sphs.h(i), 'Visible', 'off')
            end
        end
        function bool = br_sph_is_on(ba, i)
            % BR_SPH_IS_ON checks if sphere is visible
            %
            % BOOL = BR_SPH_IS_ON(BA,I) returns true if the sphere denoting
            %   the brain region I is visible and false otherwise.
            %
            % See also PlotBrainAtlas.
            
            bool = ~ishandle(ba.sphs.h(i)) && strcmpi(get(ba.sphs.h(i), 'Visible'), 'on');
        end
        function br_sphs(ba, i_vec, varargin)
            % BR_SPHS displays multiple brain regions as spheres
            %
            % BR_SPHS(BA,I_VEC) plots the spheres denoting the brain regions
            %   specified in I_VEC, if not plotted.
            %
            % BR_SPHS(BA,[]) plots the spheres for all possible brain regions.
            %
            % BR_SPHS(BA,I_VEC,'PropertyName',PropertyValue) sets the property
            %   of the multiple spheres' PropertyName to PropertyValue.
            %   All standard plot properties of surf can be used and also the sphere
            %   properties listed below.
            % SPHERE properties:
            %   Color  -   sphere color both edges and faces [default = 'k']
            %   Alpha  -   sphere transparency both edges and faces [default = 0.5]
            %   R      -   sphere radius [default = 1]
            %   The spheres properties can also be changed when hidden.
            %
            % See also PlotBrainAtlas, surf.
            
            % R - EdgeColor - EdgeAlpha - FaceColor - FaceAlpha - Color - Alpha
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'r'
                        R = varargin{n + 1};
                        nr = n + 1;
                    case 'edgecolor'
                        EdgeColor = varargin{n + 1};
                        nedgecolor = n + 1;
                    case 'edgealpha'
                        EdgeAlpha = varargin{n + 1};
                        nedgealpha = n + 1;
                    case 'facecolor'
                        FaceColor = varargin{n + 1};
                        nfacecolor = n + 1;
                    case 'facealpha'
                        FaceAlpha = varargin{n + 1};
                        nfacealpha = n + 1;
                    case 'color'
                        Color = varargin{n + 1};
                        ncolor = n + 1;
                    case 'alpha'
                        Alpha = varargin{n + 1};
                        nalpha = n + 1;
                end
            end
            
            if nargin<2 || isempty(i_vec)
                i_vec = 1:1:ba.atlas.getBrainRegions().length();
            end
            if isa(i_vec, 'IndexedDictionary')
                for m = 1:1:i_vec.length()
                    if exist('r','var') && numel(R)==length(i_vec)
                        varargin{nr} = R(m);
                    end
                    if exist('EdgeColor','var') && size(EdgeColor,1)==length(i_vec) && size(EdgeColor,2)==3
                        varargin{nedgecolor} = EdgeColor(m,:);
                    end
                    if exist('EdgeAlpha','var') && numel(EdgeAlpha)==length(i_vec)
                        varargin{nedgealpha} = EdgeAlpha(m);
                    end
                    if exist('FaceColor','var') && size(FaceColor,1)==length(i_vec) && size(FaceColor,2)==3
                        varargin{nfacecolor} = FaceColor(m,:);
                    end
                    if exist('FaceAlpha','var') && numel(FaceAlpha)==length(i_vec)
                        varargin{nfacealpha} = FaceAlpha(m);
                    end
                    if exist('Color','var') && size(Color,1)==length(i_vec) && size(Color,2)==3
                        varargin{ncolor} = Color(m,:);
                    end
                    if exist('Alpha','var') && numel(Alpha)==length(i_vec)
                        varargin{nalpha} = Alpha(m);
                    end
                    
                    ba.br_sph(m, varargin{:})
                end
            else
                for m = 1:1:length(i_vec)
                    if exist('r','var') && numel(R)==length(i_vec)
                        varargin{nr} = R(m);
                    end
                    if exist('EdgeColor','var') && size(EdgeColor,1)==length(i_vec) && size(EdgeColor,2)==3
                        varargin{nedgecolor} = EdgeColor(m,:);
                    end
                    if exist('EdgeAlpha','var') && numel(EdgeAlpha)==length(i_vec)
                        varargin{nedgealpha} = EdgeAlpha(m);
                    end
                    if exist('FaceColor','var') && size(FaceColor,1)==length(i_vec) && size(FaceColor,2)==3
                        varargin{nfacecolor} = FaceColor(m,:);
                    end
                    if exist('FaceAlpha','var') && numel(FaceAlpha)==length(i_vec)
                        varargin{nfacealpha} = FaceAlpha(m);
                    end
                    if exist('Color','var') && size(Color,1)==length(i_vec) && size(Color,2)==3
                        varargin{ncolor} = Color(m,:);
                    end
                    if exist('Alpha','var') && numel(Alpha)==length(i_vec)
                        varargin{nalpha} = Alpha(m);
                    end
                    
                    ba.br_sph(m, varargin{:})
                end
                
%                 ba.br_sph(i_vec(m), varargin{:})
            end
        end
        function br_sphs_on(ba, i_vec)
            % BR_SPHS_ON shows multiple spheres
            %
            % BR_SPHS_ON(BA,I_VEC) shows multiple spheres denoting the
            %   brain regions specified in I_VEC.
            %
            % BR_SPHS_ON(BA,[]) shows the spheres denoting all possible
            %   brain region combinations.
            %
            % See also PlotBrainAtlas.
            
            if nargin<2 || isempty(i_vec)
                i_vec = 1:1:ba.atlas.getBrainRegions().length();
            end
            
            for m = 1:1:length(i_vec)
                ba.br_sph_on(i_vec(m))
            end
        end
        function br_sphs_off(ba, i_vec)
            % BR_SPHS_OFF hides multiple spheres
            %
            % BR_SPHS_OFF(BA,I_VEC) hides multiple spheres denoting the
            %   brain regions specified in I_VEC.
            %
            % BR_SPHS_OFF(BA,[]) hides the spheres denoting all possible
            %   brain region combinations.
            %
            % See also PlotBrainAtlas.
            
            if nargin<2 || isempty(i_vec)
                i_vec = 1:1:ba.atlas.getBrainRegions().length();
            end
            
            for m = 1:1:length(i_vec)
                ba.br_sph_off(i_vec(m))
            end
        end
        function i = get_sph_i(ba, h)
            % GET_SPH_I order number of brain region corresponding to a sphere
            %
            % I = GET_SPH_I(BA,H) returns the order number of the brain regions
            %   corresponding to the sphere with handle H.
            %
            % See also PlotBrainAtlas.
            
            i = NaN;
            if ~isempty(h)
                for j = 1:1:ba.atlas.getBrainRegions().length()
                    if h==ba.sphs.h(j)
                        i = j;
                    end
                end
            end
        end
        function br = get_sph_br(ba, h)
            % GET_SPH_BR properties of brain region corresponding to a sphere
            %
            % BR = GET_SPH_BR(BA,H) returns the properties of the brain region
            %   BR corresponding to the sphere with handle H.
            %
            % See also PlotBrainAtlas.
            
            i = ba.get_sph_i(h);
            br = ba.atlas.get(i);
        end
        function br_sphs_settings(ba, i_vec, varargin)
            % BR_SPHS_SETTINGS sets spheres' properties
            %
            % BR_SPHS_SETTINGS(BA) allows the user to interractively
            %   change the spheres settings via a graphical user interface.
            %
            % BR_SPHS_SETTINGS(BA,'PropertyName',PropertyValue) sets the property
            %   of the GUI's PropertyName to PropertyValue.
            %   Admissible properties are:
            %       FigPosition  -   position of the GUI on the screen
            %       FigColor     -   background color of the GUI
            %       FigName      -   name of the GUI
            %
            % See also PlotBrainAtlas.
            
            if nargin<2
                i_vec = [];
            end
            
            % sets position of figure
            FigPosition = [.50 .30 .30 .30];
            FigColor = GUI.BKGCOLOR;
            FigName = 'Brain Region Sphere Settings';
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'figposition'
                        FigPosition = varargin{n + 1};
                    case 'figcolor'
                        FigColor = varargin{n + 1};
                    case 'figname'
                        FigName = varargin{n + 1};
                end
            end
            
            % create a figure
            if isempty(ba.f_sphs_settings) || ~ishandle(ba.f_sphs_settings)
                ba.f_sphs_settings = figure('Visible', 'off');
            end
            f = ba.f_sphs_settings;
            set(f,'units', 'normalized')
            set(f,'Position', FigPosition)
            set(f,'Color', FigColor)
            set(f,'Name', FigName)
            set(f,'MenuBar', 'none')
            set(f,'Toolbar', 'none')
            set(f,'NumberTitle', 'off')
            set(f,'DockControls', 'off')
            
            % Initialization
            ui_list = uicontrol(f, 'Style', 'listbox');
            set(ui_list, 'Units','normalized')
            set(ui_list, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_list, 'Value', i_vec)
            set(ui_list, 'Max', 2, 'Min', 0)
            set(ui_list, 'BackgroundColor', [1 1 1])
            set(ui_list, 'Position', [.08 .25 .30 .70])
            set(ui_list, 'TooltipString', 'Select brain regions');
            set(ui_list, 'Callback', {@cb_list});
            
            ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_label, 'Units','normalized')
            set(ui_checkbox_label, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_checkbox_label, 'Position', [.08 .15 .15 .10])
            set(ui_checkbox_label, 'String', 'label')
            set(ui_checkbox_label, 'Value', true)
            set(ui_checkbox_label, 'FontWeight', 'bold')
            set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_label, 'Callback', {@cb_label})
            
            ui_checkbox_name = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_name, 'Units','normalized')
            set(ui_checkbox_name, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_checkbox_name, 'Position', [.23 .15 .15 .10])
            set(ui_checkbox_name, 'String', 'name')
            set(ui_checkbox_name, 'Value', false)
            set(ui_checkbox_name, 'TooltipString', 'Shows brain regions by name')
            set(ui_checkbox_name, 'Callback', {@cb_name})
            
            ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_xyz, 'Units','normalized')
            set(ui_checkbox_xyz, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_checkbox_xyz, 'Position', [.08 .05 .15 .10])
            set(ui_checkbox_xyz, 'String', 'xyz')
            set(ui_checkbox_xyz, 'Value', false)
            set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by position')
            set(ui_checkbox_xyz, 'Callback', {@cb_xyz})
            
            %             ui_checkbox_hs = uicontrol(f, 'Style', 'checkbox');
            %             set(ui_checkbox_hs, 'Units','normalized')
            %             set(ui_checkbox_hs, 'BackgroundColor', GUI.BKGCOLOR)
            %             set(ui_checkbox_hs, 'Position', [.23 .05 .15 .10])
            %             set(ui_checkbox_hs, 'String', 'hemisphere')
            %             set(ui_checkbox_hs, 'Value', false)
            %             set(ui_checkbox_hs, 'TooltipString', 'Shows brain regions by hemisphere')
            %             set(ui_checkbox_hs, 'Callback', {@cb_hs})
            
            ui_button_show = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_show, 'Units','normalized')
            set(ui_button_show, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_show, 'Position', [.43 .85 .20 .10])
            set(ui_button_show, 'String', 'Show Regions')
            set(ui_button_show, 'TooltipString', 'Show selected brain regions')
            set(ui_button_show, 'Callback', {@cb_show})
            
            ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_hide, 'Units','normalized')
            set(ui_button_hide, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_hide, 'Position', [.73 .85 .20 .10])
            set(ui_button_hide, 'String', 'Hide Regions')
            set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
            set(ui_button_hide, 'Callback', {@cb_hide})
            
            ui_text = uicontrol(f, 'Style', 'text');
            set(ui_text, 'Units','normalized')
            set(ui_text, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_text, 'String', 'transparency')
            set(ui_text, 'Position', [.63 .70 .30 .10])
            set(ui_text, 'HorizontalAlignment', 'center')
            set(ui_text, 'FontWeight', 'bold')
            
            ui_button_color = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_color, 'Units','normalized')
            set(ui_button_color, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_color, 'Position', [.43 .60 .15 .10])
            set(ui_button_color, 'String', 'sphere color')
            set(ui_button_color, 'HorizontalAlignment', 'center')
            set(ui_button_color, 'TooltipString', 'Brain region color (applied both to faces and edges)')
            set(ui_button_color, 'Callback', {@cb_color})
            
            ui_slider_alpha = uicontrol(f, 'Style', 'slider');
            set(ui_slider_alpha, 'Units','normalized')
            set(ui_slider_alpha, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_slider_alpha, 'Position', [.63 .60 .30 .10])
            set(ui_slider_alpha, 'String', 'Brain region transparency')
            set(ui_slider_alpha, 'Min', 0, 'Max',1, 'Value',.5);
            set(ui_slider_alpha, 'TooltipString','Brain region transparency (applied both to faces and edges)')
            set(ui_slider_alpha, 'Callback',{@cb_alpha})
            
            ui_button_facecolor = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_facecolor, 'Units','normalized')
            set(ui_button_facecolor, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_facecolor, 'Position', [.43 .425 .15 .10])
            set(ui_button_facecolor, 'String', 'face color')
            set(ui_button_facecolor, 'HorizontalAlignment', 'center')
            set(ui_button_facecolor, 'TooltipString', 'Brain region face color')
            set(ui_button_facecolor, 'Callback', {@cb_facecolor})
            
            ui_slider_facealpha = uicontrol(f, 'Style', 'slider');
            set(ui_slider_facealpha, 'Units', 'normalized')
            set(ui_slider_facealpha, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_slider_facealpha, 'Position', [.63 .425 .30 .10])
            set(ui_slider_facealpha, 'String', 'Brain region transparency')
            set(ui_slider_facealpha, 'Min', 0, 'Max', 1, 'Value', .5)
            set(ui_slider_facealpha, 'TooltipString', 'Brain region face transparency')
            set(ui_slider_facealpha, 'Callback', {@cb_facealpha})
            
            ui_button_edgecolor = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_edgecolor, 'Units', 'normalized')
            set(ui_button_edgecolor, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_edgecolor, 'Position', [.43 .25 .15 .10])
            set(ui_button_edgecolor, 'String', 'edge color')
            set(ui_button_edgecolor, 'HorizontalAlignment', 'center')
            set(ui_button_edgecolor, 'TooltipString', 'Brain region edge color')
            set(ui_button_edgecolor, 'Callback', {@cb_edgecolor})
            
            ui_slider_edgealpha = uicontrol(f, 'Style', 'slider');
            set(ui_slider_edgealpha, 'Units', 'normalized')
            set(ui_slider_edgealpha, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_slider_edgealpha, 'Position', [.63 .25 .30 .10])
            set(ui_slider_edgealpha, 'String', 'Brain transparency')
            set(ui_slider_edgealpha, 'Min', 0, 'Max', 1, 'Value', .5)
            set(ui_slider_edgealpha, 'TooltipString', 'Brain region edge transparency')
            set(ui_slider_edgealpha, 'Callback', {@cb_edgealpha})
            
            ui_text_radius = uicontrol(f, 'Style', 'text');
            set(ui_text_radius, 'Units', 'normalized')
            set(ui_text_radius, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_text_radius, 'Position', [.43 .075 .10 .10])
            set(ui_text_radius, 'String', 'radius ')
            set(ui_text_radius, 'HorizontalAlignment', 'left')
            set(ui_text_radius, 'FontWeight', 'bold')
            
            ui_edit_radius = uicontrol(f, 'Style', 'edit');
            set(ui_edit_radius, 'Units', 'normalized')
            set(ui_edit_radius, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_edit_radius, 'Position', [.63 .085 .30 .10])
            set(ui_edit_radius, 'HorizontalAlignment', 'center')
            set(ui_edit_radius, 'FontWeight', 'bold')
            set(ui_edit_radius, 'TooltipString', 'Brain region sphere radius')
            set(ui_edit_radius, 'String', '1')
            set(ui_edit_radius, 'Callback', {@cb_radius})
            
            update_list()
            set(f,'Visible','on');
            
            function update_list()
                
                % get info
                for j = 1:1:ba.atlas.getBrainRegions().length()
                    labels{j} =  ba.atlas.getBrainRegions().getValue(j).getLabel(); %#ok<AGROW>
                    ids{j} = ba.atlas.getBrainRegions().getValue(j).getID(); %#ok<AGROW>
                    xs{j} =  ba.atlas.getBrainRegions().getValue(j).getX(); %#ok<AGROW>
                    ys{j} =  ba.atlas.getBrainRegions().getValue(j).getY(); %#ok<AGROW>
                    zs{j} =  ba.atlas.getBrainRegions().getValue(j).getZ(); %#ok<AGROW>
                end
                
                % Set list names
                if get(ui_checkbox_label,'Value')
                    set(ui_list, 'String', labels)
                elseif get(ui_checkbox_name,'Value')
                    set(ui_list, 'String', ids)
                elseif get(ui_checkbox_xyz,'Value')
                    xyz = cell(1,ba.atlas.getBrainRegions().length());
                    for j = 1:1:ba.atlas.getBrainRegions().length()
                        xyz{j} = [num2str(xs{j}) '   ' ...
                            num2str(ys{j}) '   ' ...
                            num2str(zs{j})];
                    end
                    set(ui_list, 'String', xyz)
                elseif get(ui_checkbox_hs, 'Value')
                    % set(ui_list, 'String', ba.atlas.getProps(BrainRegion.HS))
                end
            end
            function cb_list(~,~)  % (src,event)
                update_list()
            end
            function cb_label(~,~)  % (src,event)
                set(ui_checkbox_label,'Value',true)
                set(ui_checkbox_label,'FontWeight','bold')
                
                set(ui_checkbox_name,'Value',false)
                set(ui_checkbox_name,'FontWeight','normal')
                
                %                 set(ui_checkbox_hs,'Value',false)
                %                 set(ui_checkbox_hs,'FontWeight','normal')
                
                set(ui_checkbox_xyz,'Value',false)
                set(ui_checkbox_xyz,'FontWeight','normal')
                
                update_list()
            end
            function cb_name(~,~)  % (src,event)
                set(ui_checkbox_label,'Value',false)
                set(ui_checkbox_label,'FontWeight','normal')
                
                set(ui_checkbox_name,'Value',true)
                set(ui_checkbox_name,'FontWeight','bold')
                
                %                 set(ui_checkbox_hs,'Value',false)
                %                 set(ui_checkbox_hs,'FontWeight','normal')
                
                set(ui_checkbox_xyz,'Value',false)
                set(ui_checkbox_xyz,'FontWeight','normal')
                
                update_list()
            end
            %             function cb_hs(~,~)  % (src,event)
            %                 set(ui_checkbox_label,'Value',false)
            %                 set(ui_checkbox_label,'FontWeight','normal')
            %
            %                 set(ui_checkbox_name,'Value',false)
            %                 set(ui_checkbox_name,'FontWeight','normal')
            %
            %                 set(ui_checkbox_hs,'Value',true)
            %                 set(ui_checkbox_hs,'FontWeight','bold')
            %
            %                 set(ui_checkbox_xyz,'Value',false)
            %                 set(ui_checkbox_xyz,'FontWeight','normal')
            %
            %                 update_list()
            %             end
            function cb_xyz(~,~)  % (src,event)
                set(ui_checkbox_label,'Value',false)
                set(ui_checkbox_label,'FontWeight','normal')
                
                set(ui_checkbox_name,'Value',false)
                set(ui_checkbox_name,'FontWeight','normal')
                
                %                 set(ui_checkbox_hs,'Value',false)
                %                 set(ui_checkbox_hs,'FontWeight','normal')
                
                set(ui_checkbox_xyz,'Value',true)
                set(ui_checkbox_xyz,'FontWeight','bold')
                
                update_list()
            end
            function cb_show(~,~)  % (src,event)
                ba.br_sphs_on(get_br_list())
            end
            function cb_hide(~,~)  % (src,event)
                ba.br_sphs_off(get_br_list())
            end
            function cb_color(~,~)  %  (src,event)
                color = uisetcolor();
                
                if length(color)==3
                    ba.br_sphs(get_br_list(), 'color',color)
                end
            end
            function cb_facecolor(~,~)  % (src,event)
                color = uisetcolor();
                
                if length(color)==3
                    ba.br_sphs(get_br_list(),'FaceColor',color)
                end
            end
            function cb_edgecolor(~,~)  % (src,event)
                color = uisetcolor();
                
                if length(color)==3
                    ba.br_sphs(get_br_list(),'EdgeColor',color)
                end
            end
            function cb_alpha(~,~)  % (src,event)
                ba.br_sphs(get_br_list(),'alpha',get(ui_slider_alpha,'Value'))
                set(ui_slider_facealpha,'Value',get(ui_slider_alpha,'Value'))
                set(ui_slider_edgealpha,'Value',get(ui_slider_alpha,'Value'))
            end
            function cb_facealpha(~,~)  % (src,event)
                ba.br_sphs(get_br_list(),'FaceAlpha',get(ui_slider_facealpha,'Value'))
            end
            function cb_edgealpha(~,~)  % (src,event)
                ba.br_sphs(get_br_list(),'EdgeAlpha',get(ui_slider_edgealpha,'Value'))
            end
            function cb_radius(~,~)
                R = real(str2num(get(ui_edit_radius, 'String')));
                
                if isempty(R) || R<=0
                    set(ui_edit_radius, 'String', '1')
                    R = 1;
                end
                ba.br_sphs(get_br_list(), 'r', R)
            end
            function bri = get_br_list()
                if ba.atlas.getBrainRegions().length()>0
                    bri = get(ui_list, 'Value');
                else
                    bri = [];
                end
            end
        end
        function br_sphs_delete(ba)
            for i = 1:ba.atlas.getBrainRegions().length()
                delete(ba.sphs.h(i))
            end
        end
        function sphs_handles = getSphsHandles(ba)
            sphs_handles = ba.sphs;
        end
        function answer = checkIfSphsNotEmpty(ba)
            answer = any(ba.sphs.h, 'all');
        end
    end
    methods  % editing functions lab
        function h = br_lab(ba, i, varargin)
            % BR_LAB displays brain region as label
            %
            % BR_LAB(BA,I) denotes the brain regions I as a label, if not plotted.
            %
            % H = BR_LAB(BA,I) returns the handle to the label denoting the brain
            %   region I.
            %
            % BR_LAB(BA,I,'PropertyName',PropertyValue) sets the property
            %   of the label's PropertyName to PropertyValue.
            %   All standard plot properties of text can be used.
            %   The label properties can also be changed when hidden.
            %
            % See also PlotBrainAtlas, text.
            
            ba.set_axes();
            
            % center coordinates and label
            X = ba.atlas.getBrainRegions().getValue(i).getX();
            Y = ba.atlas.getBrainRegions().getValue(i).getY();
            Z = ba.atlas.getBrainRegions().getValue(i).getZ();
            LAB = ba.atlas.getBrainRegions().getValue(i).getLabel();
            
            % display the text
            if ~ishandle(ba.labs.h(i))
                
                ba.labs.h(i) = text( ...
                    X, ...
                    Y, ...
                    Z, ...
                    LAB,...
                    'Parent', ba.get_axes(), ...
                    'FontSize', PlotBrainAtlas.INIT_LAB_FONT_SIZE,...
                    'Color' ,PlotBrainAtlas.INIT_LAB_FONT_COLOR,...
                    'FontName', PlotBrainAtlas.INIT_LAB_FONT_NAME,...
                    'Interpreter', PlotBrainAtlas.INIT_LAB_FONT_INTERPRETER);
            else
                if ~isequal(ba.labs.X(i), {X}) || ~isequal(ba.labs.Y(i), {Y}) || ~isequal(ba.labs.Z(i), {Z}) || ~strcmp(ba.labs.LAB(i), LAB) %#ok<BDSCA>
                    
                    set(ba.labs.h(i), 'Position', [X Y Z]);
                    set(ba.labs.h(i), 'String', LAB);
                end
            end
            
            % saves new data
            ba.labs.X(i) = num2cell(X);
            ba.labs.Y(i) = num2cell(Y);
            ba.labs.Z(i) = num2cell(Z);
            ba.labs.LAB(i) = {LAB};
            
            % sets properties
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'color'
                        set(ba.labs.h(i), 'Color', varargin{n + 1});
                    case 'size'
                        set(ba.labs.h(i), 'FontSize', varargin{n + 1});
                    case 'name'
                        set(ba.labs.h(i), 'FontName', varargin{n + 1});
                    otherwise
                        set(ba.labs.h(i), varargin{n}, varargin{n + 1});
                end
            end
            
            % output if needed
            if nargout>0
                h = ba.labs.h(i);
            end
        end
        function br_lab_on(ba, i)
            % BR_LAB_ON shows a label
            %
            % BR_LAB_ON(BA,I) shows the label denoting the brain region I.
            %
            % See also PlotBrainAtlas.
            
            if ishandle(ba.labs.h(i))
                set(ba.labs.h(i), 'Visible', 'on')
            end
        end
        function br_lab_off(ba, i)
            % BR_LAB_OFF hides a label
            %
            % BR_LAB_OFF(BA,I) hides the label denoting the brain region I.
            %
            % See also PlotBrainAtlas.
            
            if ishandle(ba.labs.h(i))
                set(ba.labs.h(i), 'Visible', 'off')
            end
        end
        function bool = br_lab_is_on(ba, i)
            % BR_LAB_IS_ON checks if label is visible
            %
            % BOOL = BR_LAB_IS_ON(BA,I) returns true if the label denoting
            %   the brain region I is visible and false otherwise.
            %
            % See also PlotBrainAtlas.
            
            bool = ishandle(ba.labs.h(i)) && strcmpi(get(ba.labs.h(i), 'Visible'), 'on');
        end
        function br_labs(ba, i_vec, varargin)
            % BR_LABS displays multiple brain regions as labels
            %
            % BR_LABS(BA,I_VEC) plots the labels denoting the brain regions
            %   specified in I_VEC, if not plotted.
            %
            % BR_LABS(BA,[]) plots the labels for all possible brain regions.
            %
            % BR_LABS(BA,I_VEC,'PropertyName',PropertyValue) sets the property
            %   of the multiple labels' PropertyName to PropertyValue.
            %   All standard plot properties of text can be used.
            %   The label properties can also be changed when hidden.
            %
            % See also PlotBrainAtlas, surf.
            
            % FontSize - FontName - Color - Interpreter
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'fontsize'
                        FontSize = varargin{n+1};
                        nfontsize = n+1;
                    case 'fontname'
                        FontName = varargin{n+1};
                        nfontname = n+1;
                    case 'color'
                        Color = varargin{n+1};
                        ncolor = n+1;
                    case 'interpreter'
                        INTERP = varargin{n+1};
                        ninterp = n+1;
                end
            end
            
            if nargin<2 || isempty(i_vec)
                i_vec = 1:1:ba.atlas.getBrainRegions().length();
            end
            
            if isa(i_vec, 'IndexedDictionary')
                for m = 1:1:i_vec.length()
                    
                    if exist('FontSize','var') && numel(FontSize)==length(i_vec)
                        varargin{nfontsize} = FontSize(m);
                    end
                    if exist('FontName','var') && numel(FontName)==length(i_vec)
                        varargin{nfontname} = FontName(m);
                    end
                    if exist('Color','var') && size(Color,1)==length(i_vec) && size(Color,2)==3
                        varargin{ncolor} = Color(m,:);
                    end
                    if exist('INTERP','var') && numel(INTERP,1)==length(i_vec)
                        varargin{ninterp} = INTERP(m);
                    end
                    
                    ba.br_lab(m, varargin{:})
                end
                
            else
                for m = 1:1:length(i_vec)
                    if exist('FontSize','var') && numel(FontSize)==length(i_vec)
                        varargin{nfontsize} = FontSize(m);
                    end
                    if exist('FontName','var') && numel(FontName)==length(i_vec)
                        varargin{nfontname} = FontName(m);
                    end
                    if exist('Color','var') && size(Color,1)==length(i_vec) && size(Color,2)==3
                        varargin{ncolor} = Color(m,:);
                    end
                    if exist('INTERP','var') && numel(INTERP,1)==length(i_vec)
                        varargin{ninterp} = INTERP(m);
                    end
                    
                    ba.br_lab(m, varargin{:})
                end
            end
        end
        function br_labs_on(ba, i_vec)
            % BR_LABS_ON shows multiple labels
            %
            % BR_LABS_ON(BA,I_VEC) shows multiple labels denoting the
            %   brain regions specified in I_VEC.
            %
            % BR_LABS_ON(BA,[]) shows the labels denoting all possible
            %   brain region combinations.
            %
            % See also PlotBrainAtlas.
            
            if nargin<2 || isempty(i_vec)
                i_vec = 1:1:ba.atlas.getBrainRegions().length();
            end
            
            for m = 1:1:length(i_vec)
                ba.br_lab_on(i_vec(m))
            end
        end
        function br_labs_off(ba, i_vec)
            % BR_LABS_OFF hides multiple labels
            %
            % BR_LABS_OFF(BA,I_VEC) hides multiple labels denoting the
            %   brain regions specified in I_VEC.
            %
            % BR_LABS_OFF(BA,[]) hides the labels denoting all possible
            %   brain region combinations.
            %
            % See also PlotBrainAtlas.
            
            if nargin<2 || isempty(i_vec)
                i_vec = 1:1:ba.atlas.getBrainRegions().length();
            end
            
            for m = 1:1:length(i_vec)
                ba.br_lab_off(i_vec(m))
            end
        end
        function i = get_lab_i(ba, h)
            % GET_LAB_I order number of brain region corresponding to a label
            %
            % I = GET_LAB_I(BA,H) returns the order number of the brain regions
            %   corresponding to the label with handle H.
            %
            % See also PlotBrainAtlas.
            
            i = NaN;
            if ~isempty(h)
                for j = 1:1:ba.atlas.getBrainRegions().length()
                    if h == ba.labs.h(j)
                        i = j;
                    end
                end
            end
        end
        function br = get_lab_br(ba, h)
            % GET_LAB_BR properties of brain region corresponding to a label
            %
            % BR = GET_LAB_BR(BA,H) returns the properties of the brain region
            %   BR corresponding to the label with handle H.
            %
            % See also PlotBrainAtlas.
            
            i = ba.get_lab_i(h);
            br = ba.atlas.get(i);
        end
        function br_labs_settings(ba, i_vec, varargin)
            % BR_LABS_SETTINGS sets labels' properties
            %
            % BR_LABS_SETTINGS(BA) allows the user to interractively
            %   change the labels settings via a graphical user interface.
            %
            % BR_LABS_SETTINGS(BA,'PropertyName',PropertyValue) sets the property
            %   of the GUI's PropertyName to PropertyValue.
            %   Admissible properties are:
            %       FigPosition  -   position of the GUI on the screen
            %       FigColor     -   background color of the GUI
            %       FigName      -   name of the GUI
            %
            % See also PlotBrainAtlas.
            
            if nargin<2
                i_vec = [];
            end
            
            % sets position of figure
            FigPosition = [.50 .30 .25 .30];
            FigColor = GUI.BKGCOLOR;
            FigName = 'Brain Region Label Settings';
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'figposition'
                        FigPosition = varargin{n + 1};
                    case 'figcolor'
                        FigColor = varargin{n + 1};
                    case 'figname'
                        FigName = varargin{n + 1};
                end
            end
            
            % create a figure
            if isempty(ba.f_labs_settings) || ~ishandle(ba.f_labs_settings)
                ba.f_labs_settings = figure('Visible', 'off');
            end
            f = ba.f_labs_settings;
            set(f,'units', 'normalized')
            set(f,'Position', FigPosition)
            set(f,'Color', FigColor)
            set(f,'Name', FigName)
            set(f,'MenuBar', 'none')
            set(f,'Toolbar', 'none')
            set(f,'NumberTitle', 'off')
            set(f,'DockControls', 'off')
            
            % Initialization
            ui_list = uicontrol(f, 'Style', 'listbox');
            set(ui_list, 'Units', 'normalized')
            set(ui_list, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_list, 'Value', i_vec)
            set(ui_list, 'Max', 2, 'Min', 0)
            set(ui_list, 'BackgroundColor', [1 1 1])
            set(ui_list, 'Position', [.05 .25 .40 .70])
            set(ui_list, 'TooltipString', 'Select brain regions');
            set(ui_list, 'Callback', {@cb_list});
            
            ui_checkbox_label = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_label, 'Units', 'normalized')
            set(ui_checkbox_label, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_checkbox_label, 'Position', [.05 .125 .20 .10])
            set(ui_checkbox_label, 'String', 'label')
            set(ui_checkbox_label, 'Value', true)
            set(ui_checkbox_label, 'FontWeight', 'bold')
            set(ui_checkbox_label, 'TooltipString', 'Shows brain regions by label')
            set(ui_checkbox_label, 'Callback', {@cb_label})
            
            ui_checkbox_name = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_name, 'Units', 'normalized')
            set(ui_checkbox_name, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_checkbox_name, 'Position', [.25 .125 .20 .10])
            set(ui_checkbox_name, 'String', 'name')
            set(ui_checkbox_name, 'Value', false)
            set(ui_checkbox_name, 'TooltipString','Shows brain regions by name')
            set(ui_checkbox_name, 'Callback', {@cb_name})
            
            ui_checkbox_xyz = uicontrol(f, 'Style', 'checkbox');
            set(ui_checkbox_xyz, 'Units', 'normalized')
            set(ui_checkbox_xyz, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_checkbox_xyz, 'Position', [.05 .025 .20 .10])
            set(ui_checkbox_xyz, 'String', 'xyz')
            set(ui_checkbox_xyz, 'Value', false)
            set(ui_checkbox_xyz, 'TooltipString', 'Shows brain regions by position')
            set(ui_checkbox_xyz, 'Callback', {@cb_xyz})
            
            %             ui_checkbox_hs = uicontrol(f, 'Style', 'checkbox');
            %             set(ui_checkbox_hs, 'Units', 'normalized')
            %             set(ui_checkbox_hs, 'BackgroundColor', GUI.BKGCOLOR)
            %             set(ui_checkbox_hs, 'Position', [.25 .025 .20 .10])
            %             set(ui_checkbox_hs, 'String', 'hemisphere')
            %             set(ui_checkbox_hs, 'Value', false)
            %             set(ui_checkbox_hs, 'TooltipString', 'Shows brain regions by hemisphere')
            %             set(ui_checkbox_hs, 'Callback', {@cb_hs})
            
            ui_button_show = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_show, 'Units', 'normalized')
            set(ui_button_show, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_show, 'Position', [.50 .85 .20 .10])
            set(ui_button_show, 'String', 'Show Regions')
            set(ui_button_show, 'TooltipString', 'Show selected brain regions')
            set(ui_button_show, 'Callback', {@cb_show})
            
            ui_button_hide = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_hide, 'Units', 'normalized')
            set(ui_button_hide, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_hide, 'Position', [.75 .85 .20 .10])
            set(ui_button_hide, 'String', 'Hide Regions')
            set(ui_button_hide, 'TooltipString', 'Hide selected brain regions')
            set(ui_button_hide, 'Callback', {@cb_hide})
            
            ui_button_font = uicontrol(f,'Style', 'pushbutton');
            set(ui_button_font, 'Units', 'normalized')
            set(ui_button_font, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_font,'Position',[.50 .55 .20 .10])
            set(ui_button_font,'String','Font')
            set(ui_button_font,'TooltipString','Brain regions labels font')
            set(ui_button_font,'Callback',{@cb_font})
            
            ui_button_color = uicontrol(f, 'Style', 'pushbutton');
            set(ui_button_color, 'Units', 'normalized')
            set(ui_button_color, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_button_color, 'Position' ,[.75 .55 .20 .10])
            set(ui_button_color, 'String', 'Font Color')
            set(ui_button_color, 'TooltipString', 'Brain regions labels color')
            set(ui_button_color, 'Callback', {@cb_color})
            
            ui_text_interpreter = uicontrol(f, 'Style', 'text');
            set(ui_text_interpreter, 'Units', 'normalized')
            set(ui_text_interpreter, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_text_interpreter, 'Position', [.50 .225 .20 .10])
            set(ui_text_interpreter, 'String', 'interpreter')
            set(ui_text_interpreter, 'HorizontalAlignment', 'left')
            set(ui_text_interpreter, 'FontWeight', 'bold')
            
            ui_popup_interpreter = uicontrol(f, 'Style', 'popup', 'String', {''});
            set(ui_popup_interpreter, 'Units', 'normalized')
            set(ui_popup_interpreter, 'BackgroundColor', GUI.BKGCOLOR)
            set(ui_popup_interpreter, 'Position', [.75 .25 .20 .10])
            set(ui_popup_interpreter, 'String', {'none', 'tex', 'latex'})
            set(ui_popup_interpreter, 'Value', 2)
            set(ui_popup_interpreter, 'TooltipString', 'Brain regions labels interpreter');
            set(ui_popup_interpreter, 'Callback', {@cb_interpreter})
            
            update_list()
            set(f,'Visible','on')
            
            function update_list()
                
                % get info
                for j = 1:1:ba.atlas.getBrainRegions().length()
                    labels{j} =  ba.atlas.getBrainRegions().getValue(j).getLabel(); %#ok<AGROW>
                    ids{j} = ba.atlas.getBrainRegions().getValue(j).getID(); %#ok<AGROW>
                    xs{j} =  ba.atlas.getBrainRegions().getValue(j).getX(); %#ok<AGROW>
                    ys{j} =  ba.atlas.getBrainRegions().getValue(j).getY(); %#ok<AGROW>
                    zs{j} =  ba.atlas.getBrainRegions().getValue(j).getZ(); %#ok<AGROW>
                end
                
                % Set list names
                if get(ui_checkbox_label,'Value')
                    set(ui_list, 'String', labels)
                elseif get(ui_checkbox_name,'Value')
                    set(ui_list, 'String', ids)
                elseif get(ui_checkbox_xyz,'Value')
                    xyz = cell(1,ba.atlas.getBrainRegions().length());
                    for j = 1:1:ba.atlas.getBrainRegions().length()
                        xyz{j} = [num2str(xs{j}) '   ' ...
                            num2str(ys{j}) '   ' ...
                            num2str(zs{j})];
                    end
                    set(ui_list,'String',xyz)
                elseif get(ui_checkbox_hs,'Value')
                    %set(ui_list,'String',ba.atlas.getProps(BrainRegion.HS))
                end
            end
            function cb_list(~,~)  % (src,event)
                update_list()
            end
            function cb_label(~,~)  % (src,event)
                set(ui_checkbox_label,'Value',true)
                set(ui_checkbox_label,'FontWeight','bold')
                
                set(ui_checkbox_name,'Value',false)
                set(ui_checkbox_name,'FontWeight','normal')
                
                %                 set(ui_checkbox_hs,'Value',false)
                %                 set(ui_checkbox_hs,'FontWeight','normal')
                
                set(ui_checkbox_xyz,'Value',false)
                set(ui_checkbox_xyz,'FontWeight','normal')
                
                update_list()
            end
            function cb_name(~,~)  % (src,event)
                set(ui_checkbox_label,'Value',false)
                set(ui_checkbox_label,'FontWeight','normal')
                
                set(ui_checkbox_name,'Value',true)
                set(ui_checkbox_name,'FontWeight','bold')
                
                %                 set(ui_checkbox_hs,'Value',false)
                %                 set(ui_checkbox_hs,'FontWeight','normal')
                
                set(ui_checkbox_xyz,'Value',false)
                set(ui_checkbox_xyz,'FontWeight','normal')
                
                update_list()
            end
            %             function cb_hs(~,~)  % (src,event)
            %                 set(ui_checkbox_label,'Value',false)
            %                 set(ui_checkbox_label,'FontWeight','normal')
            %
            %                 set(ui_checkbox_name,'Value',false)
            %                 set(ui_checkbox_name,'FontWeight','normal')
            %
            %                 set(ui_checkbox_hs,'Value',true)
            %                 set(ui_checkbox_hs,'FontWeight','bold')
            %
            %                 set(ui_checkbox_xyz,'Value',false)
            %                 set(ui_checkbox_xyz,'FontWeight','normal')
            %
            %                 update_list()
            %             end
            function cb_xyz(~,~)  % (src,event)
                set(ui_checkbox_label, 'Value', false)
                set(ui_checkbox_label, 'FontWeight', 'normal')
                
                set(ui_checkbox_name, 'Value', false)
                set(ui_checkbox_name, 'FontWeight', 'normal')
                
                %                 set(ui_checkbox_hs,'Value',false)
                %                 set(ui_checkbox_hs,'FontWeight','normal')
                
                set(ui_checkbox_xyz, 'Value', true)
                set(ui_checkbox_xyz, 'FontWeight', 'bold')
                
                update_list()
            end
            function cb_show(~,~)  % (src,event)
                ba.br_labs(get_br_list())
                ba.br_labs_on(get_br_list())
            end
            function cb_hide(~,~)  % (src,event)
                ba.br_labs_off(get_br_list())
            end
            function cb_color(~,~)  %  (src,event)
                color = uisetcolor();
                
                if length(color)==3
                    ba.br_labs(get_br_list(), 'color', color)
                end
            end
            function cb_font(~,~)  %  (src,event)
                font = uisetfont;
                
                if isstruct(font)
                    ba.br_labs(get_br_list(), 'FontSize', font.FontSize,...
                        'FontName', font.FontName,...
                        'FontWeight', font.FontWeight,...
                        'FontAngle', font.FontAngle,...
                        'FontUnits', font.FontUnits)
                end
            end
            function cb_interpreter(~,~)  %  (src,event)
                string = get(ui_popup_interpreter, 'String');
                interpreter = string{get(ui_popup_interpreter, 'Value')};
                ba.br_labs(get_br_list(), 'interpreter', interpreter)
            end
            function bri = get_br_list()
                if ba.atlas.getBrainRegions().length()>0
                    bri = get(ui_list, 'Value');
                else
                    bri = [];
                end
            end
        end
        function br_labs_delete(ba)
            for i = 1:ba.atlas.getBrainRegions().length()
                delete(ba.labs.h(i))
            end
        end
        function labs_handles = getLabsHandles(ba)
            labs_handles = ba.labs;
        end
        function answer = checkIfLabsNotEmpty(ba)
            answer = any(ba.labs.h, 'all');
        end
    end
    methods  % distance               
        function distance = calculatePointDistance(ba, i)   
            % point coords
            x = ba.atlas.getBrainRegions().getValue(i).getX();
            y = ba.atlas.getBrainRegions().getValue(i).getY();
            z = ba.atlas.getBrainRegions().getValue(i).getZ();
            
            % surf coords
            brain_surf_coords = ba.getPlotBrainSurfCoords();
            
            % calculate distance
            distance = zeros(1, size(brain_surf_coords, 2));
            for i = 1:1:length(brain_surf_coords(1,:))
                distance(1, i) = 1 / sqrt( ...
                    (x - brain_surf_coords(1, i))^2 + ...
                    (y - brain_surf_coords(2, i))^2 + ...
                    (z - brain_surf_coords(3, i))^2 ...
                    );
            end
        end
        function distance = calculatePointsDistance(ba, selected)
            if nargin < 2
                selected = [1:1:ba.atlas.getBrainregions().length()]; %#ok<NBRAK>
            end
            
            % surf coords
            brain_surf_coords = ba.getPlotBrainSurfCoords();
            distance = zeros(1, size(brain_surf_coords, 2));
            for i = 1:1:length(selected)
                point_distance = ba.calculatePointDistance(selected(i));
                
                for j = 1:1:length(distance)
                    if point_distance(1, j) > distance(1, j) 
                        distance(1, j) = point_distance(1, j);
                    end
                end              
            end            
        end
        function distanceMapOn(ba, selected)
            distance_vector = ba.calculatePointsDistance(selected);
            brain_surface = ba.getBrainSurface();
            set(brain_surface, 'Facecolor', 'interp')
            set(brain_surface, 'CData', distance_vector)
            minimu = min(distance_vector(:));
            p99 = prctile(distance_vector(:), 99);  
            caxis([minimu p99])            
        end
        function distanceMapOff(ba, style)
            coords = ba.getPlotBrainSurfCoords();
            z_vector = coords(3, :);
            brain_surface = ba.getBrainSurface();
            if ~isequal(style, 'interp')
                set(brain_surface, 'Facecolor', style)
            end
            set(brain_surface, 'CData', z_vector)
            minimu = min(z_vector(:));
            maxi = max(z_vector(:));
            caxis([minimu maxi])
        end
    end
    methods (Access = protected)  % deep copy
        function cp = copyElement(ba)
            
            % Make a shallow copy
            cp = copyElement@PlotBrainSurf(ba);
            % Make a deep copy
            cp.atlas = copy(ba.atlas);
            % resets the graphic handles
            cp.syms.h = NaN(1, ba.atlas.getBrainRegions().length());
            cp.f_syms_settings = NaN;
            cp.sphs.h = NaN(1, ba.atlas.getBrainRegions().length());
            cp.f_sphs_settings = NaN;
            cp.labs.h = NaN(1, ba.atlas.getBrainRegions().length());
            cp.f_labs_settings = NaN;
        end
    end
end