%% ¡header!
PPGraphA < PlotProp (pl, plot property of graph A) is a plot of graph A.

%%% ¡description!
PPGraphA plots a Analyze Group graph table.

%%% ¡seealso!
GUI, PlotElement, PlotProp, AnalyzeGroup, AnalyzeGroup_ST_WU, AnalyzeGroup_ST_BUT, AnalyzeGroup_ST_BUD

%% ¡properties!
pp
table_value_cell

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

    pl.pp = draw@PlotProp(pl, varargin{:});

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
    value = el.getr(prop);
    layer_to_plot = 1;
    f = [];
    layer_name = [];
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        %
    else
        value_cell = el.get(prop);
        if isempty(pl.table_value_cell)
            pl.table_value_cell = cell(size(value_cell));
        end
        for i = 1:1:1 % because its only diagonal
            for j = 1:1:size(pl.table_value_cell, 2)
                if isempty(pl.table_value_cell{i, j}) || ~isgraphics(pl.table_value_cell{i, j}, 'uitable')
                    pl.table_value_cell{i, j} = uitable('Parent', pl.pp);
                end
                set(pl.table_value_cell{i, j}, ...
                    'Data', value_cell{j, j}, ...  % diagonal will advance with j values
                    'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
                    'CellEditCallback', {@cb_matrix_value, i, j} ...
                    )
            end
        end

        if isa(el, 'MultigraphBUD') || isa(el, 'MultiplexBUD')
            layer_name = 'Density';
        elseif isa(el, 'MultigraphBUT') || isa(el, 'MultiplexBUT')
            layer_name = 'Threshold';
        else
            layer_name = 'Layer';
        end

        ui_layer_text = uicontrol('Parent', pl.pp, 'Style', 'text');
        ui_layer_selector = uicontrol('Parent', pl.pp, 'Style', 'popup', 'String', {''});
        ui_adj_matrix = uicontrol('Parent', pl.pp, 'Style', 'pushbutton');
        init_adj_area()
    end

    % functions
        function init_adj_area()
            set(ui_layer_text, ...
                'Units', 'normalized', ...
                'Position', [.01 .035 .2 .055], ...
                'FontWeight', 'bold', ...
                'TooltipString', 'Select the layer of the Measure to be ploted.', ...
                'BackgroundColor', [.62 .545 .439], ...
                'String', layer_name ...
                )

            set(ui_layer_selector, ...
                'Units', 'normalized', ...
                'Position', [.22 .01 .2 .08], ...
                'String', cellfun(@(x) num2str(x),  num2cell([1:length(value_cell)]) , 'UniformOutput', false), ...
                'Callback', {@cb_layer_selector} ...
                )
            set(ui_adj_matrix, ...
                'String', 'See Matrix Plot', ...
                'Tooltip', 'Plot the Adjacency Matrix of the Graph', ...
                'Units', 'normalized', ...
                'Position', [.68 .02 .3 .08], ...
                'Callback', {@cb_adj_matrix} ...
                );
        end
        function cb_layer_selector(~, ~)
            layer_to_plot = get(ui_layer_selector, 'Value');
        end
        function cb_adj_matrix(~, ~)
            A = el.get('A');

            [~, normalized] = get_figure_position();
            x2 = normalized(1) + normalized(3);
            h2 = normalized(4) / 1.61;
            y2 = normalized(2) + normalized(4) - h2;
            w2 = normalized(3) * 1.61;

            f = figure( ...
                'Visible', 'off', ...
                'NumberTitle', 'off', ...
                'Name', ['Plot of Adjacency Matrix - ' BRAPH2.STR], ...
                'Units', 'normalized', ...
                'Position', [x2 y2 w2 h2], ...
                'Units', 'character', ...
                'Toolbar', 'figure', ...
                'MenuBar', 'none', ...
                'DockControls', 'off', ...
                'Color', [.94 .94 .94] ...
                );

            set_icon(f);

            ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
            delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
            delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))

            pg = PlotADJMatrix( ...
                'bkgcolor', [1 1 1], ...
                'setpos', [x2 y2 w2 h2], ...
                'A', A, ...
                'Layer', layer_to_plot ...
                );
            pg.draw('Parent', f);
            pg.set('SETPOS', [x2 normalized(2) w2 h2*1.61-h2-.065]);
            pg.settings();
            set(f, 'Visible', 'on')
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
                if contains(fig_h.Name, el.getClass())
                    obj = fig_h;
                end
            end
        end

    set(pl.pp, ...
        'DeleteFcn', {@close_f_settings})

        function close_f_settings(~,~)
            if ~isempty(f)
                if isgraphics(ancestor(f, 'Figure'))
                    close(ancestor(f, 'Figure'))
                end
            end

        end

    % callback
        function cb_matrix_value(src, event, i, j)
            value = el.get(prop);
            value_ij = value{i, j};
            value_ij(event.Indices(1), event.Indices(2)) = event.NewData;
            value{i, j} = value_ij;
            el.set(prop, value)

            pl.update()
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

    el = pl.get('EL');
    prop = pl.get('PROP');
    
    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pl.redraw@PlotProp('Height', 1.8, varargin{:})
    else
        value_cell = el.get(prop);
        
        if isempty(value_cell)
            pl.redraw@PlotProp('Height', 1.8, varargin{:})
        else
            pl.redraw@PlotProp('Height', 30, varargin{:})
        end
        
        for i = 1:1:1  % same as update
            for j = 1:1:size(value_cell, 2)
                set(pl.table_value_cell{i, j}, ...
                    'Units', 'character', ...
                    'Position', ...
                    [ ...
                    (0.01 + (i - 1) * 0.98 / size(pl.table_value_cell, 1)) * Plot.w(pl.pp) ...
                    (0.2 + (j - 1) * 0.8 / size(pl.table_value_cell, 2)) * (Plot.h(pl.pp) - 1.8) ...
                    0.98 / 1 * Plot.w(pl.pp) ...
                    0.8 / size(pl.table_value_cell, 2) * (Plot.h(pl.pp) - 1.8) ...
                    ] ...
                    )
            end
        end
    end
end