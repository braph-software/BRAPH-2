%% ¡header!
GUIElement < GUI (gui, element gui) is a GUI for an element.

%%% ¡description!
GUIELEMENT plots an element in a figure.

CONSTRUCTOR - To construct a GUI use the constructor:

    gui = GUI(''PE'', <element>)
    
DRAW - To create the element figure, call gui.draw():

    f = gui.<strong>draw</strong>();
 
 Here, f is the figure.
 It is also possible to use gui.draw() to get the figure handle and to set its properties.
  
CALLBACK - These are the callback functions:

    gui.<strong>cb_bring_to_front</strong>() - brings to the front the figure and its dependent figures
    gui.<strong>cb_hide</strong>() - hides the figure and its dependent figures
    gui.<strong>cb_close</strong>() - closes the figure and its dependent figures

%%% ¡seealso!
GUI, Element, PanelElement, uifigure

%% ¡props!

%%% ¡prop!
PE (metadata, item) is the panel element.
%%%% ¡settings!
'PanelElement'
%%%% ¡conditioning!
if ~isa(value, 'PanelElement')
    value = PanelElement('EL', value, 'ID', ['Panel of ' value.tostring()]);
end

%%% ¡prop!
FILE (data, string) is the B2 file where the element is saved.

%%% ¡prop!
MENU_FILE (gui, logical) determines whether to show the menu file.
%%%% ¡default!
true

%%% ¡prop!
MENU_IMPORT (gui, logical) determines whether to show the menu import.
%%%% ¡default!
true

%%% ¡prop!
MENU_EXPORT (gui, logical) determines whether to show the menu export.
%%%% ¡default!
true

%%% ¡prop!
MENU_PERSONALIZE (gui, logical) determines whether to show the menu personalize.
%%%% ¡default!
true

%%% ¡prop!
TOOL_FILE (gui, logical) determines whether to show the toolbar file buttons.
%%%% ¡default!
true

%% ¡props_update!

%%% ¡prop!
MENUBAR (gui, logical) determines whether to show the menubar.
%%%% ¡default!
true

%%% ¡prop!
MENU_ABOUT (gui, logical) determines whether to show the menu about.
%%%% ¡default!
true

%%% ¡prop!
TOOLBAR (gui, logical) determines whether to show the toolbar.
%%%% ¡default!
true

%%% ¡prop!
TOOL_ABOUT (gui, logical) determines whether to show the toolbar about buttons.
%%%% ¡default!
true

%% ¡properties!
f % handle for figure 

menu_file
menu_import
menu_export
menu_personalize

toolbar

pp % handle for parent panel of the element panel
ps % scrollable panel
p % panel element

text_filename % handle for text field filename

f_layout % handle to figure with panel to manage layout

%% ¡methods!
function f_out = draw(gui, varargin)
    %DRAW displays the GUI figure for an element.
    %
    % DRAW() displays the GUI figure for an element.
    %
    % F = DRAW(GUI) returns a handle to the GUI figure.
    %
    % DRAW(GUI, 'Property', VALUE, ...) sets the properties of the parent
    %  panel with custom Name-Value pairs.
    %  All standard plot properties of figure can be used.
    %
    % It is possible to access the properties of the various graphical
    %  objects from the handle F of the GUI figure.
    %
    % The GUI, PanelElement and Element can be retrieved as 
    %  GUI = get(F, 'UserData')
    %  PE = GUI.get('PE')
    %  EL = PE.get('EL')
    %
    % See also cb_bring_to_front, cb_hide, cb_close, uifigure.

    pe = gui.get('PE');
    el = pe.get('EL');
    
    % Set GUI name
    if el.existsTag('ID')
        name = el.get('ID');
    else
        name = el.tostring();
    end
    gui.set('NAME', [el.getClass() ' - ' name ' - ' BRAPH2.STR])

    gui.f = draw@GUI(gui, varargin{:});
    
    % output
    if nargout > 0
        f_out = gui.f;
    end
end
function x_draw(gui, f)
    %X_DRAW undocumented function for internal use only.
    
    % X_DRAW is used to draw the contents of a GUI before showing it.
    
    x_draw@GUI(gui, f)

    pe = gui.get('PE');
    el = pe.get('EL');
    
    dw = ceil(pe.get('DW') * BRAPH2.S);
    h_filename = ceil(1.5 * BRAPH2.FONTSIZE * BRAPH2.S);

    % Draw panel element (p) 
    % contained in a scrollable panel (ps)
    % contained in a parent panel (pp)
    if ~check_graphics(gui.pp, 'uipanel')
        gui.pp = uipanel( ...
            'Parent', f, ...
            'Tag', 'pp', ...
            'Units', 'normalized', ...
            'Position', [0 0 1 1], ...
            'BackgroundColor', gui.get('BKGCOLOR'), ...
            'BorderType', 'none', ...
            'AutoResizeChildren', false, ...
            'SizeChangedFcn', {@cb_resize} ...
            );
    end
    if ~check_graphics(gui.ps, 'uipanel')
        gui.ps = uipanel( ...
            'Parent', gui.pp, ...
            'Tag', 'ps', ...
            'BackgroundColor', gui.get('BKGCOLOR'), ...
            'BorderType', 'none', ...
            'AutoResizeChildren', false, ...
            'Scrollable', 'on' ...
        );
    end
    if ~check_graphics(gui.p, 'uipanel')
        gui.p = pe.draw('Parent', gui.ps);
    end
    if ~check_graphics(gui.text_filename, 'uilabel')
        gui.text_filename = uilabel( ...
            'Parent', gui.pp, ...
            'Tag', 'text_filename', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'HorizontalAlignment', 'left' ...
            );
    end

    % Callback update filename
    function update_filename()
        set(gui.text_filename, ...
            'Text', gui.get('FILE'), ...
            'Tooltip', gui.get('FILE') ...
            )
    end
    update_filename()
    
    % Callback resize
    function cb_resize(~, ~) % (src, event)
        set(gui.text_filename, ...
            'Position', [1+dw 1 w(gui.pp, 'pixels')-2*dw h_filename] ...
            )
        set(gui.ps, ...
            'Units', 'pixels', ...
            'Position', [1 1+h_filename w(gui.pp, 'pixels') h(gui.pp, 'pixels')-h_filename] ...
            );
        pe.redraw( ... 
            'X0', 1, ...
            'Y0', 1, ...
            'Width', w(gui.ps, 'pixels'), ...
            'Height', h(gui.ps, 'pixels') ...
            )
    end
    drawnow() % added to ensure that the resize is correct
    cb_resize()

    % Menu
    if gui.get('MENUBAR') && gui.get('MENU_FILE') && check_graphics(f, 'figure') && ~check_graphics(gui.menu_file, 'uimenu')
        gui.menu_file = uimenu(f, 'Label', 'File');

        uimenu(gui.menu_file, ...
            'Label', 'Open ...', ...
            'Accelerator', 'O', ...
            'Callback', {@cb_open})
        uimenu(gui.menu_file, ...
            'Label', 'Save', ...
            'Accelerator', 'S', ...
            'Callback', {@cb_save})
        uimenu(gui.menu_file, ...
            'Label', 'Save as ...', ...
            'Accelerator', 'A', ...
            'Callback', {@cb_saveas})
        uimenu(gui.menu_file, ...
            'Separator', 'on', ...
            'Label', 'Close', ...
            'Accelerator', 'C', ...
            'Callback', {@cb_close})
    elseif (~gui.get('MENUBAR') || ~gui.get('MENU_FILE'))
        delete(gui.menu_file)
    end
    function cb_open(~, ~)
        % select file
        [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.getName() ' file.']);
        if filterindex
            filename = fullfile(path, file);
            tmp_el = BRAPH2.load(filename);
            if strcmp(tmp_el.getClass(), el.getClass())
                set(gui.pp, 'Visible', 'off')
                drawnow()
                
                pe.reinit(tmp_el)
                el = tmp_el; % update local variable 'el' to synchronize it with pe 'el'

                % the motion of the figure is to ensure the correct
                % rendering of the opened element
                set(gui.f, 'Position', get(gui.f, 'Position') + [.001 0 0 0])
                gui.draw()
                set(gui.f, 'Position', get(gui.f, 'Position') - [.001 0 0 0])
                
                set(gui.pp, 'Visible', 'on')
            else
                GUIElement('PE', tmp_el, 'FILE', filename).draw()
            end
        end
    end
    function cb_save(~, ~)
        filename = gui.get('FILE');
        if isfile(filename)
            BRAPH2.save(el, filename)
        else
            cb_saveas();
        end
    end
    function cb_saveas(~, ~)
        % select file
        [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.getName() ' file.']);
        % save file
        if filterindex
            filename = fullfile(path, file);
            BRAPH2.save(el, filename)
            gui.set('FILE', filename)
            update_filename();
        end
    end
    function cb_close(~, ~)
        gui.cb_close()
    end
    
    if gui.get('MENUBAR') && gui.get('MENU_IMPORT') && check_graphics(f, 'figure') && ~check_graphics(gui.menu_import, 'uimenu')
        gui.menu_import = uimenu(f, ...
            'Label', 'Import', ...
            'Callback', {@cb_refresh_import_menu});
    elseif (~gui.get('MENUBAR') || ~gui.get('MENU_IMPORT'))
        delete(gui.menu_import)
    end
    function cb_refresh_import_menu(~,~)
        im_menus = get(gui.menu_import, 'Children');
        for i = 1:1:length(im_menus)
            delete(im_menus(i));
        end
        eval([el.getClass() '.getGUIMenuImport(el, gui.menu_import, pe)']);
        el = pe.get('el');
    end    

    if gui.get('MENUBAR') && gui.get('MENU_EXPORT') && check_graphics(f, 'figure') && ~check_graphics(gui.menu_export, 'uimenu')
        gui.menu_export = uimenu(f, ...
            'Label', 'Export', ...
            'Callback', {@cb_refresh_export_menu});
    elseif (~gui.get('MENUBAR') || ~gui.get('MENU_EXPORT'))
        delete(gui.menu_export)
    end
    function cb_refresh_export_menu(~,~)
        el = pe.get('el');
        ex_menus = get(gui.menu_export, 'Children');
        for i = 1:length(ex_menus)
            delete(ex_menus(i));
        end
        eval([el.getClass() '.getGUIMenuExport(el, gui.menu_export, pe)']);
     end

    if gui.get('MENUBAR') && gui.get('MENU_PERSONALIZE') && check_graphics(f, 'figure') && ~check_graphics(gui.menu_personalize, 'uimenu')
        gui.menu_personalize = uimenu(f, 'Label', 'Personalize');
        uimenu(gui.menu_personalize, ...
            'Label', 'Layout ...', ...
            'Callback', {@cb_layout});
    elseif (~gui.get('MENUBAR') || ~gui.get('MENU_PERSONALIZE'))
        delete(gui.menu_personalize)
    end
    function cb_layout(~, ~)
        if isgraphics(gui.f_layout, 'figure')
            delete(gui.f_layout)
        end

        gui_layout = GUI( ... 
            'Name', ['Layout ' el.getClass() ' - ' BRAPH2.STR], ...
            'Position', [x0(f, 'normalized')+w(f, 'normalized') y0(f, 'normalized')+h(f, 'normalized')*2/3 w(f, 'normalized') h(f, 'normalized')/3], ...
            'BKGCOLOR', pe.get('BKGCOLOR'), ...
            'CLOSEREQ', false ...
            );
        gui.f_layout = gui_layout.draw('Visible', 'off');

        p_layout = uipanel( ...
            'Parent', gui.f_layout, ...
            'Units', 'normalized', ...
            'Position', [0 0 1 1], ...
            'BackgroundColor', pe.get('BKGCOLOR'), ...
            'AutoResizeChildren', 'off', ...
            'SizeChangedFcn', {@cb_resize_layout} ...
            );
        function cb_resize_layout(~, ~)
            if exist('edit_table') && check_graphics(edit_table, 'uitable')
                set(edit_table, 'Position', ceil([10 10+BRAPH2.FONTSIZE*2+10 w(p_layout, 'pixels')-20 h(p_layout, 'pixels')-10-BRAPH2.FONTSIZE*2-20]))
            end
        end
        
        edit_table = uitable( ...
            'Parent', p_layout, ...
            'Tag', 'edit_table', ...
            'Units', 'pixels', ...
            'ColumnName', {'Show', 'Order', 'Title', 'Property', 'Category', 'Format'}, ...
            'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
            'ColumnEditable', [true true true false false false], ...
            'CellEditCallback', {@cb_edit_tb} ...
            );
        save_edit_btn = uibutton( ...
            'Parent', p_layout, ...
            'Tag', 'save_edit_btn', ...
            'Text', 'Save', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Position', ceil([10 10 BRAPH2.FONTSIZE*10 BRAPH2.FONTSIZE*2] * BRAPH2.S), ...
            'ButtonPushedFcn', {@cb_save_edit} ...
            );
        cancel_edit_btn = uibutton( ...
            'Parent', p_layout, ...
            'Tag', 'save_edit_btn', ...
            'Text', 'Cancel', ...
            'FontSize', BRAPH2.FONTSIZE, ...
            'Position', ceil([10+BRAPH2.FONTSIZE*10+10 10 BRAPH2.FONTSIZE*10 BRAPH2.FONTSIZE*2] * BRAPH2.S), ...
            'ButtonPushedFcn', {@cb_cancel_edit} ...
            );
        cb_resize_layout()

        [order, title, visible] = load_layout(el);
        VISIBLE = 1;
        ORDER = 2;
        TITLE = 3;
        TAG = 4;
        CATEGORY = 5;
        FORMAT = 6;
        data = cell(el.getPropNumber(), 6);
        for prop = 1:1:el.getPropNumber()
            data{prop, VISIBLE} = visible(prop);
            data{prop, ORDER} = order(prop);
            data{prop, TITLE} = title{prop};
            data{prop, TAG} = upper(el.getPropTag(prop));
            data{prop, CATEGORY} = el.getPropCategory(prop);
            data{prop, FORMAT} = el.getPropFormat(prop);
        end        
        set(edit_table, 'Data', data);

        set(gui.f_layout, 'Visible', 'on');

        function cb_edit_tb(~, event)
            prop = event.Indices(1);
            col = event.Indices(2);
            newdata = event.NewData;
            data = get(edit_table, 'Data');

            if col == VISIBLE
                if newdata == true
                    if any(~isnan(cell2mat(data(:, ORDER))))
                        data{prop, ORDER} = max(cell2mat(data(:, ORDER))) + 1;
                    else % all NaN (edge case)
                        data{prop, ORDER} = 1;
                    end
                else % newdata == false
                    for i = data{prop, ORDER} + 1:1:max(cell2mat(data(:, ORDER)))
                        data{cell2mat(data(:, ORDER)) == i, ORDER} = i - 1;
                    end
                    data{prop, ORDER} = NaN;
                end
            end

            if col == ORDER
                if isnan(newdata)
                    data{prop, VISIBLE} = false;
                else
                    data{prop, VISIBLE} = true;
                end

                order = cell2mat(data(:, ORDER)) + .00301040106;
                order(prop) = newdata;
                for i = 1:1:numel(order) - sum(isnan(order))
                    min_order_index = find(order == min(order));
                    data{min_order_index, ORDER} = i;
                    order(min_order_index) = NaN;
                end
            end

            set(edit_table, 'Data', data);
        end
        function cb_save_edit(~, ~)
            set(gui.pp, 'Visible', 'off')
            drawnow()

            data = get(edit_table, 'Data');
            order = cell2mat(data(:, 2))';
            title = data(:, 3); title = title';
            save_layout(el, order, title)

            pe.reinit(el);

            % the motion of the figure is to ensure the correct
            % rendering of the opened element
            set(gui.f, 'Position', get(gui.f, 'Position') + [.001 0 0 0])
            gui.draw()
            set(gui.f, 'Position', get(gui.f, 'Position') - [.001 0 0 0])

            set(gui.pp, 'Visible', 'on')
        end
        function cb_cancel_edit(~, ~)
            close(gui.f_layout)
        end
    end

    % Toolbar
    if gui.get('TOOLBAR') && check_graphics(f, 'figure')
        gui.toolbar = findall(f, 'Tag', 'ToolBar');
        
        if gui.get('TOOL_FILE') && check_graphics(gui.toolbar, 'uitoolbar')
            % Open
            uipushtool(gui.toolbar, ...
                'Tag', 'BRAPH2.Open', ...                
                'Tooltip', ['Open ' el.getName()], ...
                'CData', imread('icon_open_ml.png'), ...
                'ClickedCallback', {@cb_open});
            % Save
            uipushtool(gui.toolbar, ...
                'Tag', 'BRAPH2.Save', ...                
                'Tooltip', ['Save ' el.getName()], ...
                'CData', imread('icon_save_ml.png'), ...
                'ClickedCallback', {@cb_save});
        end
    end
end
function cb_bring_to_front(gui)
    %CB_BRING_TO_FRONT brings to front the figure and its dependent figures.
    %
    % CB_BRING_TO_FRONT(GUI) brings to front the figure and its dependent figures 
    %  by calling the methods cb_bring_to_front() for all the PlotProp
    %  panels of the PanelElement and by bringing to fron the layout figure. 
    %  
    % See also cb_hide, cb_close.

    % brings to front the main GUI
    cb_bring_to_front@GUI(gui)
    
    % brings to fron layout GUI
    if check_graphics(gui.f_layout, 'figure')
        figure(gui.f_layout) 
        set(gui.f_layout, ...
            'Visible', 'on', ...
            'WindowState', 'normal' ...
            )
    end
    
    % brings to front the other panels
    pe = gui.get('PE');
    pr_dict = pe.get('PR_DICT');
    for prop = 1:1:pr_dict.length()
        pr = pr_dict.getItem(prop);
        pr.cb_bring_to_front()
    end
end
function cb_hide(gui)
    %CB_HIDE hides the figure and its dependent figures.
    %
    % CB_HIDE(GUI) hides the figure and its dependent figures 
    %  by calling the methods cb_hide() for all the PlotProp
    %  panels of the PanelElement and by hiding the layout figure. 
    %
    % See also cb_bring_to_front, cb_close.

    % hides the main GUI
    cb_hide@GUI(gui)
        
    % hides the layout GUI
    if check_graphics(gui.f_layout, 'figure')
        set(gui.f_layout, 'Visible', 'off')
    end
    
    % hides the other panels
    pe = gui.get('PE');
    pr_dict = pe.get('PR_DICT');
    for prop = 1:1:pr_dict.length()
        pr = pr_dict.getItem(prop);
        pr.cb_hide()
    end
end
function cb_close(gui)
    %CB_CLOSE closes the figure and its dependent figures.
    %
    % CB_CLOSE(GUI) closes the figure and its dependent figures 
    %  by calling the methods cb_close() for all the PlotProp
    %  panels of the PanelElement and by closing the layout figure. 
    %  
    % See also cb_bring_to_front, cb_hide.

    % closes the main GUI
    cb_close@GUI(gui)
    
    % closes the layout GUI
    if check_graphics(gui.f_layout, 'figure')
        delete(gui.f_layout)
    end
    
    % closes the other panels
    pe = gui.get('PE');
    pr_dict = pe.get('PR_DICT');
    for prop = 1:1:pr_dict.length()
        pr = pr_dict.getItem(prop);
        pr.cb_close()
    end
end

%% ¡tests!

%%% ¡test! 
%%%% ¡name!
Basic use
%%%% ¡code!
gui1 = GUIElement('PE', ETA(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'CLOSEREQ', false);
f1 = gui1.draw();
close(f1)

gui2 = GUIElement('PE', BRAPH2Constants(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'POSITION', [.1 0 .2 1], 'CLOSEREQ', false);
f2 = gui2.draw();
close(f2)

gui3 = GUIElement('PE', ETA(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'POSITION', [.2 .2 .2 .78], 'CLOSEREQ', false);
f3 = gui3.draw();
close(f3)

gui4 = GUIElement('PE', BRAPH2Constants(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'POSITION', [.3 .2 .2 .78], 'CLOSEREQ', false);
f4 = gui4.draw();
close(f4)

gui5 = GUIElement('PE', ETA(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'POSITION', [.4 .2 .2 .5], 'CLOSEREQ', false);
f5 = gui5.draw();
close(f5)

gui6 = GUIElement('PE', BRAPH2Constants(), 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'POSITION', [.5 .2 .2 .5], 'CLOSEREQ', false);
f6 = gui6.draw();
close(f6)

%%% ¡test! 
%%%% ¡name!
Callbacks
%%%% ¡code!
% % % complete with CELL and NET
et1 = ETA( ...
    'PROP_STRING_P', 'prova', ...
    'PROP_LOGICAL_P', true, ...
    'PROP_OPTION_P', 'three', ...
    'PROP_CLASS_P', 'ETA', ...
    'PROP_CLASSLIST_P', {'ETA', 'Panel', 'GUI'}, ...
    'PROP_ITEM_P', BRAPH2Constants(), ...
    'PROP_ITEMLIST_P', {BRAPH2Constants(), ETA()}, ...
    'PROP_IDICT_P', IndexedDictionary(), ...
    'PROP_SCALAR_P', pi, ...
    'PROP_RVECTOR_P', [1 2 3], ...
    'PROP_CVECTOR_P', [1 2 3]', ...
    'PROP_MATRIX_P', [1 2 3; 4 5 6], ...
    'PROP_SMATRIX_P', eye(3), ...
    'PROP_COLOR_P', [.1 .6 1], ...
    'PROP_ALPHA_P', .5, ...
    'PROP_SIZE_P', 10, ...
    'PROP_MARKER_P', 's', ...
    'PROP_LINE_P', '--' ...
    );
et2 = ETA( ...
    'PROP_STRING_P', Callback('EL', et1, 'TAG', 'PROP_STRING_P'), ...
    'PROP_LOGICAL_P', Callback('EL', et1, 'TAG', 'PROP_LOGICAL_P'), ...
    'PROP_OPTION_P', Callback('EL', et1, 'TAG', 'PROP_OPTION_P'), ...
    'PROP_CLASS_P', Callback('EL', et1, 'TAG', 'PROP_CLASS_P'), ...
    'PROP_CLASSLIST_P', Callback('EL', et1, 'TAG', 'PROP_CLASSLIST_P'), ...
    'PROP_ITEM_P', Callback('EL', et1, 'TAG', 'PROP_ITEM_P'), ...
    'PROP_ITEMLIST_P', Callback('EL', et1, 'TAG', 'PROP_ITEMLIST_P'), ...
    'PROP_IDICT_P', Callback('EL', et1, 'TAG', 'PROP_IDICT_P'), ...
    'PROP_SCALAR_P', Callback('EL', et1, 'TAG', 'PROP_SCALAR_P'), ...
    'PROP_RVECTOR_P', Callback('EL', et1, 'TAG', 'PROP_RVECTOR_P'), ...
    'PROP_CVECTOR_P', Callback('EL', et1, 'TAG', 'PROP_CVECTOR_P'), ...
    'PROP_MATRIX_P', Callback('EL', et1, 'TAG', 'PROP_MATRIX_P'), ...
    'PROP_SMATRIX_P', Callback('EL', et1, 'TAG', 'PROP_SMATRIX_P'), ...
    'PROP_COLOR_P', Callback('EL', et1, 'TAG', 'PROP_COLOR_P'), ...
    'PROP_ALPHA_P', Callback('EL', et1, 'TAG', 'PROP_ALPHA_P'), ...
    'PROP_SIZE_P', Callback('EL', et1, 'TAG', 'PROP_SIZE_P'), ...
    'PROP_MARKER_P', Callback('EL', et1, 'TAG', 'PROP_MARKER_P'), ...
    'PROP_LINE_P', Callback('EL', et1, 'TAG', 'PROP_LINE_P') ...
    );
gui = GUIElement('PE', et2, 'FILE', 'xxx sss', 'MENUBAR', true, 'TOOLBAR', true, 'CLOSEREQ', false);
fig = gui.draw();
close(fig)