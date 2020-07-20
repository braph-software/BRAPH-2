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