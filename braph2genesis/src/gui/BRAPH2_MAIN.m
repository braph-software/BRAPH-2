function BRAPH2_MAIN(varargin)
% constants
screen_size = get(0, 'ScreenSize');
h_f = screen_size(4) * 0.5;
w_f = h_f * 1.61;
x_f = screen_size(3) * 0.3;
y_f = screen_size(4) * .3; 
f_position = get_from_varargin([x_f y_f w_f h_f], 'Position', varargin);
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
            'Units', 'pixels', ...
            'Position', f_position, ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'Color', BKGCOLOR, ...
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
% rotate
panel_rotate = uipanel( ...
    'Parent', f, ...
    'Units', 'normalized', ...
    'Position', [.02 .1 .56 .5], ...
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
    'GRID', false, ...
    'AXIS', false, ...    
    'COLORMAP', autumn)
h_panel = pl.draw('Parent', panel_rotate, 'Units', 'normalized', 'Position', [.0 .0 1 1], 'BackgroundColor', BKGCOLOR, 'BorderType', 'none');
pl_axes = get(h_panel, 'Children');
count = 0;
direction = 1;
    function rotate()
        try
            while get(ui_checkbox_bottom_animation, 'Value')
                if count > 100 % every 10s change direction
                    direction  = direction * -1;
                    count = 0;
                end
                camorbit(pl_axes, 3 * direction, 3 * direction, 'camera')
                drawnow
                pause(0.1)
                count = count + 1;
            end
        catch
            % nothing
        end
    end

% logo
panel_logo = uipanel( ...
    'Parent', f, ...
    'Units', 'normalized', ...
    'Position', [.55 .75 .45 .2], ...
    'BackgroundColor', BKGCOLOR,...
    'BorderType', 'none');
logo = imread([fileparts(which('braph2')) filesep 'src' filesep 'util' filesep 'head_main.png']);
pax = axes(panel_logo);
image(pax, logo);
axis off

% search
warning('off', 'all')
jPanelObj = com.mathworks.widgets.SearchTextField('Enter search filter:');
jAssetComponent = jPanelObj.getComponent;
[jhPanel, hContainer] = javacomponent(jAssetComponent, [20, 375, 350, 25], f); %#ok<JAVCM>
hjSearchField = handle(jAssetComponent.getComponent(0), 'CallbackProperties');
set(hjSearchField, 'KeyPressedCallback', {@updateSearch, jPanelObj});
warning('on', 'all')

    function updateSearch(~, ~, ~)  
        update_listbox()
    end
    function update_position(~, ~)
        set(hContainer,'units','norm', 'position', [0.62 0.65 0.36 .06]);
    end

% list
workflow_list = uicontrol( ...
    'Parent', f, ...
    'Style', 'listbox', ...
    'Units', 'normalized', ...
    'Position', [.62 .1 .36 .5], ...
    'String', '', ...
    'Callback', {@cb_wf_list_box});

jScrollPane = findjobj(workflow_list);
jListbox = jScrollPane.getViewport.getComponent(0);
jListbox = handle(jListbox, 'CallbackProperties');
set(jListbox, 'MouseMovedCallback', {@mouseMovedCallback, workflow_list});
descriptions = [];

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
        
        % open and find name and description
        
        for i = 1: length(workflow_names)
            file_path = paths{i};
            txt = fileread([file_path filesep workflow_names{i} '.m']);
            workflow_names{i} = getToken(txt, 'Name');
            descriptions{i} = getToken(txt, 'Description', 'Short');
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
    function mouseMovedCallback(jListbox, jEventData, hListbox)
        % Get the currently-hovered list-item
        mousePos = java.awt.Point(jEventData.getX, jEventData.getY);
        hoverIndex = jListbox.locationToIndex(mousePos) + 1;
        hoverValue = descriptions{hoverIndex};
        % Modify the tooltip based on the hovered item
        msgStr = sprintf('<html><b>%s</b></html>', hoverValue);
        set(hListbox, 'Tooltip',msgStr);
    end  


% menu
menu()
    function menu()
        % nothing        
    end
% toolbar
toolbar()
    function toolbar()
        set(f, 'Toolbar', 'none')
    end
% linkbar
license_btn = uicontrol(f, 'Style', 'pushbutton', 'Units', 'normalized');
about_btn = uicontrol(f, 'Style', 'pushbutton', 'Units', 'normalized');
website_btn = uicontrol(f, 'Style', 'pushbutton', 'Units', 'normalized');
linkbar()
    function linkbar()
        set(website_btn, ...
            'Position', [.415 0 .05 .07], ...
            'Tooltip', 'Click to visit BRAPH 2.0 website', ...
            'Cdata', imread('webicon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Callback', {@cb_website_btn});
        set(license_btn, ...
            'Position', [.475 0 .05 .07], ...
            'Cdata', imread('licenseicon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Tooltip', 'Click to open BRAPH 2.0 License', ...
            'Callback', {@cb_license});
        set(about_btn, ...
            'Position', [.535 0 .05 .07], ...
            'Cdata', imread('abouticon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Tooltip', 'Click to open BRAPH 2.0 information', ...
            'Callback', {@cb_about});
        
    end
    function cb_website_btn(~, ~)
        url = 'http://braph.org/';
        web(url);
    end
    function cb_license(~, ~)
        BRAPH2_LICENSE()
    end
    function cb_about(~, ~)
        BRAPH2_ABOUT();
    end
% auxiliary
update_listbox()
set(f, 'Visible', 'on')
set(f, 'Color', BKGCOLOR);
rotate()

end