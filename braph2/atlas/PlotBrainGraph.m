classdef PlotBrainGraph < PlotBrainAtlas
    % PlotBrainGraph Plot and manage edges of a graph
    % PlotBrainGraph plots and manages the edges of a brain graph. The
    % edges can be modified using the settings method.
    % It is a subclass of PlotBrainAtlas.
    %
    % PlotBrainGraph plots and manages the edges of a brain graph. The
    % edges can be modified using the settings method. PlotBrainGraph
    % utiizes the surface and brain regions created in PlotBrainSurf and
    % PlotBrainAtlas.
    %
    % PlotBrainGraph basic methods:
    %   PlotBrainGraph              - constructor
    %   initEdgesProperties         - inits PlotBrainGraph properties
    %
    % PlotBrainGraph edge methods:
    %   link_edge                   - plots an edge as line with different properties
    %   link_edge_on                - sets the edge visible
    %   link_edge_off               - sets the edge invisible
    %   link_edges                  - plots multiple edges as lines
    %   link_edges_on               - sets multiple edges visible
    %   link_edges_off              - sets multiple edges invisible
    %   link_edges_settings         - panel to set edges properties
    %   link_edges_is_on            - bool, checks if the link es on
    %
    %   arrow_edge                  - plots an edge as an arrow with different properties
    %   arrow_edge_on               - sets the edge visible
    %   arrow_edge_off              - sets the edge invisible
    %   arrow_edges                 - plots multiple edges as lines
    %   arrow_edges_on              - sets multiple edges visible
    %   arrow_edges_off             - sets multiple edges invisible
    %   arrow_edges_settings        - panel to set edges properties    
    %   arrow_edges_is_on           - bool, checks if the arrow link es on
    %
    %   cylinder_edge               - plots an edge as line with different properties
    %   cylinder_edge_on            - sets the edge visible
    %   cylinder_edge_off           - sets the edge invisible
    %   cylinder_edges              - plots multiple edges as lines
    %   cylinder_edges_on           - sets multiple edges visible
    %   cylinder_edges_off          - sets multiple edges invisible
    %   cylinder_edges_settings     - panel to set edges properties
    %   cylinder_edges_is_on        - bool, checks if the cylinder link is on
    %
    % See also PlotBrainAtlas, PlotBrainSurf.
    
    properties (Access = protected)
        edges  % structure of 2D cell arrays containing edge properties
        f_edges_settings  % edge settings figure handle
        f_arrs_settings  % arrow settings figure handle
        f_cyls_settings  % cylinder settings figure handle
        
        % edge line
        INIT_LIN_COLOR = [0 0 0];
        
        % Arrows
        INIT_ARR_COLOR = [0 0 0];
        INIT_ARR_SWIDTH = .1;
        INIT_ARR_HLENGTH = 1;
        INIT_ARR_HWIDTH = 1;
        INIT_ARR_HNODE = .5;
        INIT_ARR_N = 32;
        
        % Cylinders
        INIT_CYL_COLOR = [0 0 0];
        INIT_CYL_R = .1;
        INIT_CYL_N = 32;
    end
    methods
        function bg = PlotBrainGraph(atlas)
            % PLOTBRAINGRAPH constructs the brain graph plot
            %
            % BG = PLOTBRAINGRAPH(ATLAS) constructs the brain graph plot
            % with an atlas.
            %
            % See also PlotBrainAtlas, BrainAtlas.
            
            bg = bg@PlotBrainAtlas(atlas);
            
            bg.initEdgesProperties(atlas)
        end
        function initEdgesProperties(bg, atlas)
            % INITEDGESPROPERTIES initializes the edge property
            %
            % INITEDGESPROPERTIES initializes the edge property
            %
            % See also PlotbrainGraph.
            
            bg.edges.h = NaN(atlas.getBrainRegions().length());
            bg.edges.arr = NaN(atlas.getBrainRegions().length());
            bg.edges.cyl = NaN(atlas.getBrainRegions().length());
            bg.edges.X1 = zeros(atlas.getBrainRegions().length(), 1);
            bg.edges.Y1 = zeros(atlas.getBrainRegions().length(), 1);
            bg.edges.Z1 = zeros(atlas.getBrainRegions().length(), 1);
            bg.edges.X2 = zeros(atlas.getBrainRegions().length(), 1);
            bg.edges.Y2 = zeros(atlas.getBrainRegions().length(), 1);
            bg.edges.Z2 = zeros(atlas.getBrainRegions().length(), 1);
        end
    end
    methods  % edge methods
        function h = link_edge(bg, i, j, varargin)
            % LINK_EDGE plots edge link as line
            %
            % LINK_EDGE(BG, I, J) plots the edge link from the brain regions
            % I to J as a line, if not plotted.
            %
            % H = LINK_EDGE(BG, I, J) returns the handle to the edge link
            % from the brain region I to J.
            %
            % LINK_EDGE(BG, I, J, PROPERTY, VALUE, ...) sets the property
            % of the edge link line PROPERTY to VALUE.
            % All standard plot properties of plot3 can be used.
            % The line properties can also be changed when hidden.
            %
            % See also PlotBrainGraph, plot3, link_edges.
            
            if i == j  % removes diagonal
                return;
            end
            bg.set_axes();
            % get brain regions
            br_1 = bg.atlas.getBrainRegions().getValue(i);
            br_2 = bg.atlas.getBrainRegions().getValue(j);
            % get coordinates
            X1 = br_1.getX();
            Y1 = br_1.getY();
            Z1 = br_1.getZ();
            
            X2 = br_2.getX();
            Y2 = br_2.getY();
            Z2 = br_2.getZ();
            
            if ~ishandle(bg.edges.h(j, i))
                if ~ishandle(bg.edges.h(i, j))
                    
                    bg.edges.h(i, j) = plot3( ...
                        bg.get_axes(), ...
                        [X1 X2], ...
                        [Y1 Y2], ...
                        [Z1 Z2], ...
                        'Color', bg.INIT_LIN_COLOR, ...
                        'LineStyle', '-', 'LineWidth', 1);
                else
                    x1 = bg.edges.X1(i, j);
                    y1 = bg.edges.Y1(i, j);
                    z1 = bg.edges.Z1(i, j);
                    
                    x2 = bg.edges.X2(i, j);
                    y2 = bg.edges.Y2(i, j);
                    z2 = bg.edges.Z2(i, j);
                    
                    if x1 ~= X1 || y1 ~= Y1 || z1 ~= Z1 ...
                            || x2 ~= X2 || y2 ~= Y2 || z2 ~= Z2
                        
                        set(bg.edges.h(i, j), 'XData', [X1 X2]);
                        set(bg.edges.h(i, j), 'YData', [Y1 Y2]);
                        set(bg.edges.h(i, j), 'ZData', [Z1 Z2]);
                    end
                end
            else
                bg.edges.h(i, j) = bg.edges.h(j, i);
            end
            bg.edges.X1(i, j) = X1;
            bg.edges.Y1(i, j) = Y1;
            bg.edges.Z1(i, j) = Z1;
            
            bg.edges.X2(i, j) = X2;
            bg.edges.Y2(i, j) = Y2;
            bg.edges.Z2(i, j) = Z2;
            
            % sets properties
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'linestyle'
                        set(bg.edges.h(i, j),'LineStyle', varargin{n + 1});
                    case 'linewidth'
                        set(bg.edges.h(i, j),'LineWidth', varargin{n + 1});
                    case 'color'
                        set(bg.edges.h(i, j),'Color', varargin{n + 1});
                    otherwise
                        set(bg.edges.h(i, j),varargin{n}, varargin{n + 1});
                end
            end
            
            if nargout>0
                h = bg.edges.h(i, j);
            end
        end
        function link_edge_on(bg, i, j)
            % LINK_EDGE_ON shows a edge link
            %
            % LINK_EDGE_ON(BG, I, J) shows the edge link from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edge, link_edge_off.
            
            if ishandle(bg.edges.h(i, j))
                set(bg.edges.h(i, j), 'Visible', 'on')
            end
        end
        function link_edge_off(bg, i, j)
            % LINK_EDGE_OFF hides a edge link
            %
            % LINK_EDGE_OFF(BG, I, J) hides the edge link from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edge, link_edge_on.
            
            if ishandle(bg.edges.h(i, j))
                set(bg.edges.h(i, j), 'Visible', 'off')
            end
        end
        function link_edges(bg, i_vec, j_vec, varargin)
            % LINK_EDGES plots multiple edge links as lines
            %
            % LINK_EDGES(BG, I_VEC, J_VEC) plots the edge links from the
            % brain regions specified in I_VEC to the ones specified in
            % J_VEC, if not plotted. I_VEC and J_VEC need not be the same
            % size.
            %
            % LINK_EDGES(BG, [], []) plots the edge links between all
            % possible brain region combinations.
            %
            % LINK_EDGES(BG, I_VEC, J_VEC, PROPERTY, RULE) sets the property
            % of the multiple edge links' PROPERTY to RULE.
            % All standard plot properties of plot3 can be used.
            % The line properties can also be changed when hidden.
            %
            % See also PlotBrainGraph, plot3, link_edge.
            
            if nargin < 2 || isempty(i_vec) || isempty(j_vec)
                for i = 1:1:bg.atlas.getBrainRegions().length()
                    for j = 1:1:bg.atlas.getBrainRegions().length()
                        bg.link_edge(i, j, varargin{:})
                    end
                end
            else
                if length(i_vec) == 1
                    i_vec = i_vec * ones(size(j_vec));
                end
                if length(j_vec) == 1
                    j_vec = j_vec * ones(size(i_vec));
                end
                
                for m = 1:1:length(i_vec)
                    bg.link_edge(i_vec(m), j_vec(m), varargin{:})
                end
            end
        end
        function link_edges_on(bg, i_vec, j_vec)
            % LINK_EDGES_ON shows multiple edge link
            %
            % LINK_EDGES_ON(BG, I, J) shows multiple edge link from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edges, link_edges_off.
            
            if nargin<2 || isempty(i_vec) || isempty(j_vec)
                for i = 1:1:bg.atlas.getBrainRegions().length()
                    for j = 1:1:bg.atlas.getBrainRegions().length()
                        bg.link_edge_on(i, j)
                    end
                end
            else
                if length(i_vec) == 1
                    i_vec = i_vec * ones(size(j_vec));
                end
                if length(j_vec) == 1
                    j_vec = j_vec * ones(size(i_vec));
                end
                
                for m = 1:1:length(i_vec)
                    bg.link_edge_on(i_vec(m), j_vec(m))
                end
            end
        end
        function link_edges_off(bg, i_vec, j_vec)
            % LINK_EDGES_OFF hides multiple edge links
            %
            % LINK_EDGES_OFF(BG, I, J) hides multiple edge links from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edge, link_edge_on.
            
            if nargin<2 || isempty(i_vec) || isempty(j_vec)
                for i = 1:1:bg.atlas.getBrainRegions().length()
                    for j = 1:1:bg.atlas.getBrainRegions().length()
                        bg.link_edge_off(i, j)
                    end
                end
            else
                if length(i_vec) == 1
                    i_vec = i_vec * ones(size(j_vec));
                end
                if length(j_vec) == 1
                    j_vec = j_vec * ones(size(i_vec));
                end
                
                for m = 1:1:length(i_vec)
                    bg.link_edge_off(i_vec(m), j_vec(m))
                end
            end
        end
        function link_edges_settings(bg, i_vec, j_vec, varargin)
            % LINK_EDGES_SETTINGS sets edges' properties
            %
            % LINK_EDGES_SETTINGS(BG) allows the user to interractively
            % change the edges settings via a graphical user interface.
            %
            % LINK_LINS_SETTINGS(BG, PROPERTY, VALUE, ...) sets the property
            % of the GUI's PROPERTY to VALUES.
            %   Admissible properties are:
            %       FigPosition  -   position of the GUI on the screen
            %       FigColor     -   background color of the GUI
            %       FigName      -   name of the GUI
            %
            % See also PlotBrainGraph.
            
            atlas_length = bg.atlas.getBrainRegions().length();
            data = cell(atlas_length, atlas_length);
            
            if nargin<2 || isempty(i_vec) || isempty(j_vec)
                i_vec = 1:1:atlas_length;
                j_vec = 1:1:atlas_length;
            end
            if length(i_vec) == 1
                i_vec = i_vec * ones(size(j_vec));
            end
            if length(j_vec) == 1
                j_vec = j_vec * ones(size(i_vec));
            end
            for p = 1:1:length(i_vec)
                if i_vec(p) ~= j_vec(p)
                    data{i_vec(p), j_vec(p)} = true;
                else
                    data{i_vec(p), j_vec(p)} = false;
                end
            end
            
            set_color = bg.INIT_LIN_COLOR;
            
            % sets position of figure
            FigPosition = [.50 .30 .30 .30];
            FigColor = GUI.BKGCOLOR;
            FigName = 'Brain Graph Edges Settings';
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
            if isempty(bg.f_edges_settings) || ~ishandle(bg.f_edges_settings)
                bg.f_edges_settings = figure('Visible', 'off');
            end
            f = bg.f_edges_settings;
            set(f, 'units', 'normalized')
            set(f, 'Position', FigPosition)
            set(f, 'Color', FigColor)
            set(f, 'Name', FigName)
            set(f, 'MenuBar', 'none')
            set(f, 'Toolbar', 'none')
            set(f, 'NumberTitle', 'off')
            set(f, 'DockControls', 'off')
            
            ui_table = uitable(f);
            GUI.setUnits(ui_table)
            set(ui_table, 'BackgroundColor', GUI.TABBKGCOLOR)
            set(ui_table, 'Position', [.03 .215 .54 .71])
            %             set(ui_table, 'ColumnName', bg.atlas.getProps(BrainRegion.LABEL))
            set(ui_table, 'ColumnWidth', {40})
            %             set(ui_table, 'RowName', bg.atlas.getProps(BrainRegion.LABEL))
            [string{1:atlas_length}] = deal('logical');
            set(ui_table, 'ColumnFormat', string)
            set(ui_table, 'ColumnEditable', true)
            set(ui_table, 'Data', data)
            set(ui_table, 'CellEditCallback', {@cb_table_edit});
            
            ui_button_show = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_show)
            GUI.setBackgroundColor(ui_button_show)
            set(ui_button_show, 'Position', [.60 .825 .18 .10])
            set(ui_button_show, 'String', 'Show lines')
            set(ui_button_show, 'TooltipString', 'Show selected lines')
            set(ui_button_show, 'Callback', {@cb_show})
            
            ui_button_hide = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_hide)
            GUI.setBackgroundColor(ui_button_hide)
            set(ui_button_hide, 'Position', [.80 .825 .18 .10])
            set(ui_button_hide, 'String', 'Hide lines')
            set(ui_button_hide, 'TooltipString', 'Hide selected lines')
            set(ui_button_hide, 'Callback', {@cb_hide})
            
            ui_popup_style = uicontrol(f, 'Style', 'popup', 'String', {''});
            GUI.setUnits(ui_popup_style)
            GUI.setBackgroundColor(ui_popup_style)
            set(ui_popup_style, 'Position', [.62 .575 .35 .10])
            set(ui_popup_style, 'String', GUI.PLOT_LINESTYLE_NAME)
            set(ui_popup_style, 'Value', 1)
            set(ui_popup_style, 'TooltipString', 'Select line style');
            set(ui_popup_style, 'Callback', {@cb_style})
            
            ui_text_width = uicontrol(f, 'Style', 'text');
            GUI.setUnits(ui_text_width)
            GUI.setBackgroundColor(ui_text_width)
            set(ui_text_width, 'Position', [.62 .330 .10 .10])
            set(ui_text_width, 'String', 'Link width ')
            set(ui_text_width, 'HorizontalAlignment', 'left')
            set(ui_text_width, 'FontWeight', 'bold')
            
            ui_edit_width = uicontrol(f, 'Style', 'edit');
            GUI.setUnits(ui_edit_width)
            GUI.setBackgroundColor(ui_edit_width)
            set(ui_edit_width, 'Position', [.72 .325 .25 .10])
            set(ui_edit_width, 'HorizontalAlignment', 'center')
            set(ui_edit_width, 'FontWeight', 'bold')
            set(ui_edit_width, 'String', '1')
            set(ui_edit_width, 'Callback', {@cb_width})
            
            ui_button_linecolor = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_linecolor)
            GUI.setBackgroundColor(ui_button_linecolor)
            set(ui_button_linecolor, 'ForegroundColor', set_color)
            set(ui_button_linecolor, 'Position', [.62 .075 .35 .10])
            set(ui_button_linecolor, 'String', 'Link Color')
            set(ui_button_linecolor, 'TooltipString', 'Select line color')
            set(ui_button_linecolor, 'Callback', {@cb_linecolor})
            
            ui_button_clearselection = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_clearselection)
            GUI.setBackgroundColor(ui_button_clearselection)
            set(ui_button_clearselection, 'Position', [.03 .075 .54 .10])
            set(ui_button_clearselection, 'String', 'Clear Selection')
            set(ui_button_clearselection, 'TooltipString', 'Clear selected links')
            set(ui_button_clearselection, 'Callback', {@cb_clearselection})
            
            function cb_table_edit(~, event)  % (src, event)
                i = event.Indices(1);
                j = event.Indices(2);
                
                if i~=j
                    if data{i, j} == true
                        data{i, j} = false;
                    else
                        data{i, j} = true;
                    end
                    set(ui_table, 'Data', data)
                end
            end
            function update_link_edges()
                style = GUI.PLOT_LINESTYLE_TAG{get(ui_popup_style, 'Value')};
                width = real(str2double(get(ui_edit_width, 'String')));
                indices = find(~cellfun(@isempty, data));
                
                for m = 1:1:length(indices)
                    if data{indices(m)} == 1
                        [i, j] = ind2sub(size(data), indices(m));
                        bg.link_edges(i, j, 'LineStyle', style, 'LineWidth', width, ...
                            'Color', set_color);
                    end
                end
            end
            function cb_show(~, ~)  % (src, event)
                indices = find(~cellfun(@isempty, data));
                
                for m = 1:1:length(indices)
                    if data{indices(m)}==1
                        [i, j] = ind2sub(size(data), indices(m));
                        update_link_edges()
                        bg.link_edges_on(i, j)
                    end
                end
            end
            function cb_hide(~, ~)  % (src, event)
                indices = find(~cellfun(@isempty, data));
                
                for m = 1:1:length(indices)
                    if data{indices(m)}==1
                        [i, j] = ind2sub(size(data), indices(m));
                        bg.link_edges_off(i, j)
                    end
                end
            end
            function cb_style(~, ~)  % (src, event)
                update_link_edges()
            end
            function cb_width(~, ~)  % (src, event)
                width = real(str2double(get(ui_edit_width, 'String')));
                
                if isempty(width) || width < 1
                    set(ui_edit_width, 'String', '1')
                end
                update_link_edges()
            end
            function cb_linecolor(~, ~)  % (src, event)
                set_color_prev = get(ui_button_linecolor, 'ForegroundColor');
                set_color = uisetcolor();
                if length(set_color )== 3
                    set(ui_button_linecolor, 'ForegroundColor', set_color)
                    update_link_edges()
                else
                    set_color = set_color_prev;
                end
            end
            function cb_clearselection(~, ~)  % (src, event)
                [data{:}] = deal(zeros(1));
                set(ui_table, 'Data', data)
            end
            set(f, 'Visible', 'on')
        end
        function bool = link_edge_is_on(bg, i, j)
            % LINK_EDGE_IS_ON checks if line link is visible
            %
            % BOOL = LINK_EDGE_IS_ON(BG, I, J) returns true if the line link
            % from the brain regions I to J is visible and false otherwise.
            %
            % See also PlotBrainGraph.
            
            bool = ishandle(bg.edges.h(i, j)) && strcmpi(get(bg.edges.h(i, j), 'Visible'), 'on');
        end
        function link_edge_text(bg, graph_axes, i, j , text_value, varargin)
            if i == j  % removes diagonal
                return;
            end
            
            bg.set_axes();
            br_1 = bg.atlas.getBrainRegions().getValue(i);
            br_2 = bg.atlas.getBrainRegions().getValue(j);
            % get coordinates
            X1 = br_1.getX();
            Y1 = br_1.getY();
            Z1 = br_1.getZ();
            
            X2 = br_2.getX();
            Y2 = br_2.getY();
            Z2 = br_2.getZ();
            
            % equidistant point 
            X3 = (X1 + X2) / 2;
            Y3 = (Y1 + Y2) / 2;
            Z3 = (Z1 + Z2) / 2;
            text(graph_axes, X3, Y3, Z3, text_value);   
        end
        
        % arrows
        function h = arrow_edge(bg, i, j, varargin)
            % ARROW_EDGE plots edge link as an arrow
            %
            % ARROW_EDGE(BG, I, J) plots the edge link from the brain regions
            % I to J as a line, if not plotted.
            %
            % H = ARROW_EDGE(BG, I, J) returns the handle to the edge link
            % from the brain region I to J.
            %
            % ARROW_EDGE(BG, I, J, PROPERTY, VALUE, ...) sets the property
            % of the edge link line PROPERTY to VALUE.
            % All standard plot properties of plot3 can be used.
            % The line properties can also be changed when hidden.
            %
            % See also PlotBrainGraph, plot3, link_edges.
            
            if i == j  % removes diagonal
                return;
            end
            bg.set_axes();
            % get brain regions
            br_1 = bg.atlas.getBrainRegions().getValue(i);
            br_2 = bg.atlas.getBrainRegions().getValue(j);
            % get coordinates
            X1 = br_1.getX();
            Y1 = br_1.getY();
            Z1 = br_1.getZ();
            
            X2 = br_2.getX();
            Y2 = br_2.getY();
            Z2 = br_2.getZ();
            
            % arrow properties
            color = bg.INIT_ARR_COLOR;
            SWIDTH = bg.INIT_ARR_SWIDTH;
            HLENGTH = bg.INIT_ARR_HLENGTH;
            HWIDTH = bg.INIT_ARR_HWIDTH;
            HNODE = bg.INIT_ARR_HNODE;
            N = bg.INIT_ARR_N;
            
            if ~ishandle(bg.edges.arr(i, j))
                
                [X, Y, Z] = arrow3d(X1, Y1, Z1, X2, Y2, Z2,...
                    'StemWidth', SWIDTH, ...
                    'HeadLength', HLENGTH, ...
                    'HeadWidth', HWIDTH, ...
                    'HeadNode', HNODE, ...
                    'N', N);
                
                bg.edges.arr(i, j) = surf(X, Y, Z,...
                    'EdgeColor', color,...
                    'FaceColor', color,...
                    'Parent', bg.get_axes());
            else
                x1 = bg.edges.X1(i, j);
                y1 = bg.edges.Y1(i, j);
                z1 = bg.edges.Z1(i, j);
                
                x2 = bg.edges.X2(i, j);
                y2 = bg.edges.Y2(i, j);
                z2 = bg.edges.Z2(i, j);
                
                if x1 ~= X1 || y1 ~= Y1 || z1 ~= Z1 ...
                        || x2 ~= X2 || y2 ~= Y2 || z2 ~= Z2
                    
                    [X, Y, Z] = arrow3d(X1, Y1, Z1, X2, Y2, Z2,...
                        'StemWidth', SWIDTH, ...
                        'HeadLength', HLENGTH, ...
                        'HeadWidth', HWIDTH, ...
                        'HeadNode', HNODE, ...
                        'N', N);
                    
                    set(bg.edges.arr(i, j), 'XData', X);
                    set(bg.edges.arr(i, j), 'YData', Y);
                    set(bg.edges.arr(i, j), 'ZData', Z);
                    
                end
            end
            bg.edges.X1(i, j) = X1;
            bg.edges.Y1(i, j) = Y1;
            bg.edges.Z1(i, j) = Z1;
            
            bg.edges.X2(i, j) = X2;
            bg.edges.Y2(i, j) = Y2;
            bg.edges.Z2(i, j) = Z2;
            
            % sets properties
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'color'
                        set(bg.edges.arr(i, j), 'FaceColor', varargin{n + 1});
                        set(bg.edges.arr(i, j), 'EdgeColor', varargin{n + 1});
                        
                    otherwise
                        set(bg.edges.arr(i, j), varargin{n}, varargin{n + 1});
                end
            end
            
            if nargout>0
                h = bg.edges.arr(i, j);
            end
        end
        function arrow_edge_on(bg, i, j)
            % ARROW_EDGE_ON shows a edge link
            %
            % ARROW_EDGE_ON(BG, I, J) shows the edge link from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edge, link_edge_off.
            
            if ishandle(bg.edges.arr(i, j))
                set(bg.edges.arr(i, j), 'Visible', 'on')
            end
        end
        function arrow_edge_off(bg, i, j)
            % ARROW_EDGE_OFF hides a edge link
            %
            % ARROW_EDGE_OFF(BG, I, J) hides the edge link from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edge, link_edge_on.
            
            if ishandle(bg.edges.arr(i, j))
                set(bg.edges.arr(i, j), 'Visible', 'off')
            end
        end
        function arrow_edges(bg, i_vec, j_vec, varargin)
            % ARROW_EDGES plots multiple edge links as lines
            %
            % ARROW_EDGES(BG, I_VEC, J_VEC) plots the edge links from the
            % brain regions specified in I_VEC to the ones specified in
            % J_VEC, if not plotted. I_VEC and J_VEC need not be the same
            % size.
            %
            % ARROW_EDGES(BG, [], []) plots the edge links between all
            % possible brain region combinations.
            %
            % ARROW_LINS(BG, I_VEC, J_VEC, PROPERTY, RULE) sets the property
            % of the multiple edge links' PROPERTY to RULE.
            % All standard plot properties of plot3 can be used.
            % The line properties can also be changed when hidden.
            %
            % See also PlotBrainGraph, plot3, link_edge.
            
            if nargin < 2 || isempty(i_vec) || isempty(j_vec)
                for i = 1:1:bg.atlas.getBrainRegions().length()
                    for j = 1:1:bg.atlas.getBrainRegions().length()
                        bg.arrow_edge(i, j, varargin{:})
                    end
                end
            else
                if length(i_vec) == 1
                    i_vec = i_vec * ones(size(j_vec));
                end
                if length(j_vec) == 1
                    j_vec = j_vec * ones(size(i_vec));
                end
                
                for m = 1:1:length(i_vec)
                    bg.arrow_edge(i_vec(m), j_vec(m), varargin{:})
                end
            end
        end
        function arrow_edges_on(bg, i_vec, j_vec)
            % ARROW_EDGES_ON shows multiple edge link
            %
            % ARROW_EDGES_ON(BG, I, J) shows multiple edge link from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edges, link_edges_off.
            
            if nargin<2 || isempty(i_vec) || isempty(j_vec)
                for i = 1:1:bg.atlas.getBrainRegions().length()
                    for j = 1:1:bg.atlas.getBrainRegions().length()
                        bg.arrow_edge_on(i, j)
                    end
                end
            else
                if length(i_vec) == 1
                    i_vec = i_vec * ones(size(j_vec));
                end
                if length(j_vec) == 1
                    j_vec = j_vec * ones(size(i_vec));
                end
                
                for m = 1:1:length(i_vec)
                    bg.arrow_edge_on(i_vec(m), j_vec(m))
                end
            end
        end
        function arrow_edges_off(bg, i_vec, j_vec)
            % ARROW_EDGES_OFF hides multiple edge links
            %
            % ARROW_EDGES_OFF(BG, I, J) hides multiple edge links from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edge, link_edge_on.
            
            if nargin<2 || isempty(i_vec) || isempty(j_vec)
                for i = 1:1:bg.atlas.getBrainRegions().length()
                    for j = 1:1:bg.atlas.getBrainRegions().length()
                        bg.arrow_edge_off(i, j)
                    end
                end
            else
                if length(i_vec) == 1
                    i_vec = i_vec * ones(size(j_vec));
                end
                if length(j_vec) == 1
                    j_vec = j_vec * ones(size(i_vec));
                end
                
                for m = 1:1:length(i_vec)
                    bg.arrow_edge_off(i_vec(m), j_vec(m))
                end
            end
        end
        function arrow_edges_settings(bg, i_vec, j_vec, varargin)
            % ARROW_EDGES_SETTINGS sets edges' properties
            %
            % ARROW_EDGES_SETTINGS(BG) allows the user to interractively
            % change the edges settings via a graphical user interface.
            %
            % ARROW_LINS_SETTINGS(BG, PROPERTY, VALUE, ...) sets the property
            % of the GUI's PROPERTY to VALUES.
            %   Admissible properties are:
            %       FigPosition  -   position of the GUI on the screen
            %       FigColor     -   background color of the GUI
            %       FigName      -   name of the GUI
            %
            % See also PlotBrainGraph.
            
            atlas_length = bg.atlas.getBrainRegions().length();
            data = cell(atlas_length, atlas_length);
            
            if nargin<2 || isempty(i_vec) || isempty(j_vec)
                i_vec = 1:1:atlas_length;
                j_vec = 1:1:atlas_length;
            end
            if length(i_vec) == 1
                i_vec = i_vec * ones(size(j_vec));
            end
            if length(j_vec) == 1
                j_vec = j_vec * ones(size(i_vec));
            end
            for p = 1:1:length(i_vec)
                if i_vec(p) ~= j_vec(p)
                    data{i_vec(p), j_vec(p)} = true;
                else
                    data{i_vec(p), j_vec(p)} = false;
                end
            end
            
            set_color = bg.INIT_LIN_COLOR;
            
            % sets position of figure
            FigPosition = [.50 .30 .30 .30];
            FigColor = GUI.BKGCOLOR;
            FigName = 'Brain Graph Arrows Settings';
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
            if isempty(bg.f_arrs_settings) || ~ishandle(bg.f_arrs_settings)
                bg.f_arrs_settings = figure('Visible', 'off');
            end
            f = bg.f_arrs_settings;
            set(f, 'units', 'normalized')
            set(f, 'Position', FigPosition)
            set(f, 'Color', FigColor)
            set(f, 'Name', FigName)
            set(f, 'MenuBar', 'none')
            set(f, 'Toolbar', 'none')
            set(f, 'NumberTitle', 'off')
            set(f, 'DockControls', 'off')
            
            ui_table = uitable(f);
            set(ui_table, 'Units', 'normalized')
            set(ui_table, 'BackgroundColor', GUI.TABBKGCOLOR)
            set(ui_table, 'Position', [.03 .215 .54 .71])
            %             set(ui_table, 'ColumnName', bg.atlas.getProps(BrainRegion.LABEL))
            set(ui_table, 'ColumnWidth', {40})
            %             set(ui_table, 'RowName', bg.atlas.getProps(BrainRegion.LABEL))
            [string{1:atlas_length}] = deal('logical');
            set(ui_table, 'ColumnFormat', string)
            set(ui_table, 'ColumnEditable', true)
            set(ui_table, 'Data', data)
            set(ui_table, 'CellEditCallback', {@cb_table_edit});
            
            ui_button_show = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_show)
            GUI.setBackgroundColor(ui_button_show)
            set(ui_button_show, 'Position', [.60 .825 .18 .10])
            set(ui_button_show, 'String', 'Show lines')
            set(ui_button_show, 'TooltipString', 'Show selected arrows')
            set(ui_button_show, 'Callback', {@cb_show})
            
            ui_button_hide = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_hide)
            GUI.setBackgroundColor(ui_button_hide)
            set(ui_button_hide, 'Position', [.80 .825 .18 .10])
            set(ui_button_hide, 'String', 'Hide lines')
            set(ui_button_hide, 'TooltipString', 'Hide selected arrows')
            set(ui_button_hide, 'Callback', {@cb_hide})
            
            ui_button_arrowcolor = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_arrowcolor)
            GUI.setBackgroundColor(ui_button_arrowcolor)
            set(ui_button_arrowcolor, 'ForegroundColor', set_color)
            set(ui_button_arrowcolor, 'Position', [.62 .075 .35 .10])
            set(ui_button_arrowcolor, 'String', 'Link Color')
            set(ui_button_arrowcolor, 'TooltipString', 'Select arrow color')
            set(ui_button_arrowcolor, 'Callback', {@cb_arrowcolor})
            
            ui_button_clearselection = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_clearselection)
            GUI.setBackgroundColor(ui_button_clearselection)
            set(ui_button_clearselection, 'Position', [.03 .075 .54 .10])
            set(ui_button_clearselection, 'String', 'Clear Selection')
            set(ui_button_clearselection, 'TooltipString', 'Clear selected links')
            set(ui_button_clearselection, 'Callback', {@cb_clearselection})
            
            function cb_table_edit(~, event)  % (src, event)
                i = event.Indices(1);
                j = event.Indices(2);
                
                if i~=j
                    if data{i, j} == true
                        data{i, j} = false;
                    else
                        data{i, j} = true;
                    end
                    set(ui_table, 'Data', data)
                end
            end
            function update_link_arrs()
                stemwidth = real(str2double(get(ui_edit_stemwidth, 'String')));
                headwidth = real(str2double(get(ui_edit_headwidth, 'String')));
                headlength = real(str2double(get(ui_edit_headlength, 'String')));
                headnode = real(str2double(get(ui_edit_headnode, 'String')));
                indices = find(~cellfun(@isempty, data));
                
                for m = 1:1:length(indices)
                    if data{indices(m)} == 1
                        [i, j] = ind2sub(size(data), indices(m));
                        bg.arrow_edges(i, j, 'StemWidth', stemwidth, ...
                            'HeadWidth', headwidth, ...
                            'HeadLength', headlength, ...
                            'HeadNode', headnode, ...
                            'Color', set_color);
                    end
                end
            end
            function cb_arrowcolor(~, ~)  % (src, event)
                set_color_prev = get(ui_button_arrowcolor, 'ForegroundColor');
                set_color = uisetcolor();
                if length(set_color) == 3
                    set(ui_button_arrowcolor, 'ForegroundColor', set_color)
                    update_link_arrs()
                else
                    set_color = set_color_prev;
                end
            end
            function cb_show(~, ~)  % (src, event)
                indices = find(~cellfun(@isempty, data));
                
                for m = 1:1:length(indices)
                    if data{indices(m)} == 1
                        [i, j] = ind2sub(size(data), indices(m));
                        update_link_arrs()
                        bg.arrow_edges_on(i, j)
                    end
                end
            end
            function cb_hide(~, ~)  % (src, event)
                indices = find(~cellfun(@isempty, data));
                
                for m = 1:1:length(indices)
                    if data{indices(m)}==1
                        [i, j] = ind2sub(size(data), indices(m));
                        bg.arrow_edges_off(i, j)
                    end
                end
            end
            function cb_clearselection(~, ~)  % (src, event)
                [data{:}] = deal(zeros(1));
                set(ui_table, 'Data', data)
            end
            set(f, 'Visible', 'on')
        end
        function bool = arrow_edge_is_on(bg, i, j)
            % ARROW_EDGE_IS_ON checks if line link is visible
            %
            % BOOL = ARROW_EDGE_IS_ON(BG, I, J) returns true if the line arrow link
            % from the brain regions I to J is visible and false otherwise.
            %
            % See also PlotBrainGraph.
            
            bool = ishandle(bg.edges.arr(i, j)) && strcmpi(get(bg.edges.arr(i, j), 'Visible'), 'on');
        end
        
        % cylinders
        function h = cylinder_edge(bg, i, j, varargin)
            % CYLINDER_EDGE plots edge link as an cylinder
            %
            % CYLINDER_EDGE(BG, I, J) plots the edge link from the brain regions
            % I to J as a line, if not plotted.
            %
            % H = CYLINDER_EDGE(BG, I, J) returns the handle to the edge link
            % from the brain region I to J.
            %
            % CYLINDER_EDGE(BG, I, J, PROPERTY, VALUE, ...) sets the property
            % of the edge link line PROPERTY to VALUE.
            % All standard plot properties of plot3 can be used.
            % The line properties can also be changed when hidden.
            %
            % See also PlotBrainGraph, plot3, link_edges.
            
            if i == j  % removes diagonal
                return;
            end
            bg.set_axes();
            % get brain regions
            br_1 = bg.atlas.getBrainRegions().getValue(i);
            br_2 = bg.atlas.getBrainRegions().getValue(j);
            % get coordinates
            X1 = br_1.getX();
            Y1 = br_1.getY();
            Z1 = br_1.getZ();
            
            X2 = br_2.getX();
            Y2 = br_2.getY();
            Z2 = br_2.getZ();
            
            % cylinder properties
            color = bg.INIT_CYL_COLOR;
            R = bg.INIT_CYL_R;
            N = bg.INIT_CYL_N;
            
            if ~ishandle(bg.edges.cyl(i, j))
                
                [X, Y, Z] = cylinder3d(X1, Y1, Z1, X2, Y2, Z2,...
                    'R', R, ...
                    'N', N);
                
                bg.edges.cyl(i, j) = surf(X, Y, Z,...
                    'EdgeColor', color, ...
                    'FaceColor', color, ...
                    'Parent', bg.get_axes());
            else
                x1 = bg.edges.X1(i, j);
                y1 = bg.edges.Y1(i, j);
                z1 = bg.edges.Z1(i, j);
                
                x2 = bg.edges.X2(i, j);
                y2 = bg.edges.Y2(i, j);
                z2 = bg.edges.Z2(i, j);
                
                if x1 ~= X1 || y1 ~= Y1 || z1 ~= Z1 ...
                        || x2 ~= X2 || y2 ~= Y2 || z2 ~= Z2
                    
                    [X, Y, Z] = cylinder3d(X1, Y1, Z1, X2, Y2, Z2,...
                        'Color', color,...
                        'LineStyle', '-');
                    
                    set(bg.edges.cyl(i, j), 'XData', X);
                    set(bg.edges.cyl(i, j), 'YData', Y);
                    set(bg.edges.cyl(i, j), 'ZData', Z);
                    
                end
            end
            bg.edges.X1(i, j) = X1;
            bg.edges.Y1(i, j) = Y1;
            bg.edges.Z1(i, j) = Z1;
            
            bg.edges.X2(i, j) = X2;
            bg.edges.Y2(i, j) = Y2;
            bg.edges.Z2(i, j) = Z2;
            
            % sets properties
            for n = 1:2:length(varargin)
                switch lower(varargin{n})
                    case 'color'
                        set(bg.edges.cyl(i, j), 'FaceColor', varargin{n + 1});
                        set(bg.edges.cyl(i, j), 'EdgeColor', varargin{n + 1});
                        
                    otherwise
                        set(bg.edges.cyl(i, j), varargin{n}, varargin{n + 1});
                end
            end
            
            if nargout>0
                h = bg.edges.cyl(i, j);
            end
        end
        function cylinder_edge_on(bg, i, j)
            % CYLINDER_EDGE_ON shows a edge link
            %
            % CYLINDER_EDGE_ON(BG, I, J) shows the edge link from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edge, link_edge_off.
            
            if ishandle(bg.edges.cyl(i, j))
                set(bg.edges.cyl(i, j), 'Visible', 'on')
            end
        end
        function cylinder_edge_off(bg, i, j)
            % CYLINDER_EDGE_OFF hides a edge link
            %
            % CYLINDER_EDGE_OFF(BG, I, J) hides the edge link from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edge, link_edge_on.
            
            if ishandle(bg.edges.cyl(i, j))
                set(bg.edges.cyl(i, j), 'Visible', 'off')
            end
        end
        function cylinder_edges(bg, i_vec, j_vec, varargin)
            % CYLINDER_EDGES plots multiple edge links as lines
            %
            % CYLINDER_EDGES(BG, I_VEC, J_VEC) plots the edge links from the
            % brain regions specified in I_VEC to the ones specified in
            % J_VEC, if not plotted. I_VEC and J_VEC need not be the same
            % size.
            %
            % CYLINDER_EDGES(BG, [], []) plots the edge links between all
            % possible brain region combinations.
            %
            % CYLINDER_LINS(BG, I_VEC, J_VEC, PROPERTY, RULE) sets the property
            % of the multiple edge links' PROPERTY to RULE.
            % All standard plot properties of plot3 can be used.
            % The line properties can also be changed when hidden.
            %
            % See also PlotBrainGraph, plot3, link_edge.
            
            if nargin < 2 || isempty(i_vec) || isempty(j_vec)
                for i = 1:1:bg.atlas.getBrainRegions().length()
                    for j = 1:1:bg.atlas.getBrainRegions().length()
                        bg.cylinder_edge(i, j, varargin{:})
                    end
                end
            else
                if length(i_vec) == 1
                    i_vec = i_vec * ones(size(j_vec));
                end
                if length(j_vec) == 1
                    j_vec = j_vec * ones(size(i_vec));
                end
                
                for m = 1:1:length(i_vec)
                    bg.cylinder_edge(i_vec(m), j_vec(m), varargin{:})
                end
            end
        end
        function cylinder_edges_on(bg, i_vec, j_vec)
            % CYLINDER_EDGES_ON shows multiple edge link
            %
            % CYLINDER_EDGES_ON(BG, I, J) shows multiple edge link from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edges, link_edges_off.
            
            if nargin<2 || isempty(i_vec) || isempty(j_vec)
                for i = 1:1:bg.atlas.getBrainRegions().length()
                    for j = 1:1:bg.atlas.getBrainRegions().length()
                        bg.cylinder_edge_on(i, j)
                    end
                end
            else
                if length(i_vec) == 1
                    i_vec = i_vec * ones(size(j_vec));
                end
                if length(j_vec) == 1
                    j_vec = j_vec * ones(size(i_vec));
                end
                
                for m = 1:1:length(i_vec)
                    bg.cylinder_edge_on(i_vec(m), j_vec(m))
                end
            end
        end
        function cylinder_edges_off(bg, i_vec, j_vec)
            % CYLINDER_EDGES_OFF hides multiple edge links
            %
            % CYLINDER_EDGES_OFF(BG, I, J) hides multiple edge links from the brain
            % region I to J.
            %
            % See also PlotBrainGraph, link_edge, link_edge_on.
            
            if nargin<2 || isempty(i_vec) || isempty(j_vec)
                for i = 1:1:bg.atlas.getBrainRegions().length()
                    for j = 1:1:bg.atlas.getBrainRegions().length()
                        bg.cylinder_edge_off(i, j)
                    end
                end
            else
                if length(i_vec) == 1
                    i_vec = i_vec * ones(size(j_vec));
                end
                if length(j_vec) == 1
                    j_vec = j_vec * ones(size(i_vec));
                end
                
                for m = 1:1:length(i_vec)
                    bg.cylinder_edge_off(i_vec(m), j_vec(m))
                end
            end
        end
        function cylinder_edges_settings(bg, i_vec, j_vec, varargin)
            % CYLINDER_EDGES_SETTINGS sets edges' properties
            %
            % CYLINDER_EDGES_SETTINGS(BG) allows the user to interractively
            % change the edges settings via a graphical user interface.
            %
            % CYLINDER_LINS_SETTINGS(BG, PROPERTY, VALUE, ...) sets the property
            % of the GUI's PROPERTY to VALUES.
            %   Admissible properties are:
            %       FigPosition  -   position of the GUI on the screen
            %       FigColor     -   background color of the GUI
            %       FigName      -   name of the GUI
            %
            % See also PlotBrainGraph.
            
            atlas_length = bg.atlas.getBrainRegions().length();
            data = cell(atlas_length, atlas_length);
            
            if nargin<2 || isempty(i_vec) || isempty(j_vec)
                i_vec = 1:1:atlas_length;
                j_vec = 1:1:atlas_length;
            end
            if length(i_vec) == 1
                i_vec = i_vec * ones(size(j_vec));
            end
            if length(j_vec) == 1
                j_vec = j_vec * ones(size(i_vec));
            end
            for p = 1:1:length(i_vec)
                if i_vec(p) ~= j_vec(p)
                    data{i_vec(p), j_vec(p)} = true;
                else
                    data{i_vec(p), j_vec(p)} = false;
                end
            end
            
            set_color = bg.INIT_LIN_COLOR;
            
            % sets position of figure
            FigPosition = [.50 .30 .30 .30];
            FigColor = GUI.BKGCOLOR;
            FigName = 'Brain Graph Arrows Settings';
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
            if isempty(bg.f_cyls_settings) || ~ishandle(bg.f_cyls_settings)
                bg.f_cyls_settings = figure('Visible', 'off');
            end
            f = bg.f_cyls_settings;
            set(f, 'units', 'normalized')
            set(f, 'Position', FigPosition)
            set(f, 'Color', FigColor)
            set(f, 'Name', FigName)
            set(f, 'MenuBar', 'none')
            set(f, 'Toolbar', 'none')
            set(f, 'NumberTitle', 'off')
            set(f, 'DockControls', 'off')
            
            ui_table = uitable(f);
            set(ui_table, 'Units', 'normalized')
            set(ui_table, 'BackgroundColor', GUI.TABBKGCOLOR)
            set(ui_table, 'Position', [.03 .215 .54 .71])
            %             set(ui_table, 'ColumnName', bg.atlas.getProps(BrainRegion.LABEL))
            set(ui_table, 'ColumnWidth', {40})
            %             set(ui_table, 'RowName', bg.atlas.getProps(BrainRegion.LABEL))
            [string{1:atlas_length}] = deal('logical');
            set(ui_table, 'ColumnFormat', string)
            set(ui_table, 'ColumnEditable', true)
            set(ui_table, 'Data', data)
            set(ui_table, 'CellEditCallback', {@cb_table_edit});
            
            ui_button_show = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_show)
            GUI.setBackgroundColor(ui_button_show)
            set(ui_button_show, 'Position', [.60 .825 .18 .10])
            set(ui_button_show, 'String', 'Show lines')
            set(ui_button_show, 'TooltipString', 'Show selected cylinders')
            set(ui_button_show, 'Callback', {@cb_show})
            
            ui_button_hide = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_hide)
            GUI.setBackgroundColor(ui_button_hide)
            set(ui_button_hide, 'Position', [.80 .825 .18 .10])
            set(ui_button_hide, 'String', 'Hide lines')
            set(ui_button_hide, 'TooltipString', 'Hide selected cylinders')
            set(ui_button_hide, 'Callback', {@cb_hide})
            
            ui_button_cylindercolor = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_cylindercolor)
            GUI.setBackgroundColor(ui_button_cylindercolor)
            set(ui_button_cylindercolor, 'ForegroundColor', set_color)
            set(ui_button_cylindercolor, 'Position', [.62 .075 .35 .10])
            set(ui_button_cylindercolor, 'String', 'Link Color')
            set(ui_button_cylindercolor, 'TooltipString', 'Select cylinder color')
            set(ui_button_cylindercolor, 'Callback', {@cb_cylindercolor})
            
            ui_button_clearselection = uicontrol(f, 'Style',  'pushbutton');
            GUI.setUnits(ui_button_clearselection)
            GUI.setBackgroundColor(ui_button_clearselection)
            set(ui_button_clearselection, 'Position', [.03 .075 .54 .10])
            set(ui_button_clearselection, 'String', 'Clear Selection')
            set(ui_button_clearselection, 'TooltipString', 'Clear selected links')
            set(ui_button_clearselection, 'Callback', {@cb_clearselection})
            
            function cb_table_edit(~, event)  % (src, event)
                i = event.Indices(1);
                j = event.Indices(2);
                
                if i~=j
                    if data{i, j} == true
                        data{i, j} = false;
                    else
                        data{i, j} = true;
                    end
                    set(ui_table, 'Data', data)
                end
            end
            function update_link_cyls()
                stemwidth = real(str2double(get(ui_edit_stemwidth, 'String')));
                headwidth = real(str2double(get(ui_edit_headwidth, 'String')));
                headlength = real(str2double(get(ui_edit_headlength, 'String')));
                headnode = real(str2double(get(ui_edit_headnode, 'String')));
                indices = find(~cellfun(@isempty, data));
                
                for m = 1:1:length(indices)
                    if data{indices(m)} == 1
                        [i, j] = ind2sub(size(data), indices(m));
                        bg.cylinder_edges(i, j, 'StemWidth', stemwidth, ...
                            'HeadWidth', headwidth, ...
                            'HeadLength', headlength, ...
                            'HeadNode', headnode, ...
                            'Color', set_color);
                    end
                end
            end
            function cb_cylindercolor(~, ~)  % (src, event)
                set_color_prev = get(ui_button_cylindercolor, 'ForegroundColor');
                set_color = uisetcolor();
                if length(set_color) == 3
                    set(ui_button_cylindercolor, 'ForegroundColor', set_color)
                    update_link_cyls()
                else
                    set_color = set_color_prev;
                end
            end
            function cb_show(~, ~)  % (src, event)
                indices = find(~cellfun(@isempty, data));
                
                for m = 1:1:length(indices)
                    if data{indices(m)} == 1
                        [i, j] = ind2sub(size(data), indices(m));
                        update_link_cyls()
                        bg.cylinder_edges_on(i, j)
                    end
                end
            end
            function cb_hide(~, ~)  % (src, event)
                indices = find(~cellfun(@isempty, data));
                
                for m = 1:1:length(indices)
                    if data{indices(m)}==1
                        [i, j] = ind2sub(size(data), indices(m));
                        bg.cylinder_edges_off(i, j)
                    end
                end
            end
            function cb_clearselection(~, ~)  % (src, event)
                [data{:}] = deal(zeros(1));
                set(ui_table, 'Data', data)
            end
            set(f, 'Visible', 'on')
        end
        function bool = cylinder_edge_is_on(bg, i, j)
            % CYLINDER_EDGE_IS_ON checks if cylinder link is visible
            %
            % BOOL = CYLINDER_EDGE_IS_ON(BG, I, J) returns true if the cylinder link
            % from the brain regions I to J is visible and false otherwise.
            %
            % See also PlotBrainGraph.
            
            bool = ishandle(bg.edges.cyl(i, j)) && strcmpi(get(bg.edges.cyl(i, j), 'Visible'), 'on');
        end
    end
end