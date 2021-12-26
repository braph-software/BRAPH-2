%% ¡header!
PPGroup_SUBDict < PlotProp (pl, plot property of group subjects idict) is a plot of group subjects idict.

%%% ¡description!
PPGroup_SUBDict plots a table to visualize the group IndexedDictionary of subjects.

%%% ¡seealso!
GUI, PlotElement, PlotProp, Group, Subject

%% ¡properties!
pp
table

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

    pl.pp = draw@PlotProp(pl, varargin{:});
    
    f_subs = [];

% % %     set(pl.pp, 'DeleteFcn', {@close_f_subs}, ...
% % %         varargin{:})
% % %     function close_f_settings(~,~)
% % %         if ~isempty(f_subs)
% % %             for k = 1:1:length(f_subs)                
% % %                 sub_gui_h = f_subs{k};
% % %                 if isgraphics(sub_gui_h)
% % %                     close(sub_gui_h)
% % %                 end
% % %             end
% % %         end
% % %     end

    if isempty(pl.table) || ~isgraphics(pl.table, 'listbox')
        pl.table = uicontrol('Style', 'listbox', ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .96 .7], ...
            'String', '', ...
            'Max', -1, 'Min', 0, ...
            'Value', 1, ...
            'Callback', {@cb_table} ...
            );
    end
    
    ui_button_table_remove = uicontrol(pl.pp,'Style', 'pushbutton', ...
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

            selected_sub = get(pl.table, 'Value');
            
            selected_sub = sub_dict.remove_all(selected_sub);
            
            pl.update();           
        end
    
    ui_button_table_moveup = uicontrol(pl.pp,'Style', 'pushbutton', ...
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

            selected_sub = get(pl.table, 'Value');

            selected_sub = sub_dict.move_up(selected_sub);

            pl.update();           
        end
    
    ui_button_table_movedown = uicontrol(pl.pp,'Style', 'pushbutton', ...
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

            selected_sub = get(pl.table, 'Value');

            selected_sub = sub_dict.move_down(selected_sub);

            pl.update();           
        end
    
    ui_button_table_move2top = uicontrol(pl.pp,'Style', 'pushbutton', ...
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

            selected_sub = get(pl.table, 'Value');

            selected_sub = sub_dict.move_to_top(selected_sub);

            pl.update();           
        end
    
    ui_button_table_move2bottom = uicontrol(pl.pp,'Style', 'pushbutton', ...
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

            selected_sub = get(pl.table, 'Value');

            selected_sub = sub_dict.move_to_bottom(selected_sub);

            pl.update();           
        end

    % opens a subejct figure if double-clicked
    click_time = [];
    function cb_table(~, ~)
        if isempty(click_time)
            click_time = tic();
        else
            time_between_clicks = toc(click_time);
            click_time = tic();
            if time_between_clicks < 0.1
                selected_sub = get(pl.table, 'Value');
                plot_subject_figure(selected_sub)
            end
        end
    end
    function plot_subject_figure(selected_sub)
% % %         if isempty(index)
% % %             index = get(pl.table, 'Value');
% % %         end
% % %         subject = sub_dict.getItem(index);
% % %         [~, norm] = get_figure_position();
% % %         subjects_with_gui = getGUISubjects();
% % %         subjects_with_gui_names = cellfun(@(x) erase(erase(x.Name, ' - BRAPH2'), [el.get('SUB_CLASS') ' - ']), subjects_with_gui, 'UniformOutput', false);
% % % 
% % %         if ~any(cellfun(@(x) contains(x, subject.get('ID')), subjects_with_gui_names))
% % %             idx = length(subjects_with_gui);
% % %             y_offset = 0.02 * idx;
% % %             if y_offset > .45
% % %                 y_offset = 0;
% % %             end
% % %             x = norm(1) + norm(3) + .02 * idx;                
% % %             y = norm(2) - y_offset;
% % %             w = norm(3);
% % %             h = norm(4);
% % % 
% % %             GUI(subject, 'CloseRequest', false, 'Position', [x y w h]);
% % %         else
% % %             idx = find(contains(subjects_with_gui_names, subject.get('ID')));
% % %             sub_h = subjects_with_gui{idx};
% % %             figure(sub_h);
% % %         end
% % % 
% % %         f_subs = getGUISubjects();
    end    
% % %     function obj = getGUIFigureObj()
% % %         [~, figHandles] = get_handle_objs('figure', [], 'Group');
% % %         obj = figHandles{1};
% % %     end
% % %     function objs = getGUISubjects()
% % %         [~, objs] = get_handle_objs('figure', [], 'Subject');
% % %     end
% % %     function [pixels, normalized] = get_figure_position()
% % %         fig_h = getGUIFigureObj();
% % %         set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
% % %         pixels = getpixelposition(fig_h);
% % %         normalized = get(fig_h, 'Position');
% % %         set(fig_h, 'Units', 'characters'); % go back
% % %     end
% % %     function disableSubClassObj()
% % %         control_handles = findobj('Type', 'UIControl');
% % %         for j = 1:length(control_handles)
% % %             ctrl_h = control_handles(j);
% % %             if contains(ctrl_h.String, 'SUB_CLASS')
% % %                 set(ctrl_h, 'Enable', 'off');
% % %                 ctrl_slider = control_handles(j-2);
% % %                 set(ctrl_slider, 'Enable', 'off');
% % %             end
% % %         end
% % %     end

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
    set(pl.table, ...
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
% % % function selected = getSelected(pl)
% % %     selected = pl.selected;
% % % end
