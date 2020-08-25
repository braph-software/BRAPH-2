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
    % Measurement Plot Methods (Static)
    %  getMeasurementSettingsPanel - returns a dynamic UIPanel
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
        function handle =  getMeasurementSettingsPanel(measurement_class, analysis, uiparent) %#ok<INUSD>
            % GETCHILDPANEL returns a dynamic panel to the Measurement UIfigure
            %
            % HANDLE = GETCHILDPANEL(MEASUREMENT_CLASS, ANALYSIS, UIPARENT)
            % returns a dynamic panel to the Meaasurement UIFigure.
            %
            % See also getMesurementPanel
            
            handle = eval([measurement_class '.getMeasurementSettingsPanel(analysis, uiparent)']);
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