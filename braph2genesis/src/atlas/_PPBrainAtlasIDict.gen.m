%% ¡header!
PPBrainAtlasIDict < PlotProp (pl, plot property of brain atlas idict) is a plot of brain atlas idict.

%%% ¡description!
PPBrainAtlasIDict plots an IndexedDictionary for Brain Atlas brain regions.

%%% ¡seealso!
GUI, PlotElement, PlotProp, BrainAtlas

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
    ba_idict = el.getr(prop);    

    pl.pp = draw@PlotProp(pl, varargin{:});

    if isempty(pl.table_value_idict) || ~isgraphics(pl.table_value_idict, 'uitable')
        % construct a data holder
        value_idict_ba = ba_idict;


        pl.table_value_idict = uitable();
        set( pl.table_value_idict, ...
            'Parent', pl.pp, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .96 .7], ...
            'ColumnName', {'', 'ID', 'Label', 'x', 'y', 'z', 'Notes'}, ...
            'ColumnFormat', {'logical', 'char', 'char', 'numeric', 'numeric', 'numeric', 'char'}, ...
            'Tooltip', [num2str(el.getPropProp(prop)) ' ' el.getPropDescription(prop)], ...
            'ColumnEditable', true, ...
            'CellEditCallback', {@cb_table_idict_value} ...
            );

        if ~isequal(value_idict_ba, NoValue)
            data = cell(value_idict_ba.length(), 7);
            for sub = 1:1:value_idict_ba.length() %#ok<FXUP>
                if any(pl.selected == sub)
                    data{sub, 1} = true;
                else
                    data{sub, 1} = false;
                end
                data{sub, 2} = value_idict_ba.getItem(sub).get('ID');
                data{sub, 3} = value_idict_ba.getItem(sub).get('Label');
                data{sub, 4} = value_idict_ba.getItem(sub).get('X');
                data{sub, 5} = value_idict_ba.getItem(sub).get('Y');
                data{sub, 6} = value_idict_ba.getItem(sub).get('Z');
                data{sub, 7} = value_idict_ba.getItem(sub).get('Notes');
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
                    if ~ba_idict.containsKey(newdata)
                        % change brain region id
                        ba_idict.getItem(i).set('ID', newdata)
                        % change brain region key in idict
                        oldkey = ba_idict.getKey(i);
                        ba_idict.replaceKey(oldkey, newdata);
                    end
                case 3
                    ba_idict.getItem(i).set('Label', newdata)
                    update_brain_surface()
                case 4
                    ba_idict.getItem(i).set('X', newdata)
                    update_brain_surface()
                case 5
                    ba_idict.getItem(i).set('Y', newdata)
                    update_brain_surface()
                case 6
                    ba_idict.getItem(i).set('Z', newdata)
                    update_brain_surface()
                case 7
                    ba_idict.getItem(i).set('Notes', newdata)
            end
            pl.update()            
        end
        function cb_table_selectall(~, ~)  % (src, event)
            checkIdict();
            pl.selected = (1:1:ba_idict.length())';
            pl.update()
            update_brain_surface();
        end
        function cb_table_clearselection(~, ~)  % (src, event)
            checkIdict();
            pl.selected = [];
            pl.update()
            update_brain_surface();
        end
        function cb_table_add(~, ~)  % (src, event)
            checkIdict();
            br_id = 1;
            while ba_idict.containsKey(num2str(br_id))
                br_id = br_id + 1;
            end
            br = BrainRegion('ID', num2str(br_id), ...
                'Label', '', ...
                'Notes', '', ...
                'X', 0, ...
                'Y', 0, ...
                'Z', 0);
            ba_idict.add(br);
            pl.update()
            update_brain_surface();
        end
        function cb_table_remove(~, ~)  % (src, event)
            checkIdict();
            pl.selected = ba_idict.remove_all(pl.selected);
            pl.update()
            update_brain_surface();
        end
        function cb_table_moveup(~, ~)  % (src, event)
            checkIdict();
            pl.selected = ba_idict.move_up(pl.selected);
            pl.update()
            update_brain_surface();
        end
        function cb_table_movedown(~, ~)  % (src, event)
            checkIdict();
            pl.selected = ba_idict.move_down(pl.selected);
            pl.update()
            update_brain_surface();
        end
        function cb_table_move2top(~, ~)  % (src, event)
            checkIdict();
            pl.selected = ba_idict.move_to_top(pl.selected);
            pl.update()
            update_brain_surface();
        end
        function cb_table_move2bottom(~, ~)  % (src, event)
            checkIdict();
            pl.selected = ba_idict.move_to_bottom(pl.selected);
            pl.update()
            update_brain_surface();
        end
        function update_brain_surface()            
            figHandles = findobj('Type', 'figure');
            for i = 1:1:length(figHandles)
                fig_h = figHandles(i);
                if contains(fig_h.Name, 'Brain Surface - ')
                    fig_h_children = get(fig_h, 'Children');
                    update_btn = fig_h_children(2);
                    feval(get(update_btn, 'Callback'), update_btn, []);
                end
            end
        end
        function checkIdict()           
            if isa(ba_idict, 'NoValue')
                ba_idict = IndexedDictionary( ...
                    'id', 'idict', ...
                    'it_class', 'BrainRegion', ...
                    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY) ...
                    );
                el.set('BR_DICT', ba_idict);
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


    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        %
    else
        value_idict_ba = el.get(prop);
        % construct a data holder
        data = cell(value_idict_ba.length(), 7);
        for i = 1:1:value_idict_ba.length()
            if any(pl.selected == i)
                data{i, 1} = true;
            else
                data{i, 1} = false;
            end
            data{i, 2} = value_idict_ba.getItem(i).get('ID');
            data{i, 3} = value_idict_ba.getItem(i).get('Label');
            data{i, 4} = value_idict_ba.getItem(i).get('X');
            data{i, 5} = value_idict_ba.getItem(i).get('Y');
            data{i, 6} = value_idict_ba.getItem(i).get('Z');
            data{i, 7} = value_idict_ba.getItem(i).get('Notes');
        end


        if isempty(pl.table_value_idict)
            pl.table_value_idict = cell(value_idict_ba.length(), 7); % {'logical', 'char', 'char', 'numeric', 'numeric', 'numeric', 'char'})
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