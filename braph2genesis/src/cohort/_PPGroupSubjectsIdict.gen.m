%% ¡header!
PPGroupSubjectsIdict < PlotProp (pl, plot property of group subjects idict) is a plot of group subjects idict.

%%% ¡description!
PPGroupSubjectsIdict plots a table to visualize the group IndexedDictionary of subjects.

%%% ¡seealso!
GUI, PlotElement, PlotProp, Group, Subject

%% ¡properties!
pp
table_value_idict
selected

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
    %  objects from the handle to the brain surface graphical panel H.
    %
    % see also update, redraw, refresh, settings, uipanel, isgraphics.

    el = pl.get('EL');
    prop = pl.get('PROP');
    pl.selected = [];
    subjects_idict = el.getr(prop);    

    pl.pp = draw@PlotProp(pl, varargin{:});

    if isempty(pl.table_value_idict) || ~isgraphics(pl.table_value_idict, 'listbox')
        % construct a data holder

        pl.table_value_idict = uicontrol();
        set( pl.table_value_idict, ...
            'Parent', pl.pp, ...
            'Style', 'listbox', ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .96 .7], ...
            'String', '', ...
            'Max', -1, 'Min', 0, ...
            'Value', 1, ...
            'TooltipString', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'Callback', {@cb_table_idict_value} ...
            );

        if ~isequal(subjects_idict, NoValue)
            data = cell(subjects_idict.length(), 1);
            for i = 1:1:subjects_idict.length() %#ok<FXUP>
                sub = subjectS_idict.getItem(i);
                subjects_ids{i} = sub.tostring();
            end
            set(pl.table_value_idict, 'String', subjects_ids)
        else
        end
    end

    ui_button_table_see_subject = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');    
    ui_button_table_add = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_remove = uicontrol(pl.pp,'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_moveup = uicontrol(pl.pp,'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_movedown = uicontrol(pl.pp,'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_move2top = uicontrol(pl.pp,'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_move2bottom = uicontrol(pl.pp,'Style', 'pushbutton', 'Units', 'normalized');
    index = [];
    init_buttons()
        function init_buttons()
            set(ui_button_table_see_subject, ...
                'Position', [.02 .1 .22 .07], ...
                'String', 'Subject Data', ...
                'TooltipString', 'Get a Subject GUI', ...
                'Callback', {@cb_table_get_subject})

            set(ui_button_table_add, ...
                'Position', [.26 .1 .22 .07], ...
                'String', 'Add', ...
                'TooltipString', 'Add brain region at the end of table.', ...
                'Callback', {@cb_table_add})
            
            set(ui_button_table_remove, 'Position', [.26 .02 .22 .07], ...
                'String', 'Remove', ...
                'TooltipString', 'Remove selected brain regions.', ...
                'Callback', {@cb_table_remove})
            
            set(ui_button_table_moveup, ...
                'Position', [.52 .1 .22 .07], ...
                'String', 'Move up', ...
                'TooltipString', 'Move selected brain regions up.', ...
                'Callback', {@cb_table_moveup})
            
            set(ui_button_table_movedown, ...
                'Position', [.52 .02 .22 .07], ...
                'String', 'Move down', ...
                'TooltipString', 'Move selected brain regions down.', ...
                'Callback', {@cb_table_movedown})
            
            set(ui_button_table_move2top, ...
                'Position', [.76 .1 .22 .07], ...
                'String', 'Move top', ...
                'TooltipString', 'Move selected brain regions to top of table.', ...
                'Callback', {@cb_table_move2top})
            
            set(ui_button_table_move2bottom, ...
                'Position', [.76 .02 .22 .07], ...
                'String', 'Move bottom', ...
                'TooltipString', 'Move selected brain regions to bottom of table.', ...
                'Callback', {@cb_table_move2bottom})
        end

    % callbacks
        function cb_table_idict_value(~, ~)
            index = get(pl.table_value_idict, 'Value');
        end
        function cb_table_get_subject(~, ~)  % (src, event)
            if isempty(index)
                index = get(pl.table_value_idict, 'Value');
            end
            subject = subjects_idict.getItem(index);
            [~, norm] = get_figure_position();
            GUI(subject, true, 'Position', [norm(1)+.05 norm(2) norm(3) norm(4)]);
        end
        function cb_table_add(~, ~)  % (src, event)
            checkIdict();
            sub_id = 1;
            while subjects_idict.containsKey(num2str(sub_id))
                sub_id = sub_id + 1;
            end
            % lock subject_class
            subject_class = el.getr('SUB_CLASS');
            if ~el.isLocked('SUB_CLASS')
                el.lock('SUB_CLASS');
                disableSubClassObj()
            end
            sub = eval([subject_class '('  '''ID''' ', ' '''' num2str(sub_id) '''' ',' '''Label''' ',' '''''' ',' '''Notes''' ',' '''''' ')']);
            subjects_idict.add(sub);
            pl.update();
        end
        function cb_table_remove(~, ~)  % (src, event)
            checkIdict();
            pl.selected = subjects_idict.remove_all(index);
            pl.update();           
        end
        function cb_table_moveup(~, ~)  % (src, event)
            checkIdict();
            pl.selected = subjects_idict.move_up(index);
            pl.update();           
        end
        function cb_table_movedown(~, ~)  % (src, event)
            checkIdict();
            pl.selected = subjects_idict.move_down(index);
            pl.update();           
        end
        function cb_table_move2top(~, ~)  % (src, event)
            checkIdict();
            pl.selected = subjects_idict.move_to_top(index);
            pl.update();           
        end
        function cb_table_move2bottom(~, ~)  % (src, event)
            checkIdict();
            pl.selected = subjects_idict.move_to_bottom(index);
            pl.update();           
        end
        function checkIdict()
            if isa(subjects_idict, 'NoValue')
                subjects_idict = IndexedDictionary( ...
                    'id', 'idict', ...
                    'it_class', 'Subject', ...
                    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY) ...
                    );
                el.set('SUB_DICT', subjects_idict);
            end
        end
        function obj = getGUIFigureObj()
            figHandles = findobj('Type', 'figure');
            for i = 1:1:length(figHandles)
                fig_h = figHandles(i);
                if contains(fig_h.Name, 'Group - ')
                    obj = fig_h;
                end
            end
        end
        function [pixels, normalized] = get_figure_position()
            fig_h = getGUIFigureObj();
            set(fig_h, 'Units', 'normalized'); % set it to get position on normal units
            pixels = getpixelposition(fig_h);
            normalized = get(fig_h, 'Position');
            set(fig_h, 'Units', 'characters'); % go back
        end
        function  disableSubClassObj()
            control_handles = findobj('Type', 'UIControl');
            for j = 1:length(control_handles)
                ctrl_h = control_handles(j);
                if contains(ctrl_h.String, 'SUB_CLASS')
                    set(ctrl_h, 'Enable', 'off');
                    ctrl_slider = control_handles(j-2);
                    set(ctrl_slider, 'Enable', 'off');
                end
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
    value = el.getr(prop);

    if  isa(value, 'NoValue')
        %
    else
        % construct a data holder
        data = cell(value.length(), 1);
        for i = 1:1:value.length()            
            data{i, 1} = value.getItem(i).tostring();
        end

        if isempty(pl.table_value_idict)
            pl.table_value_idict = cell(value.length(), 1); 
        end

        set(pl.table_value_idict, ...
            'String', data, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'Value', 1 ...
            )

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

    pl.redraw@PlotProp('Height', 20, varargin{:});
end
function selected = getSelected(pl)
    selected = pl.selected;
end