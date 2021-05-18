%% ¡header!
PPGroupEnsemble< PlotProp (pl, plot property of group ensemble) is a plot of group ensemble.

%%% ¡description!
PPGroupEnsemble plots a Group Ensemble graph table.

%%% ¡seealso!
GUI, PlotElement, PlotProp, GroupEnsemble

%% ¡properties!
pp
measure_tbl
selected

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the idict for group ensemble property graphical panel.
    %
    % DRAW(PL) draws the idict property graphical panel.
    %
    % H = DRAW(PL) returns a handle to the idict property graphical panel.
    %
    % DRAW(PL, 'Property', VALUE, ...) sets the properties of the graphical
    %  panel with custom property-value couples.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    el = pl.get('EL');
    prop = pl.get('PROP');
    pl.selected = [];
    graph = el.getPropDefault(prop); 
    adj_matrix_figure = [];

    pl.pp = draw@PlotProp(pl, varargin{:});
    set(pl.pp, 'DeleteFcn', {@close_f_settings}, ...
        varargin{:})
    
    function close_f_settings(~,~)
        if ~isempty(adj_matrix_figure) && isgraphics(adj_matrix_figure)           
           close(adj_matrix_figure)               
        end
    end

    if isempty(pl.measure_tbl) || ~isgraphics(pl.measure_tbl, 'uitable')
        uicontrol( ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.3 .8 .3 .1], ...
            'Style', 'Text', ...
            'String', graph.getClass() ...
            )
        
        pl.measure_tbl = uitable();
        set( pl.measure_tbl, ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .9 .7], ...
            'ColumnName', {'', 'ID', 'Shape', 'Scope', 'Notes'}, ...
            'ColumnFormat', {'logical', 'char', 'char', 'char', 'char'}, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ColumnEditable', [true false false false false], ...
            'CellEditCallback', {@cb_measure_selection} ...
            )            
        
        % get compatible measures for specific graph
        mlist = Graph.getCompatibleMeasureList(graph);
        if ~isa(graph, 'Graph')
            data = cell(length(mlist), 5);
            for mi = 1:1:length(mlist)
                if any(pl.selected == mi)
                    data{mi, 1} = true;
                else
                    data{mi, 1} = false;
                end
                data{mi, 2} = mlist{mi};
                if Measure.is_nodal(mlist{mi})
                    data{mi, 3} = 'NODAL';
                elseif Measure.is_global(mlist{mi})
                    data{mi, 3} = 'GLOBAL';
                else
                    data{mi, 3} = 'BINODAL';
                end
                
                if Measure.is_superglobal(mlist{mi})
                    data{mi, 4} = 'SUPERGLOBAL';
                elseif Measure.is_unilayer(mlist{mi})
                    data{mi, 4} = 'UNILAYER';
                else
                    data{mi, 4} = 'BILAYER';
                end
                
                data{mi, 5} = eval([mlist{mi} '.getDescription()']);
            end
            set(pl.measure_tbl, 'Data', data)
            set(pl.measure_tbl, 'ColumnWidth', 'auto')
        end
    end
    
    ui_button_table_calculate = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_see_adjm = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_selectall = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_clearselection = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    init_buttons()
        function init_buttons()
            
            set(ui_button_table_calculate, 'Position', [.02 .1 .22 .07])
            set(ui_button_table_calculate, 'String', 'Calculate')
            set(ui_button_table_calculate, 'TooltipString', 'Calculate Selected Measures')
            set(ui_button_table_calculate, 'Callback', {@cb_table_calculate})
            
            set(ui_button_table_see_adjm, 'Position', [.02 .01 .22 .07])
            set(ui_button_table_see_adjm, 'String', 'See Graph')
            set(ui_button_table_see_adjm, 'TooltipString', 'Create a Figure with the adjacency matrix')
            set(ui_button_table_see_adjm, 'Callback', {@cb_table_adj_matrix})
            
            set(ui_button_table_selectall, 'Position', [.24 .1 .22 .07])
            set(ui_button_table_selectall, 'String', 'Select All')
            set(ui_button_table_selectall, 'TooltipString', 'Select all brain regions')
            set(ui_button_table_selectall, 'Callback', {@cb_table_selectall})

            set(ui_button_table_clearselection, 'Position', [.24 .01 .22 .07])
            set(ui_button_table_clearselection, 'String', 'Clear')
            set(ui_button_table_clearselection, 'TooltipString', 'Clear selection')
            set(ui_button_table_clearselection, 'Callback', {@cb_table_clearselection})
        end

    % callbacks
        function cb_measure_selection(~, event)
            i = event.Indices(1);
            col = event.Indices(2);
            newdata = event.NewData;
            switch col
                case 1
                    if newdata == 1
                        pl.selected = sort(unique([pl.selected(:); i]));
                    else
                        pl.selected = pl.selected(pl.selected~=i);
                    end
                otherwise
            end
            pl.update()            
        end
        function cb_table_selectall(~, ~)  % (src, event)            
            pl.selected = (1:1:ba_idict.length())';
            pl.update()
        end
        function cb_table_clearselection(~, ~)  % (src, event)            
            pl.selected = [];
            pl.update()
        end
        function cb_table_calculate(~, ~)
            mlist = Graph.getMeasureCompatibleList();
            calculate_measure_list = mlist{pl.selected};
            cellfun(@(x) el.getMeasure(x).get('M'), calculate_measure_list)
        end
        function cb_table_adj_matrix(~, ~)
            adj_matrix = el.get('G');
            [parent_position_pixels, normalized] = get_figure_position();
            x = parent_position_pixels(1);
            y = parent_position_pixels(2);
            w = parent_position_pixels(3);
            h = parent_position_pixels(4);

            screen_size = get(0,'screensize');

            if w >= screen_size(3)/2
                x2 = normalized(1) / 2;
                w2 = normalized(3) / 2 - .01;
            elseif h == screen_size(4)
                y2 = normalized(2);
                h2 = normalized(4)/2;
            else % golden ratio 
                % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
                x2 = normalized(1)+ normalized(3);
                h2 = normalized(4) / 1.61;
                y2 = normalized(2) + h2 - .195;
                w2 = normalized(3) * 1.61;               
            end
            adj_matrix_figure =   figure( ...
                'Visible', 'on', ...
                'NumberTitle', 'off', ...
                'Name', ['Adjacency Matrix - ' BRAPH2.STR], ...
                'Units', 'normalized', ...
                'Position', [x2 y2 w2 h2], ...
                'MenuBar', 'none', ...
                'Toolbar', 'figure', ...
                'Color', 'w' ...
                );
            ui_toolbar = findall(adj_matrix_figure, 'Tag', 'FigureToolBar');
            
            delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.SaveFigure'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.OpenInspector'))
            delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
            delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
            delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertColorbar'))
            delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertLegend'))
            delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOff'))
            delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOn'))
            
            % adjmatrix plot
            A = el.get('G').get('A');
            br_dict = el.get('GR').get('SUB_DICT').getItem(1).get('BA').get('BR_DICT');
            labels = cellfun(@(x) x.get('ID'), br_dict.getItems());
            
            handle_plot = plotw( ...
                A, adj_matrix_figure, ...
                'xlabels', labels', ...
                'ylabels', labels ...
                );
        end
        function [pixels, normalized] = get_figure_position()
            fig_h = getGUIFigureObj();
            set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
            pixels = getpixelposition(fig_h);
            normalized = get(fig_h, 'Position');
            set(fig_h, 'Units', 'characters'); % go back
        end
        function obj = getGUIFigureObj()
            figHandles = findobj('Type', 'figure');
            for i = 1:1:length(figHandles)
                fig_h = figHandles(i);
                if contains(fig_h.Name, 'AnalyzeGroup - ')
                    obj = fig_h;
                end
            end
        end
        function h = plotw(A, figure, varargin)
            % PLOTW plots a weighted matrix
            %
            % H = PLOTW(A) plots the weighted matrix A and returns the handle to
            %   the plot H.
            %
            % H = PLOTW(A,'PropertyName',PropertyValue) sets the property of the
            %   matrix plot PropertyName to PropertyValue.
            %   All standard plot properties of surf can be used.
            %   Additional admissive properties are:
            %       xlabels   -   1:1:number of matrix elements (default)
            %       ylabels   -   1:1:number of matrix elements (default)
            %
            % See also Graph, plotb, surf.

            N = length(A);

            % x labels
            xlabels = (1:1:N);
            for n = 1:2:length(varargin)
                if strcmpi(varargin{n}, 'xlabels')
                    xlabels = varargin{n + 1};
                end
            end
            if ~iscell(xlabels)
                xlabels = {xlabels};
            end

            % y labels
            ylabels = (1:1:N);
            for n = 1:2:length(varargin)
                if strcmpi(varargin{n}, 'ylabels')
                    ylabels = varargin{n + 1};
                end
            end
            if ~iscell(ylabels)
                ylabels = {ylabels};
            end

            ht = surf((0:1:N), ...
                (0:1:N), ...
                [A, zeros(size(A, 1), 1); zeros(1, size(A, 1) + 1)]);
            view(2)
            shading flat
            axis equal square tight
            grid off
            box on
            set(figure, ...
                'XAxisLocation', 'top', ...
                'XTick', (1:1:N) - .5, ...
                'XTickLabel', {}, ...
                'YAxisLocation', 'left', ...
                'YDir', 'Reverse', ...
                'YTick', (1:1:N) - .5, ...
                'YTickLabel', ylabels)

            if ~verLessThan('matlab', '8.4.0')
                set(gca, ...
                    'XTickLabelRotation', 90, ...
                    'XTickLabel', xlabels)
            else
                t = text((1:1:N) - .5, zeros(1, N), xlabels);
                set(t, ...
                    'HorizontalAlignment', 'left', ...
                    'VerticalAlignment', 'middle', ...
                    'Rotation', 90);
            end

            colormap jet

            % output if needed
            if nargout > 0
                h = ht;
            end
        end
    
    % output
    if nargout > 0
        h_panel = pl.pp;
    end
end
function update(pl)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PL) updates the content of the property graphical panel.
    %
    % See also draw, redraw, refresh.

    update@PlotProp(pl)

    el = pl.get('EL');
    prop = pl.get('PROP');

    value = el.getPropDefault(prop);

    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        %
    else
        % construct a data holder
        if ~isa(graph, 'Graph')            
            mlist = Graph.getCompatibleMeasureList(value);
            data = cell(length(mlist), 5);
            for mi = 1:1:length(mlist)
                if any(pl.selected == mi)
                    data{mi, 1} = true;
                else
                    data{mi, 1} = false;
                end
                data{mi, 2} = mlist{mi};
                if Measure.is_nodal(mlist{mi})
                    data{mi, 3} = 'NODAL';
                elseif Measure.is_global(mlist{mi})
                    data{mi, 3} = 'GLOBAL';
                else
                    data{mi, 3} = 'BINODAL';
                end
                
                if Measure.is_superglobal(mlist{mi})
                    data{mi, 4} = 'SUPERGLOBAL';
                elseif Measure.is_unilayer(mlist{mi})
                    data{mi, 4} = 'UNILAYER';
                else
                    data{mi, 4} = 'BILAYER';
                end
                
                data{mi, 5} = eval([mlist{mi} '.getDescription()']);
            end            

            set(pl.measure_tbl, ...
                'Data', data, ...
                'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)] ...
                )
        end

    end
end
function redraw(pl, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PL) redraws the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=3.3).
    %
    % See also draw, update, refresh.

    pl.redraw@PlotProp('Height', 30, varargin{:});
end
function selected = getSelected(pl)
    selected = pl.selected;
end