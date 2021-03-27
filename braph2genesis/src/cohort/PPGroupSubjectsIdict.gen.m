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

        pl.table_value_idict = uitable();
        set( pl.table_value_idict, ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .96 .7], ...
            'ColumnName', {'', 'Subejct ID', 'Label', 'Notes'}, ...
            'ColumnFormat', {'logical', 'char', 'char', 'char'}, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ColumnEditable', true, ...
            'CellEditCallback', {@cb_table_idict_value} ...
            );

        if ~isequal(subjects_idict, NoValue)
            data = cell(subjects_idict.length(), 4);
            for sub = 1:1:subjects_idict.length() %#ok<FXUP>
                if any(pl.selected == sub)
                    data{sub, 1} = true;
                else
                    data{sub, 1} = false;
                end
                data{sub, 2} = value_idict_ba.getItem(sub).get('ID');
                data{sub, 3} = value_idict_ba.getItem(sub).get('Label');
                data{sub, 4} = value_idict_ba.getItem(sub).get('Notes');
            end
            set(pl.table_value_idict, 'Data', data);
            set(pl.table_value_idict, 'ColumnWidth', 'auto')
        end
    end

    ui_button_table_selectall = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_clearselection = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_add = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_remove = uicontrol(pl.pp,'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_moveup = uicontrol(pl.pp,'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_movedown = uicontrol(pl.pp,'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_move2top = uicontrol(pl.pp,'Style', 'pushbutton', 'Units', 'normalized');
    ui_button_table_move2bottom = uicontrol(pl.pp,'Style', 'pushbutton', 'Units', 'normalized');
    init_buttons()
        function init_buttons()
            set(ui_button_table_selectall, 'Position', [.02 .1 .22 .07])
            set(ui_button_table_selectall, 'String', 'Select All')
            set(ui_button_table_selectall, 'TooltipString', 'Select all brain regions')
            set(ui_button_table_selectall, 'Callback', {@cb_table_selectall})

            set(ui_button_table_clearselection, 'Position', [.02 .01 .22 .07])
            set(ui_button_table_clearselection, 'String', 'Clear')
            set(ui_button_table_clearselection, 'TooltipString', 'Clear selection')
            set(ui_button_table_clearselection, 'Callback', {@cb_table_clearselection})

            set(ui_button_table_add, 'Position', [.26 .1 .22 .07])
            set(ui_button_table_add, 'String', 'Add')
            set(ui_button_table_add, 'TooltipString', 'Add brain region at the end of table.');
            set(ui_button_table_add, 'Callback', {@cb_table_add})

            set(ui_button_table_remove, 'Position', [.26 .02 .22 .07])
            set(ui_button_table_remove, 'String', 'Remove')
            set(ui_button_table_remove, 'TooltipString', 'Remove selected brain regions.');
            set(ui_button_table_remove, 'Callback', {@cb_table_remove})

            set(ui_button_table_moveup, 'Position', [.52 .1 .22 .07])
            set(ui_button_table_moveup, 'String', 'Move up')
            set(ui_button_table_moveup, 'TooltipString', 'Move selected brain regions up.');
            set(ui_button_table_moveup, 'Callback', {@cb_table_moveup})

            set(ui_button_table_movedown, 'Position', [.52 .02 .22 .07])
            set(ui_button_table_movedown, 'String', 'Move down')
            set(ui_button_table_movedown, 'TooltipString', 'Move selected brain regions down.');
            set(ui_button_table_movedown, 'Callback', {@cb_table_movedown})

            set(ui_button_table_move2top, 'Position', [.76 .1 .22 .07])
            set(ui_button_table_move2top, 'String', 'Move top')
            set(ui_button_table_move2top, 'TooltipString', 'Move selected brain regions to top of table.');
            set(ui_button_table_move2top, 'Callback', {@cb_table_move2top})

            set(ui_button_table_move2bottom, 'Position', [.76 .02 .22 .07])
            set(ui_button_table_move2bottom, 'String', 'Move bottom')
            set(ui_button_table_move2bottom, 'TooltipString', 'Move selected brain regions to bottom of table.');
            set(ui_button_table_move2bottom, 'Callback', {@cb_table_move2bottom})
        end

    % callbacks
        function cb_table_idict_value(~, event)
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
                case 2
                    if ~subjects_idict.containsKey(newdata)
                        % change brain region id
                        subjects_idict.getItem(i).set('ID', newdata)
                        % change brain region key in idict
                        oldkey = subjects_idict.getKey(i);
                        subjects_idict.replaceKey(oldkey, newdata);
                    end
                case 3
                    subjects_idict.getItem(i).set('Label', newdata)
                case 4
                    subjects_idict.getItem(i).set('Notes', newdata)
            end
            pl.update()
        end
        function cb_table_selectall(~, ~)  % (src, event)
            checkIdict();
            pl.selected = (1:1:subjects_idict.length())';
            pl.update()
        end
        function cb_table_clearselection(~, ~)  % (src, event)
            checkIdict();
            pl.selected = [];
            pl.update()
        end
        function cb_table_add(~, ~)  % (src, event)
            checkIdict();
            sub_id = 1;
            while subjects_idict.containsKey(num2str(sub_id))
                sub_id = sub_id + 1;
            end
            % must change since we dont have Subject subclass
            sub = Subject('ID', num2str(sub_id), ...
                'Label', '', ...
                'Notes', '');
            subjects_idict.add(sub);
            pl.update();
        end
        function cb_table_remove(~, ~)  % (src, event)
            checkIdict();
            pl.selected = subjects_idict.remove_all(pl.selected);
            pl.update();           
        end
        function cb_table_moveup(~, ~)  % (src, event)
            checkIdict();
            pl.selected = subjects_idict.move_up(pl.selected);
            pl.update();           
        end
        function cb_table_movedown(~, ~)  % (src, event)
            checkIdict();
            pl.selected = subjects_idict.move_down(pl.selected);
            pl.update();           
        end
        function cb_table_move2top(~, ~)  % (src, event)
            checkIdict();
            pl.selected = subjects_idict.move_to_top(pl.selected);
            pl.update();           
        end
        function cb_table_move2bottom(~, ~)  % (src, event)
            checkIdict();
            pl.selected = subjects_idict.move_to_bottom(pl.selected);
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
        data = cell(value.length(), 4);
        for i = 1:1:value.length()
            if any(pl.selected == i)
                data{i, 1} = true;
            else
                data{i, 1} = false;
            end
            data{i, 2} = value.getItem(i).get('ID');
            data{i, 3} = value.getItem(i).get('Label');
            data{i, 4} = value.getItem(i).get('Notes');
        end

        if isempty(pl.table_value_idict)
            pl.table_value_idict = cell(value.length(), 4); % {'logical', 'char', 'char', 'char'})
        end

        set(pl.table_value_idict, ...
            'Data', data, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)] ...
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