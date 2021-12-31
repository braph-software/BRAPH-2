%% ¡header!
PPGroup_SUBDict < PlotProp (pl, plot property of group subjects idict) is a plot of group subjects idict.

%%% ¡description!
PPGroup_SUBDict plots a table to visualize the group IndexedDictionary of subjects.

%%% ¡seealso!
GUI, PlotElement, PlotProp, Group, Subject

%% ¡properties!
pp
list_subs % list of subjects
f_subs % subject figures

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the idict for brain atlas property graphical panel.
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
    %  objects from the handle H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    pl.pp = draw@PlotProp(pl, 'DeleteFcn', {@close_f_subs}, varargin{:});
        function close_f_subs(~, ~) % Note that this will prevent the settings figure from being closed, which should not be a problem because settings is not used
            if ~isempty(pl.f_subs)
                for i = 1:1:length(pl.f_subs)
                    if isgraphics(pl.f_subs{i}, 'figure')
                        close(pl.f_subs{i})
                    end
                end
            end
        end
        
    pl.list_subs = uicontrol('Style', 'listbox', ...
        'Parent', pl.pp, ...
        'Units', 'normalized', ...
        'Position', [.02 .2 .96 .7], ...
        'String', '', ...
        'Max', -1, 'Min', 0, ...
        'Callback', {@cb_list_subs} ...
        );
        % opens a subejct figure if double-clicked
        click_time = [];
        function cb_list_subs(~, ~)
            if isempty(click_time)
                click_time = tic();
            else
                time_between_clicks = toc(click_time);
                click_time = tic();
                if time_between_clicks < 0.3
                    selected_sub = get(pl.list_subs, 'Value');
                    plot_subject_figure(selected_sub)
                end
            end
        end
        function plot_subject_figure(selected_sub)
            gr = pl.get('EL');
            prop = pl.get('PROP');
            sub_dict = gr.get(prop);

            % determine figure position
            f_gr = ancestor(pl.pp, 'Figure'); % GUI Group
            backup_units = get(f_gr, 'Units');
            set(f_gr, 'Units', 'pixels')
            f_gr_pos = get(f_gr, 'Position'); % pixels
            f_gr_x = f_gr_pos(1);
            f_gr_y = f_gr_pos(2);
            f_gr_w = f_gr_pos(3);
            f_gr_h = f_gr_pos(4);
            set(f_gr, 'Units', backup_units);

            screen_pos = get(0,'screensize');  % pixels
            screen_x = screen_pos(1);
            screen_y = screen_pos(2);
            screen_w = screen_pos(3);
            screen_h = screen_pos(4);
            
            N = ceil(sqrt(sub_dict.length())); % number of row and columns of figures
            
            x = (f_gr_x + f_gr_w) / screen_w + mod(selected_sub - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
            y = f_gr_y / screen_h;
            w = f_gr_w / screen_w;
            h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_sub - .5) / N)) / N / screen_h;
            
            % plot subject figure (or bring it to front)           
            sub = sub_dict.getItem(selected_sub);
            if length(pl.f_subs) < selected_sub || isempty(pl.f_subs{selected_sub}) || ~isgraphics(pl.f_subs{selected_sub}, 'figure')
                pl.f_subs{selected_sub} = GUI(sub, ...
                    'Position', [x y w h], ...
                    'CloseRequest', false ...
                    );
            else
                figure(pl.f_subs{selected_sub})
            end
        end

    ui_button_table_remove = uicontrol(pl.pp, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.02 .1 .22 .07], ...
        'String', 'Remove', ...
        'TooltipString', 'Remove selected subject.', ...
        'Callback', {@cb_table_remove} ...
        );
        function cb_table_remove(~, ~)  % (src, event)
            gr = pl.get('EL');
            prop = pl.get('PROP');
            sub_dict = gr.get(prop);

            selected_sub = get(pl.list_subs, 'Value');
            
            selected_sub = sub_dict.remove_all(selected_sub);
            
            pl.update();           
        end
    
    ui_button_table_moveup = uicontrol(pl.pp, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.26 .1 .22 .07], ...
        'String', 'Move up', ...
        'TooltipString', 'Move selected subject up.', ...
        'Callback', {@cb_table_moveup} ...
        );
        function cb_table_moveup(~, ~)  % (src, event)
            gr = pl.get('EL');
            prop = pl.get('PROP');
            sub_dict = gr.get(prop);

            selected_sub = get(pl.list_subs, 'Value');

            selected_sub = sub_dict.move_up(selected_sub);

            pl.update();           
        end
    
    ui_button_table_movedown = uicontrol(pl.pp, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.26 .02 .22 .07], ...
        'String', 'Move down', ...
        'TooltipString', 'Move selected subject down.', ...
        'Callback', {@cb_table_movedown} ...
        );
        function cb_table_movedown(~, ~)  % (src, event)
            gr = pl.get('EL');
            prop = pl.get('PROP');
            sub_dict = gr.get(prop);

            selected_sub = get(pl.list_subs, 'Value');

            selected_sub = sub_dict.move_down(selected_sub);

            pl.update();           
        end
    
    ui_button_table_move2top = uicontrol(pl.pp, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.52 .1 .22 .07], ...
        'String', 'Move top', ...
        'TooltipString', 'Move selected subject to top of table.', ...
        'Callback', {@cb_table_move2top} ...
        );
        function cb_table_move2top(~, ~)  % (src, event)
            gr = pl.get('EL');
            prop = pl.get('PROP');
            sub_dict = gr.get(prop);

            selected_sub = get(pl.list_subs, 'Value');

            selected_sub = sub_dict.move_to_top(selected_sub);

            pl.update();           
        end
    
    ui_button_table_move2bottom = uicontrol(pl.pp, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.52 .02 .22 .07], ...
        'String', 'Move bottom', ...
        'TooltipString', 'Move selected subject to bottom of table.', ...
        'Callback', {@cb_table_move2bottom} ...
        );
        function cb_table_move2bottom(~, ~)  % (src, event)
            gr = pl.get('EL');
            prop = pl.get('PROP');
            sub_dict = gr.get(prop);

            selected_sub = get(pl.list_subs, 'Value');

            selected_sub = sub_dict.move_to_bottom(selected_sub);

            pl.update();           
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

    gr = pl.get('EL');
    prop = pl.get('PROP');

    sub_dict = gr.get(prop);

    subjects_ids = cell(sub_dict.length(), 1);
    for i = 1:1:sub_dict.length()
        sub = sub_dict.getItem(i);
        subjects_ids{i} = sub.tostring();
    end
    set(pl.list_subs, ...
        'String', subjects_ids, ...
        'TooltipString', [num2str(gr.getPropProp(prop)) ' ' gr.getPropDescription(prop)], ...
        'Value', 1 ...
        )
end
function redraw(pl, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PL) redraws the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=30).
    %
    % See also draw, update, refresh.

    pl.redraw@PlotProp('Height', 30, varargin{:});
end