classdef PlotBrainGraph < PlotBrainAtlas
    properties
        edges  % structure of 2D cell arrays containing edge properties
        f_edges_settings  % edge settings figure handle
        
        % edge line
        INIT_LIN_COLOR = [0 0 0];
    end
    methods
        function bg = PlotBrainGraph(atlas)
            bg = bg@PlotBrainAtlas(atlas);
            
            bg.initEdgesProperties(atlas)
        end
        function initEdgesProperties(bg, atlas)
            % SETEDGESPROPERTIES initializes the edge property
            
            bg.edges.h = NaN(atlas.getBrainRegions().length());
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
            
            if nargout>0
                h = bg.edges.h(i, j);
            end
        end
        function link_edge_on(bg, i, j)
            % LINK_LIN_ON shows a line link
            %
            % LINK_LIN_ON(BG,I,J) shows the line link from the brain
            %   region I to J.
            %
            % See also PlotBrainGraph.
            
            if ishandle(bg.edges.h(i, j))
                set(bg.edges.h(i, j), 'Visible', 'on')
            end
        end
        function link_edge_off(bg, i, j)
            if ishandle(bg.edges.h(i, j))
                set(bg.edges.h(i, j), 'Visible', 'off')
            end
        end
        function link_edges(bg, i_vec, j_vec, varargin)
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
    end
end