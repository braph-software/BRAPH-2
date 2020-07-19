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
            % RANDOMCOMPARISON constructs a measurement
            %
            % RC = RANDOMCOMPARISON(ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP)
            % creates a random comparison with ID, LABEL, NOTES, ATLASES of
            % measure MEASURE_CODE for GROUP.
            %
            % RC = RANDOMCOMPARISON(ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP, 'PropertyValue', VALUE, ...)
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
            % MEASUREMENT_LIST = GETLIST() returns the list of random comparison 
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
            % GETRANDCOMCOMPARISON returns a new random comparison
            %
            % SUB = GETRANDCOMCOMPARISON(RANDOMCOMPARISONCLASS, ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP)
            % returns a newly created random comparison of class
            % RANDOMCOMPARISONCLASS, and with measure MEASURE_CODE. It
            % initializes with ID, LABEL, NOTES, ATLASES and GROUP. The
            % random comparison will have default settings.
            %
            % SUB = GETRANDCOMCOMPARISON(RANDOMCOMPARISONCLASS, ID, LABEL, NOTES, ATLASES, MEASURE_CODE, GROUP)
            % returns a newly created random comparison of class
            % RANDOMCOMPARISONCLASS, and with measure MEASURE_CODE. It
            % initializes with ID, LABEL, NOTES, ATLASES and GROUP. The
            % measuremnent will have VALUE settings.
            %
            % See also getClass, getList.
            
            sub = eval([randomComparisonClass '(id, label, notes, atlas, measure_code, group, varargin{:})']);
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