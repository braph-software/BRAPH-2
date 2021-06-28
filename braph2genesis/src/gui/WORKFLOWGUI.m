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
% get info of file
txt = fileread(file);
cycles = getFileCycles(txt);
% for i = 1:cycles
%     tokens{i} = getGUIToken(txt, i);
% end
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

%% panels
panel_struct = struct([]);
section_panel = cell(1, cycles - 1);  % cycles - title
slider = cell(1, cycles - 1);
panel_inner = [];
x_slice = 1 / (cycles - 1);
panel_executables = [];

for i = 2:cycles
    cycle = i - 1 ; % remove title;
    x_offset = x_slice * (cycle - 1);
    token = getGUIToken(txt, i);
    tokens{i} = token; %#ok<AGROW>  % saving purposes
    section_panel{i - 1} = uipanel(f);
    slider{i - 1} = uicontrol(section_panel{i - 1});
    
    % init
    init_section_panel(section_panel{i - 1}, x_offset)
    
    % get executables
    panel_executable = getExecutable(token);
    panel_executables{i} = panel_executable; %#ok<AGROW>
    y_slice = .15;
    total_h = 0;
    for j = 1:length(panel_executable) 
        panel_inner{i, j} = uicontrol(section_panel{i - 1}); %#ok<AGROW>
        y_offset = y_slice * (j - 1);
        total_h = total_h + y_slice;
        if j > 1
            set(panel_inner{i, j}, ...
               'Style', 'pushbutton', ...
               'String', [panel_executable{1} ' ' num2str(j - 1)], ...
               'Units', 'normalized', ...
               'BackgroundColor', BTNBKGCOLOR, ...
               'Position', [.02 1-y_offset .94 .08], ...
               'Callback', {@(src, x, y) btn_action(src, i - 1, j- 1)}) 
        else
           set(panel_inner{i, j}, ...
               'Style', 'text', ...
               'String', panel_executable{1}, ...
               'Units', 'normalized', ...
               'BackgroundColor', BKGCOLOR, ...
               'Position', [.34 .9 .3 .08]) 
        end        
    end
    
    init_slider(slider{i - 1}, total_h)
end

    function init_section_panel(panel, x_offset)
        set(panel, ...
            'Units', 'normalized', ...
            'Position', [x_offset .1 x_slice .9], ...
            'BackgroundColor', BKGCOLOR)
    end
    function init_slider(slider, total_h)
        if total_h > 1
        set(slider, ...
            'Style', 'slider', ...
            'Value', 0, ...
            'Visible', 'on', ...
            'Units', 'normalized', ...
            'Min', 0, ...
            'Max', total_h, ...
            'Position', [.96 0 .04 1])
        else
            set(slider, ...
            'Style', 'slider', ...
            'Value', 0, ...
            'Visible', 'off', ...
            'Units', 'normalized', ...
            'Position', [.96 0 .04 1])
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
            if panel + 1 <= length(section_panel)
                enable_panel(section_panel{panel + 1})
                set(src, 'Cdata', imread('checkicon_colorbackground.png'))
            end
        end
    end

%% load and save 
save_workflow_btn = uicontrol(f);
load_workflow_btn = uicontrol(f);
init_load_and_save()
    function init_load_and_save()
        set(save_workflow_btn, ...
            'Units', 'normalized', ...
            'Style', 'pushbutton', ...
            'String', 'Save ...', ...
            'Tooltip', ['Save the workspace of ' name], ...
            'Position', [.2 .01 .3 .07], ...
            'Callback', {@cb_save_worfklow})
        
        set(load_workflow_btn, ...
            'Units', 'normalized', ...
            'Style', 'pushbutton', ...
            'String', 'Load ...', ...
            'Tooltip', ['Load the workspace of ' name], ...
            'Position', [.52 .01 .3 .07], ...
            'Callback', {@cb_load_worfklow})
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
            if i + 1 <= length(section_panel)
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
                    set(childs_(k), 'Cdata', imread('checkicon_colorbackground.png'))
                end
            end
        end
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