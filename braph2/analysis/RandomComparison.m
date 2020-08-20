classdef RandomComparison < handle & matlab.mixin.Copyable
    % RandomComparison (Abstract) A random comparison
    % RandomComparison provides the methods necessary for all random comparisons.
    % It is a subclass of handle & matlab.mixin.Copyable.
    %
    % RandomComparison provides the methods necessary for all random comparisons
    % subclasses. Instances of this class cannot be created. Use on of the
    % subclases. The subclasses must be created inside the corresponding
    % workflow ./braph2/workflows/...
    %
    % RandomComparison Constructor methods (Access=protected)
    %  RandomComparison                  - Constructor
    %
    % RandomComparison Basic methods
    %  tostring                     - returns a string representing the class
    %  disp                         - displays the random comparison
    %  
    % RandomComparison set methods
    %  setID                        - sets the ID
    %  setLabel                     - sets the label
    %  setNotes                     - sets the notes
    %  setBrainAtlases              - sets the atlases to the random comparison
    %  setGroup                     - sets a group to the random comparison
    %
    % RandomComparison get methods 
    %  getID                        - returns the ID
    %  getLabel                     - returns the label
    %  getNotes                     - returns the notes
    %  getBrainAtlases              - returns the atlases
    %  getMeasureCode               - returns the measure code
    %  getGroup                     - returns the group
    %  getSettings                  - returns the settings structure
    % 
    % RandomComparison descriptive methods (Static)
    %  getList                  - returns a list of random comparison subclasses
    %  getClass                 - returns the class of the random comparison
    %  getName                  - returns the name of the random comparison
    %  getDescription           - returns the description of the random comparison
    %  getBrainAtlasNumber      - returns the number of atlases
    %  getAnalysisClass         - returns the class of the analysis
    %  getSubjectClass          - returns the class of the subject
    %  getAvailableSettings     - returns available settings to the random comparison
    %  getRandomComparion       - returns a new random comparison
    %
    % See also Analysis, Measurement, Comparison.
    
    properties (GetAccess=protected, SetAccess=protected)
        id  % unique identifier
        label  % random comparison label
        notes  % random comparison notes
        atlases  % cell array with brain atlases
        group  %  group
        measure_code  % measure code
        settings  % settings of the RandomComparison
    end
    methods (Access = protected)  % Constructor
        function rc = RandomComparison(id, label, notes, atlases, measure_code, group, varargin)
            % RANDOMCOMPARISON(ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP)
            % creates a random comparison with ID, LABEL, NOTES, ATLASES of
            % measure MEASURE_CODE for GROUP.
            %
            % RANDOMCOMPARISON(ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % creates a random comparison with ID, LABEL, NOTES, ATLASES of
            % measure MEASURE_CODE for GROUP. It utilizes the settings
            % specified in VALUE.
            %
            % See also Analysis, Measurement, Comparison.

            rc.setID(id)
            rc.setLabel(label)
            rc.setNotes(notes)
            
            rc.setBrainAtlases(atlases)
            
            assert(ischar(measure_code), ...
                [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                'The measure code must be a string.')
            rc.measure_code = measure_code;

            rc.setGroup(group)
            
            varargin = get_from_varargin(varargin, 'RandomComparisonSettings', varargin{:});  % returns varargin if no key 'RandomComparisonSettings'
            available_settings = RandomComparison.getAvailableSettings(class(rc));
            settings = cell(1, size(available_settings, 1));
            for i = 1:1:size(available_settings, 1)
                available_setting_code = available_settings{i, 1};
                available_setting_default = available_settings{i, 3};
                % TODO check that the value of the setting is amongst the acceptable values
                settings{2 * i - 1} = available_setting_code;
                settings{2 * i} = get_from_varargin(available_setting_default, available_setting_code, varargin{:});
            end
            rc.settings = settings;  % initialize the property settings
            
            rc.initialize_data(varargin{:});           
        end
    end
    methods (Abstract, Access = protected)  % Abstract function
        initialize_data(rc, varargin)  % initialize datadict
    end
    methods  % Basic functions
        function str = tostring(rc)
            % TOSTRING string with information about the random comparison
            %
            % STR = TOSTRING(RC) returns string with the random comparison
            % class and id.
            %
            % See also disp.
            
            str = [RandomComparison.getClass(rc)]; %#ok<NBRAK>
        end
        function disp(rc)
            % DISP displays information about the random comparison
            %
            % DISP(RC) displays information about the random comparison.
            % It provides information about random comparison class and id.
            %
            % See also tostring.
            
            disp(['<a href="matlab:help ' RandomComparison.getClass(rc) '">' RandomComparison.getClass(rc) '</a>'])
            disp(['id = ' rc.getID()])
            disp(['label = ' rc.getLabel()])
            disp(['notes = ' rc.getNotes()])
        end
    end
    methods  % Set functions
        function setID(rc, id)
            % SETID sets the id 
            %
            % SETID(RC, ID) sets the id
            %
            % See also setLabel, setNotes.

            assert(ischar(id), ...
                [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')

            rc.id = id;
        end
        function setLabel(rc, label)
            % SETLABEL sets the label 
            %
            % SETLABEL(RC, LABEL) sets the label
            %
            % See also setID, setNotes.

            assert(ischar(label), ...
                [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')

            rc.label = label;
        end        
        function setNotes(rc, notes)
            % SETNOTES sets the notes 
            %
            % SETNOTES(RC, NOTES) sets the notes
            %
            % See also setID, setLabel.

            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')

            rc.notes = notes;
        end
        function setBrainAtlases(rc, atlases)
            % SETBRAINATLASES sets the brain atlases 
            %
            % SETBRAINATLASES(RC, ATLASES) sets the brain atlases of the
            % random comparison.
            %
            % See also setID, setLabel, setGroup.
            
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(iscell(atlases) && all(cellfun(@(x) isa(x, 'BrainAtlas'), atlases)), ...
                [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a cell containing BrainAtlas objects')
            rc.atlases = atlases;
        end
        function setGroup(rc, group)
            % SETGROUP sets the group to the random comparison 
            %
            % SETGROUP(RC, Group) sets the group to the random comparison.
            %
            % See also setID, setLabel, setBrainAtlases
            
            assert(isa(group, 'Group'), ...
                [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a Group object')
            rc.group = group;
        end
    end
    methods  % Get functions
        function id = getID(rc)
            % GETID returns the id
            %
            % ID = GETID(RC) returns the id
            %
            % See also getLabel, getNotes.
            
            id = rc.id;
        end
        function label = getLabel(rc)
            % GETLABEL returns the label
            %
            % LABEL = GETLABEL(RC) returns the label
            %
            % See also getID, getNotes.

            label = rc.label;
        end
        function notes = getNotes(rc)
            % GETNOTES returns the notes
            %
            % NOTES = GETNOTES(RC) returns the notes
            %
            % See also getID, getLabel.

            notes = rc.notes;
        end
        function atlases = getBrainAtlases(rc)
            % GETBRAINATLASES returns the brain atlas
            %
            % ATLASES = GETBRAINATLASES(RC) returns the brain atlas
            %
            % See also getID, getLabel.
            
            atlases = rc.atlases;
        end
        function measure_code = getMeasureCode(rc)
            % GETMEASURECODE returns the measure code 
            %
            % MEASURE_CODE = GETMEASURECODE(RC) returns the measure code of
            % the random comparison.
            %
            % See also getID, getLabel, getBrainAtlases, getGroup.
            
            measure_code = rc.measure_code;
        end
        function group = getGroup(rc)
            % GETGROUP returns the group of subjects 
            %
            % GROUP = GETGROUP(RC) returns the group of subjects of
            % the random comparison.
            %
            % See also getID, getLabel, getBrainAtlases, getMeasureCode.
            
            group = rc.group;
        end
        function res = getSettings(rc, setting_code)
            % GETSETTINGS returns the settings structure.
            %
            % RES = GETSETTINGS(RC, SETTING_CODE) returns the settings
            % structure.
            %
            % See also getID, getLabel, getBrainAtlases, getMeasureCode.


            if nargin<2
                res = rc.settings;
            else
                res = get_from_varargin([], setting_code, rc.settings{:});
            end
        end
    end
    methods (Static)  % Descriptive functions
        function randomcomparisonlist = getList()
            % GETLIST returns the list of random comparison subclasses
            %
            % RANDOMCOMPARISONLIST = GETLIST() returns the list of random comparison 
            % (cell array) that are subclasses of RandomComparison.
            %
            % See also getClass, getName, getDescription.
            
            randomcomparisonlist = subclasses('RandomComparison');
        end
        function randomcomparisonclass = getClass(rc)
            % GETCLASS returns the class of random comparison
            %
            % RANDOMCOMPARISONCLASS = GETCLASS(RC) returns the class of 
            % random comparison.
            %
            % See also getList, getName, getDescription.
            
            if isa(rc, 'RandomComparison')
                randomcomparisonclass = class(rc);
            else % mshould be a string with the RandomComparison class
                randomcomparisonclass = rc;
            end
        end
        function name = getName(rc)
            % GETNAME returns the name of random comparison subclass
            %
            % NAME = GETNAME(RC) returns the name of random comparison RC.
            %
            % See also getList, getClass, getDescription.
            
            name = eval([RandomComparison.getClass(rc) '.getName()']);
        end
        function description = getDescription(rc)
            % GETDESCRIPTION returns the description of random comparison subclass
            %
            % DESCRIPTION = GETDESCRIPTION(RC) returns the description
            % of random comparison RC.
            %
            % See also getList, getClass, getName.
            
            % RandomComparison description
            description = eval([RandomComparison.getClass(rc) '.getDescription()']);
        end
        function atlas_number = getBrainAtlasNumber(rc)
            % GETBRAINATLASNUMBER returns the number of brain atlases
            %
            % ATLAS_NUMBER = GETBRAINATLASNUMBER(RC) returns the number of
            % brain atlases the random comparison utilizes.
            %
            % See also getList, getClass, getName.
            
            atlas_number =  eval([RandomComparison.getClass(rc) '.getBrainAtlasNumber()']);
        end  
        function analysis_class = getAnalysisClass(rc)
            % GETANALYSISCLASS returns the class of the analysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS(RC) returns the class of
            % the analysis where the random comparison will be used.
            %
            % See also getSubjectClass, getClass.
            
            % comparison analysis class
            analysis_class = eval([RandomComparison.getClass(rc) '.getAnalysisClass()']);
        end
        function subject_class = getSubjectClass(rc)
            % GETSUBJECTCLASS returns the class of the subjects
            %
            % SUBJECT_CLASS = GETSUBJECTCLASS(RC) returns the class of the
            % subjects whithin the group of the random comparison.
            %
            % See also getAnalysisClass, getClass.            
            
            % comparison subject class
            subject_class = eval([RandomComparison.getClass(rc) '.getSubjectClass()']);
        end
        function available_settings = getAvailableSettings(rc)
            % GETAVAILABLESETTINGS returns the available settings
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS(RC) returns the
            % available settings of the random comparison.
            %
            % See also getAnalysisClass, getClass.    

            available_settings = eval([RandomComparison.getClass(rc) '.getAvailableSettings()']);
        end
        function sub = getRandomComparison(randomComparisonClass, id, label, notes, atlas, measure_code, group, varargin) %#ok<INUSD>
            % GETRANDOMCOMPARISON returns a new random comparison
            %
            % SUB = GETRANDOMCOMPARISON(RANDOMCOMPARISONCLASS, ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP)
            % returns a newly created random comparison of class
            % RANDOMCOMPARISONCLASS, and with measure MEASURE_CODE. It
            % initializes with ID, LABEL, NOTES, ATLASES and GROUP. The
            % random comparison will have default settings.
            %
            % SUB = GETRANDOMCOMPARISON(RANDOMCOMPARISONCLASS, ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP)
            % returns a newly created random comparison of class
            % RANDOMCOMPARISONCLASS, and with measure MEASURE_CODE. It
            % initializes with ID, LABEL, NOTES, ATLASES and GROUP. The
            % random comparison will have VALUE settings.
            %
            % See also getClass, getList.
            
            sub = eval([randomComparisonClass '(id, label, notes, atlas, measure_code, group, varargin{:})']);
        end
    end
    methods (Static)  % Plot general panel
        function getRandomComparisonPanel(comparison_class, analysis)
            % variables
            mlist = Graph.getCompatibleMeasureList(analysis.getGraphType());
            selected_calc = [];
            stop = false;
            start = 0;
            
            % commands
            NAME = ['Analysis Random Comparison for: ' analysis.getID()];
            
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
            
            ui_popup_group_1 = uicontrol(ui_panel, 'Style', 'listbox', 'String', {''});
            ui_text_info = uicontrol(ui_panel, 'Style', 'text');
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
                
                set(ui_popup_group_1, 'Position', [.01 .25 .44 .28])
                set(ui_popup_group_1, 'TooltipString', 'Select group 1');
                
                set(ui_text_info, 'Position', [.5 .1 .4 .2])
                set(ui_text_info, 'String', 'RandomComparisonST')
                set(ui_text_info, 'FontWeight', 'bold')
                set(ui_text_info, 'FontSize',12)
                
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
                            mlist = mlist(selected_calc);
                            
                            calculate(analysis, mlist, group_1)
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
                
                calculate(analysis, mlist(selected_calc), group_1)
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
            end
            function calculate(analysis, mlist, g_1)
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
                for mi = 1:1:length(mlist)
                    % missing the measuremente parameters
                    if length(value) > 1
                        for vals = 1:1:length(value)
                            value_step = value(vals);
                            m = analysis.getRandomComparison(mlist{mi}, group_1, rule, value_step, ...
                                'Verbose', getappdata(ui_child_panel, 'verbose'), ...
                                'Interruptible', getappdata(ui_child_panel, 'interruptible'), ...
                                'RandomizationNumber', getappdata(ui_child_panel, 'randomization'), ...
                                'AttemptsPerEdge', getappdata(ui_child_panel, 'attempts'), ...
                                'NumberOfWeights', getappdata(ui_child_panel, 'weigths')); %#ok<NASGU>
                        end
                    else
                        m = analysis.getRandomComparison(mlist{mi}, group_1, rule, value, ...
                                'Verbose', getappdata(ui_child_panel, 'verbose'), ...
                                'Interruptible', getappdata(ui_child_panel, 'interruptible'), ...
                                'RandomizationNumber', getappdata(ui_child_panel, 'randomization'), ...
                                'AttemptsPerEdge', getappdata(ui_child_panel, 'attempts'), ...
                                'NumberOfWeights', getappdata(ui_child_panel, 'weigths')); %#ok<NASGU>
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
                set(handle_child_panel.verbose, 'enable', 'off')
                set(handle_child_panel.interruptible, 'enable', 'off')
                set(handle_child_panel.randomization, 'enable', 'off')
                if ~isempty(handle_child_panel.variables)
                    set(handle_child_panel.step, 'enable', 'off')
                    set(handle_child_panel.min, 'enable', 'off')
                    set(handle_child_panel.max, 'enable', 'off')
                end
            end            
        end 
    end
    methods (Static)  % Plot child panel
        function handle =  getChildPanel(random_comparison_class, analysis, uiparent) %#ok<INUSD>
            handle = eval([random_comparison_class '.getChildPanel(analysis, uiparent)']);
        end
    end
    methods (Access =  protected)  % Shallow copy
        function randomcomparison_copy = copyElement(rc)
            % COPYELEMENT copies elements of random comparison
            %
            % RANDOMCOMPARISON_COPY = COPYELEMENT(M) copies elements of the
            % random comparison RC. 
            %
            % See also Cohort, Analysis.
            
            % It does not make a deep copy of atlases or group
            
            % Make a shallow copy
            randomcomparison_copy = copyElement@matlab.mixin.Copyable(rc);
            
        end
    end
end