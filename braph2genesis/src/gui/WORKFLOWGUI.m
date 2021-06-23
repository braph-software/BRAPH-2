function WORKFLOWGUI(file, varargin)
%% constants
screen_size = get(0, 'ScreenSize');
h_f = screen_size(4) * 0.65;
w_f = h_f * 1.61;
x_f = screen_size(3) * 0.2;
y_f = screen_size(4) * .2; 
f_position = get_from_varargin([x_f y_f w_f h_f], 'Position', varargin);
name = 'Workflow';
BKGCOLOR = get_from_varargin([1 .9725 .929], 'BackgroundColor', varargin);
close_request = 0; % false has to be true after debugs
tokens = [];
% get info of file
txt = fileread(file);
cycles = getFileCycles(txt);
for i = 1:cycles
    tokens{i} = getGUIToken(txt, i);
end
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

%% atlas panel
atlas_vars = getExecutable(tokens{2});
% declare atlas variables
ba = [];

atlas_panel = uipanel(f);
if length(atlas_vars) >= 2
    ui_atlas_panel_name = uicontrol(atlas_panel);
    ui_atlas_btn = uicontrol(atlas_panel);
end

init_atlas_panel()
    function init_atlas_panel()
        set(atlas_panel, ...
            'Units', 'normalized', ...
            'Position', [.02 .02 .31 .96], ...
            'BackgroundColor', BKGCOLOR)
        if length(atlas_vars) >= 2
            
            set(ui_atlas_panel_name, ...
                'Style', 'text', ...
                'Units', 'normalized', ...
                'String', atlas_vars{1}, ...
                'BackgroundColor', BKGCOLOR, ...
                'Position', [.3 .9 .3 .08] ...
                )
            
             set(ui_atlas_btn, ...
                'Style', 'pushbutton', ...
                'String', 'BrainAtlas', ...
                'Units', 'normalized', ...
                'Position', [.02 .75 .96 .08], ...
                'Callback', {@cb_atlas_btn} ...
                )
        end
        
    end
    function cb_atlas_btn(~, ~)
        executable = split(atlas_vars{2}, '=');
        ba = eval([executable{2}]);   
        if ~isempty(ba) && isa(ba, 'BrainAtlas')
           GUI(ba)
           enable_panel(group_panel)
        end        
    end
    
%% group panel
group_vars = getExecutable(tokens{3});
% declare atlas variables
grs = struct;
group_panel = uipanel(f);
if length(group_vars) >= 2
    ui_group_panel_name = uicontrol(group_panel);
    ui_group_btns = zeros(length(group_vars) - 1 , 1);
    for k = 2:length(group_vars)
        ui_group_btns(k, 1) = uicontrol(group_panel);
    end    
end
init_group_panel()
    function init_group_panel()
        set(group_panel, ...
            'Units', 'normalized', ...
            'Position', [.33 .02 .33 .96], ...
            'BackgroundColor', BKGCOLOR)
        
        if length(group_vars) >= 2            
            set(ui_group_panel_name, ...
                'Style', 'text', ...
                'Units', 'normalized', ...
                'String', group_vars{1}, ...
                'BackgroundColor', BKGCOLOR, ...
                'Position', [.3 .9 .3 .08] ...
                )
            
            inner_panel_height = .8;
            for k = 2:length(group_vars)
                y_correction = (k-1) * 0.09;
                inner_panel_y = inner_panel_height - y_correction;
                set(ui_group_btns(k), ...
                'Style', 'pushbutton', ...
                'String', ['Group ' num2str(k - 1)], ...
                'Units', 'normalized', ...
                'Position', [.02 inner_panel_y .96 .08], ...
                'Callback', {@cb_group_btn} ...
                )
            end
        end
    end
    function cb_group_btn(src, ~)
        source_group = str2double(erase(src.String, 'Group '));
        executable = split(group_vars{source_group + 1}, '=');
        grs(source_group).group = eval([executable{2}]);
        grs(source_group).name = ['grs(' num2str(source_group) ').group'];
        grs(source_group).name_script = strtrim(executable{1});
        if ~isempty(grs(source_group).group) && isa(grs(source_group).group, 'Group')
           GUI(grs(source_group).group)
           enable_panel(analysis_panel)
        end        
    end

%% analysis 
% declare analysis variables
analysis_vars = getExecutable(tokens{4});
analysis_ = struct;
analysis_comparisons_panel = uipanel(f, ...
    'Units', 'normalized', ...
    'Position', [.66 .02 .31 .96], ...
    'BackgroundColor', BKGCOLOR);

analysis_panel = uipanel(analysis_comparisons_panel);
if length(analysis_vars) >= 2
    ui_analysis_panel_name = uicontrol(analysis_panel);
    ui_analysis_btns = zeros(length(analysis_vars) - 1 , 1);
    for k = 2:length(analysis_vars)
        ui_analysis_btns(k, 1) = uicontrol(analysis_panel);
    end    
end

%declare comparisons
if cycles > 4
    comparisons_vars = getExecutable(tokens{5});
    comparisons_ = cell(length(comparisons_vars) - 1 , 1);
    comparisons_panel = uipanel(analysis_comparisons_panel);
    if length(comparisons_vars) >= 2
        ui_comparisons_panel_name = uicontrol(comparisons_panel);
        ui_comparisons_btns = zeros(length(comparisons_panel) - 1 , 1);
        for k = 2:length(comparisons_vars)
            ui_comparisons_btns(k, 1) = uicontrol(comparisons_panel);
        end
    end
end

init_analysis_panel()
    function init_analysis_panel()
        set(analysis_panel, ...
            'Units', 'normalized', ...
            'Position', [.02 .02 .96 .96], ...
            'BackgroundColor', BKGCOLOR)
        
        if length(analysis_vars) >= 2
            set(ui_analysis_panel_name, ...
                'Style', 'text', ...
                'Units', 'normalized', ...
                'String', analysis_vars{1}, ...
                'BackgroundColor', BKGCOLOR, ...
                'Position', [.3 .9 .3 .08] ...
                )
            
            inner_panel_height = .8;
            for k = 2:length(analysis_vars)
                y_correction = (k-1) * 0.09;
                inner_panel_y = inner_panel_height - y_correction;
                set(ui_analysis_btns(k), ...
                    'Style', 'pushbutton', ...
                    'String', ['Analsysis ' num2str(k - 1)], ...
                    'Units', 'normalized', ...
                    'Position', [.02 inner_panel_y .96 .08], ...
                    'Callback', {@cb_analysis_btn} ...
                    )
            end
        end
        
        if cycles > 4
            set(analysis_panel, ...
                'Units', 'normalized', ...
                'Position', [.02 .45 .96 .53], ...
                'BackgroundColor', BKGCOLOR)
            
            set(comparisons_panel, ...
                'Units', 'normalized', ...
                'Position', [.02 .01 .98 .43], ...
                'BackgroundColor', BKGCOLOR)
            
            if length(comparisons_vars) >= 2
                set(ui_comparisons_panel_name, ...
                    'Style', 'text', ...
                    'Units', 'normalized', ...
                    'String', comparisons_vars{1}, ...
                    'BackgroundColor', BKGCOLOR, ...
                    'Position', [.3 .9 .3 .08] ...
                    )
                
                inner_panel_height = .8 / (length(comparisons_vars) - 1);
                for k = 2:length(comparisons_vars)
                    y_correction = (k-1) * 0.09;
                    inner_panel_y = inner_panel_height - y_correction;
                    set(ui_comparisons_btns(k), ...
                        'Style', 'pushbutton', ...
                        'String', ['Comparison ' num2str(k - 1)], ...
                        'Units', 'normalized', ...
                        'Position', [.02 inner_panel_y .96 .08], ...
                        'Callback', {@cb_comparison_btn} ...
                        )
                end
            end
            disable_panel(comparisons_panel);
        end
    end
    function cb_analysis_btn(src, ~)
        source_analysis = str2double(erase(src.String, 'Analsysis '));
        executable = split(analysis_vars{source_analysis + 1}, '=');
        for l = 1:length(grs)
            executable{2} = strrep(executable{2}, grs(source_analysis).name_script , grs(source_analysis).name);
        end        
        
        analysis_(source_analysis).analysis = eval([executable{2}]);
        analysis_(source_analysis).name = ['analysis_(' num2str(source_analysis) ').analysis'];
        analysis_(source_analysis).name_script = strtrim(executable{1});
        
        if ~isempty(analysis_(source_analysis).analysis) && isa(analysis_(source_analysis).analysis, 'Element')
            GUI(analysis_(source_analysis).analysis)
            enable_panel(comparisons_panel);
        end        
    end
    function cb_comparison_btn(src, ~)
        source_comparison = str2double(erase(src.String, 'Comparison '));
        executable = split(comparisons_vars{source_comparison + 1}, '=');
        for l = 1:length(analysis_)
            executable{2} = strrep(executable{2}, analysis_(source_comparison).name_script , analysis_(source_comparison).name);
        end        
        
        comparisons_(source_comparison).comparison = eval([executable{2}]);
        comparisons_(source_comparison).name = ['comparisons_(' num2str(source_comparison) ').comparison'];
        comparisons_(source_comparison).name_script = strtrim(executable{1});
        
        if ~isempty(comparisons_(source_comparison).comparison) && isa(comparisons_(source_comparison).comparison, 'Element')
            GUI(comparisons_(source_comparison).comparison)
        end 
    end

%% auxiliary
set(f, 'Visible', 'on')
disable_panel(group_panel)
disable_panel(analysis_panel)
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