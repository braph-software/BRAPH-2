%% ¡header!
PanelPropIDictTable < PanelProp (pr, panel property idict) plots the panel of a property idict.

%%% ¡description!
% % % PanelPropIDictTable plots the panel of an IDICT property with a pushbutton to open the indexed dictionary.
% % % It works for all categories.
% % % 
%%% ¡seealso!
GUI, PanelPropIDict, uitable

%% ¡props!

%%% ¡prop!
TAB_H (gui, size) is the height of the table in font size units.
%%%% ¡default!
30

%% ¡properties!
p
table

% % % button
% % % 
% % % f_idict % idict figure
% % % 
%% ¡methods!
function p_out = draw(pr, varargin)
% % %     %DRAW draws the panel of the idict property.
% % %     %
% % %     % DRAW(PR) draws the panel of the idict property.
% % %     %
% % %     % P = DRAW(PR) returns a handle to the property panel.
% % %     %
% % %     % DRAW(PR, 'Property', VALUE, ...) sets the properties of the graphical
% % %     %  panel with custom Name-Value pairs.
% % %     %  All standard plot properties of uipanel can be used.
% % %     %
% % %     % It is possible to access the properties of the various graphical
% % %     %  objects from the handle P of the panel.
% % %     %
% % %     % See also update, redraw, uipanel.
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
    pr.p = draw@PanelProp(pr, varargin{:});
    
    if ~check_graphics(pr.table, 'uitable')
        pr.table = uitable( ...
            'Parent', pr.p, ...
            'Tag', 'table', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'ColumnSortable', true, ...
            'CellEditCallback', {@cb_table_edit}, ...
            'CellSelectionCallback', {@cb_table_select} ...
            );
    end

    function cb_table_edit(~, event) % (src, event)
disp('edit')
event.Indices(1)
event.Indices(2)
event.NewData
%        pr.cb_table(event.Indices(1), event.Indices(2), event.NewData)
    end

    function cb_table_select(~, event) % (src, event)
disp('select')
event.Indices(1)
event.Indices(2)
%        pr.cb_table(event.Indices(1), event.Indices(2), event.NewData)
    end

    % output
    if nargout > 0
        p_out = pr.p;
    end
end
function update(pr)
% % %     %UPDATE updates the content and permissions of the button.
% % %     %
% % %     % UPDATE(PR) updates the content and permissions of the button.
% % %     %
% % %     % See also draw, redraw, PanelElement.

    update@PanelProp(pr)
    
    el = pr.get('EL');
    prop = pr.get('PROP');
    
% % %     if el.isLocked(prop)
% % %         set(pr.table, ...
% % %             'Enable', pr.get('TAB_ENABLE'), ...
% % %             'ColumnEditable', false ...
% % %             )
% % %     end

    dict = el.get(prop);
    it_class = dict.get('IT_CLASS');
		
    props = Element.getProps(it_class); % item properties to be shown in the table
        
    data = cell(dict.length(), length(props));
    for p = 1:1:length(props)
        prop = props(p);
        for i = 1:1:dict.length()
            data{i, prop} = dict.getItem(i).get(prop);
        end
    end
    
    rowname = cellfun(@(it) it.get(dict.get('IT_KEY')), dict.get('IT_LIST'), 'UniformOutput', false);
    
    columnname = cellfun(@(prop) Element.getPropTag(it_class, prop), num2cell(props)', 'UniformOutput', false);
    
    columnwidth = 'fit';
    
    columneditable = true(1, length(props));
    
    columnformat = repmat({''}, 1, length(props));
    for p = 1:1:length(props)
        prop = props(p);
        switch Element.getPropFormat(it_class, prop)
% % %             case Format.EMPTY
            case Format.STRING
                columnformat{p} = 'char';
                
            case Format.LOGICAL
                columnformat{p} = 'logical';
                
            case Format.OPTION
                columnformat{p} = Element.getPropSettings(it_class, prop);

% % %             case Format.CLASS
% % %             case Format.CLASSLIST
% % %             case Format.ITEM
% % %             case Format.ITEMLIST
% % %             case Format.IDICT
            case Format.SCALAR
                columnformat{p} = 'numeric';
                
% % %             case Format.RVECTOR
% % %             case Format.CVECTOR
% % %             case Format.MATRIX
% % %             case Format.SMATRIX
% % %             case Format.CELL
% % %             case Format.NET
% % %             case Format.COLOR
% % %             case Format.ALPHA
% % %             case Format.SIZE
% % %             case Format.MARKER
% % %             case Format.LINE
        end            
    end

    set(pr.table, ...
        'Data', data, ...
        'RowName', rowname, ...
        'ColumnName', columnname, ...
        'ColumnWidth', columnwidth, ...
        'ColumnEditable', columneditable, ...
        'ColumnFormat', columnformat ...
        )


% % %     switch el.getPropCategory(prop)
% % %         case Category.METADATA
% % %             set(pr.table, ...
% % %                 'Data', el.get(prop), ...
% % %                 'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
% % %                 'ColumnEditable', true)
% % % 
% % %         case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
% % %             set(pr.table, ...
% % %                 'Data', el.get(prop), ...
% % %                 'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
% % %                 'ColumnEditable', true)
% % %             
% % %             value = el.getr(prop);
% % %             if isa(value, 'Callback')
% % %                 set(pr.table, ...
% % %                 'Enable', pr.get('TAB_ENABLE'), ...
% % %                 'ColumnEditable', false ...
% % %                 )
% % %             end
% % % 
% % %         case Category.RESULT
% % %             value = el.getr(prop);
% % % 
% % %             if isa(value, 'NoValue')
% % %                 % don't plot anything for a result not yet calculated
% % %                 set(pr.table, 'Visible', 'off')
% % %             else
% % %                 set(pr.table, ...
% % %                     'Data', el.get(prop), ...
% % %                     'ColumnFormat', repmat({'long'}, 1, size(el.get(prop), 2)), ...
% % %                     'Enable', pr.get('TAB_ENABLE'), ...
% % %                     'ColumnEditable', false, ...
% % %                     'Visible', 'on' ...
% % %                     )
% % %             end
% % %     end
end
function redraw(pr, varargin)
% % %     %REDRAW resizes the property panel and repositions its graphical objects.
% % %     %
% % %     % REDRAW(PR) resizes the property panel and repositions its graphical objects. 
% % %     % 
% % %     % Important notes:
% % %     % 1. REDRAW() sets the units 'characters' for panel. 
% % %     % 2. REDRAW() is typically called internally by PanelElement and does not need 
% % %     %  to be explicitly called in children of PanelProp.
% % %     %
% % %     % REDRAW(PR, 'X0', X0, 'Y0', Y0, 'Width', WIDTH, 'Height', HEIGHT)
% % %     %  repositions the property panel. It is possible to use a
% % %     %  subset of the Name-Value pairs.
% % %     %  By default:
% % %     %  - X0 does not change
% % %     %  - Y0 does not change
% % %     %  - WIDTH does not change
% % %     %  - HEIGHT = 3.5 * BRAPH2.FONTSIZE * BRAPH2.S
% % %     %
% % %     % See also draw, update, PanelElement, BRAPH2.

    [h, varargin] = get_and_remove_from_varargin(ceil(2 * BRAPH2.FONTSIZE * BRAPH2.S), 'Height', varargin);
    Dh = ceil(get(pr, 'TAB_H') * BRAPH2.FONTSIZE * BRAPH2.S);
    
    el = pr.get('EL');
    prop = pr.get('PROP');

    value = el.getr(prop);
    if el.getPropCategory(prop) == Category.RESULT && isa(value, 'NoValue')
        pr.redraw@PanelProp('Height', h, varargin{:})
    else
        value = el.get(prop);

        pr.redraw@PanelProp('Height', h + Dh, varargin{:})
        drawnow()
        
        s5 = ceil(5 * BRAPH2.S);
        set(pr.table, ...
            'Units', 'pixels', ...
            'Position', [s5 s5 w(pr.p, 'pixels')-s5-s5 Dh-s5-s5] ...
            )
    end
end
% % % function cb_button(pr)
% % %     %CB_PUSHBUTTON_VALUE executes callback for the pushbutton.
% % %     %
% % %     % CB_PUSHBUTTON_VALUE(PR) executes callback for the pushbutton.
% % % 
% % %     persistent time
% % %     if isempty(time)
% % %         time = 0;
% % %     end
% % %     if now - time > 1.0 / (24 * 60 * 60)
% % %         time = now;
% % %         set(pr.button, 'Enable', 'off')
% % %         %%% start callback %%%
% % %         
% % %         el = pr.get('EL');
% % %         prop = pr.get('PROP');
% % % 
% % %         if ~check_graphics(pr.f_idict, 'figure')
% % %             f = ancestor(pr.p, 'figure');
% % %             gui = GUIElement( ...
% % %                 'PE', el.get(prop), ...
% % %                 'POSITION', [x0(f, 'normalized')+w(f, 'normalized') y0(f, 'normalized') w(f, 'normalized') h(f, 'normalized')], ...
% % %                 'CLOSEREQ', false ...
% % %                 );
% % %             pr.f_idict = gui.draw();
% % %         else
% % %             gui = get(pr.f_idict, 'UserData');
% % %             gui.cb_bring_to_front();
% % %         end
% % %         
% % %         %%% end callback %%%
% % %         set(pr.button, 'Enable', 'on')
% % %     end
% % %     
% % % % % %     % updates and redraws the parent PanelElement as well as all siblings PanelProp's
% % % % % %     pe = get(get(pr.p, 'Parent'), 'UserData');
% % % % % %     pe.update()
% % % % % %     pe.redraw()    
% % % end
% % % function cb_bring_to_front(pr)
% % %     %CB_BRING_TO_FRONT brings to the front the idict figure.
% % %     %
% % %     % CB_BRING_TO_FRONT(PR) brings to the front the idict figure.
% % %     %
% % %     % See also cb_hide, cb_close.
% % % 
% % %     cb_bring_to_front@Panel(pr);
% % %     
% % %     % bring to front idict figure
% % %     if check_graphics(pr.f_idict, 'figure')
% % %         figure(pr.f_idict)
% % %         set(pr.f_idict, ...
% % %             'Visible', 'on', ...
% % %             'WindowState', 'normal' ...
% % %             )        
% % %     end
% % % end
% % % function cb_hide(pr)
% % %     %CB_HIDE hides the idict figure.
% % %     %
% % %     % CB_HIDE(PR) hides the idict figure.
% % %     %
% % %     % See also cb_bring_to_front, cb_close.
% % %     
% % %     cb_hide@Panel(pr);
% % %     
% % %     % hide callback element figure
% % %     if check_graphics(pr.f_idict, 'figure')
% % %         set(pr.f_idict, 'Visible', 'off')
% % %     end
% % % end
% % % function cb_close(pr)
% % %     %CB_CLOSE closes the idict figure.
% % %     % 
% % %     % CB_CLOSE(PR) closes the idict figure.
% % %     %
% % %     % See also cb_bring_to_front, cb_hide.
% % %     
% % %     cb_close@Panel(pr);
% % % 
% % %     % close callback element figure
% % %     if check_graphics(pr.f_idict, 'figure')
% % %         close(pr.f_idict)
% % %     end
% % % end
% % % 
% % % %% ¡tests!
% % % 
% % % %%% ¡test!
% % % %%%% ¡name!
% % % Example
% % % %%%% ¡code!
% % % % draws PanelPropIDictTable and calls update() and redraw()
% % % % note that it doesn't work for category RESULT 
% % % % because it needs to be used with PanelElement() and GUI()
% % % fig1 = uifigure();
% % % et = ETA();
% % % props = [et.PROP_IDICT_M et.PROP_IDICT_P et.PROP_IDICT_D et.PROP_IDICT_F et.PROP_IDICT_G et.PROP_IDICT_R et.PROP_IDICT_R_CALC];
% % % for i = 1:1:length(props)
% % %     pr{i} = PanelPropIDictTable('EL', et, 'PROP', props(i));
% % %     pr{i}.draw( ...
% % %         'Parent', fig1, ...
% % %         'BackgroundColor', [i/length(props) .5 (length(props)-i)/length(props)] ...
% % %         )
% % %     pr{i}.update()
% % %     pr{i}.redraw('Y0', (length(props) - i)/length(props) * h(fig1, 'pixels'))
% % % end
% % % close(fig1)