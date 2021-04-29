function GUI(el, varargin)
%GUI creates and displays GUI for an element.
%
% GUI(EL) creates and displays GUI for element EL.
%
% GUI(EL, 'Name', NAME, 'Position', POSITION, 'BackgroundColor',
%  BACKGROUNDCOLOR) sets the GUI name, position, and background color. All
%  these settings are optional and can be in any order.
%
% See also Element.

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
        pl.draw('Parent', f)
    end

% check for importer / exporter
el_path = dir(fileparts(which(el.getClass())));
importers = el_path(contains({el_path(:).name}, {['Importer' el.getClass()]}) & ~contains({el_path(:).name}, {'test'}));
exporters = el_path(contains({el_path(:).name}, {['Exporter' el.getClass()]}) & ~contains({el_path(:).name}, {'test'}));

field = [];
for i = 1:1:length(importers)
    imp_class = erase(importers(i).name, '.m');
    imp_obj = eval([imp_class '()']);
    imp_props = imp_obj.getProps();
    for j = 1:length(imp_props)
        p = imp_props(j);
        default_p = imp_obj.getPropDefault(p);
        if isa(default_p, [el.getClass()])
            field = imp_obj.getPropTag(p);
        end
    end    
end

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
        
        if ~isempty(importers)
            ui_menu_importers = uimenu(f, 'Label', 'Importers');
            for k = 1:length(importers)
                imp = erase(importers(k).name, '.m');
                uimenu(ui_menu_importers, ...
                    'Label', imp, ...
                    'Callback', {@cb_importers});
            end
        end
        
        if ~isempty(exporters)
            ui_menu_exporters = uimenu(f, 'Label', 'Exporters');
            for k = 1:length(exporters)
                exp = erase(exporters(k).name, '.m');
                uimenu(ui_menu_exporters, ...
                    'Label', exp, ...
                    'Callback', {@cb_exporters});
            end
        end
        
        ui_menu_about = uimenu(f, 'Label', 'About');
        uimenu(ui_menu_about, ...
            'Label', 'License ...', ...
            'Callback', {@license})
        uimenu(ui_menu_about, ...
            'Label', 'About ...', ...
            'Callback', {@about})
    end
    function license(~, ~)
        CreateStruct.WindowStyle = 'modal';        
        CreateStruct.Interpreter = 'tex';
        msgbox({'' ...
            ['{\bf\color{orange}' BRAPH2.STR '}'] ...
            ['{\color{gray}version ' BRAPH2.VERSION '}'] ...
            ['{\color{gray}' BRAPH2.WEB '}'] ...
            '' ...
            'The license is available in the file {\bfbraph2license.rtf} on the main directory of BRAPH2.' ...
            'In brief, BRAPH2 is provided as is and is free to use for research.' ...
            '' ...
            ['{\color{gray}' BRAPH2.COPYRIGHT '}'] ...
            '' ...
            ''}, ...
            [BRAPH2.STR ' License'], ...
            CreateStruct)
    end
    function about(~, ~)
        CreateStruct.WindowStyle = 'modal';        
        CreateStruct.Interpreter = 'tex';
        msgbox({'' ...
            ['{\bf\color{orange}' BRAPH2.STR '}'] ...
            ['{\color{gray}version ' BRAPH2.VERSION '}'] ...
            ['{\color{gray}' BRAPH2.WEB '}'] ...
            '' ...
            BRAPH2.AUTHORS ...
            '' ...
            ['{\color{gray}' BRAPH2.COPYRIGHT '}'] ...
            '' ...
            ''}, ...
            ['About ' BRAPH2.STR], ...
            CreateStruct)
    end
    function cb_importers(hObject, ~)
        object_name = hObject.Text;
        imp_el = eval([object_name '()']);
        imp_el.uigetfile();
        el = imp_el.get(field);
        plot();
    end
    function cb_exporters(hObject, ~)
        object_name = hObject.Text;
        exmp_el = eval([object_name '(' '''' field '''' ', el)']);
        exmp_el.uiputfile();
        exmp_el.get('SAVE');
    end

%% Toolbar
toolbar()
    function toolbar()
        set(f, 'Toolbar', 'figure')

        ui_toolbar = findall(f, 'Tag', 'FigureToolBar');

        delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.SaveFigure'))
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
        % Save
        
        % Copy
        % Clone
    end

%% Show GUI
set(f, 'Visible', 'on')

end