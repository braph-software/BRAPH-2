classdef Comparison < handle & matlab.mixin.Copyable
    % Comparison (Abstract) A comparison
    % Comparison provides the methods necessary for all comparisons.
    % It is a subclass of handle & matlab.mixin.Copyable.
    %
    % Comparison provides the methods necessary for all comparisons
    % subclasses. Instances of this class cannot be created. Use on of the
    % subclases. The subclasses must be created inside the corresponding
    % workflow ./braph2/workflows/...
    %
    % Comparison Constructor methods (Access=protected)
    %  Comparison                  - Constructor
    %
    % Comparison Basic methods
    %  tostring                     - returns a string representing the class
    %  disp                         - displays the comparison
    %  
    % Comparison set methods
    %  setID                        - sets the ID
    %  setLabel                     - sets the label
    %  setNotes                     - sets the notes
    %  setBrainAtlases              - sets the atlases to the comparison
    %  setGroup                     - sets a group to the comparison
    %
    % Comparison get methods 
    %  getID                        - returns the ID
    %  getLabel                     - returns the label
    %  getNotes                     - returns the notes
    %  getBrainAtlases              - returns the atlases
    %  getMeasureCode               - returns the measure code
    %  getGroup                     - returns the group
    %  getSettings                  - returns the settings structure
    % 
    % Comparison descriptive methods (Static)
    %  getList                  - returns a list of comparison subclasses
    %  getClass                 - returns the class of the comparison
    %  getName                  - returns the name of the comparison
    %  getDescription           - returns the description of the comparison
    %  getBrainAtlasNumber      - returns the number of atlases
    %  getAnalysisClass         - returns the class of the analysis
    %  getSubjectClass          - returns the class of the subject
    %  getAvailableSettings     - returns available settings to the comparison
    %  getRandomComparion       - returns a new comparison
    %
    % Comparison Plot methods (Static)
    %  getComparisonPanel       - creates a UI Figure for Comparison Settings
    %  getChildPanel            - returns a dynamic UIPanel
    %
    % See also Analysis, Measurement, RandomComparison.
    
    properties (GetAccess=protected, SetAccess=protected)
        id  % unique identifier
        label  % comparison label
        notes  % comparison notes
        atlases  % cell array with brain atlases
        measure_code  % measure code
        group_1  % first group
        group_2  % second group
        settings  % settings of the measurement
    end
    methods (Access = protected)  % Constructor
        function c = Comparison(id, label, notes, atlases, measure_code, group_1, group_2, varargin)
            % COMPARISON(ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP_1, GROUP_2)
            % creates a comparison with ID, LABEL, NOTES, ATLASES of
            % measure MEASURE_CODE between GROUP_1 and GROUP_2.
            %
            % COMPARISON(ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % creates a comparison with ID, LABEL, NOTES, ATLASES of
            % measure MEASURE_CODE  between GROUP_1 and GROUP_2. It 
            % utilizes the settings specified in VALUE.
            %
            % See also Analysis, Measurement, RandomComparison.
            
            c.setID(id)
            c.setLabel(label)
            c.setNotes(notes)
            
            c.setBrainAtlases(atlases)
            
            assert(ischar(measure_code), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'The measure code must be a string.')
            c.measure_code = measure_code;

            c.setGroups(group_1, group_2)

            varargin = get_from_varargin(varargin, 'ComparisonSettings', varargin{:});  % returns varargin if no key 'ComparisonSettings'
            available_settings = Comparison.getAvailableSettings(class(c));
            settings = cell(1, size(available_settings, 1));
            for i = 1:1:size(available_settings, 1)
                available_setting_code = available_settings{i, 1};
                available_setting_default = available_settings{i, 3};
                % TODO check that the value of the setting is amongst the acceptable values
                settings{2 * i - 1} = available_setting_code;
                settings{2 * i} = get_from_varargin(available_setting_default, available_setting_code, varargin{:});
            end
            c.settings = settings;  % initialize the property settings
            
            c.initialize_data(varargin{:});           
        end
    end
    methods (Abstract, Access = protected)  % Abstract function
        initialize_data(c, varargin)  % initialize datadict
    end
    methods  % Basic functions
        function str = tostring(c)
            % TOSTRING string with information about the comparison
            %
            % STR = TOSTRING(C) returns string with the comparison
            % class and id.
            %
            % See also disp.
            
            str = [Comparison.getClass(c) ' ' c.getID()];
        end
        function disp(c)
            % DISP displays information about the comparison
            %
            % DISP(C) displays information about the comparison.
            % It provides information about comparison class and id.
            %
            % See also tostring.
            
            disp(['<a href="matlab:help ' Comparison.getClass(c) '">' Comparison.getClass(c) '</a>'])
            disp(['id = ' c.getID()])
            disp(['label = ' c.getLabel()])
            disp(['notes = ' c.getNotes()])
        end
    end
    methods  % Set functions
        function setID(c, id)
            % SETID sets the id 
            %
            % SETID(C, ID) sets the id
            %
            % See also setLabel, setNotes.

            assert(ischar(id), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')

            c.id = id;
        end
        function setLabel(c, label)
            % SETLABEL sets the label 
            %
            % SETLABEL(C, LABEL) sets the label
            %
            % See also setID, setNotes.

            assert(ischar(label), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')

            c.label = label;
        end        
        function setNotes(c, notes)
            % SETNOTES sets the notes 
            %
            % SETNOTES(C, NOTES) sets the notes
            %
            % See also setID, setLabel.

            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')

            c.notes = notes;
        end        
        function setBrainAtlases(c, atlases)
            % SETBRAINATLASES sets the brain atlases 
            %
            % SETBRAINATLASES(C, ATLASES) sets the brain atlases of the
            % comparison.
            %
            % See also setID, setLabel, setGroup.
            
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(iscell(atlases) && all(cellfun(@(x) isa(x, 'BrainAtlas'), atlases)), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a cell containing BrainAtlas objects')
            c.atlases = atlases;
        end
        function setGroups(c, group_1, group_2)
            % SETGROUPS sets the groups to the comparison 
            %
            % SETGROUPS(C, Group) sets the groups to the comparison.
            %
            % See also setID, setLabel, setBrainAtlases
            
            assert(isa(group_1, 'Group'), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a Group object')
            c.group_1 = group_1;
            
            assert(isa(group_2, 'Group'), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a Group object')
            c.group_2 = group_2;
        end
    end
    methods  % Get functions
        function id = getID(c)
            % GETID returns the id
            %
            % ID = GETID(C) returns the id
            %
            % See also getLabel, getNotes.
            
            id = c.id;
        end
        function label = getLabel(c)
            % GETLABEL returns the label
            %
            % LABEL = GETLABEL(C) returns the label
            %
            % See also getID, getNotes.

            label = c.label;
        end
        function notes = getNotes(c)
            % GETNOTES returns the notes
            %
            % NOTES = GETNOTES(C) returns the notes
            %
            % See also getID, getLabel.

            notes = c.notes;
        end
        function atlases = getBrainAtlases(c)
            % GETBRAINATLASES returns the brain atlas
            %
            % ATLASES = GETBRAINATLASES(C) returns the brain atlas
            %
            % See also getID, getLabel.
            
            atlases = c.atlases;
        end
        function measure_code = getMeasureCode(c)
            % GETMEASURECODE returns the measure code 
            %
            % MEASURE_CODE = GETMEASURECODE(C) returns the measure code of
            % the comparison.
            %
            % See also getID, getLabel, getBrainAtlases, getGroup.
            
            measure_code = c.measure_code;
        end
        function [group_1, group_2] = getGroups(c)
            % GETGROUPs returns the groups of subjects 
            %
            % [GROUP_1, Group_2] = GETGROUPS(C) returns the group of subjects of
            % the comparison.
            %
            % See also getID, getLabel, getBrainAtlases, getMeasureCode.
            
            group_1 = c.group_1;
            group_2 = c.group_2;
        end
        function res = getSettings(c, setting_code)
            % GETSETTINGS returns the settings structure.
            %
            % RES = GETSETTINGS(C, SETTING_CODE) returns the settings
            % structure.
            %
            % See also getID, getLabel, getBrainAtlases, getMeasureCode.

            if nargin<2
                res = c.settings;
            else
                res = get_from_varargin([], setting_code, c.settings{:});
            end
        end
    end
    methods (Static)  % Descriptive functions
        function comparison_list = getList()
            % GETLIST returns the list of comparison subclasses
            %
            % COMPARISON_LIST = GETLIST() returns the list of comparison 
            % (cell array) that are subclasses of Comparison.
            %
            % See also getClass, getName, getDescription.
            
            comparison_list = subclasses('Comparison');
        end
        function comparison_class = getClass(c)
            % GETCLASS returns the class of comparison
            %
            % COMPARISONCLASS = GETCLASS(RC) returns the class of 
            % comparison.
            %
            % See also getList, getName, getDescription.
            
            if isa(c, 'Comparison')
                comparison_class = class(c);
            else  % c should be a string with the comparison class
                comparison_class = c;
            end
        end
        function name = getName(c)
            % GETNAME returns the name of comparison subclass
            %
            % NAME = GETNAME(C) returns the name of comparison C.
            %
            % See also getList, getClass, getDescription.
            
            name = eval([Comparison.getClass(c) '.getName()']);
        end
        function description = getDescription(c)
            % GETDESCRIPTION returns the description of comparison subclass
            %
            % DESCRIPTION = GETDESCRIPTION(C) returns the description
            % of comparison RC.
            %
            % See also getList, getClass, getName.
            
            % comparison description
            description = eval([Comparison.getClass(c) '.getDescription()']);
        end
        function atlas_number = getBrainAtlasNumber(c)
            % GETBRAINATLASNUMBER returns the number of brain atlases
            %
            % ATLAS_NUMBER = GETBRAINATLASNUMBER(RC) returns the number of
            % brain atlases the comparison utilizes.
            %
            % See also getList, getClass, getName.
            
            atlas_number =  eval([Comparison.getClass(c) '.getBrainAtlasNumber()']);
        end
        function analysis_class = getAnalysisClass(c)
            % GETANALYSISCLASS returns the class of the analysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS(RC) returns the class of
            % the analysis where the comparison will be used.
            %
            % See also getSubjectClass, getClass.
            
            % comparison analysis class
            analysis_class = eval([Comparison.getClass(c) '.getAnalysisClass()']);
        end
        function subject_class = getSubjectClass(c)
            % GETSUBJECTCLASS returns the class of the subjects
            %
            % SUBJECT_CLASS = GETSUBJECTCLASS(RC) returns the class of the
            % subjects whithin the group of the comparison.
            %
            % See also getAnalysisClass, getClass.
            
            % comparison subject class
            subject_class = eval([Comparison.getClass(c) '.getSubjectClass()']);
        end
        function available_settings = getAvailableSettings(c)
            % GETAVAILABLESETTINGS returns the available settings
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS(RC) returns the
            % available settings of the comparison.
            %
            % See also getAnalysisClass, getClass. 

            available_settings = eval([Measurement.getClass(c) '.getAvailableSettings()']);
        end
        function sub = getComparison(comparison_class, id, label, notes, atlases, measure_code, group_1, group_2, varargin) %#ok<*INUSD>
            % GETCOMPARISON returns a new comparison
            %
            % SUB = GETCOMPARISON(COMPARISONCLASS, ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP_1, GROUP_2)
            % returns a newly created random comparison of class
            % RANDOMCOMPARISONCLASS, and with measure MEASURE_CODE. It
            % initializes with ID, LABEL, NOTES, ATLASES and GROUPS. The
            % comparison will have default settings.
            %
            % SUB = GETCOMPARISON(COMPARISONCLASS, ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP_1, GROUP_2)
            % returns a newly created random comparison of class
            % RANDOMCOMPARISONCLASS, and with measure MEASURE_CODE. It
            % initializes with ID, LABEL, NOTES, ATLASES and GROUPS. The
            % comparison will have VALUE settings.
            %
            % See also getClass, getList
            
            sub = eval([comparison_class '(id, label, notes, atlases, measure_code, group_1, group_2, varargin{:})']);
        end
    end
    methods (Static)  % Plot general panel
        function getComparisonPanel(comparison_class, analysis)
            % GETCOMPARISONPANEL creates a UI figure to specify Comparison settings
            %
            % GETCOMPARISONPANEL(COMPARISON_CLASS, ANALYSIS) creates a UI
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
                handle_child_panel = Comparison.getChildPanel(comparison_class, analysis, ui_child_panel);
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
                                'PermutationNumber', getappdata(ui_child_panel, 'permutation'));
                        end
                    else
                        m = analysis.getComparison(mlist{mi}, group_1, group_2, rule, value, ...
                                'PermutationNumber', getappdata(ui_child_panel, 'permutation'));
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
        function handle =  getChildPanel(comparison_class, analysis, uiparent)
            % GETCHILDPANEL returns a dynamic panel to the Comparison UIfigure
            %
            % HANDLE = GETCHILDPANEL(COMPARISON_CLASS, ANALYSIS, UIPARENT)
            % returns a dynamic panel to the Comparison UIFigure.
            %
            % See also getComparisonPanel
            
            handle = eval([comparison_class '.getChildPanel(analysis, uiparent)']);
        end
    end
    methods (Access = protected)  % Shallow copy
        function comparison_copy = copyElement(c)
            % COPYELEMENT copies elements of comparison
            %
            % RANDOMCOMPARISON_COPY = COPYELEMENT(M) copies elements of the
            % comparison C. 
            %
            % See also Cohort, Analysis.
            
            % It does not make a deep copy of atlases or groups
            
            % Make a shallow copy
            comparison_copy = copyElement@matlab.mixin.Copyable(c);
        end
    end
end