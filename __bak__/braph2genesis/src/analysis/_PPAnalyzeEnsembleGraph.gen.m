%% ¡header!
PPAnalyzeEnsembleGraph < PlotProp (pl, plot property of analyze ensemble graph) is a plot of analyze ensemble graph.

%%% ¡description!
PPAnalyzeEnsembleGraph plots a Analyze Ensemble Graph table.

%%% ¡seealso!
GUI, PlotElement, PlotProp, AnalyzeEnsemble.

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

    pl.pp = draw@PlotProp(pl, varargin{:});

    % output
    if nargout > 0
        h_panel = pl.pp;
    end
end
function update(pl, selected)
    %UPDATE updates the content of the property graphical panel.
    %
    % UPDATE(PL) updates the content of the property graphical panel.
    %
    % See also draw, redraw, refresh.

    update@PlotProp(pl)

    el = pl.get('EL');
    prop = pl.get('PROP');
    if nargin > 1
        pl.selected = selected;
    else
        pl.selected = [];
    end
    
    graph_gui = [];

    if el.getPropCategory(prop) == Category.RESULT && ~el.isLocked('ID')
        % do nothing
    else
        graph_dict = el.get(prop);
        if isa(graph_dict, 'NoValue')
            graph_dict = el.getPropDefault(prop);
        end
        
        if graph_dict.length ~= 0
            selected_graph = graph_dict.getItem(1);
        else
            selected_graph =  graph_dict;
        end
        if isempty(pl.measure_tbl) || ~isgraphics(pl.measure_tbl, 'uitable')
            graph_list = get_graph_list();
            pl.measure_tbl = uicontrol( ...
                pl.pp, ...
                'Parent', pl.pp, ...
                'Units', 'normalized', ...
                'Style', 'listbox', ...
                'Position', [.02 .2 .9 .7], ...
                'String', graph_list, ...
                'Callback', {@cb_graph_selection} ...
                );
            ui_button_graph = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');

            init_buttons()
        end
    end

        function init_buttons()
            set(ui_button_graph, ...
                'Position', [.02 .01 .3 .07], ...
                'String', 'See Graph', ...
                'TooltipString', 'Create a GUI Graph', ...
                'Callback', {@cb_table_graph})
        end
        function cb_graph_selection(~, ~)
            selected_graph = graph_dict.getItem(get(pl.measure_tbl, 'Value'));
            graph_dict.move_to(get(pl.measure_tbl, 'Value'), 1);
            updateMeasures();
        end
        function cb_table_graph(~, ~)
            [parent_position_pixels, normalized] = get_figure_position();
            w = parent_position_pixels(3);
            h = parent_position_pixels(4);

            screen_size = get(0,'screensize');

            if w >= screen_size(3) / 2
                x2 = normalized(1) / 2;
                w2 = normalized(3) / 2 - .01;
            elseif h == screen_size(4)
                y2 = normalized(2);
                h2 = normalized(4) / 2;
            else % golden ratio
                % golden ratio is defined as a+b/a = a/b = phi. phi = 1.61
                x2 = normalized(1) + normalized(3);
                h2 = normalized(4);
                y2 = normalized(2);
                w2 = normalized(3);
            end
            GUI(selected_graph, 'CloseRequest', false, 'Position', [x2 y2 w2 h2]);
            graph_gui = getGUIGraph();
        end
        function [pixels, normalized] = get_figure_position()
            fig_h = getGUIFigureObj();
            set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
            pixels = getpixelposition(fig_h);
            normalized = get(fig_h, 'Position');
            set(fig_h, 'Units', 'characters'); % go back
        end
        function obj = getGUIFigureObj()
            obj = get_handle_objs('figure', 'AnalyzeEnsemble');
        end
        function obj = getGUIGraph()
            [~, figHandles] = get_handle_objs('figure', [], 'Graph');
            obj = figHandles{1};
        end
        function list = get_graph_list()
            graphs = graph_dict.getItems();
            list = cellfun(@(x) x.tostring(), graphs, 'UniformOutput', false);
            % list = unique(list);
        end
        function updateMeasures()
            control_handles = findobj('Type', 'UIControl');
            for j = 1:length(control_handles)
                ctrl_h = control_handles(j);
                if contains(ctrl_h.String, 'ME_DICT')
                    update_btn = control_handles(j - 3);
                    feval(get(update_btn, 'Callback'), update_btn, []);
                end
            end
        end

    set(pl.pp, 'DeleteFcn', {@close_f_settings})

        function close_f_settings(~,~)
            if ~isempty(graph_gui)
                if isgraphics(ancestor(graph_gui, 'Figure'))
                    close(ancestor(graph_gui, 'Figure'))
                end
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

    el = pl.get('EL');
    prop = pl.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pl.redraw@PlotProp('Height', 1.8, varargin{:})
    else
        value_cell = el.get(prop);
        base = 10;

        if isempty(value_cell)
            pl.redraw@PlotProp('Height', 1.8, varargin{:})
        else
            tmp_data = get(pl.measure_tbl, 'String');
            tmp_h = size(tmp_data, 1); % 1.1 per row
            f_h = (tmp_h * 1.1) + base;
            if f_h < 20
                pl.redraw@PlotProp('Height', f_h, varargin{:})
                set(pl.measure_tbl, 'Position', [.01 .2 .98 .6])
            else
                pl.redraw@PlotProp('Height', 15, varargin{:})
            end
        end

    end
end
function selected = getSelected(pl)
    selected = pl.selected;
end