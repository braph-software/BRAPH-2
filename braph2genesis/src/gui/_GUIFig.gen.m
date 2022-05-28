%% ¡header!
GUIFig < GUI (gui, figure gui) is a GUI for a figure.

%%% ¡description!
GUIFIG plots a figure.

CONSTRUCTOR - To construct a GUI use the constructor:

    gui = GUI(''PF'', <panel figure>)
    
DRAW - To create the figure, call gui.draw():

    f = gui.<strong>draw</strong>();
 
 Here, f is the figure.
 It is also possible to use gui.draw() to get the figure handle and to set its properties.
  
CALLBACK - These are the callback functions:

    gui.<strong>cb_bring_to_front</strong>() - brings to the front the figure and its dependent figures
    gui.<strong>cb_hide</strong>() - hides the figure and its dependent figures
    gui.<strong>cb_close</strong>() - closes the figure and its dependent figures

%%% ¡seealso!
GUI, PanelFig, uifigure

%% ¡props!

%%% ¡prop!
PF (metadata, item) is the panel figure.
%%%% ¡settings!
'PanelFig'

%%% ¡prop!
FILE (data, string) is the B2 file where the element is saved.

%%% ¡prop!
MENU_FILE (gui, logical) determines whether to show the menu file.
%%%% ¡default!
true

%%% ¡prop!
MENU_PRINT (gui, logical) determines whether to show the print to image file.
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

%%% ¡prop!
TOOL_PRINT (gui, logical) determines whether to show the toolbar print button.
%%%% ¡default!
true

%%% ¡prop!
TOOL_SETTINGS (gui, logical) determines whether to show the toolbar settings buttons.
%%%% ¡default!
true

%% ¡props_update!

%%% ¡prop!
POSITION (gui, rvector) is the normalized position of the GUI on the screen.
%%%% ¡default!
[.30 .40 .39 .47]

%%% ¡prop!
BKGCOLOR (gui, color) is the GUI background color.
%%%% ¡default!
BRAPH2.COL_FIG

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
menu_print
menu_personalize

toolbar
tool_open
tool_save
tool_print
tool_settings

pp % handle for parent panel of the element figure
ps % scrollable panel
p % panel figure

text_filename % handle for text field filename

f_layout % handle to figure with panel to manage layout

f_settings % handle to settings figure 

%% ¡methods!
function f_out = draw(gui, varargin)
    %DRAW displays the GUI figure.
    %
    % DRAW() displays the GUI figure.
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
    % The GUI and PanelFig can be retrieved as 
    %  GUI = get(F, 'UserData')
    %  PF = GUI.get('PF')
    %
    % See also cb_bring_to_front, cb_hide, cb_close, uifigure.

    pf = gui.get('PF');
    
    % Set GUI name
    if pf.existsTag('ID')
        name = pf.get('ID');
    else
        name = pf.tostring();
    end
    gui.set('NAME', [pf.getClass() ' - ' name ' - ' BRAPH2.STR])

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

    pf = gui.get('PF');
    
    h_filename = s(1.5);

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
            'BackgroundColor', [.5 .5 .5], ... % gui.get('BKGCOLOR'), ...
            'BorderType', 'none', ...
            'AutoResizeChildren', false, ...
            'Scrollable', 'on' ...
        );
    end
    if ~check_graphics(gui.p, 'uipanel')
        gui.p = pf.draw('Parent', gui.ps);
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
            'Position', [1+s(.3) 1 w(gui.pp, 'pixels')-s(.6) h_filename] ...
            )
        set(gui.ps, ...
            'Units', 'pixels', ...
            'Position', [1 1+h_filename w(gui.pp, 'pixels') h(gui.pp, 'pixels')-h_filename] ...
            );
        pf.set()
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
        [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' pf.getName() ' file.']);
        if filterindex
            filename = fullfile(path, file);
            tmp_el = BRAPH2.load(filename);
            if strcmp(tmp_el.getClass(), pf.getClass())
                GUIFig('PF', tmp_el, 'FILE', filename).draw()
            else
                GUIElement('PE', tmp_el, 'FILE', filename).draw()
            end
        end
    end
    function cb_save(~, ~)
        filename = gui.get('FILE');
        if isfile(filename)
            BRAPH2.save(pf, filename)
        else
            cb_saveas();
        end
    end
    function cb_saveas(~, ~)
        % select file
        [file, path, filterindex] = uiputfile(BRAPH2.EXT_ELEMENT, ['Select the ' pf.getName() ' file.']);
        % save file
        if filterindex
            filename = fullfile(path, file);
            BRAPH2.save(pf, filename)
            gui.set('FILE', filename)
            update_filename();
        end
    end
    function cb_close(~, ~)
        gui.cb_close()
    end

    if gui.get('MENUBAR') && gui.get('MENU_PRINT') && check_graphics(f, 'figure') && ~check_graphics(gui.menu_print, 'uimenu')
        gui.menu_print = uimenu(f, 'Label', 'Print');

        uimenu(gui.menu_print, ...
            'Label', 'Print ...', ...
            'Accelerator', 'P', ...
            'Callback', {@cb_print})
        uimenu(gui.menu_print, ...
            'Label', 'Vectorial ...', ...
            'Callback', {@cb_print, 'vector'})
        uimenu(gui.menu_print, ...
            'Separator', 'on', ...
            'Label', 'Hi-res (300 dpi) ...', ...
            'Callback', {@cb_print, 'image', 300})
        uimenu(gui.menu_print, ...
            'Label', 'Hi-res (600 dpi) ...', ...
            'Callback', {@cb_print, 'image', 600})
        uimenu(gui.menu_print, ...
            'Label', 'Hi-res (1200 dpi) ...', ...
            'Callback', {@cb_print, 'image', 1200})
        uimenu(gui.menu_print, ...
            'Separator', 'on', ...
            'Label', 'Grayscale ...', ...
            'Callback', {@cb_print, [], [], 'gray'})
        uimenu(gui.menu_print, ...
            'Label', 'Vectorial grayscale ...', ...
            'Callback', {@cb_print, 'vector', [], 'gray'})
        uimenu(gui.menu_print, ...
            'Separator', 'on', ...
            'Label', 'CMYK ...', ...
            'Callback', {@cb_print, [], [], 'cmyk'})
        uimenu(gui.menu_print, ...
            'Label', 'Vectorial CMYK ...', ...
            'Callback', {@cb_print, 'vector', [], 'cmyk'})

    elseif (~gui.get('MENUBAR') || ~gui.get('MENU_PRINT'))
        delete(gui.menu_print)
    end
    function cb_print(~, ~, contenttype, resolution, colorspace)
        if nargin < 5 || isempty(colorspace)
            colorspace = 'rgb';
        end
        if nargin < 4 || isempty(resolution)
            resolution = 150;
        end
        if nargin < 3 || isempty(contenttype)
            contenttype = 'auto';
        end        
        BRAPH2.print(gui.p, [], 'ContentType', contenttype, 'Resolution', resolution, 'Colorspace', colorspace)
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
            'Name', ['Layout ' pf.getClass() ' - ' BRAPH2.STR], ...
            'Position', [x0(f, 'normalized')+w(f, 'normalized') y0(f, 'normalized')+h(f, 'normalized')*2/3 w(f, 'normalized') h(f, 'normalized')/3], ...
            'BKGCOLOR', pf.get('BKGCOLOR'), ...
            'CLOSEREQ', false ...
            );
        gui.f_layout = gui_layout.draw('Visible', 'off');

        p_layout = uipanel( ...
            'Parent', gui.f_layout, ...
            'Units', 'normalized', ...
            'Position', [0 0 1 1], ...
            'BackgroundColor', gui.get('BKGCOLOR'), ...
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

        [order, title, visible] = load_layout(pf);
        VISIBLE = 1;
        ORDER = 2;
        TITLE = 3;
        TAG = 4;
        CATEGORY = 5;
        FORMAT = 6;
        data = cell(pf.getPropNumber(), 6);
        for prop = 1:1:pf.getPropNumber()
            data{prop, VISIBLE} = visible(prop);
            data{prop, ORDER} = order(prop);
            data{prop, TITLE} = title{prop};
            data{prop, TAG} = upper(pf.getPropTag(prop));
            data{prop, CATEGORY} = pf.getPropCategory(prop);
            data{prop, FORMAT} = pf.getPropFormat(prop);
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
            data = get(edit_table, 'Data');
            order = cell2mat(data(:, 2))';
            title = data(:, 3); title = title';
            save_layout(pf, order, title)
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
            gui.tool_open = uipushtool(gui.toolbar, ...
                'Tag', 'tool_open', ...                
                'Tooltip', ['Open ' pf.getName()], ...
                'CData', imread('icon_open_ml.png'), ...
                'ClickedCallback', {@cb_open});
            % Save
            gui.tool_save = uipushtool(gui.toolbar, ...
                'Tag', 'tool_save', ...                
                'Tooltip', ['Save ' pf.getName()], ...
                'CData', imread('icon_save_ml.png'), ...
                'ClickedCallback', {@cb_save});
        end

        if gui.get('TOOL_PRINT') && check_graphics(gui.toolbar, 'uitoolbar')
            % Print
            gui.tool_print = uipushtool(gui.toolbar, ...
                'Tag', 'tool_print', ...                
                'Tooltip', ['Print/Export to image file ' pf.getName()], ...
                'CData', imread('icon_print_ml.png'), ...
                'ClickedCallback', {@cb_print, 'auto', 300});
        end
        
        if gui.get('TOOL_SETTINGS') && check_graphics(gui.toolbar, 'uitoolbar')
            % Settings
            gui.tool_settings = uipushtool(gui.toolbar, ...
                'Tag', 'tool_settings', ...       
                'Separator', 'on', ...
                'Tooltip', ['Settings ' pf.getName()], ... 
                'CData', imread('icon_settings_ml.png'), ...
                'ClickedCallback', {@cb_settings});
        end
        
        % reorder tool so that open and save are at the beginning
        tools = get(gui.toolbar, 'Children');
        set(gui.toolbar, 'Children', [tools(5:end); tools(1:4)])
    end
	function cb_settings(~, ~)
        persistent time
        if isempty(time)
            time = 0;
        end
        if now - time > 1.0 / (24 * 60 * 60)
            time = now;
            set(gui.tool_settings, 'Enable', 'off')
            %%% start callback %%%

            if ~check_graphics(gui.f_settings, 'figure')
                pe = PanelElement( ...
                    'EL', pf, ...
                    'VISIBLE', pf.getProps(Category.FIGURE) ...
                    );
                gui_settings = GUIElement( ...
                    'PE', pe, ...
                    'NAME', ['Seettings - ' gui.get('NAME')], ...
                    'POSITION', [ ...
                        x0(gui.f, 'normalized')+w(gui.f, 'normalized')+.01 ...
                        y0(gui.f, 'normalized')-.01 ...
                        .2 ...
                        h(gui.f, 'normalized') ...
                        ], ...
                    'MENUBAR', false, ...
                    'TOOLBAR', false, ...
                    'CLOSEREQ', false ...
                    );
                gui.f_settings = gui_settings.draw();
            else
                gui_settings = get(gui.f_settings, 'UserData');
                gui_settings.cb_bring_to_front();
            end
            
            %%% end callback %%%
            set(gui.tool_settings, 'Enable', 'on')
        end
    end
end
function cb_bring_to_front(gui)
    %CB_BRING_TO_FRONT brings to front the figure and its dependent figures.
    %
    % CB_BRING_TO_FRONT(GUI) brings to front the figure and its dependent figures
    %  by calling the method cb_bring_to_front() of the settings GUI
    %  and by bringing to fron the layout figure. 
    %  
    % See also cb_hide, cb_close.

    % brings to front the main GUI
    cb_bring_to_front@GUI(gui)
    
    % brings to front layout GUI
    if check_graphics(gui.f_layout, 'figure')
        figure(gui.f_layout) 
        set(gui.f_layout, ...
            'Visible', 'on', ...
            'WindowState', 'normal' ...
            )
    end
    
    % brings to front settings GUI
    if check_graphics(gui.f_settings, 'figure')
        gui_settings = get(gui.f_settings, 'UserData');
        gui_settings.cb_bring_to_front();
    end
end
function cb_hide(gui)
    %CB_HIDE hides the figure and its dependent figures.
    %
    % CB_HIDE(GUI) hides the figure and its dependent figures 
    %  by calling the method cb_hide() of the settings GUI
    %  and by hiding the layout figure.
    %
    % See also cb_bring_to_front, cb_close.

    % hides the main GUI
    cb_hide@GUI(gui)
        
    % hides the layout GUI
    if check_graphics(gui.f_layout, 'figure')
        set(gui.f_layout, 'Visible', 'off')
    end
    
    % hides the settings GUI
    if check_graphics(gui.f_settings, 'figure')
        gui_settings = get(gui.f_settings, 'UserData');
        gui_settings.cb_hide();
    end
end
function cb_close(gui)
    %CB_CLOSE closes the figure and its dependent figures.
    %
    % CB_CLOSE(GUI) closes the figure and its dependent figures 
    %  by calling the method cb_close() of the settings GUI
    %  and by closing the layout figure. 
    %  
    % See also cb_bring_to_front, cb_hide.

    % closes the main GUI
    cb_close@GUI(gui)
    
    % closes the layout GUI
    if check_graphics(gui.f_layout, 'figure')
        delete(gui.f_layout)
    end
    
    % closes the settings GUI
    if check_graphics(gui.f_settings, 'figure')
        gui_settings = get(gui.f_settings, 'UserData');
        gui_settings.cb_close();
    end
end

%% ¡tests!

%%% ¡test! 
%%%% ¡name!
Basic use
%%%% ¡code!
pf = PanelFig();
gui = GUIFig('PF', pf, 'FILE', 'xxx sss', 'CLOSEREQ', false);
f = gui.draw('Units', 'normalized', 'Position', [.1 .4 .4 .4]);
close(f)