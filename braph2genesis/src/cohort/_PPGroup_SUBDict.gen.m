%% ¡header!
PPGroup_SUBDict < PlotProp (pr, plot property of group subjects idict) is a plot of group subjects idict.

%%% ¡description!
PPGroup_SUBDict plots a table to visualize IndexedDictionary of the group of subjects.

CALLBACK - This is a callback function:

    pr.<strong>cb_bring_to_front</strong>() - brings to the front the group figure and its subject figures
    pr.<strong>cb_hide</strong>() - hides the group figure and its subject figures
    pr.<strong>cb_close</strong>() - closes the group figure and its subject figures

%%% ¡seealso!
GUI, PlotElement, PlotProp, Group, Subject, IndexedDictionary

%% ¡properties!
p
list_subs % list of subjects
f_subs % subject figures

%% ¡methods!
function h_panel = draw(pr, varargin)
    %DRAW draws the idict for brain atlas property graphical panel.
    %
    % DRAW(PR) draws the property panel with a table for the idict of the
    %  brain atlas and the relative management buttons.
    %
    % H = DRAW(PR) returns a handle to the property panel.
    %
    % DRAW(PR, 'Property', VALUE, ...) sets the properties of the panel 
    %  with custom Name-Value pairs.
    %  All standard plot properties of uipanel can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle H of the panel.
    %
    % See also update, redraw, settings, uipanel.

    pr.p = draw@PlotProp(pr, 'DeleteFcn', {@close_f_subs}, varargin{:});
        function close_f_subs(~, ~) 
            % Note that this will prevent the settings figure from being closed
            % which should not be a problem because settings is not used
            
            if ~isempty(pr.f_subs)
                for i = 1:1:length(pr.f_subs)
                    if check_graphics(pr.f_subs{i}, 'figure')
                        close(pr.f_subs{i})
                    end
                end
            end
        end
        
    pr.list_subs = uicontrol('Style', 'listbox', ...
        'Parent', pr.p, ...
        'Units', 'normalized', ...
        'Position', [.02 .2 .96 .74], ...
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
            if time_between_clicks < .3
                selected_sub = get(pr.list_subs, 'Value');
                plot_subject_figure(selected_sub)
            end
        end
    end
    function plot_subject_figure(selected_sub)
        gr = pr.get('EL');
        prop = pr.get('PROP');
        sub_dict = gr.get(prop);

        % determine figure position
        f_gr = ancestor(pr.p, 'Figure'); % GUI Group
        f_gr_x = Plot.x0(f_gr, 'pixels');
        f_gr_y = Plot.y0(f_gr, 'pixels');
        f_gr_w = Plot.w(f_gr, 'pixels');
        f_gr_h = Plot.h(f_gr, 'pixels');

        screen_x = Plot.x0(0, 'pixels');
        screen_y = Plot.y0(0, 'pixels');
        screen_w = Plot.w(0, 'pixels');
        screen_h = Plot.h(0, 'pixels');

        N = ceil(sqrt(sub_dict.length())); % number of row and columns of figures

        x = (f_gr_x + f_gr_w) / screen_w + mod(selected_sub - 1, N) * (screen_w - f_gr_x - 2 * f_gr_w) / N / screen_w;
        y = f_gr_y / screen_h;
        w = f_gr_w / screen_w;
        h = .5 * f_gr_h / screen_h + .5 * f_gr_h * (N - floor((selected_sub - .5) / N)) / N / screen_h;

        % plot subject figure (or bring it to front)           
        sub = sub_dict.getItem(selected_sub);
        if length(pr.f_subs) < selected_sub || ~check_graphics(pr.f_subs{selected_sub}, 'figure')
            pr.f_subs{selected_sub} = GUI( ...
                'PE', sub, ...
                'POSITION', [x y w h], ...
                'MENU_FILE', false, ...
                'MENU_IMPORT', false, ...
                'MENU_EXPORT', false, ...
                'TOOL_FILE', false, ...
                'CLOSEREQ', false ...
                ).draw();
            tmp_gui = get(pr.f_subs{selected_sub}, 'UserData');
            set(pr.f_subs{selected_sub}, 'UserData', {tmp_gui, pr.p})
        else
            figure(pr.f_subs{selected_sub})
        end
    end

    ui_button_table_remove = uicontrol(pr.p, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.02 .1 .22 .07], ...
        'String', 'Remove', ...
        'TooltipString', 'Remove selected subject.', ...
        'Callback', {@cb_table_remove} ...
        );
    function cb_table_remove(~, ~)  % (src, event)
        gr = pr.get('EL');
        prop = pr.get('PROP');
        sub_dict = gr.get(prop);

        selected_sub = get(pr.list_subs, 'Value');

        selected_sub = sub_dict.remove_all(selected_sub);

        pr.update();           
    end
    
    ui_button_table_moveup = uicontrol(pr.p, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.26 .1 .22 .07], ...
        'String', 'Move up', ...
        'TooltipString', 'Move selected subject up.', ...
        'Callback', {@cb_table_moveup} ...
        );
    function cb_table_moveup(~, ~)  % (src, event)
        gr = pr.get('EL');
        prop = pr.get('PROP');
        sub_dict = gr.get(prop);

        selected_sub = get(pr.list_subs, 'Value');

        selected_sub = sub_dict.move_up(selected_sub);

        pr.update();           
    end
    
    ui_button_table_movedown = uicontrol(pr.p, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.26 .02 .22 .07], ...
        'String', 'Move down', ...
        'TooltipString', 'Move selected subject down.', ...
        'Callback', {@cb_table_movedown} ...
        );
    function cb_table_movedown(~, ~)  % (src, event)
            gr = pr.get('EL');
            prop = pr.get('PROP');
            sub_dict = gr.get(prop);

            selected_sub = get(pr.list_subs, 'Value');

            selected_sub = sub_dict.move_down(selected_sub);

            pr.update();           
        end
    
    ui_button_table_move2top = uicontrol(pr.p, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.52 .1 .22 .07], ...
        'String', 'Move top', ...
        'TooltipString', 'Move selected subject to top of table.', ...
        'Callback', {@cb_table_move2top} ...
        );
    function cb_table_move2top(~, ~)  % (src, event)
            gr = pr.get('EL');
            prop = pr.get('PROP');
            sub_dict = gr.get(prop);

            selected_sub = get(pr.list_subs, 'Value');

            selected_sub = sub_dict.move_to_top(selected_sub);

            pr.update();           
        end
    
    ui_button_table_move2bottom = uicontrol(pr.p, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.52 .02 .22 .07], ...
        'String', 'Move bottom', ...
        'TooltipString', 'Move selected subject to bottom of table.', ...
        'Callback', {@cb_table_move2bottom} ...
        );
    function cb_table_move2bottom(~, ~)  % (src, event)
            gr = pr.get('EL');
            prop = pr.get('PROP');
            sub_dict = gr.get(prop);

            selected_sub = get(pr.list_subs, 'Value');

            selected_sub = sub_dict.move_to_bottom(selected_sub);

            pr.update();           
    end
    
    % output
    if nargout > 0
        h_panel = pr.p;
    end
end
function update(pr)
    %UPDATE updates the content of the property panel and its graphical objects.
    %
    % UPDATE(PR) updates the content of the property panel and its graphical objects.
    %
    % Important note:
    % 1. UPDATE() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % See also draw, redraw, PlotElement.

    update@PlotProp(pr)

    gr = pr.get('EL');
    prop = pr.get('PROP');

    sub_dict = gr.get(prop);

    subjects_ids = cell(sub_dict.length(), 1);
    for i = 1:1:sub_dict.length()
        sub = sub_dict.getItem(i);
        subjects_ids{i} = sub.tostring();
    end
    set(pr.list_subs, ...
        'String', subjects_ids, ...
        'TooltipString', [num2str(gr.getPropProp(prop)) ' ' gr.getPropDescription(prop)], ...
        'Value', 1 ...
        )
end
function redraw(pr, varargin)
    %REDRAW resizes the property panel and repositions its graphical objects.
    %
    % REDRAW(PR) resizes the property panel and repositions its
    %   graphical objects. 
    % 
    % Important notes:
    % 1. REDRAW() sets the units 'characters' for panel and all its graphical objects. 
    % 2. REDRAW() is typically called internally by PlotElement and does not need 
    %  to be explicitly called in children of PlotProp.
    %
    % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
    %  repositions the property panel. It is possible to use a
    %  subset of the Name-Value pairs.
    %  By default:
    %  - X0 does not change
    %  - Y0 does not change
    %  - WIDTH does not change
    %  - HEIGHT=1.4 characters.
    %
    % See also draw, update, PlotElement.

    pr.redraw@PlotProp('Height', 28, varargin{:});
end
function cb_bring_to_front(pr)
    %CB_BRING_TO_FRONT brings to front the group figure and its subject figures.
    %
    % CB_BRING_TO_FRONT(PR) brings to front the group figure and its
    %  subject figures.
    %
    % See also cb_hide, cb_close.

    % brings to front settings panel
    pr.cb_bring_to_front@PlotProp();

    % brings to front subject figures
    for i = 1:1:length(pr.f_subs)
        f_sub = pr.f_subs{i};
        if check_graphics(f_sub, 'figure')
            gui_tmp = get(f_sub, 'UserData');
            gui = gui_tmp{1};
            pe = gui.get('PE');
            pe.cb_bring_to_front()
        end
    end
end
function cb_hide(pr)
    %CB_HIDE hides the group figure and its subject figures.
    %
    % CB_HIDE(PR) hides the group figure and its subject figures.
    %
    % See also cb_bring_to_front, cb_close.

    % hides settings panel
    pr.cb_hide@PlotProp();

    % hides subject figures
    for i = 1:1:length(pr.f_subs)
        f_sub = pr.f_subs{i};
        if check_graphics(f_sub, 'figure')
            gui_tmp = get(f_sub, 'UserData');
            gui = gui_tmp{1};
            pe = gui.get('PE');
            pe.cb_hide()
        end
    end
end
function cb_close(pr)
    %CB_CLOSE closes the group figure and its subject figures.
    %
    % CB_CLOSE(PR) closes the group figure and its subject figures.
    %
    % See also cb_bring_to_front, cb_hide.

    % closes settings panel
    pr.cb_close@PlotProp();

    % closes subject figures
    for i = 1:1:length(pr.f_subs)
        f_sub = pr.f_subs{i};
        if check_graphics(f_sub, 'figure')
            gui_tmp = get(f_sub, 'UserData');
            gui = gui_tmp{1};
            pe = gui.get('PE');
            pe.cb_close()
        end
    end
end


