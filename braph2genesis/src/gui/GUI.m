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
OPEN_TP = el.getName();
SAVE_TP = el.getName();

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
            'CloseRequestFcn', {@cb_close} ...
            );
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
    end

%% Plot Element
plot()
    function plot()        
        pl = el.getPlotElement();
        pl.draw('Parent', f);
    end
%% Menu
el_path = [];
menu()
    function menu()
        ui_menu_file = uimenu(f, 'Label', 'File');
        uimenu(ui_menu_file, ...
            'Label', 'Open ...', ...
            'Accelerator', 'O', ...
            'Callback', {@cb_open})
        uimenu(ui_menu_file, ...
            'Label', 'Save', ...
            'Accelerator', 'O', ...
            'Callback', {@cb_save})
        uimenu(ui_menu_file, ...
            'Label', 'Save as ...', ...
            'Accelerator', 'O', ...
            'Callback', {@cb_saveas})
        %%% ---
        uimenu(ui_menu_file, ...
            'Separator', 'on', ...
            'Label', 'Close', ...
            'Accelerator', 'C', ...
            'Callback', {@cb_close})
        
        ui_menu_import = uimenu(f, 'Label', 'Import');
        uimenu(ui_menu_import, ...
            'Label', 'Import JSON ...', ...
            'Accelerator', 'O', ...
            'Callback', {@cb_import_json})

        ui_menu_export = uimenu(f, 'Label', 'Export');
        uimenu(ui_menu_export, ...
            'Label', 'Export JSON ...', ...
            'Accelerator', 'O', ...
            'Callback', {@cb_export_json})
        
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
        [file, path, filterindex] = uigetfile('.mat', ['Select the ' el.getName() ' file.']);
        if filterindex
            filename = fullfile(path, file);
            tmp = load(filename, '-mat', 'el');
            el_path = filename;
            if isa(tmp.el, [el.getClass()]) %#ok<NBRAK>
                el = tmp.el;
                plot();
            end
        end
    end
    function cb_save(~, ~)
        if isempty(el_path)
            cb_saveas();
        else
            save(el_path, 'el');
        end
    end
    function cb_saveas(~, ~)
         % select file
        [file, path, filterindex] = uiputfile('.mat', ['Select the ' el.getName() ' file.']);
        % save file
        if filterindex
            filename = fullfile(path, file);
            save(filename, 'el');
            el_path = filename;
        end
    end
    function cb_import_json(~,~)
        [file, path, filterindex] = uigetfile('.json', ['Select ' el.getName  ' file location.']);
        if filterindex
            filename = fullfile(path, file);           
            fid = fopen(filename);
            raw = fread(fid, inf);
            str = char(raw');
            fclose(fid);
            tmp_el = Element.decodeJSON(str);
            el = tmp_el;
            plot();
        end
    end
    function cb_export_json(~,~)
        [file, path, filterindex] = uiputfile('.json', ['Select ' el.getName  ' file location.']);
        if filterindex
            filename = fullfile(path, file);
            [json, ~, ~] = encodeJSON(el);
            fid = fopen(filename, 'w');
            fprintf(fid, json);
            fclose(fid);
        end
    end
    function cb_license(~, ~)
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
    function cb_about(~, ~)
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

%% Toolbar
toolbar()
    function toolbar()
        set(f, 'Toolbar', 'figure')

        ui_toolbar = findall(f, 'Tag', 'FigureToolBar');

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
        ui_toolbar_open = findall(ui_toolbar, 'Tag', 'Standard.FileOpen');
        set(ui_toolbar_open, 'TooltipString', OPEN_TP);
        set(ui_toolbar_open, 'ClickedCallback', {@cb_open})
        % Save
        ui_toolbar_save = findall(ui_toolbar, 'Tag', 'Standard.SaveFigure');
        set(ui_toolbar_save, 'TooltipString', SAVE_TP);
        set(ui_toolbar_save, 'ClickedCallback', {@cb_save})
        
        % Copy
        % Clone
    end

%% Show GUI
set(f, 'Visible', 'on')

end