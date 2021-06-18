function BRAPH2_MAIN(varargin)
% constants
f_position = get_from_varargin([.02 .1 .5 .65], 'Position', varargin);
name = 'BRAPH 2.0';
BKGCOLOR = get_from_varargin([1 .9725 .929], 'BackgroundColor', varargin);
close_request = 1; % true

% init
f = init();
    function f = init()
        f = figure(...
            'Visible', 'off', ...
            'NumberTitle', 'off', ...
            'Name', name, ...
            'Units', 'normalized', ...
            'Position', f_position, ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'SizeChangedFcn', {@update_position} ...
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
warning('off', 'all')
jPanelObj = com.mathworks.widgets.SearchTextField('Enter search filter:');
jAssetComponent = jPanelObj.getComponent;
[jhPanel, hContainer] = javacomponent(jAssetComponent, [20, 375, 350, 25], f);
hjSearchField = handle(jAssetComponent.getComponent(0), 'CallbackProperties');
set(hjSearchField, 'KeyPressedCallback', {@updateSearch, jPanelObj});
warning('on', 'all')

    function updateSearch(~, ~, ~)  
        update_listbox()
    end
    function update_position(~, ~)
        pos = get_figure_position();
        x = pos(1);
        y = pos(2);
        w = pos(3);
        h = pos(4);
        
        
        jhPanel.setLocation(1, 1);
        jhPanel.setSize(1,1);
    end
    function pos = get_figure_position()
        pos = getpixelposition(f); %// gives x left, y bottom, width, height
    end


% list
workflow_list = uicontrol( ...
    'Parent', f, ...
    'Style', 'listbox', ...
    'Units', 'normalized', ...
    'Position', [.02 .1 .46 .5], ...
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
        workflow_names = cellfun(@(x) erase(x, '.m'), workflow_names, 'UniformOutput', false);
        
        if ~isempty(jPanelObj.getSearchText.toCharArray')
            filter = jPanelObj.getSearchText.toCharArray';
            workflow_filter_index = cell2mat(cellfun(@(x) contains(x, filter), workflow_names, 'UniformOutput', false));
            workflow_names = workflow_names(workflow_filter_index);
        end
        
        set(workflow_list, 'String', workflow_names)
    end
    function varargout = subdir(varargin)
        % Function based on Kelly Kearney subdir function.
        [folder, name, ext] = fileparts(varargin{1});
        if isempty(folder)
            folder = pwd;
        end
        if isempty(ext)
            if isdir(fullfile(folder, name))
                folder = fullfile(folder, name);
                filter = '*';
            else
                filter = [name ext];
            end
        else
            filter = [name ext];
        end
        if ~isdir(folder)
            error('Folder (%s) not found', folder);
        end
        pathstr = genpath_local(folder);
        pathfolders = regexp(pathstr, pathsep, 'split');  % Same as strsplit without the error checking
        pathfolders = pathfolders(~cellfun('isempty', pathfolders));  % Remove any empty cells
        Files = [];
        pathandfilt = fullfile(pathfolders, filter);
        for ifolder = 1:length(pathandfilt)
            NewFiles = dir(pathandfilt{ifolder});
            if ~isempty(NewFiles)
                fullnames = cellfun(@(a) fullfile(pathfolders{ifolder}, a), {NewFiles.name}, 'UniformOutput', false);
                [NewFiles.name] = deal(fullnames{:});
                Files = [Files; NewFiles];
            end
        end
        if ~isempty(Files)
            [~, ~, tail] = cellfun(@fileparts, {Files(:).name}, 'UniformOutput', false);
            dottest = cellfun(@(x) isempty(regexp(x, '\.+(\w+$)', 'once')), tail);
            Files(dottest & [Files(:).isdir]) = [];
        end
        if nargout == 0
            if ~isempty(Files)
                fprintf('\n');
                fprintf('%s\n', Files.name);
                fprintf('\n');
            end
        elseif nargout == 1
            varargout{1} = Files;
        end
        function [p] = genpath_local(d)
            % Modified genpath that doesn't ignore:
            %     - Folders named 'private'
            %     - MATLAB class folders (folder name starts with '@')
            %     - MATLAB package folders (folder name starts with '+')
            files = dir(d);
            if isempty(files)
                return
            end
            p = '';  % Initialize output
            % Add d to the path even if it is empty.
            p = [p d pathsep];
            % Set logical vector for subdirectory entries in d
            isdir = logical(cat(1,files.isdir));
            dirs = files(isdir);  % Select only directory entries from the current listing
            for i=1:length(dirs)
                dirname = dirs(i).name;
                if    ~strcmp( dirname,'.') && ~strcmp( dirname,'..')
                    p = [p genpath(fullfile(d,dirname))];  % Recursive calling of this function.
                end
            end
        end
    end

% logo
panel_logo = uipanel( ...
    'Parent', f, ...
    'Units', 'normalized', ...
    'Position', [.02 .75 .6 .25], ...
    'BackgroundColor', BKGCOLOR,...
    'BorderType', 'none');
logo = imread([fileparts(which('braph2')) filesep 'src' filesep 'util' filesep 'head_main.png']);
pax = axes(panel_logo);
image(pax, logo);
axis off

% rotate
panel_rotate = uipanel( ...
    'Parent', f, ...
    'Units', 'normalized', ...
    'Position', [.52 .1 .46 .5], ...
    'BackgroundColor', BKGCOLOR,...
    'BorderType', 'none');

ui_checkbox_bottom_animation = uicontrol(f, 'Style', 'checkbox', 'Visible', 'off', 'Value', true);
pl = PlotBrainSurface('SURF', ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF'));
pl.set(...
    'AXESCOLOR', BKGCOLOR, ...
    'LIGHTING', 'phong', ...
    'MATERIAL', 'shiny', ...
    'CAMLIGHT', 'left', ...
    'SHADING', 'interp', ...
    'COLORMAP', autumn)
h_panel = pl.draw('Parent', panel_rotate, 'Units', 'normalized', 'Position', [.0 .0 1 1], 'BackgroundColor', BKGCOLOR);
a = get(h_panel, 'Children');
pl_axes = a;
axis off
pl.set('axis', false);
    function rotate()        
        try        
            while get(ui_checkbox_bottom_animation, 'Value')
                camorbit(pl_axes, 2, 2, 'camera')                
                drawnow
                pause(0.1)
            end
        catch
            % nothing
        end
    end

% menu
menu()
    function menu()
        ui_menu_about = uimenu(f, 'Label', 'About');
        uimenu(ui_menu_about, ...
            'Label', 'License ...', ...
            'Callback', {@cb_license})
        uimenu(ui_menu_about, ...
            'Label', 'About ...', ...
            'Callback', {@cb_about})
        function cb_license(~, ~)
            BRAPH2_LICENSE()
        end
        function cb_about(~, ~)
            BRAPH2_ABOUT();
        end
    end
% toolbar
toolbar()
    function toolbar()
        set(f, 'Toolbar', 'none')
    end
% auxiliary
update_listbox()
set(f, 'Visible', 'on')
set(f, 'Color', BKGCOLOR);
rotate()

end