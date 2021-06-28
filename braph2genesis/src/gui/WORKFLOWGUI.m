function WORKFLOWGUI(file, name,  varargin)
%% constants
screen_size = get(0, 'ScreenSize');
h_f = screen_size(4) * 0.65;
w_f = h_f * 1.61;
x_f = screen_size(3) * 0.2;
y_f = screen_size(4) * .2; 
name = ['Workflow - ' name];
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
            'Name', name, ...
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
panel_inner = [];
x_slice = 1 / (cycles - 1);
panel_executables = [];

for i = 2:cycles
    cycle = i - 1 ; % remove title;
    x_offset = x_slice * (cycle - 1);
    token = getGUIToken(txt, i);
    tokens{i} = token; %#ok<AGROW>  % saving purposes
    section_panel{i - 1} = uipanel(f);
    init_section_panel(section_panel{i - 1}, x_offset) 
    
    % get executables
    panel_executable = getExecutable(token);
    panel_executables{i} = panel_executable; %#ok<AGROW>
    y_slice = 1 / length(panel_executable);
    for j = 1:length(panel_executable) + 1 % need to add panel name
        panel_inner{i, j} = uicontrol(section_panel{i - 1}); %#ok<AGROW>
        y_offset = y_slice * (j - 1);
        if j > 1
            set(panel_inner{i, j}, ...
               'Style', 'pushbutton', ...
               'String', [panel_executable{1} ' ' num2str(j - 1)], ...
               'Units', 'normalized', ...
               'BackgroundColor', BTNBKGCOLOR, ...
               'Position', [.02 y_offset .96 .08], ...
               'Callback', {@(x, y) btn_action(i, j)}) 
        else
           set(panel_inner{i, j}, ...
               'Style', 'text', ...
               'String', panel_executable{1}, ...
               'Units', 'normalized', ...
               'BackgroundColor', BKGCOLOR, ...
               'Position', [.3 .9 .3 .08]) 
        end
        
    end
end

    function init_section_panel(panel, x_offset)
        set(panel, ...
            'Units', 'normalized', ...
            'Position', [x_offset .02 x_slice .96], ...
            'BackgroundColor', BKGCOLOR)
    end
    function btn_action(panel, child)        
        panel_exe_ = panel_executables{panel};
        exe_ = split(panel_exe_{child}, '=');
        for l = 1:length(panel_struct)
            if ~isempty(panel_struct)
                exe_{2} = strrep(exe_{2}, ...
                    panel_struct(panel - 1, child - 1).name_script, ...
                    panel_struct(panel - 1, child - 1).name);
            end
        end
        panel_struct(panel - 1, child - 1).exe = eval([exe_{2}]);
        panel_struct(panel - 1, child - 1).name = ['panel_struct(' num2str(panel - 1) ',' num2str(child - 1) ').exe'];
        panel_struct(panel - 1, child - 1).name_script = strtrim(exe_{1});
        
        if ~isempty(panel_struct(panel - 1, child - 1).exe) && isa(panel_struct(panel - 1, child - 1).exe, 'Element')
            GUI(panel_struct(panel - 1, child - 1).exe)
            enable_panel(section_panel{panel}) % no need to add, since its offet by 1
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
            set(childs(i), 'BackgroundColor', BKGCOLOR);
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