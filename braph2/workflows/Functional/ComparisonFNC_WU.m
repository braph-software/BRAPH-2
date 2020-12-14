classdef ComparisonFNC_WU < Comparison
    % ComparisonFNC_WU A comparison of functional data with weighted undirected graphs
    % ComparisonFNC_WU is a subclass of Comparison, it implements the
    % initialization of data methods.
    %
    % ComparisonFNC_WU implements the initialization of the data which the
    % class will save. It checks if the data being saved has correct
    % dimensions. Functional data can be for example fMRI data.
    %
    % ComparisonFNC_WU constructor methods:
    %  ComparisonFNC_WU             - Constructor
    %
    % ComparisonFNC_WU basic methods:
    %  disp                         - displays the comparison
    %
    % ComparisonFNC_WU get methods:
    %  getGroupValues               - returns the groups measurement value
    %  getGroupValue                - returns the group measurement value
    %  getDifference                - returns the difference between values
    %  getAllDifferences            - returns all the differecens between values
    %  getP1                        - returns the p-values single tail
    %  getP2                        - returns the p-values double tail
    %  getConfidenceIntervalMin     - returns the min value of the confidence interval
    %  getConfidenceIntervalMax     - returns the max value of the confidence interval
    %
    % ComparisonFNC_WU initialze data (Access=protected):
    %  initialize_data              - initializes and checks the data
    %
    % ComparisonFNC_WU descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getBrainAtlasNumber          - returns the number of brain atlases
    %  getAnalysisClass             - returns the class of the analysis
    %  getSubjectClass              - returns the class of the subject
    %  getAvailbleSettings          - returns the available settings
    %  getComparison                - returns a new comparison
    %
    % ComparisonFNC_WU plot methods (Static):
    %  getComparisonSettingsPanel   - returns a UIPanel
    %
    % See also Comparison, AnalysisFNC_WU, MeasurementFNC_WU, RandomComparisonFNC_WU.
    
    properties
        statistic
        comparison_dict
        
    end
    methods  % Constructor
        function c =  ComparisonFNC_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % COMPARISONFNC_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and GROUP_2. It initializes the
            % COMPARISONFNC_WU with default settings.
            %
            % COMPARISONFNC_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and GROUP_2. It initializes the
            % COMPARISONFNC_WU with VALUE settings.
            %
            % See also MeasurementFNC_WU, RandomComparisonFNC_WU, AnalysisFNC_WU.
            
            graph_type = AnalysisFNC_WU.getGraphType();
            measure_list = Graph.getCompatibleMeasureList(graph_type);
            assert(ismember(measure_code, measure_list), ...
                [BRAPH2.STR ':ComparisonFNC:' BRAPH2.BUG_FUNC], ...
                'ComparisonFNC measure_code is not compatible with the permited Measures.');
            
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
            %  'ComparisonFNC.PermutationNumber'  - number of permutations
            %  'ComparisonFNC.value_1'            - value of group 1
            %  'ComparisonFNC.value_2'            - value of group 2
            %  'ComparisonFNC.average_value_1'    - average value of group 1
            %  'ComparisonFNC.average_value_2'    - average value of group 2
            %  'ComparisonFNC.difference'         - value of difference
            %  'ComparisonFNC.all_differences'    - value of all differences
            %  'ComparisonFNC.p1'                 - single tail p-value
            %  'ComparisonFNC.p2'                 - double tail p-value
            %  'ComparisonFNC.confidence_min'     - min value in confidence interval
            %  'ComparisonFNC.confidence_max'     - max value in confidence interval
            %
            % See also AnalysisFNC_WU.
            c.statistic = get_from_varargin('PermutationTest', 'StatisticalTest', varargin{:});
            c.comparison_dict = get_from_varargin([], 'StatisticalDict', varargin{:});
            c.Check()
        end
        function Check(c)
            atlases = c.getBrainAtlases();
            atlas = atlases{1};
            [group_1, group_2]  = c.getGroups();
            
            measure_code = c.getMeasureCode();
            if isequal(c.statistic, 'PermutationTest') && ~isempty(c.comparison_dict)
                number_of_permutations = c.getSettings('ComparisonFNC.PermutationNumber');
                
                if Measure.is_global(measure_code)  % global measure
                    % values
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.values_1')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.values_1')), [1, group_1.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonFNC.values_1'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonFNC_WU.'])  %#ok<*NBRAK>
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.values_2')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.values_2')), [1, group_2.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonFNC.values_2'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonFNC_WU.'])
                    
                    % average values
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.average_values_1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.average_values_1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonFNC.average_values_1'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2.WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.average_values_2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.average_values_2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonFNC.average_values_2'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2.WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                    % statistic measures
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.difference')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.difference')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonFNC.difference'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.all_differences')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.all_differences')), [1, number_of_permutations]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonFNC.all_differences'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.p1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.p1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonFNC.p1'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.p2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.p2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonFNC.p2'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.confidence_min')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.confidence_min')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonFNC.confidence_min'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.confidence_max')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.confidence_max')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonFNC.confidence_max'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                elseif Measure.is_nodal(measure_code)  % nodal measure
                  
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.values_1')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.values_1')), [1, group_1.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonFNC.values_1'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonFNC_WU.'])
                    
                  
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.values_2')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.values_2')), [1, group_2.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonFNC.values_2'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonFNC_WU.'])
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.average_values_1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.average_values_1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonFNC.average_values_1'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.average_values_2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.average_values_2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonFNC.average_values_2'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                    % statistic values
                    
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.difference')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.difference')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonFNC.difference'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.all_differences')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.all_differences')), [1, number_of_permutations]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonFNC.all_differences'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.p1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.p1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonFNC.p1'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                  
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.p2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.p2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonFNC.p2'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.confidence_min')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.confidence_min')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonFNC.confidence_min'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.confidence_max')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.confidence_max')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonFNC.confidence_max'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                elseif Measure.is_binodal(measure_code)  % binodal measure
                  
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.values_1')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.values_1')), [1, group_1.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonFNC.values_1'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonFNC_WU.'])
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.values_2')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.values_2')), [1, group_2.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonFNC.values_2'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonFNC_WU.'])
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.average_values_1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.average_values_1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonFNC.average_values_1'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.average_values_2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.average_values_2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonFNC.average_values_2'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                    % statistic values
                    
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.difference')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.difference')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonFNC.difference'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.all_differences')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.all_differences')), [1, number_of_permutations]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonFNC.all_differences'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.p1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.p1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonFNC.p1'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                   
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.p2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.p2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonFNC.p2'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                    
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.confidence_min')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.confidence_min')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonFNC.confidence_min'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                    
                  
                    assert(iscell(c.getComparisonProperties('ComparisonFNC.confidence_max')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonFNC.confidence_max')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonFNC.confidence_max'))), ...
                        [BRAPH2.STR ':ComparisonFNC_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonFNC_WU')
                end
            end
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of functional comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % comparison. In this case 'ComparisonFNC_WU'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonFNC_WU';
        end
        function name = getName()
            % GETNAME returns the name of functional comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonFNC_WU.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison FNC WU';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional comparison
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonFNC_WU.
            %
            % See also getList, getClass, getName.
            
            description = 'Functional comparison';
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
            % analysis the comparison is part of, 'AnalysisFNC_WU'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisFNC_WU';
        end
        function subject_class = getSubjectClass()
            % GETSUBJETCLASS returns the class of functional comparison subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of ComparisonFNC_WU subject, 'SubjectFNC'.
            %
            % See also getList, getClass, getName, getDescription.
            
            subject_class = 'SubjectFNC';
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the available settings of functional comparison
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS() returns the
            % available settings of ComparisonFNC_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {
                'ComparisonFNC.PermutationNumber', BRAPH2.NUMERIC, 1000, {};
                };
        end
        function sub = getComparison(comparisonClass, id, label, notes, atlas, measure_code, group_1, group_2, varargin) %#ok<INUSD>
            % GETCOMPARISON returns a new comparison
            %
            % SUB = GETCOMPARISON(COMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % returns a new ComparisonFNC_WU object with COMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with default settings.
            %
            % SUB = GETCOMPARISON(COMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % returns a new ComparisonFNC_WU object with COMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with VALUE settings.
            %
            % See also getClass, getName, getDescription.
            
            sub = eval([comparisonClass '(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:})']);
        end
    end
    methods (Static)  % Plot ComparisonGUI Child Panel
        function handle = getComparisonSettingsPanel(analysis, uiparent) %#ok<INUSL>
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. Modificable settings are: Verbose, Interruptible and
            % Permutation.
            %
            % See also ComparisonST_WU.
            
            set(uiparent, 'Visible', 'on')
            
            ui_permutation_text = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'text');
            ui_permutation_edit = uicontrol('Parent', uiparent, 'Units', 'normalized', 'Style', 'edit');
            init_child_panel()
            function init_child_panel()
                
                set(ui_permutation_text, 'String', 'Permutation Number')
                set(ui_permutation_text, 'Position', [.01 .8 .47 .14])
                set(ui_permutation_text, 'Fontweight', 'bold')
                
                set(ui_permutation_edit, 'String', 1000)
                set(ui_permutation_edit, 'Position', [.5 .87 .45 .08])
                set(ui_permutation_edit, 'Callback', {@cb_comparison_permutation})
            end
            
            function cb_comparison_permutation(~, ~)
                setappdata(uiparent, 'permutation', str2double(get(ui_permutation_edit, 'String')))
            end
            handle.variables = [];
            handle.permutation = ui_permutation_edit;
            setappdata(uiparent, 'permutation', str2double(get(ui_permutation_edit, 'String')))
        end
    end
end