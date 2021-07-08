function WORKFLOWGUI(file, name,  varargin)
%% constants
screen_size = get(0, 'ScreenSize');
h_f = screen_size(4) * 0.65;
w_f = h_f * 1.61;
x_f = screen_size(3) * 0.2;
y_f = screen_size(4) * .2; 
name_w = ['Workflow - ' name];
f_position = get_from_varargin([x_f y_f w_f h_f], 'Position', varargin);
BKGCOLOR = get_from_varargin([1 .9725 .929], 'BackgroundColor', varargin);
BTNBKGCOLOR = get_from_varargin([.902 .835 .745], 'BackgroundColor', varargin);
close_request = 0; % false has to be true after debugs
tokens = [];
width_ct = 1;
heigth_ct = .5;
slider_width = 3;

% get info of file
txt = fileread(file);
cycles = getFileCycles(txt);
    function cycles = getFileCycles(txt)
        splits = regexp(txt, ['(^|' newline() ')%%\s*'], 'split');
        splits = splits(~cellfun('isempty', splits));
        cycles = length(splits);
    end
    function token = getGUIToken(txt, cycle)
        splits = regexp(txt, ['(^|' newline() ')%%\s*'], 'split');
        splits = splits(~cellfun('isempty', splits));
        for j = 1:1:length(splits)
            split_tmp = splits{j};
            if j == cycle
                in_splits = regexp(split_tmp, ['(^|' newline() ')%\s*'], 'split');
                in_splits = in_splits(~cellfun('isempty', in_splits));
                token = in_splits{1};                
                break
            end
        end
    end
    function [vars, vars_per_token] = getExecutable(token)
        vars = regexp(token, ['(^|' newline() ')'], 'split');
        vars = cellfun(@(x) strtrim(x), vars, 'UniformOutput', false);
        vars = vars(~cellfun('isempty', vars));
        vars_per_token = length(vars);
    end

%% figure
f = init();
    function f = init()
        f = figure(...
            'Visible', 'off', ...
            'NumberTitle', 'off', ...
            'Name', name_w, ...
            'Units', 'pixels', ...
            'Position', f_position, ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'Color', BKGCOLOR , ...
            'SizeChangedFcn', {@redraw} ...
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
    function redraw(~, ~)
        panel_plot()
        set(f, 'Units', 'pixels')
        figure_size = getPosition(f);        
        if figure_size(3) < w_f
            add_space_to_btns()
        else
            substract_space_to_btns()
        end
        set(f, 'Units', 'characters')
    end

%% panels
panel_struct = struct([]);
section_panel = cell(1, cycles - 1);  % cycles - title
slider = cell(1, cycles - 1);
panel_inner = [];
x_slice = 1 / (cycles - 1);
panel_executables = [];
y_slice = 2;
define = false;
horizontal_slider = uicontrol(f, 'Style', 'slider', 'Callback', {@cb_horizontal_slider});

panel_plot()
    function panel_plot()
        for i = 2:cycles
            cycle = i - 1 ; % remove title;
            x_offset = x_slice * (cycle - 1);
            token = getGUIToken(txt, i);
            tokens{i} = token; % saving purposes   
            
            if isempty(section_panel{i - 1}) || ~isgraphics(section_panel{i - 1}, 'uipanel')
                define = true;
                section_panel{i - 1} = uipanel(f, 'BackgroundColor', BKGCOLOR);
            else
                define = false;
            end
            
            if isempty(slider{i - 1}) || ~isgraphics(slider{i - 1}, 'uicontrol')
                slider{i - 1} = uicontrol(section_panel{i - 1}, 'Style', 'slider', 'Callback', {@slide}); 
                init_section_panel(section_panel{i - 1}, x_offset)                
            end

            % set y 
            set_y_section_panel(section_panel{i - 1})
            
            % get position
            set(section_panel{i - 1}, 'Units', 'characters')
            pos = getPosition(section_panel{i - 1});
            
            % horizontal slider
            set(f, 'Units', 'pixels')
            figure_size = getPosition(f);
            if figure_size(3) < w_f
                set(horizontal_slider, ...
                    'Units', 'characters', ...
                    'Visible', 'on', ...
                    'Min', 0, ...
                    'Max', w_f, ...
                    'Value', max(get(horizontal_slider, 'Value'), w_f - figure_size(3)), ...
                    'Position', [0 0 figure_size(3) 1])
            else
                set(horizontal_slider, ... 
                    'Units', ' characters', ...
                    'Visible', 'off', ...
                    'Position', [0 0 figure_size(3) 1])
            end
            set(f, 'Units', 'characters')
            
            % get executables
            panel_executable = getExecutable(token);
            panel_executables{i} = panel_executable;            
            total_h = 0;
            for j = 1:length(panel_executable)
                if define
                    panel_inner{i, j} = uicontrol(section_panel{i - 1}); 
                    set(panel_inner{i, j}, 'BackgroundColor', BKGCOLOR);
                end
                y_offset = heigth_ct + y_slice * (j);
                total_h = total_h + y_slice;
                
                if j > 1
                    set(panel_inner{i, j}, ...
                        'Style', 'pushbutton', ...
                        'String', [panel_executable{1} ' ' num2str(j - 1)], ...
                        'Units', 'characters', ...                        
                        'Position', [width_ct pos(4)-y_offset pos(3)-2*slider_width y_slice], ...
                        'Callback', {@(src, x, y) btn_action(src, i - 1, j - 1)})
                else
                    set(panel_inner{i, j}, ...
                        'Style', 'text', ...
                        'String', panel_executable{1}, ...
                        'Units', 'characters', ...
                        'Position', [pos(1)+width_ct pos(4)-y_offset pos(3)-2*slider_width y_slice])
                end
            end
            
            init_slider(slider{i - 1}, total_h, pos)
        end
    end
    function init_section_panel(panel, x_offset)        
        set(panel, ...
            'Units', 'normalized', ...
            'Position', [x_offset .1 x_slice .9])
    end
    function set_y_section_panel(panel)
        panel.Units = 'normalized';
        panel.Position(2) = .1;
        panel.Position(4) = .9;
    end
    function init_slider(slider, total_h, pos)
        if total_h > pos(4)
            set(slider, ...                
                'Value', 0, ...
                'Visible', 'on', ...
                'Units', 'character', ...
                'Min', 0, ...
                'Max', total_h, ...
                'Position', [pos(3)-slider_width 0 slider_width pos(4)])
        else
            set(slider, ...
                'Style', 'slider', ...
                'Value', 0, ...
                'Visible', 'off', ...
                'Min', 0, ...
                'Max', total_h, ...
                'Position', [pos(3)-slider_width 0 slider_width pos(4)])
        end
    end
    function btn_action(src, panel, child)        
        panel_exe_ = panel_executables{panel + 1};
        exe_ = split(panel_exe_{child + 1}, '=');       
        
        % fill struct
        panel_struct(panel, child).name = ['panel_struct(' num2str(panel) ',' num2str(child) ').exe'];
        panel_struct(panel, child).name_script = strtrim(exe_{1});
        panel_struct(panel, child).btn = src.String;
        
        for l = 1:size(panel_struct, 2)
            if ~isempty(panel_struct) && size(panel_struct, 1) > 1
                exe_{2} = strrep(exe_{2}, ...
                    panel_struct(panel - 1, l).name_script, ...
                    panel_struct(panel - 1, l).name);
            end
        end
        
        panel_struct(panel, child).exe = eval([exe_{2}]);
        if ~isempty(panel_struct(panel, child).exe) && isa(panel_struct(panel, child).exe, 'Element')
            GUI(panel_struct(panel, child).exe)
            change_state_btn(src)
            if check_section_objs(panel)
                enable_panel(section_panel{panel + 1})                
            end
        end
    end
    function check = check_section_objs(panel)
        check = false;
        n = length(panel_executables{panel + 1}) - 1 ;
        tmp = struct2cell(panel_struct);
        if panel + 1 <= length(section_panel) && ...
                (isequal(n, length(tmp(4, 1))) ||  isequal(n, length(tmp(4, panel, :))))             
                
            check = true;
        end
    end
    function change_state_btn(btn)
        set(btn, 'BackgroundColor', [166 218 149]/255)
    end
    function pos = getPosition(obj)
        pos = get(obj, 'Position');
    end
    function slide(~, ~)
        for i = 1:length(slider)            
            set(slider{i}, 'Visible', 'on')
        end
    end
    function cb_horizontal_slider(~, ~)
        set(horizontal_slider, 'Visible', 'on')
    end

%% buttons
save_workflow_btn = uicontrol(f, 'Style', 'pushbutton', 'Units', 'normalized');
load_workflow_btn = uicontrol(f, 'Style', 'pushbutton', 'Units', 'normalized');
% linkbar
license_btn = uicontrol(f, 'Style', 'pushbutton', 'Units', 'normalized');
about_btn = uicontrol(f, 'Style', 'pushbutton', 'Units', 'normalized');
website_btn = uicontrol(f, 'Style', 'pushbutton', 'Units', 'normalized');
forums_btn = uicontrol(f, 'Style', 'pushbutton', 'Units', 'normalized');
twitter_btn = uicontrol(f, 'Style', 'pushbutton', 'Units', 'normalized');
buttons()
    function buttons()        
        set(save_workflow_btn, ...
            'String', 'Save ...', ...
            'Tooltip', ['Save the workspace of ' name], ...
            'Position', [.0 0 .1428 .08], ...
            'BackgroundColor', [1 1 1], ...
            'Callback', {@cb_save_worfklow})
        
        set(load_workflow_btn, ...
            'String', 'Load ...', ...
            'Tooltip', ['Load the workspace of ' name], ...
            'Position', [.1428 0 .1428 .08], ...
            'BackgroundColor', [1 1 1], ...
            'Callback', {@cb_load_worfklow})
        
        set(website_btn, ...
            'Position', [.2856 0 .1428 .08], ...
            'Tooltip', 'Click to visit BRAPH 2.0 website', ...
            'Cdata', imread('webicon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Callback', {@cb_website_btn});
        set(forums_btn, ...
            'Position', [.4284 0 .1428 .08], ...
            'Tooltip', 'Click to visit BRAPH 2.0 forums', ...
            'Cdata', imread('forum_icon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Callback', {@cb_forum_btn});
        set(twitter_btn, ...
            'Position', [.5712 0 .1428 .08], ...
            'Tooltip', 'Click to visit BRAPH 2.0 twitter', ...
            'Cdata', imread('twitter_icon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Callback', {@cb_twitter_btn});        
        set(license_btn, ...
            'Position', [.714 0 .1428 .08], ...
            'Cdata', imread('licenseicon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Tooltip', 'Click to open BRAPH 2.0 License', ...
            'Callback', {@cb_license});
        set(about_btn, ...
            'Position', [.8568 0 .1428 .08], ...
            'Cdata', imread('abouticon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Tooltip', 'Click to open BRAPH 2.0 information', ...
            'Callback', {@cb_about});     
    end
    function cb_website_btn(~, ~)
        url = 'http://braph.org/';
        web(url);
    end
    function cb_twitter_btn(~, ~)
        url = 'google.com'; % create a BRAPH 2 twitter.
        web(url);
    end
    function cb_forum_btn(~, ~)
        url = 'http://braph.org/forum/';
        web(url);
    end
    function cb_license(~, ~)
        BRAPH2_LICENSE()
    end
    function cb_about(~, ~)
        BRAPH2_ABOUT();
    end
    function cb_save_worfklow(~, ~)
        % select file
        [file, path, filterindex] = uiputfile(BRAPH2.EXT_WORKSPACE, 'Select the file to save the workspace.');
        % save file
        if filterindex
            filename = fullfile(path, file);
            build = BRAPH2.BUILD;
            save(filename, 'panel_struct', 'build');            
        end
    end
    function cb_load_worfklow(~, ~)
        [file, path, filterindex] = uigetfile(BRAPH2.EXT_WORKSPACE, 'Select the file to load a workspace.');
        if filterindex
            filename = fullfile(path, file);
            tmp = load(filename, '-mat', 'panel_struct');
            if isa(tmp.panel_struct, 'struct')
                panel_struct = tmp.panel_struct;
                load_struct();
            end
        end
    end
    function load_struct()
        for i = 1:size(panel_struct, 1)
            if i + 1 <= length(section_panel) && check_section_objs(i)
                enable_panel(section_panel{i + 1})
            end
        end
        set_loaded_objects()
    end
    function set_loaded_objects()
        for j = 1:length(section_panel)
            childs = get(section_panel{j}, 'Children');
            childs_ = flip(childs(1: end - 2));
            if size(panel_struct, 1) < j
                    break;
            end
            for k = 1:length(childs_)
                child_name = get(childs_(k), 'String');
                if size(panel_struct, 2) < k
                    break;
                end
                panel_btn = panel_struct(j, k).btn;
                if isequal(child_name, panel_btn)
                    change_state_btn(childs_(k))
                end
            end
        end
    end
    function add_space_to_btns()
        set(save_workflow_btn, ...
            'Position', [.0 0.02 .1428 .08] ...
            );
        set(load_workflow_btn, ...
            'Position', [.1428 0.02 .1428 .08] ...
            );
        set(website_btn, ...
            'Position', [.2856 0.02 .1428 .08] ...
            );
        set(forums_btn, ...
            'Position', [.4284 0.02 .1428 .08] ...
            );
        set(twitter_btn, ...
            'Position', [.5712 0.02 .1428 .08] ...
            );
        set(license_btn, ...
            'Position', [.714 0.02 .1428 .08] ...
            );
        set(about_btn, ...
            'Position', [.8568 0.02 .1428 .08] ...
            );
    end
    function substract_space_to_btns()
         set(save_workflow_btn, ...
            'Position', [.0 0 .1428 .08] ...
            );
        set(load_workflow_btn, ...
            'Position', [.1428 0 .1428 .08] ...
            );
        set(website_btn, ...
            'Position', [.2856 0 .1428 .08] ...
            );
        set(forums_btn, ...
            'Position', [.4284 0 .1428 .08] ...
            );
        set(twitter_btn, ...
            'Position', [.5712 0 .1428 .08] ...
            );
        set(license_btn, ...
            'Position', [.714 0 .1428 .08] ...
            );
        set(about_btn, ...
            'Position', [.8568 0 .1428 .08] ...
            );
    end

%% auxiliary
set(f, 'Visible', 'on')
for i = 2:cycles-1
    disable_panel(section_panel{i})
end
    function enable_panel(panel)
        set(panel, 'BackgroundColor', BKGCOLOR)
        childs = get(panel, 'Children');
        for i = 1:length(childs)
            set(childs(i), 'Enable', 'on');
            if isequal(childs(i).Style, 'pushbutton')
                set(childs(i), 'BackgroundColor', BTNBKGCOLOR);
            else
                set(childs(i), 'BackgroundColor', BKGCOLOR);
            end
        end
    end
    function disable_panel(panel)
        set(panel, 'BackgroundColor', [220,220,220]/255)
        childs = get(panel, 'Children');
        for i = 1:length(childs)
            set(childs(i), 'Enable', 'off');
            set(childs(i), 'BackgroundColor', [220,220,220]/255);
        end
    end
end