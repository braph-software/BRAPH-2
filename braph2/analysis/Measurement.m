classdef Measurement < handle & matlab.mixin.Copyable
    % Measurement (Abstract) A measurement
    % Measurement provides the methods necessary for all measurements
    % It is a subclass of handle & matlab.mixin.Copyable
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
    % See also Analysis, RandomComparison, Comparison
    
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
            % MEASUREMENT constructs a measurement
            %
            % M = MEASUREMENT(ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP)
            % creates a measurement with ID, LABEL, NOTES, ATLASES of
            % measure MEASURE_CODE for GROUP.
            %
            % M = MEASUREMENT(ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP, 'PropertyValue', VALUE, ...)
            % creates a measurement with ID, LABEL, NOTES, ATLASES of
            % measure MEASURE_CODE for GROUP. It utilizes the settings
            % specified in VALUE.
            %
            % See also Analysis, RandomComparison, Comparison

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
        end        
    end
    methods  % Set functions
        function setID(m, id)

            assert(ischar(id), ...
                [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')

            m.id = id;
        end
        function setLabel(m, label)

            assert(ischar(label), ...
                [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')

            m.label = label;
        end        
        function setNotes(m, notes)

            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')

            m.notes = notes;
        end        
        function setBrainAtlases(m, atlases)
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(iscell(atlases) && all(cellfun(@(x) isa(x, 'BrainAtlas'), atlases)), ...
                [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a cell containing BrainAtlas objects')
            m.atlases = atlases;
        end
        function setGroup(m, group)
            assert(isa(group, 'Group'), ...
                [BRAPH2.STR ':' class(m) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a Group object')
            m.group = group;
        end
    end
    methods  % Get functions
        function id = getID(m)
            id = m.id;
        end
        function label = getLabel(m)

            label = m.label;
        end
        function notes = getNotes(m)

            notes = m.notes;
        end
        function atlases = getBrainAtlases(m)
            atlases = m.atlases;
        end
        function measure_code = getMeasureCode(m)
            measure_code = m.measure_code;
        end
        function group = getGroup(m)
            group = m.group;
        end
        function res = getSettings(m, setting_code)

            if nargin<2
                res = m.settings;
            else
                res = get_from_varargin([], setting_code, m.settings{:});
            end
        end
    end
    methods (Static)  % Descriptive functions
        function measurement_list = getList()
            measurement_list = subclasses('Measurement');
        end
        function measurement_class = getClass(m)
            if isa(m, 'Measurement')
                measurement_class = class(m);
            else  % m should be a string with the measurement class
                measurement_class = m;
            end
        end
        function name = getName(m)
            name = eval([Measurement.getClass(m) '.getName()']);
        end
        function description = getDescription(m)
            % measurement description
            description = eval([Measurement.getClass(m) '.getDescription()']);
        end
        function atlas_number = getBrainAtlasNumber(m)
            atlas_number =  eval([Measurement.getClass(m) '.getBrainAtlasNumber()']);
        end
        function analysis_class = getAnalysisClass(m)
            % measurement analysis class
            analysis_class = eval([Measurement.getClass(m) '.getAnalysisClass()']);
        end
        function subject_class = getSubjectClass(m)
            % measurement subject class
            subject_class = eval([Measurement.getClass(m) '.getSubjectClass()']);
        end        
        function available_settings = getAvailableSettings(m)

            available_settings = eval([Measurement.getClass(m) '.getAvailableSettings()']);
        end
        function sub = getMeasurement(measurement_class, id, label, notes, atlases, measure_code, group, varargin) %#ok<INUSD>
            sub = eval([measurement_class  '(id, label, notes, atlases, measure_code, group, varargin{:})']);
        end
    end
    methods (Access = protected)  % Shallow copy
        function measurement_copy = copyElement(m)
            % It does not make a deep copy of atlases or groups

            % Make a shallow copy
            measurement_copy = copyElement@matlab.mixin.Copyable(m);
        end
    end    
end