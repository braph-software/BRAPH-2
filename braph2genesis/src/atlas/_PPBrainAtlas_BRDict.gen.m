%% ¡header!
PPBrainAtlas_BRDict < PlotProp (pl, plot property of brain atlas idict) is a plot of brain atlas idict.

%%% ¡description!
PPBrainAtlas_BRDict plots the IndexedDictionary containing a BrainAtlas.

%%% ¡seealso!
GUI, PlotElement, PlotProp, BrainAtlas

%% ¡properties!
pp
table % table with the brain regions
selected % selected brain regions

%% ¡methods!
function h_panel = draw(pl, varargin)
    %DRAW draws the BrainAtlas idict.
    %
    % DRAW(PL) draws the BrainAtlas idict graphical panel.
    %
    % H = DRAW(PL) returns a handle to the BrainAtlas idict graphical panel.
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

    pl.table = uitable();
    set(pl.table, ...
        'Parent', pl.pp, ...
        'Units', 'normalized', ...
        'Position', [.02 .20 .96 .75], ...
        'ColumnName', {'', 'ID', 'Label', 'x', 'y', 'z', 'Notes'}, ...
        'ColumnFormat', {'logical', 'char', 'char', 'numeric', 'numeric', 'numeric', 'char'}, ...
        'Tooltip', [num2str(BrainAtlas.BR_DICT) ' ' BrainAtlas.getPropDescription('BR_DICT')], ...
        'ColumnEditable', true, ...
        'CellEditCallback', {@cb_table} ...
        );
        function cb_table(~, event)
            i = event.Indices(1);
            col = event.Indices(2);
            newdata = event.NewData;

            ba = pl.get('EL');
            br_dict = ba.get('BR_DICT');

            switch col
                case 1
                    if newdata == 1
                        pl.selected = sort(unique([pl.selected(:); i]));
                    else
                        pl.selected = pl.selected(pl.selected~=i);
                    end
                case 2
                    if ~br_dict.containsKey(newdata)
                        % change brain region id
                        br_dict.getItem(i).set('ID', newdata)
                        % change brain region key in idict
                        oldkey = br_dict.getKey(i);
                        br_dict.replaceKey(oldkey, newdata);
                    end
                case 3
                    br_dict.getItem(i).set('Label', newdata)
                case 4
                    br_dict.getItem(i).set('X', newdata)
                case 5
                    br_dict.getItem(i).set('Y', newdata)
                case 6
                    br_dict.getItem(i).set('Z', newdata)
                case 7
                    br_dict.getItem(i).set('Notes', newdata)
            end

            pl.update()            
        end

    ui_button_table_selectall = uicontrol(pl.pp, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.02 .1 .22 .07], ...
        'String', 'Select All', ...
        'TooltipString', 'Select all brain regions', ...
        'Callback', {@cb_table_selectall} ...
        );
        function cb_table_selectall(~, ~)  % (src, event)
            ba = pl.get('EL');
            br_dict = ba.get('BR_DICT');

            pl.selected = [1:1:br_dict.length()]';

            pl.update()
        end

    ui_button_table_clearselection = uicontrol(pl.pp, 'Style', 'pushbutton', 'Units', 'normalized', ...
        'Position', [.02 .02 .22 .07], ...
        'String', 'Clear', ...
        'TooltipString', 'Clear selection', ...
        'Callback', {@cb_table_clearselection} ...
        );
        function cb_table_clearselection(~, ~)  % (src, event)
            ba = pl.get('EL');
            br_dict = ba.get('BR_DICT');

            pl.selected = [];

            pl.update()
        end
    
    ui_button_table_add = uicontrol(pl.pp, 'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.27 .1 .22 .07], ...
        'String', 'Add', ...
        'TooltipString', 'Add brain region at the end of table', ...
        'Callback', {@cb_table_add} ...
        );
        function cb_table_add(~, ~)  % (src, event)
            ba = pl.get('EL');
            br_dict = ba.get('BR_DICT');

            br_id = 1;
            while br_dict.containsKey(num2str(br_id))
                br_id = br_id + 1;
            end

            br = BrainRegion( ...
                'ID', num2str(br_id), ...
                'Label', '', ...
                'Notes', '', ...
                'X', 0, ...
                'Y', 0, ...
                'Z', 0 ...
                );
            br_dict.add(br);

            pl.update()
        end
    
    ui_button_table_remove = uicontrol(pl.pp,'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.27 .02 .22 .07], ...
        'String', 'Remove', ...
        'TooltipString', 'Remove selected brain regions', ...
        'Callback', {@cb_table_remove} ...
        );
        function cb_table_remove(~, ~)  % (src, event)
            ba = pl.get('EL');
            br_dict = ba.get('BR_DICT');

            pl.selected = br_dict.remove_all(pl.selected);

            pl.update()
        end
    
    ui_button_table_moveup = uicontrol(pl.pp,'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.52 .1 .22 .07], ...
        'String', 'Move up', ...
        'TooltipString', 'Move selected brain regions up', ...
        'Callback', {@cb_table_moveup} ...
        );
        function cb_table_moveup(~, ~)  % (src, event)
            ba = pl.get('EL');
            br_dict = ba.get('BR_DICT');

            pl.selected = br_dict.move_up(pl.selected);

            pl.update()
        end
    
    ui_button_table_movedown = uicontrol(pl.pp,'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.52 .02 .22 .07], ...
        'String', 'Move down', ...
        'TooltipString', 'Move selected brain regions down', ...
        'Callback', {@cb_table_movedown} ...
        );
        function cb_table_movedown(~, ~)  % (src, event)
            ba = pl.get('EL');
            br_dict = ba.get('BR_DICT');

            pl.selected = br_dict.move_down(pl.selected);

            pl.update()
        end
    
    ui_button_table_move2top = uicontrol(pl.pp,'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.77 .1 .22 .07], ...
        'String', 'Move top', ...
        'TooltipString', 'Move selected brain regions to top of table', ...
        'Callback', {@cb_table_move2top} ...
        );
        function cb_table_move2top(~, ~)  % (src, event)
            ba = pl.get('EL');
            br_dict = ba.get('BR_DICT');

            pl.selected = br_dict.move_to_top(pl.selected);

            pl.update()
        end
    
    ui_button_table_move2bottom = uicontrol(pl.pp,'Style', 'pushbutton', ...
        'Units', 'normalized', ...
        'Position', [.77 .02 .22 .07], ...
        'String', 'Move bottom', ...
        'TooltipString', 'Move selected brain regions to bottom of table', ...
        'Callback', {@cb_table_move2bottom} ...
        );
        function cb_table_move2bottom(~, ~)  % (src, event)
            ba = pl.get('EL');
            br_dict = ba.get('BR_DICT');

            pl.selected = br_dict.move_to_bottom(pl.selected);

            pl.update()
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

    ba = pl.get('EL');
	br_dict = ba.get('BR_DICT');

    if isa(ba.getr('BR_DICT'), 'NoValue')
        ba.set('BR_DICT', br_dict)
    end
    
    data = cell(br_dict.length(), 7);
    for sub = 1:1:br_dict.length()
        if any(pl.selected == sub)
            data{sub, 1} = true;
        else
            data{sub, 1} = false;
        end
        data{sub, 2} = br_dict.getItem(sub).get('ID');
        data{sub, 3} = br_dict.getItem(sub).get('Label');
        data{sub, 4} = br_dict.getItem(sub).get('X');
        data{sub, 5} = br_dict.getItem(sub).get('Y');
        data{sub, 6} = br_dict.getItem(sub).get('Z');
        data{sub, 7} = br_dict.getItem(sub).get('Notes');
    end
    set(pl.table, 'Data', data);
    
    % update brain surface
    f = ancestor(pl.pp, 'Figure'); % get figure BrainAtlas
    pe = get(f, 'UserData'); % get PlotElement BrainAtlas
    pp_surf = pe.get(PlotElement.PR_DICT).getItem(BrainAtlas.SURF_TAG); % get PlotProp Surf
    pp_surf.update_brain_atlas()
end
function redraw(pl, varargin)
    %REDRAW redraws the element graphical panel.
    %
    % REDRAW(PL) redraws the plot PL.
    %
    % REDRAW(PL, 'Height', HEIGHT) sets the height of PL (by default HEIGHT=35).
    %
    % See also draw, update, refresh.

    pl.redraw@PlotProp('Height', 35, varargin{:});
end