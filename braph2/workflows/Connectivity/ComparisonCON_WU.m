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
        values_1  % array with the values_1 of the measure for each subject of group 1
        values_2  % array with the values_1 of the measure for each subject of group 1
        average_value_1  % average value of group 1
        average_value_2  % average value of group 1
        difference  % difference
        all_differences  % all differences obtained through the permutation test
        p1  % p value single tailed
        p2  % p value double tailed
        confidence_interval_min  % min value of the 95% confidence interval
        confidence_interval_max  % max value of the 95% confidence interval
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
        function [values_1, values_2] = getGroupValues(c)
            % GETGROUPVALUES returns the measure values of both groups
            %
            % [VALUE_1, VALUE_2] = GETGROUPVALUES(C) returns the measure
            % values of both groups.
            %
            % See also getGroupValue, getDifference, getAllDifferences.
            
            values_1 = c.values_1;
            values_2 = c.values_2;
        end
        function values = getGroupValue(c, group_index)
            % GETGROUPVALUE returns the measure value of specified group
            %
            % VALUE = GETGROUPVALUE(C, GROUP_INDEX) returns the measure value of
            % specified group.
            %
            % See also getGroupValues, getDifference, getAllDifferences.
            
            if group_index == 1
                values = c.values_1;
            else
                values = c.values_2;
            end
        end
        function [average_value_1, average_value_2] = getGroupAverageValues(c)
            % GETGROUPAVERAGEVALUES returns the measure average value of the groups
            %
            % [AVERAGEVALUE1, AVERAGEVALUE2] = GETGROUPAVERAGEVALUES(C)
            % returns the measures average values.
            %
            % See also getGroupValues, getDifference, getGroupAverageValue.
            
            average_value_1 = c.average_value_1;
            average_value_2 = c.average_value_2;
        end
        function average_value = getGroupAverageValue(c, group_index)
            % GETGROUPAVERAGEVALUE returns the measure average value of specified group
            %
            % AVERAGE_VALUE = GETGROUPAVERAGEVALUE(C, GROUP_INDEX) returns
            % the measure value of specified group.
            %
            % See also getGroupValues, getDifference, getGroupAverageValues.
            
            if group_index == 1
                average_value = c.average_value_1;
            else
                average_value = c.average_value_2;
            end
        end
        function difference = getDifference(c)
            % GETDIFFERENCE returns the difference between measure values
            %
            % DIFFERENCE = GETDIFFERENCE(C) returns the difference between
            % measure values of both groups. This difference is the mean of
            % all differences.
            %
            % See also getGroupValue, getGroupValues, getAllDifferences.
            
            difference = c.difference;
        end
        function all_differences = getAllDifferences(c)
            % GETALLDIFFERENCES returns the all differences between measure values
            %
            % ALL_DIFFERENCES = GETALLDIFFERENCE(C) returns all differences between
            % measure values of both groups.
            %
            % See also getGroupValue, getGroupValues, getDifference.
            
            all_differences = c.all_differences;
        end
        function p1 = getP1(c)
            % GETP1 returns the single tail p-value of the comparison
            %
            % P1 = GETP1(C) returns the single tail p-value of the comparison
            %
            % See also getP2, getConfidenceIntervalMin, getConfidenceIntervalMax.
            
            p1 = c.p1;
        end
        function p2 = getP2(c)
            % GETP2 returns the double tail p-value of the comparison
            %
            % P2 = GETP2(C) returns the double tail p-value of the comparison
            %
            % See also getP1, getConfidenceIntervalMin, getConfidenceIntervalMax.
            
            p2 = c.p2;
        end
        function confidence_interval_min = getConfidenceIntervalMin(c)
            % GETCONFIDENCEINTERVALMIN returns minimum value of the confidence interval
            %
            % CONFIDENCE_INTERVAL_MIN = GETCONFIDENCEINTERVALMIN(C)
            % returns minimum value of the confidence interval
            %
            % See also getP1, getP2, getConfidenceIntervalMax.
            
            confidence_interval_min = c.confidence_interval_min;
        end
        function confidence_interval_max = getConfidenceIntervalMax(c)
            % GETCONFIDENCEINTERVALMAX returns maximum value of the confidence interval
            %
            % CONFIDENCE_INTERVAL_MAX = GETCONFIDENCEINTERVALMAX(C)
            % returns maximum value of the confidence interval
            %
            % See also getP1, getP2, getConfidenceIntervalMin.
            
            confidence_interval_max = c.confidence_interval_max;
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
            
            atlases = c.getBrainAtlases();
            atlas = atlases{1};
            [group_1, group_2]  = c.getGroups();
            
            measure_code = c.getMeasureCode();
            
            number_of_permutations = c.getSettings('ComparisonCON.PermutationNumber');
            
            if Measure.is_global(measure_code)  % global measure
                % values
                c.values_1 = get_from_varargin( ...
                    repmat({0}, 1, group_1.subjectnumber()), ...
                    'ComparisonCON.values_1', ...
                    varargin{:});
                assert(iscell(c.getGroupValue(1)) & ...
                    isequal(size(c.getGroupValue(1)), [1, group_1.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getGroupValue(1))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with ComparisonCON_WU.'])  %#ok<*NBRAK>
                
                c.values_2 = get_from_varargin( ...
                    repmat({0}, 1, group_2.subjectnumber()), ...
                    'ComparisonCON.values_2', ...
                    varargin{:});
                assert(iscell(c.getGroupValue(2)) & ...
                    isequal(size(c.getGroupValue(2)), [1, group_2.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getGroupValue(2))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with ComparisonCON_WU.'])
                
                % average values
                c.average_value_1 = get_from_varargin( ...
                    {0}, ...
                    'ComparisonCON.average_values_1', ...
                    varargin{:});
                assert(iscell(c.getGroupAverageValue(1)) && ...
                    isequal(size(c.getGroupAverageValue(1)), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getGroupAverageValue(1))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.average_value_2 = get_from_varargin( ...
                    {0}, ...
                    'ComparisonCON.average_values_2', ...
                    varargin{:});
                assert(iscell(c.getGroupAverageValue(2)) && ...
                    isequal(size(c.getGroupAverageValue(2)), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getGroupAverageValue(2))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                % statistic measures
                c.difference = get_from_varargin( ...
                    {0}, ...
                    'ComparisonCON.difference', ...
                    varargin{:});
                assert(iscell(c.getDifference()) && ...
                    isequal(size(c.getDifference()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getDifference())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.all_differences = get_from_varargin( ...
                    repmat({0}, 1, number_of_permutations), ...
                    'ComparisonCON.all_differences', ...
                    varargin{:});
                assert(iscell(c.getAllDifferences()) && ...
                    isequal(size(c.getAllDifferences()), [1, number_of_permutations]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getAllDifferences())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.p1 = get_from_varargin( ...
                    {0}, ...
                    'ComparisonCON.p1', ...
                    varargin{:});
                assert(iscell(c.getP1()) && ...
                    isequal(size(c.getP1()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getP1())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.p2 = get_from_varargin( ...
                    {0}, ...
                    'ComparisonCON.p2', ...
                    varargin{:});
                assert(iscell(c.getP2()) && ...
                    isequal(size(c.getP2()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getP2())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.confidence_interval_min = get_from_varargin( ...
                    {0}, ...
                    'ComparisonCON.confidence_min', ...
                    varargin{:});
                assert(iscell(c.getConfidenceIntervalMin()) && ...
                    isequal(size(c.getConfidenceIntervalMin()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getConfidenceIntervalMin())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.confidence_interval_max = get_from_varargin( ...
                    {0}, ...
                    'ComparisonCON.confidence_max', ...
                    varargin{:});
                assert(iscell(c.getConfidenceIntervalMax()) && ...
                    isequal(size(c.getConfidenceIntervalMax()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [1, 1]), c.getConfidenceIntervalMax())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
            elseif Measure.is_nodal(measure_code)  % nodal measure
                c.values_1 = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, group_1.subjectnumber()), ...
                    'ComparisonCON.values_1', ...
                    varargin{:});
                assert(iscell(c.getGroupValue(1)) & ...
                    isequal(size(c.getGroupValue(1)), [1, group_1.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getGroupValue(1))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with ComparisonCON_WU.'])
                
                c.values_2 = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, group_2.subjectnumber()), ...
                    'ComparisonCON.values_2', ...
                    varargin{:});
                assert(iscell(c.getGroupValue(2)) & ...
                    isequal(size(c.getGroupValue(2)), [1, group_2.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getGroupValue(2))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with ComparisonCON_WU.'])
                
                c.average_value_1 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'ComparisonCON.average_values_1', ...
                    varargin{:});
                assert(iscell(c.getGroupAverageValue(1)) && ...
                    isequal(size(c.getGroupAverageValue(1)), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getGroupAverageValue(1))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.average_value_2 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'ComparisonCON.average_values_2', ...
                    varargin{:});
                assert(iscell(c.getGroupAverageValue(2)) && ...
                    isequal(size(c.getGroupAverageValue(2)), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getGroupAverageValue(2))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                % statistic values
                c.difference = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'ComparisonCON.difference', ...
                    varargin{:});
                assert(iscell(c.getDifference()) && ...
                    isequal(size(c.getDifference()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getDifference())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.all_differences = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length(), 1)}, 1, number_of_permutations), ...
                    'ComparisonCON.all_differences', ...
                    varargin{:});
                assert(iscell(c.getAllDifferences()) && ...
                    isequal(size(c.getAllDifferences()), [1, number_of_permutations]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getAllDifferences())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.p1 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'ComparisonCON.p1', ...
                    varargin{:});
                assert(iscell(c.getP1()) && ...
                    isequal(size(c.getP1()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getP1())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.p2 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'ComparisonCON.p2', ...
                    varargin{:});
                assert(iscell(c.getP2()) && ...
                    isequal(size(c.getP2()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getP2())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.confidence_interval_min = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'ComparisonCON.confidence_min', ...
                    varargin{:});
                assert(iscell(c.getConfidenceIntervalMin()) && ...
                    isequal(size(c.getConfidenceIntervalMin()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getConfidenceIntervalMin())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.confidence_interval_max = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length(), 1)}, ...
                    'ComparisonCON.confidence_max', ...
                    varargin{:});
                assert(iscell(c.getConfidenceIntervalMax()) && ...
                    isequal(size(c.getConfidenceIntervalMax()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getConfidenceIntervalMax())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
            elseif Measure.is_binodal(measure_code)  % binodal measure
                c.values_1 = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, group_1.subjectnumber()), ...
                    'ComparisonCON.values_1', ...
                    varargin{:});
                assert(iscell(c.getGroupValue(1)) & ...
                    isequal(size(c.getGroupValue(1)), [1, group_1.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getGroupValue(1))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with ComparisonCON_WU.'])
                
                c.values_2 = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, group_2.subjectnumber()), ...
                    'ComparisonCON.values_2', ...
                    varargin{:});
                assert(iscell(c.getGroupValue(2)) & ...
                    isequal(size(c.getGroupValue(2)), [1, group_2.subjectnumber]) & ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getGroupValue(2))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2.WRONG_INPUT], ...
                    ['Data not compatible with ComparisonCON_WU.'])
                
                c.average_value_1 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'ComparisonCON.average_values_1', ...
                    varargin{:});
                assert(iscell(c.getGroupAverageValue(1)) && ...
                    isequal(size(c.getGroupAverageValue(1)), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getGroupAverageValue(1))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.average_value_2 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'ComparisonCON.average_values_2', ...
                    varargin{:});
                assert(iscell(c.getGroupAverageValue(2)) && ...
                    isequal(size(c.getGroupAverageValue(2)), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getGroupAverageValue(2))), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                % statistic values
                c.difference = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'ComparisonCON.difference', ...
                    varargin{:});
                assert(iscell(c.getDifference()) && ...
                    isequal(size(c.getDifference()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getDifference())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.all_differences = get_from_varargin( ...
                    repmat({zeros(atlas.getBrainRegions().length())}, 1, number_of_permutations), ...
                    'ComparisonCON.all_differences', ...
                    varargin{:});
                assert(iscell(c.getAllDifferences()) && ...
                    isequal(size(c.getAllDifferences()), [1, number_of_permutations]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getAllDifferences())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.p1 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'ComparisonCON.p1', ...
                    varargin{:});
                assert(iscell(c.getP1()) && ...
                    isequal(size(c.getP1()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getP1())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.p2 = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'ComparisonCON.p2', ...
                    varargin{:});
                assert(iscell(c.getP2()) && ...
                    isequal(size(c.getP2()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getP2())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.confidence_interval_min = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'ComparisonCON.confidence_min', ...
                    varargin{:});
                assert(iscell(c.getConfidenceIntervalMin()) && ...
                    isequal(size(c.getConfidenceIntervalMin()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getConfidenceIntervalMin())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
                
                c.confidence_interval_max = get_from_varargin( ...
                    {zeros(atlas.getBrainRegions().length())}, ...
                    'ComparisonCON.confidence_max', ...
                    varargin{:});
                assert(iscell(c.getConfidenceIntervalMax()) && ...
                    isequal(size(c.getConfidenceIntervalMax()), [1, 1]) && ...
                    all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getConfidenceIntervalMax())), ...
                    [BRAPH2.STR ':ComparisonCON_WU:' BRAPH2. WRONG_INPUT], ...
                    'Data not compatible with ComparisonCON_WU')
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
            
            available_settings = {
                'ComparisonCON.PermutationNumber', BRAPH2.NUMERIC, 1000, {};
                };
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
        function handle = getComparisonSettingsPanel(analysis, uiparent, varargin) %#ok<INUSL>
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. Modificable settings are: Verbose, Interruptible and
            % Permutation.
            %
            % See also ComparisonST_WU.
            
            statistic_type = get_from_varargin('PermutationTest', 'StatisticsType', varargin{:});
            
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