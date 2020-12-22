classdef AnalysisST_MP_WU < Analysis
    % AnalysisST_MP_WU An analysis of structural multiplex data with weighted undirected graphs
    % AnalysisST_MP_WU is a subclass of Analysis and implements the methods
    % needed for structural multiplex analysis.
    %
    % AnalysisST_MP_WU implements the abstract analysis calculting methods
    % to obtain a structural multiplex measurement, a random comparison or a
    % comparison. AnalysisST_MP_WU also implements the ID methods to get
    % the correct signature of the analysis.
    % Structural multiplex data can be for example MRI or/and PET data.
    %
    % AnalysisST_MP_WU constructor methods:
    %  AnalysisST_MP_WU             - Constructor
    %
    % AnalysisST_MP_WU ID methods:
    %  getMeasurementID             - returns the measurement ID
    %  getRandomComparisonID        - returns the random comparison ID
    %  getComparisonID              - returns the comparison ID
    %
    % AnalysisST_MP_WU graph methods (Access = protected)
    %  get_weighted_correlation_matrix - returns the correlated matrix
    %  get_graph_for_subjects       - returns the graph with the correlated matrix
    %
    % AnalysisST_MP_WU calcultion methods (Access = protected):
    %  calculate_measurement        - returns the measurement
    %  calculate_random_comparison  - returns the random comparison
    %  calculate_comparison         - returns the comparison
    %
    % AnalysisST_MP_WU descriptive methods (Static):
    %  getClass                     - returns the class of the analysis
    %  getName                      - returns the name of the analysis
    %  getDescription               - returns the description of the analysis
    %  getGraphType                 - returns the availble type of graph
    %  getSubjectClass              - returns the class of the subject
    %  getMeasurementClass          - returns the class of the measurement
    %  getRandomComparisonClass     - returns the class of the random comparison
    %  getComparisonClass           - returns the class of the comparison
    %  getAvailbleSettings          - returns the available settings
    %
    % AnalysisST_MP_WU Plot panel methods
    %  getGraphPanel                - creates a uipanel
    %  getGlobalPanel               - creates a global uipanel for GUIAnalysis
    %  getNodalPanel                - creates a nodal uipanel for GUIAnalysis
    %  getGlobalMeasurePlot         - returns a global measurement plot
    %  getGlobalComparisonPlot      - returns a global comparison plot
    %  getGlobalRandomComparisonPlot - returns a global randomcomparison plot
    %  getNodalMeasurePlot          - returns a nodal measure plot
    %  getNodalComparisonPlot       - returns a nodal comparison plot
    %  getNodalRandomComparisonPlot - returns a nodal randomcomparison plot
    %  getBinodalMeasurePlot        - returns a binodal measure plot
    %  getBinodalComparisonPlot     - returns a binodal comparison plot
    %  getBinodalRandomComparisonPlot - returns a binodal randomcomparison plot
    %
    % See also Analysis, MeasurementST_MP_WU, RandomComparisonST_MP_WU, ComparisonST_MP_WU
    
    methods  % Constructor
        function analysis = AnalysisST_MP_WU(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            % ANALYSISST_MP_WU(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates a structural multiplex analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSISST_MP_WU with default settings.
            %
            % ANALYSISST_MP_WU(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates a structural multiplex analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSISST_MP_WU with specified settings VALUES.
            %
            % See also MeasurementST_WU, RandomComparisonST_WU, ComparisonST_WU.
            
            analysis = analysis@Analysis(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin{:});
        end
    end
    methods  % ID functions
        function measurement_id = getMeasurementID(analysis, measure_code, group, varargin)
            % GETMEASUREMENTID returns a measurement ID
            %
            % MEASUREMENT_ID = GETMEASUREMENTID(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % creates a measurement ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and all PROPERTIES and VALUES.
            %
            % See also getRandomComparisonID, getComparisonID.
            
            measurement_id = [ ...
                tostring(analysis.getMeasurementClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group)) ...
                ];
        end
        function randomcomparison_id = getRandomComparisonID(analysis, measure_code, group, varargin)
            % GETRANDOMCOMPARISONID returns a random comparison ID
            %
            % RANDOMCOMPARISON_ID = GETRANDOMCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and all PROPERTIES and VALUES.
            %
            % See also getMeasurementID, getComparisonID.
            
            randomcomparison_id = [ ...
                tostring(analysis.getRandomComparisonClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group)) ...
                ];
        end
        function comparison_id = getComparisonID(analysis, measure_code, group_1, group_2, varargin)
            % GETCOMPARISONID returns a comparison ID
            %
            % COMPARISON_ID = GETCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, GROUP_1 and GROUP_2, and all PROPERTIES and VALUES.
            %
            % See also getMeasurementID, getRandomComparisonID.
            
            comparison_id = [ ...
                tostring(analysis.getComparisonClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group_1)) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group_2)) ...
                ];
        end
    end
    methods (Access = protected)  % graph methods
        function A = get_weighted_correlation_matrix(analysis, subjects, varargin)
%         function A = get_weighted_correlation_matrix(analysis, subjects, matrix1, matrix2, varargin)
            % GET_WEIGHTED_CORRELATION_MATRIX creates a correlated matrix
            %
            % A = GET_WEIGHTED_CORRELATION_MATRIX(ANALYSIS, SUBJECTS)
            % creates a correlated matrix using the SUBJECTS data. Applies
            % the ANALYSIS settings to correlate.
            %
            % See also get_graph_for_subjects.           
            
            subject_number = numel(subjects);
            
            covariates_keys = get_from_varargin({}, 'ST_MP_Covariates', varargin{:});
            correlation_rule = analysis.getSettings('AnalysisST_MP.CorrelationRule');
            negative_weight_rule = analysis.getSettings('AnalysisST_MP.NegativeWeightRule');
            
            for i = 1:1:subject_number
                subject = subjects{i};
                layers = subject.getNumberOfLayers();
                
                for j = 1:1:layers
                    id = ['ST_MP_' num2str(j)];
                    data = subject.getData(id).getValue();
                    
                    covariates = [];
                    for k = 1:1:length(covariates_keys)
                        covs = subject.getData(covariates_keys{k}).getValue();
                        covariates = [covs{:}];  % comma or ;
                    end
                    
                    A{j, j} = Correlation.getAdjacencyMatrix(data', correlation_rule, negative_weight_rule, covariates); %#ok<AGROW>
                end
            end
            
            hold_size = size(A{1,1});
            A(cellfun('isempty', A)) = {eye(hold_size)};
        end
        function g = get_graph_for_subjects(analysis, subjects, varargin)
        %function g = get_graph_for_subjects(analysis, subjects, matrix1, matrix2, varargin)
            % GET_GRAPH_FOR_SUBJECTS returns the graph created with the correlation matrix
            %
            % G = GET_GRAPH_FOR_SUBJECTS(ANALYSIS, SUBJECTS) creates a
            % graph with the correlation matrix made of the data of
            % subjects.
            %
            % G = GET_GRAPH_FOR_SUBJECTS(ANALYSIS, SUBJECTS, PROPERTY, VALUE) creates a
            % graph with the correlation matrix made of the data of
            % subjects.
            % Admissible PROPERTIES are:
            %   AnalysisST_MP.CorrelationRule     - determines which type of
            %                                    correlation function will be used
            %   AnalysisST_MP.NegativeWeightRule  - determines which type of
            %                                    filter will be applied to the matrix
            %
            % See also calculate_measurement.
            
            A = analysis.get_weighted_correlation_matrix(subjects, varargin{:});
            
            graph_type = AnalysisST_MP_WU.getGraphType();
            g = Graph.getGraph(graph_type, A);
        end
    end
    methods (Access = protected)  % Calculation functions
        function measurement = calculate_measurement(analysis, measure_code, group, varargin)
%         function measurement = calculate_measurement(analysis, measure_code, group, matrix1, matrix2, varargin)
            % CALCULATE_MEASUREMENT returns a measurement
            %
            % MEASUREMENT = CALCULTE_MEASUREMENT(ANALYSIS, MEASURE_CODE, GROUP)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subject. It will return a measurement with the
            % calculated measure. The function will utilize default
            % settings.
            %
            % MEASUREMENT = CALCULTE_MEASUREMENT(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subject. It will return a measurement with the
            % calculated measure. The function will utilize VALUE settings.
            %
            % See also calculate_random_comparison, calculate_comparison.
            
            subjects = group.getSubjects();
            g = analysis.get_graph_for_subjects(subjects, varargin{:});
            measure = Measure.getMeasure(measure_code, g, varargin{:});
            measurement_value = measure.getValue();
            measurement_parameter_values = measure.getParameterValues();
            
            % get layers info
            subs = group.getSubjects();
            sub = subs{1};
            layers = sub.getNumberOfLayers();
            
            measurement = Measurement.getMeasurement(analysis.getMeasurementClass(), ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                '', ...  % meaurement label
                '', ...  % meaurement notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group,  ...
                'ST_MP_Layers', layers, ...
                'MeasurementST_MP.Value', measurement_value, ...
                'MeasurementST_MP.ParameterValues', measurement_parameter_values, ...
                varargin{:} ...
                );
        end
        function randomcomparison = calculate_random_comparison(analysis, measure_code, group, varargin)
            % CALCULATE_RANDOM_COMPARISON returns a random comparison
            %
            % RANDOMCOMPARISON = CALCULATE_RANDOM_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subject and random data. It will compare the measures
            % obtained and will return a random comparison. The function
            % will utilize default settings.
            %
            % RANDOMCOMPARISON = CALCULATE_RANDOM_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subject and random data. It will compare the measures
            % obtained and will return a random comparison. The function
            % will utilize VALUE settings.
            % Available PROPERTIES are:
            %  Verbose             - true to display info about the
            %                        randomization cycle, false by default
            %  Interruptible       - true if randomization cycle can be
            %                        interreput, false by default
            %  RandomizationNUmber - number of randomizations
            %  AttemptsPerEdge     - number of swap attempts
            %  NumberOfWeigths     - number of weigths sorted at the same time during randomization
            %
            % See also calculate_measurement, calculate_comparison.
            
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            M = get_from_varargin(1e+3, 'RandomizationNumber', varargin{:});
            attempts_per_edge = get_from_varargin(5, 'AttemptsPerEdge', varargin{:});
            number_of_weights = get_from_varargin(1, 'NumberOfWeights', varargin{:});
            
            % get layers info
            subs = group.getSubjects();
            sub = subs{1};
            layers = sub.getNumberOfLayers();
            
            if Measure.is_superglobal(measure_code)
                rows = 1;
                columns = 1;
            elseif Measure.is_unilayer(measure_code)
                rows = layers;
                columns = 1;
            elseif Measure.is_bilayer(measure_code)
                rows = layers;
                columns = layers;
            end
            
            % Measurements for the group
            measurement_group = analysis.getMeasurement(measure_code, group, varargin{:});
            value_group = measurement_group.getMeasureValue();
            parameter_value_group = measurement_group.getMeasureParameterValues();
            
            g = analysis.get_graph_for_subjects(group.getSubjects(), varargin{:});
            
            % Randomization
            all_randomizations = cell(1, M);
            all_differences = cell(1, M);
            %difference_all_permutations = cell(rows*columns, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                g_random = g.randomize('AttemptsPerEdge', attempts_per_edge, 'NumberOfWeights', number_of_weights);
                measure_random = g_random.getMeasure(measure_code);
                value_randomization = measure_random.getValue();
                
                all_randomizations(i) = {value_randomization};
                all_differences(i) = {cellfun(@(x, y) x - y, value_group, value_randomization, 'UniformOutput', false)};
                
                if interruptible
                    pause(interruptible)
                end
            end
            
            % TODO rewrite following code more elegantly
            value_random = all_randomizations{1};
            for i = 2:1:M
                for j=1:rows
                    for t=1:columns
                        % value_random = value_random + all_randomizations{i};
                        value_random = cellfun(@(x, y) x - y, value_random, all_randomizations{i}, 'UniformOutput', false);
                    end
                end
            end
            value_random = cellfun(@(x) x/M, value_random, 'UniformOutput', false);
            difference = cellfun(@(x, y) x - y, value_group, value_random, 'UniformOutput', false);
            
            all_differences2 = cell(rows*columns, M);
            p1 = cell(rows, columns);
            p2 =  cell(rows, columns);
            qtl = cell(rows, columns);
            ci_lower = cell(rows, columns);
            ci_upper =  cell(rows, columns);
            
            for i=1:rows
                for j=1:columns
                    all_differences2(i*j, :) = cellfun(@(x) x{i, j}, all_differences, 'UniformOutput', false);
                    % Statistical analysis
                    p1(i, j) = {pvalue1(difference{i, j}, all_differences2(i*j, :))};  % singe tail,
                    p2(i, j) = {pvalue2(difference{i, j}, all_differences2(i*j, :))};  % double tail
                    qtl(i, j) = {quantiles(all_differences2(i*j, :), 40)};
                    ci_lower(i, j) = {cellfun(@(x) x(2), qtl{i, j})};
                    ci_upper(i, j)  = {cellfun(@(x) x(40), qtl{i, j})};
                end
            end
            
            % create randomComparisonClass
            randomcomparison = RandomComparison.getRandomComparison(analysis.getRandomComparisonClass(), ...
                analysis.getRandomComparisonID(measure_code, group, varargin{:}), ...
                '', ...  % random comparison label
                '', ...  % random comparison notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group, ...
                'RandomComparisonST_MP.RandomizationNumber', M, ...
                'RandomComparisonST_MP.AttemptsPerEdge', attempts_per_edge, ...
                'RandomComparisonST_MP.NumberOfWeights', number_of_weights, ...
                'RandomComparisonST_MP.value_group', value_group, ...
                'RandomComparisonST_MP.value_random', value_random, ...
                'RandomComparisonST_MP.difference', difference, ...
                'RandomComparisonST_MP.all_differences', all_differences2, ...
                'RandomComparisonST_MP.p1', p1, ...
                'RandomComparisonST_MP.p2', p2, ....
                'RandomComparisonST_MP.confidence_min', ci_lower, ...
                'RandomComparisonST_MP.confidence_max', ci_upper, ...
                'RandomComparisonST_MP.ParameterValues', parameter_value_group, ...
                varargin{:} ...
                );
        end
        function comparison = calculate_comparison(analysis, measure_code, group_1, group_2, varargin)
            % CALCULATE_COMPARISON returns a comparison
            %
            % COMPARISON = CALCULATE_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP_1 subject and GROUP_2 data. It will compare the measures
            % obtained and will return a comparison. The function
            % will utilize default settings.
            %
            % COMPARISON = CALCULATE_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP_1 subject and GROUP_2 data. It will compare the measures
            % obtained and will return a comparison. The function
            % will utilize VALUE settings.
            % Available PROPERTIES are:
            %  Verbose             - true to display info about the
            %                        randomization cycle, false by default
            %  Interruptible       - true if randomization cycle can be
            %                        interreput, false by default
            %  Longitudinal        - checks if the permutation is longitudinal
            %
            % See also calculate_random_comparison, calculate_measurement.
            
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            
            is_longitudinal = analysis.getSettings('AnalysisST_MP.Longitudinal');
            M = get_from_varargin(1e+3, 'PermutationNumber', varargin{:});
            
            if Measure.is_superglobal(measure_code)
                rows = 1;
                columns = 1;
            elseif Measure.is_unilayer(measure_code)
                rows = 2;
                columns = 1;
            elseif Measure.is_bilayer(measure_code)
                rows = 2;
                columns = 2;
            end
            
            % Measurements for groups 1 and 2, and their difference
%             g1matrix1 = get_from_varargin(1e+3, 'CorrelationMatrix1', varargin{:});
%             g1matrix2 = get_from_varargin(1e+3, 'CorrelationMatrix2', varargin{:});
%             measurements_1 = analysis.getMeasurement(measure_code, group_1, g1matrix1, g1matrix2, varargin{:});
            measurements_1 = analysis.getMeasurement(measure_code, group_1, varargin{:});
            value_1 = measurements_1.getMeasureValue();
            
%             g2matrix1 = get_from_varargin(1e+3, 'CorrelationMatrix3', varargin{:});
%             g2matrix2 = get_from_varargin(1e+3, 'CorrelationMatrix4', varargin{:});
%             measurements_2 = analysis.getMeasurement(measure_code, group_2,  g2matrix1, g2matrix2,  varargin{:});
            measurements_2 = analysis.getMeasurement(measure_code, group_2, varargin{:});
            value_2 = measurements_2.getMeasureValue();
            
            difference_mean = cellfun(@(x, y) y - x, value_1, value_2, 'UniformOutput', false);
            
            subjects_1 = group_1.getSubjects();
            subjects_2 = group_2.getSubjects();
            
            % Permutations
            all_permutations_1 = cell(1, M);
            all_permutations_2 = cell(1, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                [permutation_subjects_1, permutation_subjects_2] = permutation(subjects_1, subjects_2, is_longitudinal);
                
                graph_permutated_1 = analysis.get_graph_for_subjects(permutation_subjects_1, varargin{:});
                measure_permutated_1 = Measure.getMeasure(measure_code, graph_permutated_1, varargin{:});
                measure_permutated_value_1 = measure_permutated_1.getValue();
                
                graph_permutated_2 = analysis.get_graph_for_subjects(permutation_subjects_2, varargin{:});
                measure_permutated_2 = Measure.getMeasure(measure_code, graph_permutated_2, varargin{:});
                measure_permutated_value_2 = measure_permutated_2.getValue();
                
                all_permutations_1{1, i} = measure_permutated_value_1;
                all_permutations_2{1, i} = measure_permutated_value_2;
                
                if interruptible
                    pause(interruptible)
                end
            end
            
            difference_all_permutations = cell(rows*columns, M);
            p1 = cell(rows, columns);
            p2 =  cell(rows, columns);
            qtl = cell(rows, columns);
            ci_lower = cell(rows, columns);
            ci_upper =  cell(rows, columns);
            
            for i=1:rows
                for j=1:columns
                    difference_all_permutations(i*j, :) = cellfun(@(x, y) y{i, j} - x{i, j}, all_permutations_1, all_permutations_2, 'UniformOutput', false);
                    % Statistical analysis
                    p1(i, j) = {pvalue1(difference_mean{i, j}, difference_all_permutations(i*j, :))};  % singe tail,
                    p2(i, j) = {pvalue2(difference_mean{i, j}, difference_all_permutations(i*j, :))};  % double tail
                    qtl(i, j) = {quantiles(difference_all_permutations(i*j, :), 40)};
                    ci_lower(i, j) = {cellfun(@(x) x(2), qtl{i, j})};
                    ci_upper(i, j)  = {cellfun(@(x) x(40), qtl{i, j})}; % or 39?
                end
            end
            
            comparison = Comparison.getComparison(analysis.getComparisonClass(), ...
                analysis.getComparisonID(measure_code, group_1, group_2, varargin{:}), ...
                '', ...  % comparison label
                '', ...  % comparison notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group_1, ...
                group_2, ...
                'ComparisonST_MP.PermutationNumber', M, ...
                'ComparisonST_MP.value_1', value_1, ...
                'ComparisonST_MP.value_2', value_2, ...
                'ComparisonST_MP.difference', difference_mean, ...
                'ComparisonST_MP.all_differences', difference_all_permutations, ...
                'ComparisonST_MP.p1', p1, ...
                'ComparisonST_MP.p2', p2, ...
                'ComparisonST_MP.confidence_min', ci_lower, ...
                'ComparisonST_MP.confidence_max', ci_upper, ...
                varargin{:} ...
                );
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            % GETCLASS returns the class of structural multiplex analysis
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % analysis. In this case AnalysisST_WU.
            %
            % See also getList, getName, getDescription.
            
            analysis_class = 'AnalysisST_MP_WU';
        end
        function name = getName()
            % GETNAME returns the name of structural multiplex analysis
            %
            % NAME = GETNAME() returns the name of ANALYSIS.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Analysis Structural Multiplex WU';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural multiplex analysis
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of AnalysisST_WU.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'Analysis based on structural multiplex data in the two layers, ' ...
                'e.g. cortical thickness for each brain region. ' ...
                'It provides a multiplex graph of two layers for each subject group.' ...
                'Structural data can be for example MRI or/and PET data.' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the compatible type of graph
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns the compatible type of
            % graph 'MultiplexGraphWU'.
            %
            % See also getSubjectClass.
            
            graph_type = 'MultiplexGraphWU';
        end
        function subject_class = getSubjectClass()
            % GETSUBJETCLASS returns the class of structural multiplex analysis subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of AnalysisST_MP_WU subject, 'SubjectST_MP'.
            %
            % See also getList, getClass, getName, getDescription.
            
            subject_class = 'SubjectST_MP';
        end
        function measurement_class = getMeasurementClass()
            % GETMEASUREMENTCLASS returns the class of structural multiplex analysis measurement
            %
            % MEASUREMENT_CLASS = GETMEASUREMENT_CLASS() returns the
            % class of AnalysisST_MP_WU measurement, 'MeasurementST_MP_WU'.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class =  'MeasurementST_MP_WU';
        end
        function randomcomparison_class = getRandomComparisonClass()
            % GETRANDOMCOMPARISONCLASS returns the class of structural multiplex analysis randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS()
            % returns the class of AnalysisST_MP_WU randomcomparison,
            % 'RandomComparisonST_MP_WU'.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = 'RandomComparisonST_MP_WU';
        end
        function comparison_class = getComparisonClass()
            % GETCOMPARISONCLASS returns the class of structural multiplex analysis comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS() returns the
            % class of AnalysisST_MP_WU comparison, 'ComparisonST_MP_WU'.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = 'ComparisonST_MP_WU';
        end
        function available_settings = getAvailableSettings(m) %#ok<INUSD>
            % GETAVAILABLESETTINGS returns the available settings of structural multiplex analysis
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS(M) returns the
            % available settings of AnalysisST_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {
                {'AnalysisST_MP.CorrelationRule', BRAPH2.STRING, 'pearson', Correlation.CORRELATION_RULE_LIST}, ...
                {'AnalysisST_MP.NegativeWeightRule', BRAPH2.STRING, 'zero', Correlation.NEGATIVE_WEIGHT_RULE_LIST}, ...
                {'AnalysisST_MP.Longitudinal', BRAPH2.LOGICAL, false, {false, true}}, ...
                };
        end
    end
    methods  % Plot panel functions
        function graph_panel = getGraphPanel(analysis, varargin)
            % GETGRAPHPANEL creates a matrix uipanel
            %
            % GRAPH_PANEL = GETGRAPHPANEL(ANALYSIS, PROPERTY, RULE, ...)
            % creates a uipanel with group selection uicontrol, weighted
            % plot uicontrol, density uicontorol, and threshold uicontrol.
            %
            % See also getClass, getSubjectClass, getGraphType.
            
            ui_parent = get_from_varargin([], 'UIParent', varargin{:});
            ui_parent_axes = get_from_varargin([], 'UIParentAxes', varargin{:});
            
            % groups labels
            groups = analysis.getCohort().getGroups().getValues();
            if ~isempty(groups)
                groups_labels = analysis.getCohort().getGroups().getKeys();
            else
                groups_labels = 'No groups';
            end
            
            % layer labels
            subs = analysis.getCohort().getSubjects().getValues();
            s = subs{1};
            for j = 1:1:s.getNumberOfLayers()
                layers_labels{j} = ['Layer ' num2str(j)]; %#ok<AGROW>
            end
            
            subject_labels = {''};
            selected_group = 1;
            selected_subject = 1;
            selected_layer = 1;
            matrix_plot = [];
            
            
            cla(ui_parent_axes)
            axes(ui_parent_axes)
            
            % create the options     ****************
            % groups popup
            ui_matrix_groups_popup = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'popup');
            set(ui_matrix_groups_popup, 'Position', [.7 .88 .28 .05])  % left bottom width height
            set(ui_matrix_groups_popup, 'TooltipString', 'Select Group')
            set(ui_matrix_groups_popup, 'String', groups_labels)
            set(ui_matrix_groups_popup, 'Callback', {@cb_groups_popup})
            
            % layer popup
            ui_matrix_layers_popup = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'popup');
            set(ui_matrix_layers_popup, 'Position', [.70 .8 .28 .05])
            set(ui_matrix_layers_popup, 'TooltipString', 'Select Layer')
            set(ui_matrix_layers_popup, 'String', layers_labels)
            set(ui_matrix_layers_popup, 'Callback', {@cb_layers_popup})
            
            % weighted
            ui_matrix_weighted_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_weighted_checkbox, 'Position', [.70 .6 .28 .05])
            set(ui_matrix_weighted_checkbox, 'String', 'weighted correlation matrix')
            set(ui_matrix_weighted_checkbox, 'Value', true)
            set(ui_matrix_weighted_checkbox, 'TooltipString', 'Select weighted matrix')
            set(ui_matrix_weighted_checkbox, 'FontWeight', 'bold')
            set(ui_matrix_weighted_checkbox, 'Callback', {@cb_matrix_weighted_checkbox})
            
            % density
            ui_matrix_density_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_density_checkbox, 'Position', [.70 .54 .28 .05])
            set(ui_matrix_density_checkbox, 'String', 'binary correlation matrix (set density)')
            set(ui_matrix_density_checkbox, 'Value', false)
            set(ui_matrix_density_checkbox, 'TooltipString', 'Select binary correlation matrix with a set density')
            set(ui_matrix_density_checkbox, 'Callback', {@cb_matrix_density_checkbox})
            
            ui_matrix_density_edit = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'edit');
            set(ui_matrix_density_edit, 'Position', [.70 .515 .05 .025])
            set(ui_matrix_density_edit, 'String', '50.00');
            set(ui_matrix_density_edit, 'TooltipString', 'Set density.');
            set(ui_matrix_density_edit, 'FontWeight', 'bold')
            set(ui_matrix_density_edit, 'Enable', 'off')
            set(ui_matrix_density_edit, 'Callback', {@cb_matrix_density_edit});
            
            ui_matrix_density_slider = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'slider');
            set(ui_matrix_density_slider, 'Position', [.75 .515 .23 .025])
            set(ui_matrix_density_slider, 'Min', 0, 'Max', 100, 'Value', 50)
            set(ui_matrix_density_slider, 'TooltipString', 'Set density.')
            set(ui_matrix_density_slider, 'Enable', 'off')
            set(ui_matrix_density_slider, 'Callback', {@cb_matrix_density_slider})
            
            % threshold
            ui_matrix_threshold_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_threshold_checkbox, 'Position', [.70 .44 .28 .05])
            set(ui_matrix_threshold_checkbox, 'String', 'binary correlation matrix (set threshold)')
            set(ui_matrix_threshold_checkbox, 'Value', false)
            set(ui_matrix_threshold_checkbox, 'TooltipString', 'Select binary correlation matrix with a set threshold')
            set(ui_matrix_threshold_checkbox, 'Callback', {@cb_matrix_threshold_checkbox})
            
            ui_matrix_threshold_edit = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'edit');
            set(ui_matrix_threshold_edit, 'Position', [.70 .415 .05 .025])
            set(ui_matrix_threshold_edit, 'String', '0.50');
            set(ui_matrix_threshold_edit, 'TooltipString', 'Set threshold.');
            set(ui_matrix_threshold_edit, 'FontWeight', 'bold')
            set(ui_matrix_threshold_edit, 'Enable', 'off')
            set(ui_matrix_threshold_edit, 'Callback', {@cb_matrix_threshold_edit});
            
            ui_matrix_threshold_slider = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'slider');
            set(ui_matrix_threshold_slider, 'Position', [.75 .415 .23 .025])
            set(ui_matrix_threshold_slider, 'Min', -1, 'Max', 1, 'Value', .50)
            set(ui_matrix_threshold_slider, 'TooltipString', 'Set threshold.')
            set(ui_matrix_threshold_slider, 'Enable', 'off')
            set(ui_matrix_threshold_slider, 'Callback', {@cb_matrix_threshold_slider})
            
            % histogram
            ui_matrix_histogram_checkbox = uicontrol('Parent', ui_parent, 'Units', 'normalized', 'Style', 'checkbox');
            set(ui_matrix_histogram_checkbox, 'Position', [.70 .34 .28 .05])
            set(ui_matrix_histogram_checkbox, 'String', 'histogram')
            set(ui_matrix_histogram_checkbox, 'Value', false)
            set(ui_matrix_histogram_checkbox, 'TooltipString', 'Select histogram of correlation coefficients')
            set(ui_matrix_histogram_checkbox, 'Callback', {@cb_matrix_histogram_checkbox})
            
            function cb_layers_popup(~, ~)
                selected_layer = get(ui_matrix_layers_popup, 'Value');
                update_matrix()
            end
            function cb_groups_popup(~, ~)
                selected_group = get(ui_matrix_groups_popup, 'Value');
                set(ui_matrix_layers_popup, 'Value', 1)
                update_layers();
                update_matrix();
            end
            function cb_matrix_weighted_checkbox(~, ~)
                set(ui_matrix_weighted_checkbox, 'Value', true)
                set(ui_matrix_weighted_checkbox, 'FontWeight', 'bold')
                
                set(ui_matrix_histogram_checkbox, 'Value', false)
                set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_density_checkbox, 'Value', false)
                set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_density_edit, 'Enable', 'off')
                set(ui_matrix_density_slider, 'Enable', 'off')
                
                set(ui_matrix_threshold_checkbox, 'Value', false)
                set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_threshold_edit, 'Enable', 'off')
                set(ui_matrix_threshold_slider, 'Enable', 'off')
                
                update_matrix()
            end
            function cb_matrix_density_checkbox(~, ~)
                set(ui_matrix_weighted_checkbox, 'Value', false)
                set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_histogram_checkbox, 'Value', false)
                set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_density_checkbox, 'Value', true)
                set(ui_matrix_density_checkbox, 'FontWeight', 'bold')
                set(ui_matrix_density_edit, 'Enable', 'on')
                set(ui_matrix_density_slider, 'Enable', 'on')
                
                set(ui_matrix_threshold_checkbox, 'Value', false)
                set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_threshold_edit, 'Enable', 'off')
                set(ui_matrix_threshold_slider, 'Enable', 'off')
                
                update_matrix()
            end
            function cb_matrix_threshold_checkbox(~, ~)
                set(ui_matrix_weighted_checkbox, 'Value', false)
                set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_histogram_checkbox, 'Value', false)
                set(ui_matrix_histogram_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_density_checkbox, 'Value', false)
                set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_density_edit, 'Enable', 'off')
                set(ui_matrix_density_slider, 'Enable', 'off')
                
                set(ui_matrix_threshold_checkbox, 'Value', true)
                set(ui_matrix_threshold_checkbox, 'FontWeight', 'bold')
                set(ui_matrix_threshold_edit, 'Enable', 'on')
                set(ui_matrix_threshold_slider, 'Enable', 'on')
                
                update_matrix()
            end
            function cb_matrix_histogram_checkbox(~, ~)
                set(ui_matrix_weighted_checkbox, 'Value', false)
                set(ui_matrix_weighted_checkbox, 'FontWeight', 'normal')
                
                set(ui_matrix_histogram_checkbox, 'Value', true)
                set(ui_matrix_histogram_checkbox, 'FontWeight', 'bold')
                
                set(ui_matrix_density_checkbox, 'Value', false)
                set(ui_matrix_density_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_density_edit, 'Enable', 'off')
                set(ui_matrix_density_slider, 'Enable', 'off')
                
                set(ui_matrix_threshold_checkbox, 'Value', false)
                set(ui_matrix_threshold_checkbox, 'FontWeight', 'normal')
                set(ui_matrix_threshold_edit, 'Enable', 'off')
                set(ui_matrix_threshold_slider, 'Enable', 'off')
                
                update_matrix()
            end
            function cb_matrix_density_edit(~, ~)
                update_matrix();
            end
            function cb_matrix_density_slider(src, ~)
                set(ui_matrix_density_edit, 'String', get(src, 'Value'))
                update_matrix();
            end
            function cb_matrix_threshold_edit(~, ~)
                update_matrix();
            end
            function cb_matrix_threshold_slider(src, ~)
                set(ui_matrix_threshold_edit, 'String', get(src, 'Value'))
                update_matrix();
            end
            function update_layers()
            end
            
            function update_matrix()
                % i need to ask graph to return the plot 'Graph.PlotType'
                if  get(ui_matrix_histogram_checkbox, 'Value') % histogram
                    graph_type_value = 'histogram';
                elseif get(ui_matrix_threshold_checkbox, 'Value')  % threshold
                    graph_type_value = 'binary';
                    graph_rule = 'threshold';
                    graph_rule_value = str2double(get(ui_matrix_threshold_edit, 'String'));
                elseif get(ui_matrix_density_checkbox, 'Value')  % density
                    graph_type_value = 'binary';
                    graph_rule = 'density';
                    graph_rule_value = str2double(get(ui_matrix_density_edit, 'String'));
                else  % weighted correlation
                    graph_type_value = 'correlation';
                    graph_rule = 'nothing';
                    graph_rule_value = 0;
                end
                
                if ~isempty(groups)
                    cla(ui_parent_axes)
                    axes(ui_parent_axes)
                    
                    % get A
                    group = analysis.getCohort().getGroups().getValue(selected_group);
                    subjects = group.getSubjects();
                    A = analysis.get_weighted_correlation_matrix(subjects, varargin{:});
                    
                    if get(ui_matrix_histogram_checkbox, 'Value')
                        matrix_plot = Graph.hist(A, varargin{:});
                    else
                        % get atlas labels
                        atlases = analysis.getCohort().getBrainAtlases();
                        atlas = atlases{1};
                        br_labels = atlas.getBrainRegions().getKeys();
                        matrix_plot = GraphWU.plot(A, ...
                            graph_rule, graph_rule_value, ...
                            'Graph.PlotType', graph_type_value, ...
                            'xlabels', br_labels, ...
                            'ylabels', br_labels, ...
                            varargin{:});
                    end
                end
            end
            
            update_matrix()
            
            if nargout > 0
                graph_panel = matrix_plot;
            end
        end
        function global_panel = getGlobalPanel(analysis, varargin)
            % GETGLOBALPANEL creates the global uipanel for GUIAnalysis
            %
            % GLOBAL_PANEL = GETGLOBALPANEL(ANALYSIS, PROPERTY, VALUE, ...)
            % creates a uipanel that contains information about global
            % measures in Measurement, RandomComparison and Comparison.
            %
            % See also getGraphPanel, getMainPanelMeasurePlot.
            
            global_panel = [];
            
        end
        function nodal_panel = getNodalPanel(analysis, varargin)
            % GETNODALPANEL creates the nodal uipanel for GUIAnalysis
            %
            % NODAL_PANEL = GETNODALPANEL(ANALYSIS, PROPERTY, VALUE, ...)
            % creates a uipanel that contains information about nodal
            % measures in Measurement, RandomComparison and Comparison.
            %
            % See also getGraphPanel, getMainPanelMeasurePlot, getGlobalPanel
            nodal_panel = [];
        end
        function binodal_panel = getBinodalPanel(analysis, varargin)
            % GETBINODALPANEL creates the binodal uipanel for GUIAnalysis
            %
            % BINODAL_PANEL = GETBINODALPANEL(ANALYSIS, PROPERTY, VALUE, ...)
            % creates a uipanel that contains information about binodal
            % measures in Measurement, RandomComparison and Comparison.
            %
            % See also getGraphPanel, getMainPanelMeasurePlot, getGlobalPanel
            
            binodal_panel = ui_mainpanel;
            
        end
        function p = getGlobalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, varargin) %#ok<INUSD>
            % GETGLOBALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getGlobalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group_1, group_2, varargin) %#ok<INUSD>
            % GETGLOBALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getGlobalRandomComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group, varargin) %#ok<INUSD>
            % GETGLOBALRANDOMCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETGLOBALRANDOMCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the global
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getNodalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region, varargin) %#ok<INUSD>
            % GETNODALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP, BRAINREGION, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getNodalPanel.
            
            p = [];
        end
        function p = getNodalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group_1, group_2, brain_region, varargin) %#ok<INUSD>
            % GETNODALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAIN_REGION, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getNodalRandomComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region, varargin) %#ok<INUSD>
            % GETNODALRANDOMCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALRANDOMCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2,  BRAINREGION, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getBinodalMeasurePlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region_1, brain_region_2, varargin) %#ok<INUSD>
            % GETBINODALMEASUREPLOT creates a uipanel to contain a plot
            %
            % P = GETBINODALMEASUREPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP,  BRAINREGION1,  BRAINREGION2, PROPERTY, VLAUE)
            % creates a uipanel to contain the plot displayed in the nodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getBinodalPanel.
            
            p = [];
        end
        function p = getBinodalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group_1, group_2, brain_region_1, brain_region_2, varargin) %#ok<INUSD>
            % GETNODALCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAINREGION1,  BRAINREGION2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the binodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getBinodalRandomComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, measure_code, group, brain_region_1, brain_region_2, varargin) %#ok<INUSD>
            % GETNODALRANDOMCOMPARISONPLOT creates a uipanel to contain a plot
            %
            % P = GETNODALRANDOMCOMPARISONPLOT(ANALYSIS, UIPARENTPANEL, UIPARENTAXES, GROUP 1, GROUP 2, BRAINREGION1,  BRAINREGION2, PROPERTY, VALUE, ...)
            % creates a uipanel to contain the plot displayed in the binodal
            % measure panel for GUIAnalysis.
            %
            % See also getGraphPanel, getGlobalPanel.
            
            p = [];
        end
        function p = getBrainView(analysis, varargin)
            % GETBRAINVIEW creates a brain view panel for GUIAnalysis
            %
            % P = GETBRAINVIEW(ANALYSIS, PROPERTY, RULE, ...) creates a
            % brain view panel for GUIAnalysis.
            %
            % See also getGlobalPanel, getNodalPanel, getBinodalPanel.
            
            p = [];
        end
        function brain_graph_panel = getBrainGraphPanel(analysis, brain_axes, brain_graph)
            % GETBRAINGRAPHPANEL creates a braingraph panel
            %
            % BRAIN_GRAPH_PANEL = GETBRAINGRAPHPANEL(ANAlYSIS, AXES, PLOTBRAINGRAPH)
            % creates a brain graph panel to manage the type of
            % PLOTBRAINGRAPH that the GUIAnalysis plots in the AXES.
            %
            % See also getBrainView,
            
            brain_graph_panel = [];
        end
        function h = getMCRPanel(analysis, brain_axes, bg)
            % sets position of figure
            
            h = [];
        end
    end
    methods (Static)  % Save and load functions
        function analysis = load_from_xls(tmp, varargin)
        end
        function save_to_xls(analysis, varargin)
        end
        function analysis = load_from_json(tmp, varargin)
            raw = JSON.Deserialize(varargin{:});
            
            if isa(tmp, 'Analysis')
                analysis = tmp;
                subject_class = analysis.getCohort().getSubjectClass(); %#ok<NASGU>
            else
                cohort = tmp;
                analysis_id = raw.ID;
                analysis_label = raw.Label;
                analysis_notes = raw.Notes;
                type_of_analysis = raw.Analysis;
                
                if isequal(type_of_analysis, 'AnalysisST_MP_WU')
                    analysis = AnalysisST_MP_WU(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
                elseif isequal(type_of_analysis, 'AnalysisST_MP_BUT')
                    analysis = AnalysisST_MP_BUT(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
                elseif isequal(type_of_analysis, 'AnalysisST_MP_BUD')
                    analysis = AnalysisST_MP_BUD(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
                else
                    errordlg('Type of Analysis does not exist.');
                end
            end
            measurements_idict = analysis.getMeasurements();
            comparisons_idict = analysis.getComparisons();
            random_comp_idict = analysis.getRandomComparisons();
            
            % measurements idict
            for i = 1:1:length(raw.Measurements)
                group =  cohort.getGroups().getValue(raw.Measurements(i).group);
                measurement = Measurement.getMeasurement(analysis.getMeasurementClass(), ...
                    raw.Measurements(i).id, ...
                    raw.Measurements(i).label, ...  % meaurement label
                    raw.Measurements(i).notes, ...  % meaurement notes
                    analysis.getCohort().getBrainAtlases(), ...
                    raw.Measurements(i).measure, ...
                    group,  ...
                    'MeasurementST.Value', num2cell(raw.Measurements(i).value', 1), ...
                    varargin{:});
                measurements_idict.add(measurement.getID(), measurement, i);
            end
            % comparison idict
            for i = 1:1:length(raw.Comparisons)
                comparison = Comparison.getComparison(analysis.getComparisonClass(), ...
                    raw.Comparisons(i).id, ...
                    raw.Comparisons(i).label, ...  % comparison label
                    raw.Comparisons(i).notes, ...  % comparison notes
                    analysis.getCohort().getBrainAtlases(), ...
                    raw.Comparisons(i).measure, ...
                    cohort.getGroups().getValue(raw.Comparisons(i).group1), ...
                    cohort.getGroups().getValue(raw.Comparisons(i).group2), ...
                    'ComparisonST_MP.value_1', num2cell(raw.Comparisons(i).value1', 1)', ...
                    'ComparisonST_MP.value_2', num2cell(raw.Comparisons(i).value2', 1)', ...
                    'ComparisonST_MP.difference', num2cell(raw.Comparisons(i).difference', 1)', ...
                    'ComparisonST_MP.all_differences', reshape(num2cell(raw.Comparisons(i).alldifferences', 1), 2, []), ...
                    'ComparisonST_MP.p1', num2cell(raw.Comparisons(i).p1', 1)', ...
                    'ComparisonST_MP.p2', num2cell(raw.Comparisons(i).p2', 1)', ...
                    'ComparisonST_MP.confidence_min', num2cell(raw.Comparisons(i).confidencemin', 1)', ...
                    'ComparisonST_MP.confidence_max', num2cell(raw.Comparisons(i).confidencemax', 1)', ...
                    varargin{:});
                
                comparisons_idict.add(comparison.getID(), comparison, i);
            end
            % randomcomparisons idict
            for i = 1:1:length(raw.RandomComparisons)
                random_comparison = RandomComparison.getRandomComparison(analysis.getRandomComparisonClass(), ...
                    raw.RandomComparisons(i).id, ...
                    raw.RandomComparisons(i).label, ...  % comparison label
                    raw.RandomComparisons(i).notes, ...  % comparison notes
                    analysis.getCohort().getBrainAtlases(), ...
                    raw.RandomComparisons(i).measure, ...
                    cohort.getGroups().getValue(raw.RandomComparisons(i).group), ...
                    'RandomComparisonST_MP.value_group', num2cell(raw.RandomComparisons(i).value', 1)', ...
                    'RandomComparisonST_MP.value_random', num2cell(raw.RandomComparisons(i).ranvalue', 1)', ...
                    'RandomComparisonST_MP.difference',  num2cell(raw.RandomComparisons(i).difference', 1)', ...
                    'RandomComparisonST_MP.all_differences', reshape(num2cell(raw.RandomComparisons(i).alldifferences', 1), 2, []), ...
                    'RandomComparisonST_MP.p1', num2cell(raw.RandomComparisons(i).p1', 1)', ...
                    'RandomComparisonST_MP.p2', num2cell(raw.RandomComparisons(i).p2', 1)', ....
                    'RandomComparisonST_MP.confidence_min', num2cell(raw.RandomComparisons(i).confidencemin', 1)', ...
                    'RandomComparisonST_MP.confidence_max', num2cell(raw.RandomComparisons(i).confidencemax', 1)', ...
                    varargin{:});
                
                random_comp_idict.add(random_comparison.getID(), random_comparison, i);
            end
        end
        function structure = save_to_json(analysis, varargin)
             % get info
            cohort = analysis.getCohort();
            atlases = cohort.getBrainAtlases();
            atlas = atlases{1};
            analysis_class = analysis.getClass();
            measurements = analysis.getMeasurements().getValues();
            comparisons = analysis.getComparisons().getValues();
            random_comparisons = analysis.getRandomComparisons().getValues();
            
            % create structs
            Measurements_structure = struct;
            Comparisons_structure = struct;
            RandomComparisons_structure = struct;
            
            % fill info into structures
            for i = 1:1:length(measurements)
                meas = measurements{i};
                Measurements_structure(i).id = meas.getID();
                Measurements_structure(i).label = meas.getLabel();
                Measurements_structure(i).notes = meas.getNotes();
                Measurements_structure(i).measure = meas.getMeasureCode();
                Measurements_structure(i).group = meas.getGroup().getID();
                Measurements_structure(i).value = meas.getMeasureValue();
            end
            for i = 1:1:length(comparisons)
                comp = comparisons{i};
                [g1, g2] = comp.getGroups();
                Comparisons_structure(i).id = comp.getID();
                Comparisons_structure(i).label = comp.getLabel();
                Comparisons_structure(i).notes = comp.getNotes();
                Comparisons_structure(i).measure = comp.getMeasureCode();
                Comparisons_structure(i).group1 = g1.getID();
                Comparisons_structure(i).group2 = g2.getID();
                Comparisons_structure(i).value1 = comp.getGroupValue(1);
                Comparisons_structure(i).value2 = comp.getGroupValue(2);
                Comparisons_structure(i).difference = comp.getDifference();
                Comparisons_structure(i).alldifferences = comp.getAllDifferences();
                Comparisons_structure(i).p1 = comp.p1;
                Comparisons_structure(i).p2 = comp.p2;
                Comparisons_structure(i).confidencemin = comp.getConfidenceIntervalMin();
                Comparisons_structure(i).confidencemax = comp.getConfidenceIntervalMax();
            end
            for i = 1:1:length(random_comparisons)
                ran_comp = random_comparisons{i};
                RandomComparisons_structure(i).id = ran_comp.getID();
                RandomComparisons_structure(i).label = ran_comp.getLabel();
                RandomComparisons_structure(i).notes = ran_comp.getNotes();
                RandomComparisons_structure(i).measure = ran_comp.getMeasureCode();
                RandomComparisons_structure(i).group = ran_comp.getGroup().getID();
                RandomComparisons_structure(i).value = ran_comp.getGroupValue();
                RandomComparisons_structure(i).ranvalue = ran_comp.getRandomValue();
                RandomComparisons_structure(i).difference = ran_comp.getDifference();
                RandomComparisons_structure(i).alldifferences = ran_comp.getAllDifferences();
                RandomComparisons_structure(i).p1 = ran_comp.p1;
                RandomComparisons_structure(i).p2 = ran_comp.p2;
                RandomComparisons_structure(i).confidencemin = ran_comp.getConfidenceIntervalMin();
                RandomComparisons_structure(i).confidencemax = ran_comp.getConfidenceIntervalMax();
            end
            
            %create analysis structure
            structure = struct( ...
                'Braph', BRAPH2.NAME, ...
                'Build', BRAPH2.BUILD, ...
                'Analysis', analysis_class, ...
                'ID', analysis.getID(), ...
                'Label', analysis.getLabel(), ...
                'Notes', analysis.getNotes(), ...
                'Cohort', SubjectST_MP.save_to_json(cohort), ...
                'Measurements', Measurements_structure, ...
                'Comparisons', Comparisons_structure, ...
                'RandomComparisons', RandomComparisons_structure ...
                );
        end
    end
end