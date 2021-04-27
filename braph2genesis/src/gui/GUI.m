function GUI(el, varargin)

%% Parameters

% option whether close dialog

if el.existsTag('ID')
    name = get_from_varargin([el.getClass() ' - ' el.get('ID')], 'Name', varargin);
else
    name = get_from_varargin(el.getClass(), 'Name', varargin);
end

f_position = get_from_varargin([.02 .30 .30 .80], 'Position', varargin);

BKGCOLOR = get_from_varargin([.98 .95 .95], 'BackgroundColor', varargin);

%% Initialize GUI
f = init();
    function f = init()
        f = figure( ...
            'Visible', 'off', ...
            'NumberTitle', 'off', ...
            'Name', [name ' - ' BRAPH2.STR], ...
            'Units', 'normalized', ...
            'Position', f_position, ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'Color', BKGCOLOR, ... 
            'CloseRequestFcn', {@close} ...
            );
    end
    function close(~, ~)
        selection = questdlg(['Do you want to close ' name '?'], ...
            ['Close ' name], ...
            'Yes', 'No', 'Yes');
        switch selection
            case 'Yes'
                delete(f)
            case 'No'
                return
        end
    end

%% Plot Element
plot()
    function plot()
        pl = el.getPlotElement();
        pl.draw('Parent', f);
    end

OPEN_TP = ['Open ' el.getName()];
SAVE_TP = ['Save ' el.getName()];

%% Menu
menu()
    function menu()
        ui_menu_file = uimenu(f, 'Label', 'File');
        % Open ...
        % Save
        % Save as ...
        uimenu(ui_menu_file, ...
            'Label', 'Close', ...
            'Accelerator', 'C', ...
            'Callback', {@close})
        
        ui_menu_about = uimenu(f, 'Label', 'About');
        uimenu(ui_menu_about, ...
            'Label', 'About ...', ...
            'Callback', {@about})
        % License ...
    end
    function about(~, ~)
        msgbox({'' ...
            BRAPH2.STR ...
            ['version ' BRAPH2.VERSION] ...
            '' ...
            BRAPH2.AUTHORS ...
            '' ...
            BRAPH2.COPYRIGHT ...
            ''}, ...
            ['About ' BRAPH2.STR])
    end

%% Toolbar
toolbar()
    function toolbar()
        set(f, 'Toolbar', 'figure')

        ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
        if ~ismethod(el, 'getImporters')
           delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen')) 
        end
        
        if ~ismethod(el, 'getExporters')
            delete(findall(ui_toolbar, 'Tag', 'Standard.SaveFigure')) 
        end
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
        set(ui_toolbar_open, 'TooltipString', OPEN_TP);
        set(ui_toolbar_open, 'ClickedCallback', {@cb_open_window})
        % Save
        ui_toolbar_save = findall(ui_toolbar, 'Tag', 'Standard.SaveFigure');
        set(ui_toolbar_save, 'TooltipString', SAVE_TP);
        set(ui_toolbar_save, 'ClickedCallback', {@cb_save_window})
        
        % Copy
        % Clone
    end
f_open = [];
f_close = [];
    function cb_open_window(~, ~)  % (src, event)
        f_open = figure( ...
            'Visible', 'on', ...
            'NumberTitle', 'off', ...
            'Name', [name ' Open Window ' BRAPH2.STR], ...
            'Units', 'normalized', ...
            'Position', [.3 .4 .2 .2], ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'Color', BKGCOLOR ...
            );
        
        % get importers
        [importers, field] = el.getImporters();
        
        buttons_importer = zeros(length(importers), 1);
        
        for i = 1:length(importers)
            x_button = .01;
            y_button = .01 + .1*i*2;
            
            buttons_importer(i, 1) = uicontrol( ...
                'Parent', f_open, ...
                'Units', 'normalized', ...
                'Position', [x_button y_button .98 .15], ...
                'String', importers{i}, ...
                'Callback', {@cb_open_via_importer} ...
                );
        end
        
        function cb_open_via_importer(hObject, ~)
            object_name = hObject.String;
            imp_el = eval([object_name '()']);
            imp_el.uigetfile();
            el = imp_el.get(field);
            delete(f_open);
            plot();
        end
    end
    function cb_save_window(~, ~)  % (src, event)
        f_close = figure( ...
            'Visible', 'on', ...
            'NumberTitle', 'off', ...
            'Name', [name ' Close Window ' BRAPH2.STR], ...
            'Units', 'normalized', ...
            'Position', [.3 .4 .2 .2], ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'Color', BKGCOLOR ...
            );
        
        % get importers
        [exporters, field] = el.getExporters();
        
        buttons_exporter = zeros(length(exporters), 1);
        
        for i = 1:length(exporters)
            x_button = .01;
            y_button = .01 + .1*i*2;
            
            buttons_exporter(i, 1) = uicontrol( ...
                'Parent', f_close, ...
                'Units', 'normalized', ...
                'Position', [x_button y_button .98 .15], ...
                'String', exporters{i}, ...
                'Callback', {@cb_open_via_exporter} ...
                );
        end
        
        function cb_open_via_exporter(hObject, ~)
            object_name = hObject.String;
             exmp_el = eval([object_name '(' '''' field '''' ', el)']);
            exmp_el.uiputfile();
            exmp_el.get('SAVE');
            delete(f_close);
        end
    end

%% Show GUI
set(f, 'Visible', 'on')

end