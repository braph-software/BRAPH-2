classdef ComparisonCON_WU < Comparison
    % ComparisonCON_WU A comparison of connectivity data with weighted undirected graphs
    % ComparisonCON_WU is a subclass of Comparison, it implements the
    % initialization of data methods.
    %
    % ComparisonCON_WU implements the initialization of the data which the
    % class will save. It checks if the data being saved has correct
    % dimensions. Connectivity data can be for example MRI or PET data.
    %
    % ComparisonCON_WU constructor methods:
    %  ComparisonCON_WU              - Constructor
    %
    % ComparisonCON_WU basic methods:
    %  disp                         - displays the comparison
    %
    % ComparisonCON_WU get methods:
    %  getGroupValues               - returns the groups measurement value
    %  getGroupValue                - returns the group measurement value
    %  getDifference                - returns the difference between values
    %  getAllDifferences            - returns all the differecens between values
    %  getP1                        - returns the p-values single tail
    %  getP2                        - returns the p-values double tail
    %  getConfidenceIntervalMin     - returns the min value of the confidence interval
    %  getConfidenceIntervalMax     - returns the max value of the confidence interval
    %
    % ComparisonCON_WU initialze data (Access=protected):
    %  initialize_data              - initializes and checks the data
    %
    % ComparisonCON_WU descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getBrainAtlasNumber          - returns the number of brain atlases
    %  getAnalysisClass             - returns the class of the analysis
    %  getSubjectClass              - returns the class of the subject
    %  getAvailbleSettings          - returns the available settings
    %  getComparison                - returns a new comparison
    %
    % ComparisonCON_WU plot methods (Static):
    %  getComparisonSettingsPanel   - returns a UIPanel
    %
    % See also Comparison, AnalysisCON_WU, MeasurementCON_WU, RandomComparisonCON_WU.
    
    properties
        % I want to remove this properties and just a dict
        % the properties of a comparison should not be hard coded
        % this is the dict
        statistic
        comparison_dict
        
    end
    methods  % Constructor
        function c =  ComparisonCON_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % COMPARISONCON_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and GROUP_2. It initializes the
            % COMPARISONCON_WU with default settings.
            %
            % COMPARISONCON_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and GROUP_2. It initializes the
            % COMPARISONCON_WU with VALUE settings.
            %
            % See also MeasurementCON_WU, RandomComparisonCON_WU, AnalysisCON_WU.
            
            graph_type = AnalysisCON_WU.getGraphType();
            measure_list = Graph.getCompatibleMeasureList(graph_type);
            assert(ismember(measure_code, measure_list), ...
                [BRAPH2.STR ':ComparisonCON:' BRAPH2.BUG_FUNC], ...
                'ComparisonCON measure_code is not compatible with the permited Measures.');
            
            c = c@Comparison(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
        end
    end
    methods  % Get functions
        function data = getComparisonProperties(c, key)
            % returns a dict
            if nargin < 2
                data = c.comparison_dict;
            else  % or returns specified key
                data = c.comparison_dict(key);
            end
        end
        function keys_list = getComparisonPropertiesKeys(c)
            data = c.comparison_dict;
            keys_list = keys(data);
        end
        function type = getStatisticType(c)
            type = c.statistic;
        end
    end
    methods (Access=protected)  % Initialize data
        function initialize_data(c, varargin)
            % INITIALIZE_DATA initialize and check the data for the comparison
            %
            % INITIALIZE_DATA(C) initialize and check the data for the
            % comparison. It initializes with default settings.
            %
            % INITIALIZE_DATA(C, PROPERTY, VALUE, ...) initialize and
            % check the data for the comparison. It initializes with VALUE settings.
            % Admissible rules are:
            %  'ComparisonCON.PermutationNumber'  - number of permutations
            %  'ComparisonCON.value_1'            - value of group 1
            %  'ComparisonCON.value_2'            - value of group 2
            %  'ComparisonCON.average_value_1'    - average value of group 1
            %  'ComparisonCON.average_value_2'    - average value of group 2
            %  'ComparisonCON.difference'         - value of difference
            %  'ComparisonCON.all_differences'    - value of all differences
            %  'ComparisonCON.p1'                 - single tail p-value
            %  'ComparisonCON.p2'                 - double tail p-value
            %  'ComparisonCON.confidence_min'     - min value in confidence interval
            %  'ComparisonCON.confidence_max'     - max value in confidence interval
            %
            % See also AnalysisCON_WU.
            
            c.statistic = get_from_varargin('PermutationTest', 'StatisticalTest', varargin{:});
            c.comparison_dict = get_from_varargin([], 'StatisticalDict', varargin{:});
            c.Check()
        end
        function Check(c)
            % this will have to be modified with each addition of statistic
            atlases = c.getBrainAtlases();
            atlas = atlases{1};
            [group_1, group_2]  = c.getGroups();
          
            measure_code = c.getMeasureCode();
            
            if isequal(c.statistic, 'PermutationTest')  % default one
                number_of_permutations =  c.getComparisonProperties('ComparisonCON.PermutationNumber'); %c.getSettings('ComparisonCON.PermutationNumber');
                
                if Measure.is_global(measure_code)  % global measure
                    % values
                    assert(iscell(c.getComparisonProperties('ComparisonCON.values_1')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.values_1')), [1, group_1.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonCON.values_1'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonCON_WU.'])  %#ok<*NBRAK>
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.values_2')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.values_2')), [1, group_2.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonCON.values_2'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonCON_WU.'])
                    
                    % average values
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.average_values_1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.average_values_1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonCON.average_values_1'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.average_values_2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.average_values_2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonCON.average_values_2'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    % statistic measures
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.difference')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.difference')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonCON.difference'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.all_differences')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.all_differences')), [1, number_of_permutations]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonCON.all_differences'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.p1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.p1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonCON.p1'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.p2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.p2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonCON.p2'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.confidence_min')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.confidence_min')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonCON.confidence_min'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.confidence_max')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.confidence_max')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonCON.confidence_max'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                elseif Measure.is_nodal(measure_code)  % nodal measure
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.values_1')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.values_1')), [1, group_1.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonCON.values_1'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonCON_WU.'])
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.values_2')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.values_2')), [1, group_2.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonCON.values_2'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonCON_WU.'])
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.average_values_1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.average_values_1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonCON.average_values_1'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.average_values_2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.average_values_2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonCON.average_values_2'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    % statistic values
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.difference')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.difference')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonCON.difference'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.all_differences')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.all_differences')), [1, number_of_permutations]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonCON.all_differences'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.p1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.p1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonCON.p1'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.p2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.p2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonCON.p2'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.confidence_min')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.confidence_min')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonCON.confidence_min'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.confidence_max')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.confidence_max')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonCON.confidence_max'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                elseif Measure.is_binodal(measure_code)  % binodal measure
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.values_1')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.values_1')), [1, group_1.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonCON.values_1'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonCON_WU.'])
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.values_2')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.values_2')), [1, group_2.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonCON.values_2'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonCON_WU.'])
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.average_values_1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.average_values_1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonCON.average_values_1'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.average_values_2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.average_values_2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonCON.average_values_2'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    % statistic values
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.difference')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.difference')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonCON.difference'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.all_differences')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.all_differences')), [1, number_of_permutations]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonCON.all_differences'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.p1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.p1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonCON.p1'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.p2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.p2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonCON.p2'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.confidence_min')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.confidence_min')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonCON.confidence_min'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonCON.confidence_max')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonCON.confidence_max')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonCON.confidence_max'))), ...
                        [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonCON_WU')
                end
            else
            end
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of connectivity comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % comparison. In this case 'ComparisonCON_WU'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonCON_WU';
        end
        function name = getName()
            % GETNAME returns the name of connectivity comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonCON_WU.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison CON WU';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of connectivity comparison
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonCON_WU.
            %
            % See also getList, getClass, getName.
            
            description = 'Connectivity comparison';
        end
        function atlas_number = getBrainAtlasNumber()
            % GETBRAINATLASNUMBER returns the number of brain atlases
            %
            % ATLAS_NUMBER = GETBRAINATLASNUMBER() returns the number of
            % brain atlases.
            %
            % See also getList, getClass, getName.
            
            atlas_number =  1;
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisCON_WU'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisCON_WU';
        end
        function subject_class = getSubjectClass()
            % GETSUBJETCLASS returns the class of connectivity comparison subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of ComparisonCON_WU subject, 'SubjectCON'.
            %
            % See also getList, getClass, getName, getDescription.
            
            subject_class = 'SubjectCON';
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the available settings of connectivity comparison
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS() returns the
            % available settings of ComparisonCON_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {};
        end
        function sub = getComparison(comparisonClass, id, label, notes, atlas, measure_code, group_1, group_2, varargin) %#ok<INUSD>
            % GETCOMPARISON returns a new comparison
            %
            % SUB = GETCOMPARISON(COMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % returns a new ComparisonCON_WU object with COMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with default settings.
            %
            % SUB = GETCOMPARISON(COMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % returns a new ComparisonCON_WU object with COMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with VALUE settings.
            %
            % See also getClass, getName, getDescription.
            
            sub = eval([comparisonClass '(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:})']);
        end
    end
    methods (Static)  % Plot ComparisonGUI Child Panel
        function handle = getComparisonSettingsPanel(analysis, uiparent, varargin)
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. Modificable settings are: Verbose, Interruptible and
            % Permutation.
            %
            % See also ComparisonST_WU.
            
            statistic_type = get_from_varargin('PermutationTest', 'StatisticsType', varargin{:});
            
            init_Statistic_Panel()
            
            set(uiparent, 'Visible', 'on')
            
            function init_Statistic_Panel()
                handle = Statistics.getStatisticPanel(statistic_type, analysis, uiparent, varargin);
            end
            
        end
    end
end