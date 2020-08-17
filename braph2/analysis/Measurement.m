classdef Measurement < handle & matlab.mixin.Copyable
    % Measurement (Abstract) A measurement
    % Measurement provides the methods necessary for all measurements.
    % It is a subclass of handle & matlab.mixin.Copyable.
    %
    % Measurement provides the methods necessary for all measurements
    % subclasses. Instances of this class cannot be created. Use on of the
    % subclases. The subclasses must be created inside the corresponding
    % workflow ./braph2/workflows/...
    %
    % Measurement Constructor methods (Access=protected)
    %  Measurement                  - Constructor
    %
    % Measurement Basic methods
    %  tostring                     - returns a string representing the class
    %  disp                         - displays the measurement
    %
    % Measurement set methods
    %  setID                        - sets the ID
    %  setLabel                     - sets the label
    %  setNotes                     - sets the notes
    %  setBrainAtlases              - sets the atlases to the measurement
    %  setGroup                     - sets a group to the measurement
    %
    % Measurement get methods
    %  getID                        - returns the ID
    %  getLabel                     - returns the label
    %  getNotes                     - returns the notes
    %  getBrainAtlases              - returns the atlases
    %  getMeasureCode               - returns the measure code
    %  getGroup                     - returns the group
    %  getSettings                  - returns the settings structure
    %
    % Measurement descriptive methods (Static)
    %  getList                  - returns a list of measurement subclasses
    %  getClass                 - returns the class of the measurement
    %  getName                  - returns the name of the measurement
    %  getDescription           - returns the description of the measurement
    %  getBrainAtlasNumber      - returns the number of atlases
    %  getAnalysisClass         - returns the class of the analysis
    %  getSubjectClass          - returns the class of the subject
    %  getAvailableSettings     - returns available settings to the measurement
    %  getMeasurement           - returns a new measurement
    %
    % See also Analysis, RandomComparison, Comparison.
    
    properties (GetAccess=protected, SetAccess=protected)
        id  % unique identifier
        label  % measurement label
        notes  % measurement notes
        atlases  % cell array with brain atlases
        measure_code  % measure code
        group  % group
        settings  % settings of the measurement
    end
    methods (Access = protected)  % Constructor
        function m = Measurement(id, label, notes, atlases, measure_code, group, varargin)
            % MEASUREMENT(ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP)
            % creates a measurement with ID, LABEL, NOTES, ATLASES of
            % measure MEASURE_CODE for GROUP.
            %
            % MEASUREMENT(ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % creates a measurement with ID, LABEL, NOTES, ATLASES of
            % measure MEASURE_CODE for GROUP. It utilizes the settings
            % specified in VALUE.
            %
            % See also Analysis, RandomComparison, Comparison.
            
            m.setID(id)
            m.setLabel(label)
            m.setNotes(notes)
            
            m.setBrainAtlases(atlases)
            
            assert(ischar(measure_code), ...
                [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                'The measure code must be a string.')
            m.measure_code = measure_code;
            
            m.setGroup(group)
            
            varargin = get_from_varargin(varargin, 'MeasurementSettings', varargin{:});  % returns varargin if no key 'MeasurementSettings'
            available_settings = Measurement.getAvailableSettings(class(m));
            settings = cell(1, size(available_settings, 1));
            for i = 1:1:size(available_settings, 1)
                available_setting_code = available_settings{i, 1};
                available_setting_default = available_settings{i, 3};
                % TODO check that the value of the setting is amongst the acceptable values
                settings{2 * i - 1} = available_setting_code;
                settings{2 * i} = get_from_varargin(available_setting_default, available_setting_code, varargin{:});
            end
            m.settings = settings;  % initialize the property settings
            
            m.initialize_data(varargin{:});
        end
    end
    methods (Abstract, Access = protected)  % Abstract function
        initialize_data(m, varargin)  % initialize datadict
    end
    methods  % Basic functions
        function str = tostring(m)
            % TOSTRING string with information about the measurement
            %
            % STR = TOSTRING(M) returns string with the measurement
            % class and id.
            %
            % See also disp.
            
            str = [Measurement.getClass(m) ' ' m.getID()];
        end
        function disp(m)
            % DISP displays information about the measurement
            %
            % DISP(M) displays information about the measurement.
            % It provides information about measurement class and id.
            %
            % See also tostring.
            
            disp(['<a href="matlab:help ' Measurement.getClass(m) '">' Measurement.getClass(m) '</a>'])
            disp(['id = ' m.getID()])
            disp(['label = ' m.getLabel()])
            disp(['notes = ' m.getNotes()])
        end
    end
    methods  % Set functions
        function setID(m, id)
            % SETID sets the id
            %
            % SETID(M, ID) sets the id
            %
            % See also setLabel, setNotes.
            
            assert(ischar(id), ...
                [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')
            
            m.id = id;
        end
        function setLabel(m, label)
            % SETLABEL sets the label
            %
            % SETLABEL(M, LABEL) sets the label
            %
            % See also setID, setNotes.
            
            assert(ischar(label), ...
                [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')
            
            m.label = label;
        end
        function setNotes(m, notes)
            % SETNOTES sets the notes
            %
            % SETNOTES(M, NOTES) sets the notes
            %
            % See also setID, setLabel.
            
            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')
            
            m.notes = notes;
        end
        function setBrainAtlases(m, atlases)
            % SETBRAINATLASES sets the brain atlases
            %
            % SETBRAINATLASES(M, ATLASES) sets the brain atlases of the
            % measurement.
            %
            % See also setID, setLabel, setGroup.
            
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(iscell(atlases) && all(cellfun(@(x) isa(x, 'BrainAtlas'), atlases)), ...
                [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a cell containing BrainAtlas objects')
            m.atlases = atlases;
        end
        function setGroup(m, group)
            % SETGROUP sets the group to the measurement
            %
            % SETGROUP(M, Group) sets the group to the measurement.
            %
            % See also setID, setLabel, setBrainAtlases
            
            assert(isa(group, 'Group'), ...
                [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a Group object')
            m.group = group;
        end
    end
    methods  % Get functions
        function id = getID(m)
            % GETID returns the id
            %
            % ID = GETID(M) returns the id
            %
            % See also getLabel, getNotes.
            
            id = m.id;
        end
        function label = getLabel(m)
            % GETLABEL returns the label
            %
            % LABEL = GETLABEL(M) returns the label
            %
            % See also getID, getNotes.
            
            label = m.label;
        end
        function notes = getNotes(m)
            % GETNOTES returns the notes
            %
            % NOTES = GETNOTES(M) returns the notes
            %
            % See also getID, getLabel.
            
            notes = m.notes;
        end
        function atlases = getBrainAtlases(m)
            % GETBRAINATLASES returns the brain atlas
            %
            % ATLASES = GETBRAINATLASES(M) returns the brain atlas
            %
            % See also getID, getLabel.
            
            atlases = m.atlases;
        end
        function measure_code = getMeasureCode(m)
            % GETMEASURECODE returns the measure code
            %
            % MEASURE_CODE = GETMEASURECODE(M) returns the measure code of
            % the measurement.
            %
            % See also getID, getLabel, getBrainAtlases, getGroup.
            
            measure_code = m.measure_code;
        end
        function group = getGroup(m)
            % GETGROUP returns the group of subjects
            %
            % GROUP = GETGROUP(M) returns the group of subjects of
            % the measurement.
            %
            % See also getID, getLabel, getBrainAtlases, getMeasureCode.
            
            group = m.group;
        end
        function res = getSettings(m, setting_code)
            % GETSETTINGS returns the settings structure.
            %
            % RES = GETSETTINGS(M, SETTING_CODE) returns the settings
            % structure.
            %
            % See also getID, getLabel, getBrainAtlases, getMeasureCode.
            
            if nargin<2
                res = m.settings;
            else
                res = get_from_varargin([], setting_code, m.settings{:});
            end
        end
    end
    methods (Static)  % Descriptive functions
        function measurement_list = getList()
            % GETLIST returns the list of measurement subclasses
            %
            % MEASUREMENT_LIST = GETLIST() returns the list of measurement
            % (cell array) that are subclasses of Measurement.
            %
            % See also getClass, getName, getDescription.
            
            measurement_list = subclasses('Measurement');
        end
        function measurement_class = getClass(m)
            % GETCLASS returns the class of measurement
            %
            % MEASUREMENT_CLASS = GETCLASS(M) returns the class of
            % measurement.
            %
            % See also getList, getName, getDescription.
            
            if isa(m, 'Measurement')
                measurement_class = class(m);
            else  % m should be a string with the measurement class
                measurement_class = m;
            end
        end
        function name = getName(m)
            % GETNAME returns the name of measurement subclass
            %
            % NAME = GETNAME(M) returns the name of measurement M.
            %
            % See also getList, getClass, getDescription.
            
            name = eval([Measurement.getClass(m) '.getName()']);
        end
        function description = getDescription(m)
            % GETDESCRIPTION returns the description of measurement subclass
            %
            % DESCRIPTION = GETDESCRIPTION(M) returns the description
            % of measurement M.
            %
            % See also getList, getClass, getName.
            
            % measurement description
            description = eval([Measurement.getClass(m) '.getDescription()']);
        end
        function atlas_number = getBrainAtlasNumber(m)
            % GETBRAINATLASNUMBER returns the number of brain atlases
            %
            % ATLAS_NUMBER = GETBRAINATLASNUMBER(M) returns the number of
            % brain atlases the measurement utilizes.
            %
            % See also getList, getClass, getName.
            
            atlas_number =  eval([Measurement.getClass(m) '.getBrainAtlasNumber()']);
        end
        function analysis_class = getAnalysisClass(m)
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS(M) returns the class of
            % the analysis where the measurement will be used.
            %
            % See also getSubjectClass, getClass.
            
            % measurement analysis class
            analysis_class = eval([Measurement.getClass(m) '.getAnalysisClass()']);
        end
        function subject_class = getSubjectClass(m)
            % GETSUBJECTCLASS returns the class of the subjects
            %
            % SUBJECT_CLASS = GETSUBJECTCLASS(M) returns the class of the
            % subjects whithin the group of the measurement.
            %
            % See also getAnalysisClass, getClass.
            
            % measurement subject class
            subject_class = eval([Measurement.getClass(m) '.getSubjectClass()']);
        end
        function available_settings = getAvailableSettings(m)
            % GETAVAILABLESETTINGS returns the available settings
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS(M) returns the
            % available settings of the measurement.
            %
            % See also getAnalysisClass, getClass.
            
            available_settings = eval([Measurement.getClass(m) '.getAvailableSettings()']);
        end
        function sub = getMeasurement(measurement_class, id, label, notes, atlases, measure_code, group, varargin) %#ok<INUSD>
            % GETMEASUREMENT returns a new measurement
            %
            % SUB = GETMEASUREMENT(MEASUREMENT_CLASS, ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP)
            % returns a newely created measurment of class
            % MEASUREMENT_CLASS, and with measure MEASURE_CODE. It
            % initializes with ID, LABEL, NOTES, ATLASES and GROUP. The
            % measurement will have default settings.
            %
            % SUB = GETMEASUREMENT(MEASUREMENT_CLASS, ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP)
            % returns a newely created measurment of class
            % MEASUREMENT_CLASS, and with measure MEASURE_CODE. It
            % initializes with ID, LABEL, NOTES, ATLASES and GROUP. The
            % measuremnent will have VALUE settings.
            %
            % See also getClass, getList.
            
            sub = eval([measurement_class  '(id, label, notes, atlases, measure_code, group, varargin{:})']);
        end
    end
    methods (Static)  % Plot general panel
        function getMesurementPanel(measurement_class, analysis)
            % variables
            mlist = Graph.getCompatibleMeasureList(analysis.getGraphType());
            selected_calc = [];
            stop = false;
            start = 0;
            
            % commands
            NAME = ['Analysis Measurements for: ' analysis.getID()];
            
            CALC_SELECTED_COL = 1;
            CALC_NAME_COL = 2;
            CALC_FORMAT_COL = 3;
            CALC_SCOPE_COL = 4;
            
            CALC_GLOBAL = 'Global';
            CALC_NODAL = 'Nodal';
            CALC_BINODAL = 'Binodal';
            CALC_SUPERGLOBAL = 'Superglobal';
            CALC_UNILAYER = 'Unilayer';
            CALC_BILAYER = 'Bilayer';
            
            CALC_TXT_COL = 5;
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
            variables = [];
            
            % Main Panel
            PANEL_POSITION = [0 0 1 1];
            
            ui_panel = uipanel();
            
            ui_calc_table = uitable(ui_panel);
            ui_calc_selectall_button = uicontrol(ui_panel, 'Style', 'pushbutton');
            ui_calc_clear_button = uicontrol(ui_panel, 'Style', 'pushbutton');
            ui_calc_global_button = uicontrol(ui_panel, 'Style', 'pushbutton');
            ui_calc_nodal_button = uicontrol(ui_panel, 'Style', 'pushbutton');
            ui_calc_binodal_button = uicontrol(ui_panel, 'Style', 'pushbutton');
            
            ui_popup_group = uicontrol(ui_panel, 'Style', 'listbox', 'String', {''});
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
                
                set(ui_calc_selectall_button, 'Position', [.01 .64 .15 .05])
                set(ui_calc_selectall_button, 'String', SELECTALL_CALC_CMD)
                set(ui_calc_selectall_button, 'TooltipString', SELECTALL_CALC_TP)
                set(ui_calc_selectall_button, 'Callback', {@cb_calc_selectall})
                
                set(ui_calc_clear_button, 'Position', [.01 .58 .15 .05])
                set(ui_calc_clear_button, 'String', CLEARSELECTION_CALC_CMD)
                set(ui_calc_clear_button, 'TooltipString', CLEARSELECTION_CALC_TP)
                set(ui_calc_clear_button, 'Callback', {@cb_calc_clearselection})
                
                set(ui_calc_global_button, 'Position', [.22 .64 .15 .05])
                set(ui_calc_global_button, 'String',SELECTGLOBAL_CALC_CMD)
                set(ui_calc_global_button, 'TooltipString',SELECTGLOBAL_CALC_TP)
                set(ui_calc_global_button, 'Callback', {@cb_calc_global})
                
                set(ui_calc_nodal_button, 'Position', [.22 .58 .15 .05])
                set(ui_calc_nodal_button, 'String',SELECTNODAL_CALC_CMD)
                set(ui_calc_nodal_button, 'TooltipString',SELECTNODAL_CALC_TP)
                set(ui_calc_nodal_button, 'Callback', {@cb_calc_nodal})
                
                set(ui_calc_binodal_button, 'Position', [.22 .52 .15 .05])
                set(ui_calc_binodal_button, 'String', SELECTBINODAL_CALC_CMD)
                set(ui_calc_binodal_button, 'TooltipString', SELECTBINODAL_CALC_TP)
                set(ui_calc_binodal_button, 'Callback', {@cb_calc_binodal})
                
                set(ui_popup_group, 'Position', [.01 .25 .44 .2])
                set(ui_popup_group, 'TooltipString', 'Select group 1');
                
                set(ui_text_info, 'Position', [.5 .1 .4 .34])
                set(ui_text_info, 'String', 'MeasurementST')
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
                variables = Measurement.getChildPanel(measurement_class, analysis, ui_child_panel);  %#ok<NASGU>
            end
            function deactivate_components()
                set(ui_calc_table, 'Enable', 'off')
                set(ui_calc_selectall_button, 'Enable', 'off')
                set(ui_calc_clear_button, 'Enable', 'off')
                set(ui_calc_global_button, 'Enable', 'off')
                set(ui_calc_nodal_button, 'Enable', 'off')
                set(ui_calc_binodal_button, 'Enable', 'off')
                set(ui_popup_group, 'Enable', 'off')
            end
            function activate_components()
                set(ui_calc_table, 'Enable', 'on')
                set(ui_calc_selectall_button, 'Enable', 'on')
                set(ui_calc_clear_button, 'Enable', 'on')
                set(ui_calc_global_button, 'Enable', 'on')
                set(ui_calc_nodal_button, 'Enable', 'on')
                set(ui_calc_binodal_button, 'Enable', 'on')
                set(ui_popup_group, 'Enable', 'on')
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
                            group = get(ui_popup_group, 'Value');
                            mlist = mlist(selected_calc);
                            
                            calculate(analysis, mlist, group)
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
                group = get(ui_popup_group, 'Value');
                
                calculate(analysis, mlist(selected_calc), group)
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
                    GroupList = ['All Groups' GroupList];
                else
                    GroupList = {''};
                end
                set(ui_popup_group, 'String', GroupList)
            end
            function calculate(analysis, mlist, g)
                L = 100;
                txt = cell(1, L);
                
                if isempty(variables)
                    rule = '';
                    value = '';
                else
                    if contains('threshold', variables)
                            rule = 'threshold';
                            value =  getappdata(ui_child_panel, 'threshold');
                    elseif contains('density', variables)
                            rule = 'density';
                            value = getappdata(ui_child_panel, 'density');                            
                    end
                end
                
                if isequal(g, 1)
                    group = analysis.getCohort().getGroups().getValues();                   
                    for i = 1:1:length(group)
                        gr = group{i};
                        for mi = 1:1:length(mlist)
                            % missing the measuremente parameters
                            if iscell(value)
                                for vals = 1:1:length(value)
                                    value_step = value{vals};
                                     m = analysis.getMeasurement(mlist{mi}, gr, rule, value_step);
                                end
                            else
                                 m = analysis.getMeasurement(mlist{mi}, gr, rule, value);
                            end
                            msg = ['time = ' int2str(toc(start)) '.'  int2str(mod(toc(start)*10, 10)) 's - group = ' gr.tostring() ' - ' mlist{mi}];
                            
                            % visualize status
                            txt(2:L) = txt(1:L - 1);
                            txt{1} = msg;
                            set(ui_edit_info, 'String', txt)
                            
                            pause(.001)
                            
                            if stop
                                break
                            end
                        end
                    end
                    
                else
                    g = g - 1;
                    group = analysis.getCohort().getGroups().getValue(g);
                    for mi = 1:1:length(mlist)
                        % missing the measuremente parameters
                        if length(value) > 1
                            for vals = 1:1:length(value)
                                value_step = value(vals);
                                m = analysis.getMeasurement(mlist{mi}, group, rule, value_step);
                            end
                        else
                            m = analysis.getMeasurement(mlist{mi}, group, rule, value);
                        end
                        msg = ['time = ' int2str(toc(start)) '.' int2str(mod(toc(start)*10, 10)) 's - group = ' int2str(g) ' - ' mlist{mi}];
                        
                        % visualize status
                        txt(2:L) = txt(1:L - 1);
                        txt{1} = msg;
                        set(ui_edit_info, 'String', txt)
                        
                        pause(.001)
                        
                        if stop
                            break
                        end
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
        end
    end
    methods (Static)  % Plot child panel
        function variables =  getChildPanel(measurement_class, analysis, uiparent)
            variables = eval([measurement_class '.getChildPanel(analysis, uiparent)']);
        end
    end
    methods (Access = protected)  % Shallow copy
        function measurement_copy = copyElement(m)
            % COPYELEMENT copies elements of measurement
            %
            % MEASUREMENT_COPY = COPYELEMENT(M) copies elements of the
            % measurement M.
            %
            % See also Cohort, Analysis.
            
            % It does not make a deep copy of atlases or groups
            
            % Make a shallow copy
            measurement_copy = copyElement@matlab.mixin.Copyable(m);
        end
    end
end