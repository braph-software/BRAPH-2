function BRAPH2_MAIN(varargin)
% constants
f_position = get_from_varargin([.02 .1 .6 .80], 'Position', varargin);
BKGCOLOR = get_from_varargin([.98 .95 .95], 'BackgroundColor', varargin);
close_request = 1; % true

% init
f = init();
    function f = init()
        f = figure(...
            'Visible', 'off', ...
            'NumberTitle', 'off', ...
            'Name', [BRAPH2.STR], ...
            'Units', 'normalized', ...
            'Position', f_position, ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'Color', BKGCOLOR ...
            );
        set_icon(f)
        
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
    end
% main
% search
warnings('off')
hContainer = handle(uipanel('BorderType','none', 'Parent', f)); 
jPanelObj = com.mathworks.widgets.SearchTextField('Enter search filter:');
jAssetComponent = jPanelObj.getComponent;
[jhPanel,hContainer] = javacomponent(jAssetComponent, [10,500,200,25], f);
hjSearchField = handle(jAssetComponent.getComponent(0), 'CallbackProperties');
set(hjSearchField, 'KeyPressedCallback', {@updateSearch, jPanelObj});

    function updateSearch(~, ~, ~)  
        update_listbox()
    end

% list
workflow_list = uicontrol( ...
    'Parent', f, ...
    'Style', 'listbox', ...
    'Units', 'normalized', ...
    'Position', [.02 .1 .3 .5], ...
    'String', '', ...
    'Callback', {@cb_wf_list_box});

    function cb_wf_list_box(~, ~)
        % select the wf and plot the next window
    end
    function update_listbox()
        workflows_path = [fileparts(which('braph2.m')) filesep 'workflows'];
        files = subdir(fullfile(workflows_path, '*.m'));
        files_array = struct2cell(files);
        files_names = files_array(1, :); 
        files_paths = files_array(2, :);
        
        workflow_indices = cell2mat(cellfun(@(x) contains(x, 'workflow_'), files_names, 'UniformOutput', false));
        
        workflow_names = files_names(workflow_indices);
        paths = files_paths(workflow_indices);
        
        workflow_names = cellfun(@(x, y) erase(x, [y filesep()]), workflow_names, paths, 'UniformOutput', false);
        
        if ~isempty(jPanelObj.getSearchText.toCharArray')
            filter = jPanelObj.getSearchText.toCharArray';
            workflow_filter_index = cell2mat(cellfun(@(x) contains(x, filter), workflow_names, 'UniformOutput', false));
            workflow_names = workflow_names(workflow_filter_index);
        end
        
        set(workflow_list, 'String', workflow_names)
    end

% logo
panel_logo = uipanel( ...
    'Parent', f, ...
    'Units', 'normalized', ...
    'Position', [.52 .1 .48 .8], ...
    'BackgroundColor', [0 0 0],...
    'BorderType', 'none');
logo = imread([fileparts(which('braph2')) filesep 'src' filesep 'util' filesep 'braph2icon.png']);
pax = axes(panel_logo);
image(pax, logo);
axis off

% menu
menu()
    function menu()
    end
% toolbar
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
    end
% auxiliary
update_listbox()
set(f, 'Visible', 'on')
warnings('on')
end