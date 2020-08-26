function GUIComparison(comparison_class, analysis, measure_rules)
% GUICOMPARISON creates a UI figure to specify Comparison settings
%
% GUICOMPARISON(COMPARISON_CLASS, ANALYSIS) creates a UI
% figure where the user specifies the Analysis Comparison
% Settings.
%
% See also getChildPanel.

% variables
mlist = Graph.getCompatibleMeasureList(analysis.getGraphType());
selected_calc = [];
stop = false;
start = 0;

% commands
NAME = ['Analysis Comparison for: ' analysis.getID()];

CALC_SELECTED_COL = 1;
CALC_NAME_COL = 2;
CALC_FORMAT_COL = 3;
CALC_SCOPE_COL = 4;
CALC_TXT_COL = 5;

CALC_GLOBAL = 'Global';
CALC_NODAL = 'Nodal';
CALC_BINODAL = 'Binodal';
CALC_SUPERGLOBAL = 'Superglobal';
CALC_UNILAYER = 'Unilayer';
CALC_BILAYER = 'Bilayer';

SELECTALL_CALC_CMD = GUI.SELECTALL_CMD;
SELECTALL_CALC_TP = 'Select all measures';

CLEARSELECTION_CALC_CMD = GUI.CLEARSELECTION_CMD;
CLEARSELECTION_CALC_TP = 'Clear measure selection';

SELECTGLOBAL_CALC_CMD = 'Select Global';
SELECTGLOBAL_CALC_TP = 'Select all global measures';

SELECTNODAL_CALC_CMD = 'Select Nodal';
SELECTNODAL_CALC_TP = 'Select all nodal measures';

SELECTBINODAL_CALC_CMD = 'Select Binodal';
SELECTBINODAL_CALC_TP = 'Select all Binodal measures';

% figure
f = GUI.init_figure(NAME, .35, .6, 'west');

% dynamic variables
handle_child_panel = [];

% Main Panel
PANEL_POSITION = [0 0 1 1];

ui_panel = uipanel();

ui_calc_table = uitable(ui_panel);
ui_calc_selectall_button = uicontrol(ui_panel, 'Style', 'pushbutton');
ui_calc_clear_button = uicontrol(ui_panel, 'Style', 'pushbutton');
ui_calc_global_button = uicontrol(ui_panel, 'Style', 'pushbutton');
ui_calc_nodal_button = uicontrol(ui_panel, 'Style', 'pushbutton');
ui_calc_binodal_button = uicontrol(ui_panel, 'Style', 'pushbutton');

ui_popup_group_1 = uicontrol(ui_panel, 'Style', 'popup', 'String', {''});
ui_popup_group_2 = uicontrol(ui_panel, 'Style', 'popup', 'String', {''});
ui_edit_info = uicontrol(ui_panel, 'Style', 'edit');
ui_button_stop = uicontrol(ui_panel, 'Style', 'pushbutton');
ui_button_resume = uicontrol(ui_panel, 'Style', 'pushbutton');

ui_child_panel = uipanel(ui_panel);  % child panel

init_calculate()
init_child_panel()
update_popups_grouplists()
update_tab()

% Menu
[ui_menu_about,ui_menu_about_about] = GUI.setMenuAbout(f, NAME); %#ok<ASGLU>

% Make the GUI visible.
set(f, 'Visible', 'on');

% callbacks
    function init_calculate()
        GUI.setUnits(ui_panel)
        GUI.setBackgroundColor(ui_panel)
        
        set(ui_panel, 'Position', PANEL_POSITION)
        set(ui_panel, 'BorderType', 'none')
        
        set(ui_calc_table, 'BackgroundColor', GUI.TABBKGCOLOR)
        set(ui_calc_table, 'Position', [.01 .7 .98 .29])
        set(ui_calc_table, 'ColumnName', {'', '   Brain Measure   ', ' Format ', ' Scope ',  '   notes   '})
        set(ui_calc_table, 'ColumnFormat', {'logical', 'char', {CALC_GLOBAL CALC_NODAL CALC_BINODAL}, {CALC_SUPERGLOBAL CALC_UNILAYER CALC_BILAYER}, 'char'})
        set(ui_calc_table, 'ColumnEditable', [true false false false false])
        set(ui_calc_table, 'ColumnWidth', {GUI.width(f, .98 * 0.1), GUI.width(f, .98 * 0.1), GUI.width(f, .98 * 0.1), GUI.width(f, .98 * 0.1), GUI.width(f, .98 * 0.51)})
        set(ui_calc_table, 'CellEditCallback', {@cb_calc_edit});
        
        set(ui_calc_selectall_button, 'Position', [.01 .64 .21 .04])
        set(ui_calc_selectall_button, 'String', SELECTALL_CALC_CMD)
        set(ui_calc_selectall_button, 'TooltipString', SELECTALL_CALC_TP)
        set(ui_calc_selectall_button, 'Callback', {@cb_calc_selectall})
        
        set(ui_calc_clear_button, 'Position', [.01 .59 .21 .04])
        set(ui_calc_clear_button, 'String', CLEARSELECTION_CALC_CMD)
        set(ui_calc_clear_button, 'TooltipString', CLEARSELECTION_CALC_TP)
        set(ui_calc_clear_button, 'Callback', {@cb_calc_clearselection})
        
        set(ui_calc_global_button, 'Position', [.24 .64 .21 .04])
        set(ui_calc_global_button, 'String', SELECTGLOBAL_CALC_CMD)
        set(ui_calc_global_button, 'TooltipString', SELECTGLOBAL_CALC_TP)
        set(ui_calc_global_button, 'Callback', {@cb_calc_global})
        
        set(ui_calc_nodal_button, 'Position', [.24 .59 .21 .04])
        set(ui_calc_nodal_button, 'String', SELECTNODAL_CALC_CMD)
        set(ui_calc_nodal_button, 'TooltipString', SELECTNODAL_CALC_TP)
        set(ui_calc_nodal_button, 'Callback', {@cb_calc_nodal})
        
        set(ui_calc_binodal_button, 'Position', [.24 .54 .21 .04])
        set(ui_calc_binodal_button, 'String', SELECTBINODAL_CALC_CMD)
        set(ui_calc_binodal_button, 'TooltipString', SELECTBINODAL_CALC_TP)
        set(ui_calc_binodal_button, 'Callback', {@cb_calc_binodal})
        
        set(ui_popup_group_1, 'Position', [.01 .40 .44 .1])
        set(ui_popup_group_1, 'TooltipString', 'Select group 1');
        
        set(ui_popup_group_2, 'Position', [.01 .3 .44 .1])
        set(ui_popup_group_2, 'TooltipString', 'Select group 1');
        
        set(ui_edit_info, 'BackgroundColor', [1 1 1])
        set(ui_edit_info, 'Position', [.01 .08 .98 .15])
        set(ui_edit_info, 'Max',2)
        set(ui_edit_info, 'HorizontalAlignment', 'left')
        set(ui_edit_info, 'Enable', 'inactive')
        
        set(ui_button_stop, 'Position', [.25 .02 .25 .04])
        set(ui_button_stop, 'String', 'Calculate measures')
        set(ui_button_stop, 'Callback', {@cb_stop})
        
        set(ui_button_resume, 'Position', [.51 .02 .25 .04])
        set(ui_button_resume, 'String', 'Resume')
        set(ui_button_resume, 'Enable', 'off')
        set(ui_button_resume, 'Callback', {@cb_resume})
        
        set(ui_child_panel, 'Units', 'normalized')
        set(ui_child_panel, 'Position', [.46 .25 .53 .44])
        
    end
    function init_child_panel()
        handle_child_panel = Comparison.getComparisonSettingsPanel(comparison_class, analysis, ui_child_panel);
    end
    function deactivate_components()
        set(ui_calc_table, 'Enable', 'off')
        set(ui_calc_selectall_button, 'Enable', 'off')
        set(ui_calc_clear_button, 'Enable', 'off')
        set(ui_calc_global_button, 'Enable', 'off')
        set(ui_calc_nodal_button, 'Enable', 'off')
        set(ui_calc_binodal_button, 'Enable', 'off')
        set(ui_popup_group_1, 'Enable', 'off')
        set(ui_popup_group_2, 'Enable', 'off')
    end
    function activate_components()
        set(ui_calc_table, 'Enable', 'on')
        set(ui_calc_selectall_button, 'Enable', 'on')
        set(ui_calc_clear_button, 'Enable', 'on')
        set(ui_calc_global_button, 'Enable', 'on')
        set(ui_calc_nodal_button, 'Enable', 'on')
        set(ui_calc_binodal_button, 'Enable', 'on')
        set(ui_popup_group_1, 'Enable', 'on')
        set(ui_popup_group_2, 'Enable', 'on')
    end
    function cb_stop(src, ~)  % (src,event)
        deactivate_components()
        start = tic;
        if strcmp(get(src, 'String'), 'Calculate measures')
            if analysis.getCohort().getGroups().length() > 0
                if isempty(selected_calc)
                    errordlg('Select measures to be calculated', 'Select measures', 'modal');
                    activate_components()
                else
                    set(ui_button_stop, 'String', 'stop')
                    group_1 = get(ui_popup_group_1, 'Value');
                    group_2 = get(ui_popup_group_2, 'Value');
                    mlist = mlist(selected_calc);
                    
                    calculate(analysis, mlist, group_1, group_2)
                end
            else
                errordlg('Define a group in order to perform calculations', 'Define a group', 'modal');
                activate_components()
            end
            
        else
            if strcmp(get(src, 'String'), 'stop')
                set(ui_button_stop, 'String', 'Calculate measures')
                set(ui_button_stop, 'Enable', 'off')
                set(ui_button_resume, 'Enable', 'on')
                stop = true;
            end
        end
        set(ui_button_stop, 'String', 'Calculate measures')
    end
    function cb_resume(~, ~)  % (src,event)
        stop = false;
        set(ui_button_stop, 'Enable', 'on')
        set(ui_button_resume, 'Enable', 'off')
        set(ui_button_stop, 'String', 'stop')
        group_1 = get(ui_popup_group_1, 'Value');
        group_2 = get(ui_popup_group_2, 'Value');
        
        calculate(analysis, mlist(selected_calc), group_1, group_2)
    end
    function update_tab()
        data = cell(length(mlist), 3);
        for mi = 1:1:length(mlist)
            if any(selected_calc == mi)
                data{mi, CALC_SELECTED_COL} = true;
            else
                data{mi, CALC_SELECTED_COL} = false;
            end
            data{mi, CALC_NAME_COL} = Measure.getName(mlist{mi});
            if Measure.is_nodal(mlist{mi})
                data{mi, CALC_FORMAT_COL} = CALC_NODAL;
            elseif Measure.is_global(mlist{mi})
                data{mi, CALC_FORMAT_COL} = CALC_GLOBAL;
            else
                data{mi, CALC_FORMAT_COL} = CALC_BINODAL;
            end
            
            if Measure.is_superglobal(mlist{mi})
                data{mi, CALC_SCOPE_COL} = CALC_SUPERGLOBAL;
            elseif Measure.is_unilayer(mlist{mi})
                data{mi, CALC_SCOPE_COL} = CALC_UNILAYER;
            else
                data{mi, CALC_SCOPE_COL} = CALC_BILAYER;
            end
            
            data{mi, CALC_TXT_COL} = Measure.getDescription(mlist{mi});
        end
        set(ui_calc_table, 'Data', data)
    end
    function cb_calc_edit(~, event)  % (src,event)
        mi = event.Indices(1);
        col = event.Indices(2);
        newdata = event.NewData;
        switch col
            case CALC_SELECTED_COL
                if newdata==1
                    selected_calc = sort(unique([selected_calc(:); mi]));
                else
                    selected_calc = selected_calc(selected_calc~=mi);
                end
        end
    end
    function cb_calc_selectall(~, ~)  % (src,event)
        selected_calc = (1:1:length(mlist))';
        update_tab()
    end
    function cb_calc_clearselection(~, ~)  % (src,event)
        selected_calc = [];
        update_tab()
    end
    function cb_calc_global(~, ~)  % (src,event)
        selected_calc = [];
        for mi = 1:1:length(mlist)
            if Measure.is_global(mlist{mi})
                selected_calc = [selected_calc; mi]; %#ok<AGROW>
            end
        end
        update_tab()
    end
    function cb_calc_nodal(~, ~)  % (src,event)
        selected_calc = [];
        for mi = 1:1:length(mlist)
            if Measure.is_nodal(mlist{mi})
                selected_calc = [selected_calc; mi]; %#ok<AGROW>
            end
        end
        update_tab()
    end
    function cb_calc_binodal(~, ~)
        selected_calc = [];
        for mi = 1:1:length(mlist)
            if Measure.is_binodal(mlist{mi})
                selected_calc = [selected_calc; mi]; %#ok<AGROW>
            end
        end
        update_tab()
    end

% Auxilary functions
    function update_popups_grouplists()
        if analysis.getCohort().getGroups().length() > 0
            % updates group lists of popups
            GroupList = {};
            for g = 1:1:analysis.getCohort().getGroups().length()
                group = analysis.getCohort().getGroups().getValue(g);
                GroupList{g} = group.getID(); %#ok<AGROW>
            end
        else
            GroupList = {''};
        end
        set(ui_popup_group_1, 'String', GroupList)
        set(ui_popup_group_2, 'String', GroupList)
    end
    function calculate(analysis, mlist, g_1, g_2)
        L = 100;
        txt = cell(1, L);
        
        if isempty(handle_child_panel.variables)
            rule = '';
            value = '';
            
        else
            if contains('threshold', handle_child_panel.variables)
                rule = 'threshold';
                value =  getappdata(ui_child_panel, 'threshold');
            elseif contains('density', handle_child_panel.variables)
                rule = 'density';
                value = getappdata(ui_child_panel, 'density');
            end
        end
        
        disable_child_panel()
        
        group_1 = analysis.getCohort().getGroups().getValue(g_1);
        group_2 = analysis.getCohort().getGroups().getValue(g_2);
        for mi = 1:1:length(mlist)
            % missing the measuremente parameters
            if length(value) > 1
                for vals = 1:1:length(value)
                    value_step = value(vals);
                    m = analysis.getComparison(mlist{mi}, group_1, group_2, rule, value_step, ...
                        'PermutationNumber', getappdata(ui_child_panel, 'permutation'), measure_rules{:});
                end
            else
                m = analysis.getComparison(mlist{mi}, group_1, group_2, rule, value, ...
                    'PermutationNumber', getappdata(ui_child_panel, 'permutation'), measure_rules{:});
            end
            msg = ['time = ' int2str(toc(start)) '.' int2str(mod(toc(start)*10, 10)) 's - group = ' int2str(g_1) ' - ' mlist{mi}];
            
            % visualize status
            txt(2:L) = txt(1:L - 1);
            txt{1} = msg;
            set(ui_edit_info, 'String', txt)
            
            pause(.001)
            
            if stop
                break
            end
        end
        
        if (isempty(mlist) || mi==length(mlist))
            txt(4:L) = txt(1:L-3);
            txt{1} = 'DONE!!!';
            txt{2} = ['time = ' int2str(toc(start)) '.' int2str(mod(toc(start)*10,10)) 's'];
            txt{3} = '';
            set(ui_edit_info, 'String',txt)
            
            set(ui_button_stop, 'Enable', 'off')
            set(ui_button_resume, 'Enable', 'off')
        end
    end
    function disable_child_panel()
        set(handle_child_panel.permutation, 'enable', 'off')
        if ~isempty(handle_child_panel.variables)
            set(handle_child_panel.step, 'enable', 'off')
            set(handle_child_panel.min, 'enable', 'off')
            set(handle_child_panel.max, 'enable', 'off')
        end
    end

end