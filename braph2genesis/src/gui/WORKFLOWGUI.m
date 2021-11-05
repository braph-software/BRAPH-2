function h_workflow = WORKFLOWGUI(file, name,  varargin)
%% constants
screen_size = get(0, 'ScreenSize');
h_f = screen_size(4) * 0.25;
w_f = h_f * 3; % 1.61
x_f = 1;
y_f = screen_size(4) - h_f - 90;
name_w = ['Workflow - ' name];
f_position = get_from_varargin([x_f y_f w_f h_f], 'Position', varargin);
BKGCOLOR = get_from_varargin([1 .9725 .929], 'BackgroundColor', varargin);
BTNBKGCOLOR = get_from_varargin([.902 .835 .745], 'BackgroundColor', varargin);
close_request = get_from_varargin(1, 'CloseRequest', varargin); % false has to be true after debugs
tokens = [];
width_ct = 1;
heigth_ct = .5;
slider_width = 3;
min_height = 250;
min_width = 500;
object_gui_handles = [];

% get info of file
cycles = 1;
previous_workspace = get_from_varargin([], 'PreviousWorkSpace', varargin);
if ~isempty(previous_workspace)
    txt = get_from_varargin('', 'PreviousWorkSpaceText', varargin);
    cycles = get_from_varargin('', 'PreviousWorkSpaceCycles', varargin);

else
    txt = fileread(file);
    cycles = getFileCycles(txt);
    disable_cycle = 2;
end
    function cycles = getFileCycles(txt)
        splits = regexp(txt, ['(^|' newline() ')%%\s*'], 'split');
        splits = splits(~cellfun('isempty', splits));
        cycles = length(splits);
    end
    function [token, comments] = getGUIToken(txt, cycle)
        splits = regexp(txt, ['(^|' newline() ')%%\s*'], 'split');
        splits = splits(~cellfun('isempty', splits));
        for j = 1:1:length(splits)
            split_tmp = splits{j};
            if j == cycle
                in_splits = regexp(split_tmp, ['(^|' newline() ')%\s*'], 'split');
                in_splits = in_splits(~cellfun('isempty', in_splits));
                token = in_splits{1};
                if length(in_splits) > 1
                    comments = in_splits{2};
                    comments = comments(2:end);
                    for k = 3:length(in_splits)
                        comments = [comments newline() in_splits{k}]; %#ok<AGROW>
                    end
                    break
                end
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
            'Units', 'pixels', ...
            'Position', f_position, ...
            'Units', 'character', ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'Color', BKGCOLOR , ...
            'SizeChangedFcn', {@redraw}, ...
            'WindowButtonDownFcn', {@cb_get_objs_id} ...
            );
        set_icon(f)
        
        if close_request
            set(f, 'CloseRequestFcn', {@cb_close})
        end
    end
    
    function redraw(~, ~)
        panel_plot(false)
        set(f, 'Units', 'pixels')
        figure_size = getPosition(f);
        f_w = get(f, 'Position');
          
        % control min height
        if figure_size(4) < min_height             
            f.Position(4) = min_height;
        end
        if figure_size(3) < min_width
            f.Position(3) = min_width;
        end
        
        % control height changes in buttons and pannels
        if figure_size(4) > h_f + 100
            set(save_workflow_btn, ...
                'Position', [.0 0 .1428 .1] ...
                );
            set(load_workflow_btn, ...
                'Position', [.1428 0 .1428 .1] ...
                );
            set(website_btn, ...
                'Position', [.2856 0 .1428 .1] ...
                );
            set(forums_btn, ...
                'Position', [.4284 0 .1428 .1] ...
                );
            set(twitter_btn, ...
                'Position', [.5712 0 .1428 .1] ...
                );
            set(license_btn, ...
                'Position', [.714 0 .1428 .1] ...
                );
            set(about_btn, ...
                'Position', [.8568 0 .1428 .1] ...
                );
            
            set(ui_panels_section, ...
                'Position', [0 .1 1 .9]);
        else
            set(save_workflow_btn, ...
                'Position', [.0 0 .1428 .15] ...
                );
            set(load_workflow_btn, ...
                'Position', [.1428 0 .1428 .15] ...
                );
            set(website_btn, ...
                'Position', [.2856 0 .1428 .15] ...
                );
            set(forums_btn, ...
                'Position', [.4284 0 .1428 .15] ...
                );
            set(twitter_btn, ...
                'Position', [.5712 0 .1428 .15] ...
                );
            set(license_btn, ...
                'Position', [.714 0 .1428 .15] ...
                );
            set(about_btn, ...
                'Position', [.8568 0 .1428 .15] ...
                );
            
            set(ui_panels_section, ...
                'Position', [0 .15 1 .85]);

        end
        
        if figure_size(3) < w_f-1
            set(horizontal_slider, ...
                'Units', 'pixels',...
                'Position', [0 figure_size(4)*0.08+1 figure_size(3) 10], ...
                'Visible', 'on' ...
                )
            
            if figure_size(4) > h_f + 100
                set(ui_panels_section, ...
                    'Position', [0 .12 1 .88]);
                set(horizontal_slider, ...
                    'Position', [0 figure_size(4)*0.1+1 figure_size(3) 10] ...
                    );
            else
                set(ui_panels_section, ...
                    'Position', [0 .17 1 .83]);
                set(horizontal_slider, ...
                    'Position', [0 figure_size(4)*0.15+1 figure_size(3) 10] ...
                    );
            end
            
        else
            set(horizontal_slider, ...
                'Units', ' pixels', ...
                'Visible', 'off' ...
                );
            if figure_size(4) > h_f + 100
                set(ui_panels_section, ...
                    'Position', [0 .1 1 .9]);
            else
                set(ui_panels_section, ...
                    'Position', [0 .15 1 .85]);
            end
            panel_plot(true)
        end
    end
    function update_figure_title(title)
        set(f, 'Name', title)
    end

%% file name
ui_text_workflow_filename = uicontrol(f, 'Style','text');
init_filename()
    function init_filename()
        set(f, 'Units', 'pixels')
        figure_size = getPosition(f);
        set(ui_text_workflow_filename, ...
            'Units', 'pixels', ...
            'BackgroundColor', BKGCOLOR, ...
            'Position', [3 figure_size(4)*0.08+15 300 20], ...
            'HorizontalAlignment', 'left');
    end
    function update_filename(filename)
        set(ui_text_workflow_filename, 'String', filename)
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
ui_panels_section = uipanel(f, 'Units', 'normalized', 'Position', [0 .15 1 .85]);
horizontal_slider = uicontrol(f, 'Style', 'slider', 'Value', 1, 'Callback', {@cb_slide});
loaded_names = struct([]);

if ~isempty(previous_workspace)
    panel_struct = previous_workspace;
    disable_cycle = size(panel_struct, 1) + 1;
    panel_plot(false);
    load_struct();
else
    panel_plot(false)
end
    function panel_plot(isredraw)
        for i = 2:cycles
            cycle = i - 1 ; % remove title;
            x_offset = x_slice * (cycle - 1);
            token = getGUIToken(txt, i);
            tokens{i} = token; % saving purposes
            
            if isempty(section_panel{i - 1}) || ~isgraphics(section_panel{i - 1}, 'uipanel')
                define = true;
                section_panel{i - 1} = uipanel(ui_panels_section, 'BackgroundColor', BKGCOLOR);
            else
                define = false;
            end
            
            if isempty(slider{i - 1}) || ~isgraphics(slider{i - 1}, 'uicontrol') || isredraw
                slider{i - 1} = uicontrol(section_panel{i - 1}, 'Style', 'slider', 'Callback', {@slide});
                init_section_panel(section_panel{i - 1}, x_offset)
            end
            
            % set y
            set_y_section_panel(section_panel{i - 1})
            
            % get position
            set(section_panel{i - 1}, 'Units', 'characters')
            pos = getPosition(section_panel{i - 1});
            
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
                    decomp_exec = split(panel_executable{j}, '%');  % decomposition of the executable
                    if length(decomp_exec) > 1
                        btn_name = deblank(decomp_exec{2});
                        loaded_names(i - 1, j - 1).msg = deblank(decomp_exec{3});
                    else
                        btn_name = [panel_executable{1} ' ' num2str(j - 1)];
                    end
                    
                    set(panel_inner{i, j}, ...
                        'Style', 'pushbutton', ...
                        'String', btn_name, ...
                        'FontUnits', BRAPH2.FONTUNITS, ...
                        'FontSize', BRAPH2.FONTSIZE, ...
                        'Units', 'characters', ...
                        'Position', [width_ct pos(4)-y_offset pos(3)-2*slider_width y_slice], ...
                        'Callback', {@btn_action})
                else
                    set(panel_inner{i, j}, ...
                        'Style', 'text', ...
                        'String', panel_executable{1}, ...
                        'Units', 'characters', ...
                        'FontUnits', BRAPH2.FONTUNITS, ...
                        'FontSize', BRAPH2.FONTSIZE, ...
                        'Position', [width_ct pos(4)-y_offset pos(3)-2*slider_width y_slice])
                end
            end
            
            init_slider(slider{i - 1}, total_h, pos)
        end
    end
    function init_section_panel(panel, x_offset)
        set(panel, ...
            'Units', 'normalized', ...
            'Position', [x_offset 0 x_slice 1])
    end
    function set_y_section_panel(panel)
        panel.Units = 'normalized';
        panel.Position(2) = 0;
        panel.Position(4) = 1;
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
    function btn_action(src, ~)
        set(src, 'Enable', 'off')        
        for k = 1:size(panel_inner, 1)
            for j = 1:size(panel_inner, 2)
                obj_inner = panel_inner{k, j};
                if isequal(src, obj_inner)
                    panel = k-1;
                    child = j-1;
                end
            end
        end
        
        panel_exe_ = panel_executables{panel + 1};
        exe_ = split(panel_exe_{child + 1}, '=');
        
        % fill struct
        panel_struct(panel, child).name = ['panel_struct(' num2str(panel) ',' num2str(child) ').exe'];
        panel_struct(panel, child).name_script = strtrim(exe_{1});
        panel_struct(panel, child).btn = src.String;
        
        % change script for internal values
        exe_check = false;
        for l = 1:size(panel_struct, 2)
            if ~isempty(panel_struct) && size(panel_struct, 1) > 1 && panel ~= 1
                if ~isempty(panel_struct(panel - 1, l).name_script) && ~isempty(panel_struct(panel - 1, l).name)
                    tmp_pl = panel_struct(panel - 1, l).plot_element;
                    tmp_el = tmp_pl.get('EL');
                    inner_el = panel_struct(panel - 1, l).exe;
                    if ~isempty(tmp_pl) && ~isequal_shallow(inner_el, tmp_el)
                        % change to new obj
                        new_script = ['panel_struct(' num2str(panel-1) ',' num2str(child) ').plot_element.get(''' 'El' ''')'];
                        exe_{2} = strrep(exe_{2}, ...
                            panel_struct(panel - 1, l).name_script, ...
                            new_script);
                    else
                        exe_{2} = strrep(exe_{2}, ...
                            panel_struct(panel - 1, l).name_script, ...
                            panel_struct(panel - 1, l).name);
                    end
                end
            end
        end
        if isfield(panel_struct(panel, child), 'exe') && ~isempty(panel_struct(panel, child).exe)           
            tmp_pl = panel_struct(panel, child).plot_element;         
            if ~isempty(tmp_pl) && ~isequal_shallow(panel_struct(panel , child).exe, tmp_pl.get('EL'))
                % change to new obj
                panel_struct(panel, child).exe = tmp_pl.get('El');
                exe_check = true;
            else
                % use the object;
                exe_check = true;
            end
        else
            try
                panel_struct(panel, child).exe = eval([exe_{2}]);
                exe_check = true;
            catch e
                 if isequal(e.message, 'BugIO')
                     warndlg('Please select a valid file', 'Warning');
                 end
            end
        end
        
        if exe_check && ~isempty(panel_struct(panel, child).exe) && isa(panel_struct(panel, child).exe, 'Element')
            new_object =  panel_struct(panel, child).exe;
            [h_plot_element, h_fig] = GUI(new_object);
            object_gui_handles{end+1} = h_fig;
            panel_struct(panel, child).plot_element = h_plot_element;
            % change btn state. turn green and change string
            change_state_btn(src, new_object.get('ID'),  loaded_names(panel, child).msg)
            if check_section_objs(panel)
                enable_panel(section_panel{panel + 1})
            end
        end        
        set(src, 'Enable', 'on')
    end
    function check = check_section_objs(panel)
        check = false;
        n = length(panel_executables{panel + 1}) - 1 ;
        tmp = struct2cell(panel_struct);
        if panel + 1 <= length(section_panel) && ...
                (isequal(n, length(tmp(5, 1))) ||  isequal(n, length([tmp{5, panel, :}])))
            
            check = true;
        end
    end
    function change_state_btn(varargin)
        btn = varargin{1};
        
        if ~isempty(btn) && isgraphics(btn)
            if ~isequal(btn.Style,'text')
                set(btn, 'BackgroundColor', [166 218 149] / 255) % color
            end
            if length(varargin) > 1
                if ~isempty(varargin{2})
                    btn_new_name = [varargin{3} ' ' varargin{2}];
                    set(btn, 'String', btn_new_name); % id
                else % just default
                    set(btn, 'String', varargin{3}); % id
                end
            end
        else
            h_btn = panel_inner{varargin{5}, varargin{6}};
            if ~isempty(h_btn) && ~isequal(h_btn.Style,'text')
                set(h_btn, 'BackgroundColor', [166 218 149] / 255) % color
            end          
            if ~isempty(varargin{4})
                btn_new_name = [varargin{3} ' ' varargin{4}];
                set(btn, 'String', btn_new_name); % id
            else % just default
                set(btn, 'String', varargin{3}); % id
            end            
        end        
    end
    function pos = getPosition(obj)
        pos = get(obj, 'Position');
    end
    function slide(~, ~)
        for i = 1:length(slider)
            set(slider{i}, 'Visible', 'on')
        end
    end
    function cb_slide(~, ~)
        uf = get(section_panel{1}, 'Units');
        up = get(ui_panels_section, 'Units');
        set(ui_panels_section, 'Units', 'pixels');
        
        figure_size = getPosition(f);
        
        cellfun(@(x) set(x, 'Units', 'pixels'), section_panel, 'UniformOutput', false);
        
        fp = get(ui_panels_section, 'Position');
        fs = get(horizontal_slider, 'Position');
        
        dw = 1;
        w_up = cellfun(@(x) Plot.w(x), section_panel);       
        w_p = sum(w_up + dw) + dw;
        if w_p > figure_size(3)
            offset = get(horizontal_slider, 'Value');
            set(ui_panels_section, 'Position', [Plot.w(ui_panels_section)-figure_size(3)-offset fp(2) w_p fp(4)])
            
            set(horizontal_slider, ...
                'Position', [0 figure_size(4)*0.08+1 figure_size(3) 10], ...
                'Visible', 'on', ...
                'Min', Plot.w(ui_panels_section) - figure_size(3), ...
                'Max', Plot.w(ui_panels_section) - figure_size(3) + Plot.w(ui_panels_section) - figure_size(3) , ...
                'Value', max(get(horizontal_slider, 'Value'), Plot.w(ui_panels_section) - figure_size(3)) ...
                );
        else  
            set(ui_panels_section,'Units', 'normalized', 'Position', [0 .15 1 .85], 'Position', [0 0 figure_size(3) h(f)]);
        end
        
        set(ui_panels_section, 'Units', up);
        cellfun(@(x) set(x, 'Units', uf), section_panel, 'UniformOutput', false);
    end
    function cb_get_objs_id(~, ~)
        % load new ids.
        for i = 1:size(panel_struct, 1)
            for j = 1:size(panel_struct, 2)
                if isfield(panel_struct(i, j), 'plot_element') && ~isempty(panel_struct(i, j).plot_element)
                    obj = panel_struct(i, j).plot_element;
                    if isempty(obj)
                        continue;
                    else
                        tmp_el =  obj.get('EL');
                        btn = panel_struct(i, j).btn;
                        default_msg = loaded_names(i, j).msg;
                        change_state_btn([], tmp_el.get('ID'), default_msg, btn, i, j);
                    end
                end
            end
        end
    end
    function check = isequal_shallow(obj_a, obj_b)
        check = isa(obj_b, obj_a.getClass());
        if check
            for prop = 1:1:obj_a.getPropNumber()
                val_prop_a = obj_a.getr(prop);
                val_prop_b = obj_b.getr(prop);
                if isa(val_prop_a,'NoValue') || isa(val_prop_b,'NoValue')
                    check = check && (obj_a.isLocked(prop) == obj_b.isLocked(prop));
                elseif isa(val_prop_a, 'Element')
                    check = check && isequal(val_prop_a.get('ID'), val_prop_b.get('ID')) && (obj_a.isLocked(prop) == obj_b.isLocked(prop));
                else
                    % not an object
                    check = check && isequal(val_prop_a, val_prop_b) && (obj_a.isLocked(prop) == obj_b.isLocked(prop));
                end
                
            end
        end
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
            'Cdata', imread('saveicon.png'), ...
            'Tooltip', ['Save the workspace of ' name], ...
            'Position', [.0 0 .1428 .15], ...
            'BackgroundColor', [1 1 1], ...
            'Callback', {@cb_save_workspace})
        
        set(load_workflow_btn, ...
            'Cdata', imread('loadicon.png'), ...
            'Tooltip', ['Load the workspace of ' name], ...
            'Position', [.1428 0 .1428 .15], ...
            'BackgroundColor', [1 1 1], ...
            'Callback', {@cb_load_workspace})
        
        set(website_btn, ...
            'Position', [.2856 0 .1428 .15], ...
            'Tooltip', 'Click to visit BRAPH 2.0 website', ...
            'Cdata', imread('webicon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Callback', {@cb_website_btn});
        set(forums_btn, ...
            'Position', [.4284 0 .1428 .15], ...
            'Tooltip', 'Click to visit BRAPH 2.0 forums', ...
            'Cdata', imread('forum_icon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Callback', {@cb_forum_btn});
        set(twitter_btn, ...
            'Position', [.5712 0 .1428 .15], ...
            'Tooltip', 'Click to visit BRAPH 2.0 twitter', ...
            'Cdata', imread('twitter_icon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Callback', {@cb_twitter_btn});
        set(license_btn, ...
            'Position', [.714 0 .1428 .15], ...
            'Cdata', imread('licenseicon.png'), ...
            'BackgroundColor', [1 1 1], ...
            'Tooltip', 'Click to open BRAPH 2.0 License', ...
            'Callback', {@cb_license});
        set(about_btn, ...
            'Position', [.8568 0 .1428 .15], ...
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
    function cb_save_workspace(~, ~)
        % select file
        [file, path, filterindex] = uiputfile(BRAPH2.EXT_WORKSPACE, 'Select the file to save the workspace.');
        % save file
        if filterindex
            filename = fullfile(path, file);
            build = BRAPH2.BUILD;
            save(filename, 'panel_struct', 'txt', 'cycles', 'build');
            update_filename(filename);
        end
    end
    function cb_load_workspace(~, ~)
        [file, path, filterindex] = uigetfile(BRAPH2.EXT_WORKSPACE, 'Select the file to load a workspace.');
        if filterindex
            filename = fullfile(path, file);
            tmp = load(filename, '-mat', 'panel_struct');
            if isa(tmp.panel_struct, 'struct')
                panel_struct = tmp.panel_struct;
                load_struct();
                update_filename(filename)
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

%% menus
menu()
    function menu()
        ui_menu_file = uimenu(f, 'Label', 'Workspace');
        uimenu(ui_menu_file, ...
            'Label', 'Open ...', ...
            'Accelerator', 'O', ...
            'Callback', {@cb_load_workspace})
        uimenu(ui_menu_file, ...
            'Label', 'Save ...', ...
            'Accelerator', 'S', ...
            'Callback', {@cb_save_direct_workspace})
        uimenu(ui_menu_file, ...
            'Label', 'Save as ...', ...
            'Accelerator', 'A', ...
            'Callback', {@cb_save_workspace})
        uimenu(ui_menu_file, ...
            'Separator', 'on', ...
            'Label', 'Close', ...
            'Accelerator', 'C', ...
            'Callback', {@cb_close})
        
        ui_menu_workflow = uimenu(f, ...
            'Label', 'Workflow');
        uimenu(ui_menu_workflow, ...
            'Label', 'About ...', ...
            'Callback', {@cb_about_workflow})
        uimenu(ui_menu_workflow, ...
            'Label', 'Clone ...', ...
            'Callback', {@cb_save_workflow_braph2})
        uimenu(ui_menu_workflow, ...
            'Label', 'Export ...', ...
            'Callback', {@cb_export_workflow_braph2})
        
        
        ui_menu_about = uimenu(f, 'Label', 'About');
        
        uimenu(ui_menu_about, ...
            'Label', 'License ...', ...
            'Callback', {@cb_license})
        uimenu(ui_menu_about, ...
            'Label', 'About ...', ...
            'Callback', {@cb_about})
        
    end
    function cb_save_workflow_braph2(~, ~)
        % select file
        [fileoutput, path, filterindex] = uiputfile(BRAPH2.EXT_WORKFLOW, 'Select a workflow file name.');
        % save file
        if filterindex
            filename = fullfile(path, fileoutput);
            dlmwrite(filename, txt, 'delimiter', '')
        end
    end
    function cb_save_direct_workspace(~, ~)
        fn = get(ui_text_workflow_filename, 'String');
        if isempty(fn)
            cb_save_workspace();
        else
            build = BRAPH2.BUILD;
            save(fn, 'panel_struct', 'txt', 'cycles', 'build');
        end
    end
    function cb_about_workflow(~, ~)
        [tittle, msg] =  getGUIToken(txt, 1);
        msg = erase(msg, '%');
        CreateStruct.WindowStyle = 'modal';
        CreateStruct.Interpreter = 'tex';
        h = msgbox({'' ...
            ['{\bf\color{orange}' BRAPH2.STR '}'] ...
            '' ...
            tittle ...
            '' ...
            msg(2:end) ...
            '' ...
            ['{\color{gray}' BRAPH2.COPYRIGHT '}'] ...
            '' ...
            ''}, ...
            ['About: ' tittle], ...
            CreateStruct);
        set_icon(h)
    end
    function cb_export_workflow_braph2(~, ~)
        exp_h_f = screen_size(4) * 0.5;
        exp_w_f = exp_h_f * 1.61;
        exp_x_f = screen_size(3) * 0.3;
        exp_y_f = screen_size(4) * .2;
        export_fig = figure('Units', 'pixels', ...
            'Position', [exp_x_f exp_y_f exp_w_f exp_h_f], ...
            'Color', BKGCOLOR , ...
            'MenuBar', 'none', ...
            'DockControls', 'off', ...
            'NumberTitle', 'off' ...
            );
        
        ui_export_textbox = uicontrol(export_fig, ...
            'Style', 'edit', ...
            'Units', 'normalized', ...
            'Position', [.01 .1 .98 .9], ...
            'BackgroundColor', 'w', ...
            'Min', 0, ...
            'Max', 10000, ...
            'HorizontalAlignment', 'left' , ...
            'String', txt);
        ui_export_btn = uicontrol(export_fig, ...
            'Style', 'pushbutton', ...
            'Units', 'normalized', ...
            'Position', [.01 .01 .98 .08], ...
            'String', 'Export ...', ...
            'Callback', {@cb_export_btn});
        
        function cb_export_btn(~, ~)
            export_txt = get(ui_export_textbox, 'String');
            [fileoutput, path, filterindex] = uiputfile(BRAPH2.EXT_WORKFLOW, 'Select a workflow file name.');
            % save file
            if filterindex
                filename = fullfile(path, fileoutput);
                dlmwrite(filename, export_txt, 'delimiter', '')
            end
        end
    end

%% auxiliary
set(f, 'Visible', 'on')
[title, ~] =  getGUIToken(txt, 1);
update_figure_title(title)
for i = disable_cycle:cycles-1
    disable_panel(section_panel{i})
end
    function enable_panel(panel)
        if ~isequal(get(panel, 'BackgroundColor'), BKGCOLOR)
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
    end
    function disable_panel(panel)
        set(panel, 'BackgroundColor', [220,220,220]/255)
        childs = get(panel, 'Children');
        for i = 1:length(childs)
            set(childs(i), 'Enable', 'off');
            set(childs(i), 'BackgroundColor', [220,220,220]/255);
        end
    end
    function cb_close(~, ~)        
        if ~isempty(object_gui_handles)
            for m = 1:length(object_gui_handles)                
                wf_g = object_gui_handles{m};
                if isgraphics(ancestor(wf_g, 'Figure'))
                    close(ancestor(wf_g, 'Figure'))
                end                
            end
        end
        delete(f)
    end

    if nargout > 0
        h_workflow = f;
    end
    
end