function f_out = GUI(el, varargin)
%GUI creates and displays GUI for an element.
%
% GUI(EL) creates and displays GUI for element EL.
%
% GUI(EL, 'CloseRequest', CLOSE_REQUEST, 'Name', NAME, 'Position',
%  POSITION, 'BackgroundColor', BACKGROUNDCOLOR, 'FileName', FILENAME) sets
%  the GUI close request, name, position (normalized units), background
%  color, and filename. 
%  All these settings are optional and can be in any order.
%
% F = GUI(EL) returns also the handle of the figure.
%
% The PlotElement and Element can be retrieved as 
%  pl = get(F, 'UserData')
%  el = pl.get('EL')
%
% See also Element, PlotElement.

%% Parameters
if el.existsTag('ID')
    name = get_from_varargin([el.getClass() ' - ' el.get('ID')], 'Name', varargin);
else
    name = get_from_varargin(el.getClass(), 'Name', varargin);
end

close_request = get_from_varargin(true, 'CloseRequest', varargin);

position = get_from_varargin([.00 .00 .20 1.00], 'Position', varargin);

bkgcolor = get_from_varargin([.98 .95 .95], 'BackgroundColor', varargin);

filename = get_from_varargin('', 'FileName', varargin);

%% Handles
el_panel = []; % Element panel
f_layout = []; % Figure with panel to manage layout

%% Initialize GUI
f = init();
    function f = init()
        f = figure( ...
            'Visible', 'off', ...
            'NumberTitle', 'off', ...
            'Name', [name ' - ' BRAPH2.STR], ...
            'Units', 'normalized', ...
            'Position', position, ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'Color', bkgcolor ...
            );
        set_braph2_icon(f)
        
        if close_request
            set(f, 'CloseRequestFcn', {@cb_close})
        end
    end
    function cb_close(~, ~)
        selection = questdlg(['Do you want to close ' name '?'], ...
            ['Close ' name], ...
            'Yes', 'No', 'Yes');
        switch selection
            case 'Yes'
                delete(f)
            case 'No'
                return
        end
        if ~isempty(f_layout) && isgraphics(f_layout, 'figure')
            close(f_layout)
        end
    end

%% Text File Name
ui_text_filename = uicontrol('Parent', f, 'Style','text');
init_filename()
    function init_filename()
        set(ui_text_filename, ...
            'Units', 'character', ...
            'HorizontalAlignment', 'left', ...
            'String', filename)
    end
    function update_filename()
        set(ui_text_filename, 'String', filename)
    end

%% Plot Element
pl = [];
plot()
    function plot()
        if isgraphics(el_panel, 'uipanel')
            delete(el_panel)
        end
        
        el_panel = uipanel( ...
            'Parent', f, ...
            'BorderType', 'none' ...
            );
        set(f, 'SizeChangedFcn', {@resize})
        function resize(~, ~)
            set(f, 'Units', 'character')
            set(el_panel, ...
                'Units', 'Character', ...
                'Position', [0 1 Plot.w(f) Plot.h(f)-1] ...
                );
            set(ui_text_filename, 'Position', [0 0 Plot.w(f) 1])
        end
        
        if isempty(pl) % executed when called the first time
            pl = el.getPlotElement();
        else % executed subsequent times
            el = pl.get('EL');
        end
        pl.draw('Parent', el_panel);
        
        set(f, 'UserData', pl) % handle to retrieve pl and el
        
        update_filename()
        
        resize() % to ensure that filename appears
    end

%% Menu
ui_menu_import = [];
ui_menu_export = [];
menu()
    function menu()
        ui_menu_file = uimenu(f, 'Label', 'File');
        uimenu(ui_menu_file, ...
            'Label', 'Open ...', ...
            'Accelerator', 'O', ...
            'Callback', {@cb_open})
        uimenu(ui_menu_file, ...
            'Label', 'Save', ...
            'Accelerator', 'S', ...
            'Callback', {@cb_save})
        uimenu(ui_menu_file, ...
            'Label', 'Save as ...', ...
            'Accelerator', 'A', ...
            'Callback', {@cb_saveas})
        uimenu(ui_menu_file, ...
            'Separator', 'on', ...
            'Label', 'Close', ...
            'Accelerator', 'C', ...
            'Callback', {@cb_close})
        
        ui_menu_import = uimenu(f, ...
            'Label', 'Import', ...
            'Callback', {@cb_refresh_menus});
        
        ui_menu_export = uimenu(f, ...
            'Label', 'Export', ...
            'Callback', {@cb_refresh_menus});
        
        ui_menu_personalize = uimenu(f, 'Label', 'Personalize');
        uimenu(ui_menu_personalize, ...
            'Label', 'Layout ...', ...
            'Callback', {@cb_layout});
        
        ui_menu_about = uimenu(f, 'Label', 'About');
        uimenu(ui_menu_about, ...
            'Label', 'License ...', ...
            'Callback', {@cb_license})
        uimenu(ui_menu_about, ...
            'Label', 'About ...', ...
            'Callback', {@cb_about})
    end
    function cb_open(~, ~)
        % select file
        [file, path, filterindex] = uigetfile(BRAPH2.EXT_ELEMENT, ['Select the ' el.getName() ' file.']);
        if filterindex
            filename = fullfile(path, file);
            tmp = load(filename, '-mat', 'el');
            if isa(tmp.el, el.getClass())
                el = tmp.el;
                pl = [];
                plot();
            else
                GUI(tmp.el, 'FileName', filename)
            end
        end
    end
    function cb_save(~, ~)
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
            update_filename();
        end
    end
    function cb_license(~, ~)
        BRAPH2.license()
    end
    function cb_about(~, ~)
        BRAPH2.about()
    end
    function cb_layout(~, ~)
        if isgraphics(f_layout, 'figure')
            delete(f_layout)
        end
        
        f_layout = figure( ...
            'Visible', 'off', ...
            'NumberTitle', 'off', ...
            'Name', ['Layout ' el.getClass() ' - ' BRAPH2.STR], ...
            'Units', get(f, 'Units'), ...
            'Position', [Plot.x0(f)+Plot.w(f) Plot.y0(f)+Plot.h(f)*2/3 Plot.w(f) Plot.h(f)/3], ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'Color', get(f, 'Color') ...
            );
        set_braph2_icon(f_layout);

        edit_table = uitable('Parent', f_layout, ...
            'Units', 'normalized', ...
            'Position', [.02 .2 .9 .7], ...
            'ColumnName', {'Show', 'Order', 'Title', 'Property', 'Category', 'Format'}, ...
            'ColumnFormat', {'logical', 'char', 'char', 'char', 'char', 'char'}, ...
            'ColumnEditable', [true true true false false false], ...
            'CellEditCallback', {@cb_edit_tb} ...
            );
        save_edit_btn = uicontrol('Parent', f_layout, ...
            'Units', 'normalized', ...
            'Position', [.49 .02 .24 .1], ...
            'String', 'Save', ...
            'Callback', {@cb_save_edit} ...
            );
        cancel_edit_btn =  uicontrol('Parent', f_layout, ...
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

        set(f_layout, 'Visible', 'on');
        
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
                
                order = cell2mat(data(:, ORDER)) + .001;
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

            pl.set('PP_DICT', NoValue.getNoValue());
            plot();
        end
        function cb_cancel_edit(~, ~)
            close(f_layout)
        end
    end
    function cb_refresh_menus(~,~)
        im_menus = get(ui_menu_import, 'Children');
        for i = 1:1:length(im_menus)
            delete(im_menus(i));
        end
        eval([el.getClass() '.getGUIMenuImport(el, ui_menu_import, pl)']);
        
        ex_menus = get(ui_menu_export, 'Children');
        for i = 1:length(ex_menus)
            delete(ex_menus(i));
        end
        eval([el.getClass() '.getGUIMenuExport(el, ui_menu_export, pl)']);
    end

%% Toolbar
toolbar()
    function toolbar()
        set(f, 'Toolbar', 'figure')
        
        ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
        
        delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.OpenInspector'))
        delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
        delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
        delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertColorbar'))
        delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertLegend'))
        delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOff'))
        delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOn'))
        
        % Open
        ui_toolbar_open = findall(ui_toolbar, 'Tag', 'Standard.FileOpen');
        set(ui_toolbar_open, ...
            'TooltipString', ['Open ' el.getName()], ...
            'ClickedCallback', {@cb_open})
        % Save
        ui_toolbar_save = findall(ui_toolbar, 'Tag', 'Standard.SaveFigure');
        set(ui_toolbar_save, ...
            'TooltipString', ['Save ' el.getName()], ...
            'ClickedCallback', {@cb_save})        
    end

%% Show GUI
set(f, 'Visible', 'on')

if nargout > 0
    f_out = f;
end
end