classdef ComparisonST_MP_WU < Comparison
    % ComparisonST_MP_WU A comparison of structural multiplex data with weighted undirected graphs
    % ComparisonST_MP_WU is a subclass of Comparison, it implements the
    % initialization of data methods.
    %
    % ComparisonST_MP_WU implements the initialization of the data which the
    % class will save. It checks if the data being saved has correct
    % dimensions. Structural multiplex data can be for example MRI or/and PET data.
    %
    % ComparisonST_MP_WU constructor methods:
    %  ComparisonST_MP_WU           - Constructor
    %
    % ComparisonST_MP_WU basic methods:
    %  disp                         - displays the comparison
    % 
    % ComparisonST_MP_WU get methods:
    %  getGroupValues               - returns the groups measurement value
    %  getGroupValue                - returns the group measurement value
    %  getDifference                - returns the difference between values
    %  getAllDifferences            - returns all the differecens between values
    %  getP1                        - returns the p-values single tail
    %  getP2                        - returns the p-values double tail
    %  getConfidenceIntervalMin     - returns the min value of the confidence interval
    %  getConfidenceIntervalMax     - returns the max value of the confidence interval
    %  getMeasureParameterValues    - returns the values of the measure's parameter
    %
    % ComparisonST_MP_WU initialze data (Access=protected):
    %  initialize_data              - initializes and checks the data
    %
    % ComparisonST_MP_WU descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getBrainAtlasNumber          - returns the number of brain atlases
    %  getAnalysisClass             - returns the class of the analysis
    %  getSubjectClass              - returns the class of the subject
    %  getAvailbleSettings          - returns the available settings
    %  getComparison                - returns a new comparison
    %
    % ComparisonST_MP_WU plot methods (Static):
    %  getComparisonSettingsPanel   - returns a UIPanel
    % 
    % See also Comparison, AnalysisST_MP_WU, MeasurementST_MP_WU, RandomComparisonST_MP_WU. 
  
    properties
%         value_1  % array with the value_1 of the measure for each subject of group 1
%         value_2  % array with the value_1 of the measure for each subject of group 1
%         difference  % difference
%         all_differences  % all differences obtained through the permutation test
%         p1  % p value single tailed
%         p2  % p value double tailed
%         confidence_interval_min  % min value of the 95% confidence interval
%         confidence_interval_max  % max value of the 95% confidence interval
%         parameter_values  % parameter values of the measure
%         
%         
        
        % I want to remove this properties and just a dict
        % the properties of a comparison should not be hard coded
        % this is the dict
        statistic
        comparison_dict
        parameter_values  
    end
    methods  % Constructor
        function c =  ComparisonST_MP_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % COMPARISONST_MP_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2) 
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and GROUP_2. It initializes the
            % COMPARISONST_MP_WU with default settings.
            %
            % COMPARISONST_MP_WU(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...) 
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP_1 and GROUP_2. It initializes the
            % COMPARISONST_MP_WU with VALUE settings.
            %
            % See also MeasurementST_MP_WU, RandomComparisonST_MP_WU, AnalysisST_MP_WU.
            
            graph_type = AnalysisST_MP_WU.getGraphType();
            measure_list = Graph.getCompatibleMeasureList(graph_type);            
            assert(ismember(measure_code, measure_list), ...
                [BRAPH2.STR ':ComparisonST_MP:' BRAPH2.BUG_FUNC], ...
                'ComparisonST_MP measure_code is not compatible with the permited Measures.');            

            c = c@Comparison(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
        end
    end
    methods  % Basic function
        function disp(c)
            % DISP overrides Comparison disp
            %
            % DISP(M) overrides Comparison disp and displays additional
            % information about the difference of the ComparisonST_MP_WU.
            % 
            % See also Comparison
            
            c.disp@Comparison()
            disp(['value group 2 (' tostring(size(c.value_1{1}, 1)) 'x' tostring(size(c.value_1{1}, 2)) ') = {' tostring(c.value_1{1}) '}' ])
            disp(['value group 2 (' tostring(size(c.value_2{1}, 1)) 'x' tostring(size(c.value_2{1}, 2)) ') = {' tostring(c.value_2{1}) '}' ])
            disp(['difference (' tostring(size(c.difference{1}, 1)) 'x' tostring(size(c.difference{1}, 2)) ') = {' tostring(c.difference{1}) '}' ])
            disp(['p1 (' tostring(size(c.p1{1}, 1)) 'x' tostring(size(c.p1{1}, 2)) ') = {' tostring(c.p1{1}) '}' ])
            disp(['p2 (' tostring(size(c.p2{1}, 1)) 'x' tostring(size(c.p2{1}, 2)) ') = {' tostring(c.p2{1}) '}' ])
            disp(['confidence interval min (' tostring(size(c.confidence_interval_min{1}, 1)) 'x' tostring(size(c.confidence_interval_min{1}, 2)) ') = {' tostring(c.confidence_interval_min{1}) '}' ])
            disp(['confidence interval max (' tostring(size(c.confidence_interval_max{1}, 1)) 'x' tostring(size(c.confidence_interval_max{1}, 2)) ') = {' tostring(c.confidence_interval_max{1}) '}' ])
        end
    end
    methods  % Get functions
        function data = getComparisonProperties(c, key)
            % GETCOMPARISONPROPERTIES returns the comparison property or properties
            %
            % DATA = GETCOMPARISONPROPERTIES(C) returns all the properties
            % in a dictionary structure.
            % 
            % DATA = GETCOMPARISONPROPERTIES(C, KEY) returns the property
            % specified by the KEY.
            % 
            % See also getComparisonPropertiesKeys, getStatisticType.

            % returns a dict
            if nargin < 2
                data = c.comparison_dict;
            else  % or returns specified key                
                data = c.comparison_dict(key);
            end
        end
        function keys_list = getComparisonPropertyKeys(c)
            % GETCOMPARISONPROPERTYKEYS returns the comparison property keys
            %
            % KET_LIST = GETCOMPARISONPROPERTYKEYS(C) returns all the keys.
            %
            % See also getComparisonProperties, getStatisticType.

            data = c.comparison_dict;
            keys_list = keys(data);
        end
        function type = getStatisticType(c)
            % GETSTATISTICTYPE returns the comparison statistic analysis type
            %
            % TYPE = GETCOMPARISONPROPERTYKEYS(C) returns the type of
            % statistic.
            %
            % See also getComparisonProperties, getStatisticType.

            type = c.statistic;
        end
        function [value_1, value_2] = getGroupValues(c)
            % GETGROUPVALUES returns the measure values of both groups
            %
            % [VALUE_1, VALUE_2] = GETGROUPVALUES(C) returns the measure 
            % values of both groups.
            % 
            % See also getGroupValue, getDifference, getAllDifferences.
            
            value_1 = c.value_1;
            value_2 = c.value_2;
        end
        function value = getGroupValue(c, group_index)
            % GETGROUPVALUE returns the measure value of specified group
            %
            % VALUE = GETGROUPVALUE(C, GROUP_INDEX) returns the measure value of 
            % specified group.
            % 
            % See also getGroupValues, getDifference, getAllDifferences.
            
            if group_index == 1
                value = c.value_1;
            else
                value = c.value_2;
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
        function parameter_values = getMeasureParameterValues(c)
            % GETMEASUREPARAMETERVALUES returns the values of the measure's parameter
            %
            % PARAMETER_VALUES = GETMEASUREPARAMETERVALUES(C) returns the values
            % of the measure parameter of the comparison.
            %
            % See also getGroupValue, getGroupValues, getDifference, getAllDifferences.
            
            parameter_values = c.parameter_values;
        end
    end
    methods (Access=protected)  % Initialize data
        function initialize_data(c, varargin)
            % INITIALIZE_DATA initialize  the data for the comparison
            %
            % INITIALIZE_DATA(C) initialize the data for the
            % comparison.
            %
            % See also check
            
            c.statistic = get_from_varargin('PermutationTest', 'StatisticalTest', varargin{:});
            c.comparison_dict = get_from_varargin([], 'StatisticalDict', varargin{:});
            c.parameter_values = get_from_varargin( ...
                [], ...  % 1 dimension minimum
                'ComparisonST_MP.ParameterValues', ...
                varargin{:});
            c.check()
        end
        function check(c)
            % CHECK checks the data for the comparison
            %
            % CHECK(C) checks the data for the
            % comparison. Admissible rules for Permutation Test are:
            %  'ComparisonST_MP.PermutationNumber'  - number of permutations
            %  'ComparisonST_MP.value_1'            - value of group 1
            %  'ComparisonST_MP.value_2'            - value of group 2
            %  'ComparisonST_MP.difference'         - value of difference
            %  'ComparisonST_MP.all_differences'    - value of all differences
            %  'ComparisonST_MP.p1'                 - single tail p-value
            %  'ComparisonST_MP.p2'                 - double tail p-value
            %  'ComparisonST_MP.confidence_min'     - min value in confidence interval
            %  'ComparisonST_MP.confidence_max'     - max value in confidence interval
            %
            % See also initialize_data.

            % this will have to be modified with each addition of statistic
            atlases = c.getBrainAtlases();
            atlas = atlases{1};
            [group_1, group_2]  = c.getGroups();

            measure_code = c.getMeasureCode();

            parameter_values_length = max(1, length(c.parameter_values));

            if isequal(c.statistic, 'PermutationTest')  && ~isempty(c.comparison_dict)  % default one
                number_of_permutations =  c.getComparisonProperties('ComparisonST_MP.PermutationNumber'); %c.getSettings('ComparisonST_MP.PermutationNumber');

                if iscell(number_of_permutations)
                    number_of_permutations = number_of_permutations{:};
                end

                if Measure.is_superglobal(measure_code)  % superglobal measure
                    rows = 1;
                    columns = 1;
                elseif Measure.is_unilayer(measure_code)  % unilayer measure
                    rows = 2;
                    columns = 1;
                elseif Measure.is_bilayer(measure_code)  % bilayer measure
                    rows = 2;
                    columns = 2;
                end

                if Measure.is_global(measure_code)  % global measure
                    % group values
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.value_1')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.value_1')), [1, rows, columns, group_1.subjectnumber]) & ...
                        all(all(cellfun(@(x) isequal(size(x, 1), 1), c.getComparisonProperties('ComparisonST_MP.value_1')))) & ...
                        all(all(cellfun(@(x) isequal(size(x, 2), 1), c.getComparisonProperties('ComparisonST_MP.value_1')))) & ...
                        all(all(cellfun(@(x) isequal(size(x, 3), parameter_values_length), m.getMeasureValues()))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonST_MP_WU.'])  %#ok<*NBRAK>


                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.value_2')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.value_2')), [1, group_2.subjectnumber]) & ...
                        all(all(cellfun(@(x) isequal(size(x, 1), 1), c.getComparisonProperties('ComparisonST_MP.value_2')))) & ...
                        all(all(cellfun(@(x) isequal(size(x, 2), 1), c.getComparisonProperties('ComparisonST_MP.value_2')))) & ...
                        all(all(cellfun(@(x) isequal(size(x, 3), parameter_values_length), m.getMeasureValues()))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonST_MP_WU.'])

                    % statistic measures
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.difference')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.difference')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonST_MP.difference'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')


                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.all_differences')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.all_differences')), [1, number_of_permutations]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonST_MP.all_differences'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')


                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.p1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.p1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonST_MP.p1'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')


                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.p2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.p2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonST_MP.p2'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')


                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.confidence_min')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.confidence_min')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonST_MP.confidence_min'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')


                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.confidence_max')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.confidence_max')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [1, 1]), c.getComparisonProperties('ComparisonST_MP.confidence_max'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')

                elseif Measure.is_nodal(measure_code)  % nodal measure
                    % group values
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.value_1')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.value_1')), [1, group_1.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonST_MP.value_1'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonST_MP_WU.'])

                    
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.value_2')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.value_2')), [1, group_2.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonST_MP.value_2'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonST_MP_WU.'])

                    % statistic values
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.difference')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.difference')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonST_MP.difference'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')

                    
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.all_differences')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.all_differences')), [1, number_of_permutations]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonST_MP.all_differences'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')

                    
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.p1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.p1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonST_MP.p1'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')

                    
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.p2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.p2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonST_MP.p2'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')

                    
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.confidence_min')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.confidence_min')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonST_MP.confidence_min'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')

                    
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.confidence_max')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.confidence_max')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), 1]), c.getComparisonProperties('ComparisonST_MP.confidence_max'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')

                    
                elseif Measure.is_binodal(measure_code)  % binodal measure
                    % group values
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.value_1')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.value_1')), [1, group_1.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonST_MP.value_1'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonST_MP_WU.'])


                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.value_2')) & ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.value_2')), [1, group_2.subjectnumber]) & ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonST_MP.value_2'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2.WRONG_INPUT], ...
                        ['Data not compatible with ComparisonST_MP_WU.'])


                    % statistic values
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.difference')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.difference')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonST_MP.difference'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')

                    
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.all_differences')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.all_differences')), [1, number_of_permutations]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonST_MP.all_differences'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')

                    
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.p1')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.p1')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonST_MP.p1'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')

                    
                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.p2')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.p2')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonST_MP.p2'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')


                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.confidence_min')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.confidence_min')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonST_MP.confidence_min'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')


                    assert(iscell(c.getComparisonProperties('ComparisonST_MP.confidence_max')) && ...
                        isequal(size(c.getComparisonProperties('ComparisonST_MP.confidence_max')), [1, 1]) && ...
                        all(cellfun(@(x) isequal(size(x), [atlas.getBrainRegions().length(), atlas.getBrainRegions().length()]), c.getComparisonProperties('ComparisonST_MP.confidence_max'))), ...
                        [BRAPH2.STR ':ComparisonST_MP_WU:' BRAPH2. WRONG_INPUT], ...
                        'Data not compatible with ComparisonST_MP_WU')
                end
            else
            end
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural multiplex comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % comparison. In this case 'ComparisonST_MP_WU'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonST_MP_WU';
        end
        function name = getName()
            % GETNAME returns the name of structural multiplex comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonST_MP_WU.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Structural Multiplex WU';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural multiplex comparison
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonST_MP_WU.
            %
            % See also getList, getClass, getName.
            
            description = 'Structural multiplex comparison using weighted graphs.';
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
            % analysis the comparison is part of, 'AnalysisST_MP_WU'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_MP_WU';
        end
        function subject_class = getSubjectClass()
            % GETSUBJETCLASS returns the class of structural multiplex comparison subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of ComparisonST_MP_WU subject, 'SubjectST_MP'.
            %
            % See also getList, getClass, getName, getDescription.
            
            subject_class = 'SubjectST_MP';
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the available settings of structural multiplex comparison
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS() returns the 
            % available settings of ComparisonST_MP_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {
                'ComparisonST_MP.PermutationNumber', BRAPH2.NUMERIC, 1000, {};
                };
        end
        function sub = getComparison(comparisonClass, id, label, notes, atlas, group_1, group_2, varargin) %#ok<INUSD>
            % GETCOMPARISON returns a new comparison
            %
            % SUB = GETCOMPARISON(COMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % returns a new ComparisonST_MP_WU object with COMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with default settings.
            % 
            % SUB = GETCOMPARISON(COMPARISON_CLASS, ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % returns a new ComparisonST_MP_WU object with COMPARISON_CLASS,
            % ID, LABEL, NOTES, ATLAS. The measure will be MEASURE_CODE and
            % it will initialize with VALUE settings.
            %
            % See also getClass, getName, getDescription.
            
            sub = eval([comparisonClass '(id, label, notes, atlas, group_1, group_2, varargin{:})']);
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
            % See also ComparisonST_MP_WU.

            statistic_type = get_from_varargin('PermutationTest', 'StatisticsType', varargin{:});

            init_Statistic_Panel()
            
            set(uiparent, 'Visible', 'on')
            
            function init_Statistic_Panel()
                handle = Statistics.getStatisticPanel(statistic_type, analysis, uiparent, varargin);
            end
        end
    end
end