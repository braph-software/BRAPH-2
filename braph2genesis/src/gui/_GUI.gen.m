%% ¡header!
GUI < Element (gui, graphical user interface) is a GUI for an element.

%%% ¡description!
% % % FIXME

%%% ¡seealso!
Element, PlotElement

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the GUI.

%%% ¡prop!
PE (metadata, item) is the plot element.
%%%% ¡settings!
'PlotElement'
%%%% ¡conditioning!
if ~isa(value, 'PlotElement')
    value = PlotElement('EL', value, 'ID', ['Plot of ' value.tostring()]);
end

%%% ¡prop!
FILE (data, string) is the B2 file where the element is saved.

%%% ¡prop!
NAME (metadata, string) is the name of the GUI.

%%% ¡prop!
POSITION (metadata, rvector) is the normalized position of the GUI on the screen.
%%%% ¡check_prop!
check = (length(value) == 4) && all(value(3:4) >= 0);
%%%% ¡default!
[.00 .00 .20 1.00]

%%% ¡prop!
CLOSEREQ (metadata, logical) determines whether to confirm close.
%%%% ¡default!
true

%% ¡properties!
f % handle for figure 
pp % handle for parent panel of the element panel
text_filename % handle for text field filename

toolbar
menu_file
menu_import
menu_export
menu_personalize
menu_about

f_layout % handle to figure with panel to manage layout

%% ¡methods!
function f_out = draw(gui)
% % % FIXME

    pe = gui.get('pe');
    el = pe.get('el');

    %% Figure
    % draw figure
    if ~check_graphics(gui.f, 'figure')
        gui.f = figure( ...
            'Visible', 'off', ...
            'NumberTitle', 'off', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'SizeChangedFcn', {@cb_resize}, ...
            'CloseRequestFcn', {@cb_close} ...
            );
        set_braph2_icon(gui.f)
    end
    
    % update figure
    name = gui.get('NAME');
    if isempty(name)
        if el.existsTag('ID')
            name = el.get('ID');
        else
            name = el.tostring();
        end
    end
    set(gui.f, ...
        'UserData', pe, ... % handle to retrieve pe and el from figure
        'Name', [el.getClass() ' - ' name ' - ' BRAPH2.STR], ...
        'Units', 'normalized', ...
        'Position', gui.get('POSITION'), ...
        'Color', pe.get('BKGCOLOR') ...
        )
    
    % callback on close request
    function cb_close(~, ~)
        if gui.get('CLOSEREQ')
            selection = questdlg(['Do you want to close ' name '?'], ...
                ['Close ' name], ...
                'Yes', 'No', 'Yes');
        else
            selection = 'Yes';
        end
        switch selection
            case 'Yes'
                delete(gui.f)
                if check_graphics(gui.f_layout, 'figure')
                    close(gui.f_layout)
                end
            case 'No'
                return
        end
    end

    % callback on resize
    function cb_resize(~, ~)
        set(gui.pp, ...
            'Units', 'characters', ...
            'Position', [0 1 Plot.w(gui.f, 'characters') Plot.h(gui.f, 'characters')-1] ...
            );
        set(gui.text_filename, ...
            'Position', [0 0 Plot.w(gui.f, 'characters') 1] ...
            )
    end

    %% FILENAME
    % draw text filename
    if ~check_graphics(gui.text_filename, 'text')
        gui.text_filename = uicontrol( ...
            'Parent', gui.f, ...
            'Tag', 'text_filename', ...
            'Style','text', ...
            'Units', 'character', ...
            'HorizontalAlignment', 'left', ...
            'String', gui.get('FILE') ...
            )
    end
% FIXME: check whether to bring out the update filename    
    function update_filename()
        set(gui.text_filename, 'String', gui.get('FILE'))
    end

    %% ELEMENT PANEL
    % draw element parent panel
    if ~check_graphics(gui.pp, 'uipanel')
        gui.pp = uipanel( ...
            'Parent', gui.f, ...
            'Tag', 'pp', ...
            'BorderType', 'none' ...
            );
    end
    pe.draw('Parent', gui.pp)
    
    %% Menu
    if ~check_graphics(gui.menu_file, 'uimenu')
        gui.menu_file = uimenu(gui.f, 'Label', 'File');
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
    end
    function cb_open(~, ~)
        % select file
        [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.getName() ' file.']);
        if filterindex
            filename = fullfile(path, file);
            tmp = load(filename, '-mat', 'el');
            if strcmp(tmp.el.getClass(), el.getClass())
                pe.reinit(tmp.el)
                gui.draw()
            else
                GUI('PE', tmp.el, 'FILE', filename).draw()
            end
        end
    end
    function cb_save(~, ~)
        filename = gui.get('FILE');
        if isfile(filename)
            build = BRAPH2.BUILD;
            save(filename, 'el', 'build');
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
            build = BRAPH2.BUILD;
            save(filename, 'el', 'build');
            gui.set('FILE', filename)
            update_filename();
        end
    end
    
    if ~check_graphics(gui.menu_import, 'uimenu')
        gui.menu_import = uimenu(gui.f, ...
            'Label', 'Import', ...
            'Callback', {@cb_refresh_import_menu});
    end
    function cb_refresh_import_menu(~,~)
        im_menus = get(gui.menu_import, 'Children');
        for i = 1:1:length(im_menus)
            delete(im_menus(i));
        end
        eval([el.getClass() '.getGUIMenuImport(el, gui.menu_import, pe)']);
    end    

    if ~check_graphics(gui.menu_export, 'uimenu')
        gui.menu_export = uimenu(gui.f, ...
            'Label', 'Export', ...
            'Callback', {@cb_refresh_export_menu});
    end
    function cb_refresh_export_menu(~,~)
        ex_menus = get(gui.menu_export, 'Children');
        for i = 1:length(ex_menus)
            delete(ex_menus(i));
        end
        eval([el.getClass() '.getGUIMenuExport(el, gui.menu_export, pe)']);
    end

    if ~check_graphics(gui.menu_personalize, 'uimenu')
        gui.menu_personalize = uimenu(gui.f, 'Label', 'Personalize');
        uimenu(gui.menu_personalize, ...
            'Label', 'Layout ...', ...
            'Callback', {@cb_layout});
    end
    function cb_layout(~, ~)
        if isgraphics(gui.f_layout, 'figure')
            delete(gui.f_layout)
        end
        
        gui.f_layout = figure( ...
            'Visible', 'off', ...
            'NumberTitle', 'off', ...
            'Name', ['Layout ' el.getClass() ' - ' BRAPH2.STR], ...
            'Units', get(gui.f, 'Units'), ...
            'Position', [Plot.x0(gui.f)+Plot.w(gui.f) Plot.y0(gui.f)+Plot.h(gui.f)*2/3 Plot.w(gui.f) Plot.h(gui.f)/3], ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'Color', pe.get('BKGCOLOR') ...
            );
        set_braph2_icon(gui.f_layout);

        edit_table = uitable('Parent', gui.f_layout, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .9 .7], ...
            'ColumnName', {'Show', 'Order', 'Title', 'Property', 'Category', 'Format'}, ...
            'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
            'ColumnEditable', [true true true false false false], ...
            'CellEditCallback', {@cb_edit_tb} ...
            );
        save_edit_btn = uicontrol('Parent', gui.f_layout, ...
            'Units', 'normalized', ...
            'Position', [.49 .02 .24 .1], ...
            'String', 'Save', ...
            'Callback', {@cb_save_edit} ...
            );
        cancel_edit_btn =  uicontrol('Parent', gui.f_layout, ...
            'Units', 'normalized', ...
            'Position', [.74 .02 .24 .1], ...
            'String', 'Cancel', ...
            'Callback', {@cb_cancel_edit} ...
            );

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
            data = get(edit_table, 'Data');
            order = cell2mat(data(:, 2))';
            title = data(:, 3); title = title';
            save_layout(el, order, title)

            pe.reinit(el);
            gui.draw()
        end
        function cb_cancel_edit(~, ~)
            close(gui.f_layout)
        end
    end

    if ~check_graphics(gui.menu_about, 'uimenu')
        gui.menu_about = uimenu(gui.f, 'Label', 'About');
        uimenu(gui.menu_about, ...
            'Label', 'BRAPH.org ...', ...
            'Callback', {@cb_web})
        uimenu(gui.menu_about, ...
            'Label', 'Forum...', ...
            'Callback', {@cb_forum})
        uimenu(gui.menu_about, ...
            'Label', 'Twitter ...', ...
            'Callback', {@cb_twitter})
        uimenu(gui.menu_about, ...
            'Label', 'License ...', ...
            'Callback', {@cb_license})
        uimenu(gui.menu_about, ...
            'Label', 'Credits ...', ...
            'Callback', {@cb_credits})
    end
    function cb_web(~, ~)
        BRAPH2.web()
    end
    function cb_forum(~, ~)
        BRAPH2.forum()
    end
    function cb_twitter(~, ~)
        BRAPH2.twitter()
    end
    function cb_license(~, ~)
        BRAPH2.license()
    end
    function cb_credits(~, ~)
        BRAPH2.credits()
    end

    %% Toolbar
    if ~check_graphics(gui.toolbar, 'uitoolbar')
        set(gui.f, 'Toolbar', 'figure')

        gui.toolbar = findall(gui.f, 'Tag', 'FigureToolBar');

        delete(findall(gui.toolbar, 'Tag', 'Standard.NewFigure'))
        delete(findall(gui.toolbar, 'Tag', 'Standard.PrintFigure'))
        delete(findall(gui.toolbar, 'Tag', 'Standard.EditPlot'))
        delete(findall(gui.toolbar, 'Tag', 'Standard.OpenInspector'))
        delete(findall(gui.toolbar, 'Tag', 'Exploration.Brushing'))
        delete(findall(gui.toolbar, 'Tag', 'DataManager.Linking'))
        delete(findall(gui.toolbar, 'Tag', 'Annotation.InsertColorbar'))
        delete(findall(gui.toolbar, 'Tag', 'Annotation.InsertLegend'))
        delete(findall(gui.toolbar, 'Tag', 'Plottools.PlottoolsOff'))
        delete(findall(gui.toolbar, 'Tag', 'Plottools.PlottoolsOn'))

        % Open
        toolbar_open = findall(gui.toolbar, 'Tag', 'Standard.FileOpen');
        set(toolbar_open, ...
            'TooltipString', ['Open ' el.getName()], ...
            'ClickedCallback', {@cb_open})
        % Save
        toolbar_save = findall(gui.toolbar, 'Tag', 'Standard.SaveFigure');
        set(toolbar_save, ...
            'TooltipString', ['Save ' el.getName()], ...
            'ClickedCallback', {@cb_save})
        
        uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')
        uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')

        % Website
        toolbar_web = uipushtool(gui.toolbar, ...
            'Separator', 'on', ...
            'TooltipString', 'Link to braph.org', ...
            'CData', imresize(imread('icon_web.png'), [24 24]), ...
            'ClickedCallback', {@cb_web});

        % Forum
        toolbar_web = uipushtool(gui.toolbar, ...
            'Separator', 'off', ...
            'TooltipString', 'Link to the BRAPH 2.0 forum', ...
            'CData', imresize(imread('icon_forum.png'), [24 24]), ...
            'ClickedCallback', {@cb_forum});

        % Twitter
        toolbar_web = uipushtool(gui.toolbar, ...
            'Separator', 'off', ...
            'TooltipString', 'Link to the BRAPH 2.0 Twitter', ...
            'CData', imresize(imread('icon_twitter.png'), [24 24]), ...
            'ClickedCallback', {@cb_twitter});
        
        uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')
        uipushtool(gui.toolbar, 'Separator', 'on', 'Visible', 'off')
        
        % License
        toolbar_web = uipushtool(gui.toolbar, ...
            'Separator', 'on', ...
            'TooltipString', 'BRAPH 2.0 License', ...
            'CData', imresize(imread('icon_license.png'), [24 24]), ...
            'ClickedCallback', {@cb_license});

        % About
        toolbar_web = uipushtool(gui.toolbar, ...
            'Separator', 'off', ...
            'TooltipString', 'Informtion about BRAPH 2.0 and credits', ...
            'CData', imresize(imread('icon_about.png'), [24 24]), ...
            'ClickedCallback', {@cb_about});
    end

    %% SHOW and OUTPUT
    % show figure
    set(gui.f, 'Visible', 'on')
    
    % output
    if nargout > 0
        f_out = gui.f;
    end
end