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
            % GET_WEIGHTED_CORRELATION_MATRIX creates a correlated matrix
            %
            % A = GET_WEIGHTED_CORRELATION_MATRIX(ANALYSIS, SUBJECTS)
            % creates a correlated matrix using the SUBJECTS data. Applies
            % the ANALYSIS settings to correlate.
            %
            % See also get_graph_for_subjects.
            
            atlases = analysis.cohort.getBrainAtlases();
            atlas = atlases{1};
            
            subject_number = numel(subjects);
            
            data1 = zeros(subject_number, atlas.getBrainRegions().length());
            data2 = zeros(subject_number, atlas.getBrainRegions().length());
            for i = 1:1:subject_number
                subject = subjects{i};
                data1(i, :) = subject.getData('ST_MP1').getValue();  % Structural data layer 1
                data2(i, :) = subject.getData('ST_MP2').getValue();  % Structural data layer 2
            end
            
            correlation_rule = analysis.getSettings('AnalysisST_MP.CorrelationRule');
            negative_weight_rule = analysis.getSettings('AnalysisST_MP.NegativeWeightRule');
            A11 = Correlation.getAdjacencyMatrix(data1, correlation_rule, negative_weight_rule);
            A22 = Correlation.getAdjacencyMatrix(data2, correlation_rule, negative_weight_rule);
            A12 = eye(length(A11));
            A21 = eye(length(A11));
            A = {A11, A12; A21, A22};
        end
        function g = get_graph_for_subjects(analysis, subjects, varargin)
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

            g = get_graph_for_subjects(analysis, subjects);
            
            measure = Measure.getMeasure(measure_code, g, varargin{:});
            measurement_value = measure.getValue();
            measurement_parameter_values = measure.getParameterValues();    

            measurement = Measurement.getMeasurement(analysis.getMeasurementClass(), ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                '', ...  % meaurement label
                '', ...  % meaurement notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group,  ...
                'MeasurementST_MP.Value', measurement_value, ...
                'MeasurementST_MP.ParameterValues', measurement_parameter_values, ...
                varargin{:} ...
                );
        end
%         function randomcomparison = calculate_random_comparison(analysis, measure_code, group, varargin)
%             % rules
%             attemptsPerEdge = analysis.getSettings('AnalysisMRI.AttemptsPerEdge');
%             numerOfWeights = analysis.getSettings('AnalysisMRI.NumberOfWeights');
%             graph_type = analysis.getSettings('AnalysisMRI.GraphType');
%             verbose = analysis.getSettings('AnalysisMRI.ComparisonVerbose');
%             interruptible = analysis.getSettings('AnalysisMRI.ComparionInterruptible');
%             correlation_rule = analysis.getSettings('AnalysisMRI.CorrelationRule');
%             negative_weight_rule = analysis.getSettings('AnalysisMRI.NegativeWeightRule');
%             is_longitudinal = analysis.getSettings('AnalysisMRI.Longitudinal');
%             M = get_from_varargin(1e+3, 'NumerOfPermutations', varargin{:});
%             
%             % get info from subjects
%             subjects = group.getSubjects();
%             subject_class = group.getSubjectClass();
%             atlases = analysis.getCohort().getBrainAtlases();
%             A = zeros(atlases{1}.getBrainRegions().length());
%             for i = 1:1:numel(subjects)
%                 subject = subjects{i};
%                 A(i, :) = subject.getData('MRI').getValue();
%             end
%             
%             % get randomize graphs of subjects
%             g = Graph.getGraph(graph_type, A);
%             [permuted_A, ~] = g.randomize_graph('AttemptsPerEdge', attemptsPerEdge, 'NumberOfWeights', numerOfWeights);
%             
%             % create subjects with new data
%             for i = 1:1:numel(subjects)
%                 info_subject =  permuted_A(i, :);
%                 permuted_subjects{i} = Subject.getSubject(subject_class, atlases{1}, 'MRI', info_subject'); %#ok<AGROW>
%             end
%             
% 
%             permuted_group = Group(subject_class, permuted_subjects, 'GroupName', ['RandomGroup_' group.getName()]);
%             
%             % create Measurements
%             measurement_group = analysis.calculate_measurement(measure_code, group, varargin{:});
%             measurement_random = analysis.calculate_measurement(measure_code, permuted_group, 'is_randomMRI', 1, varargin{:});
%             
%             value_group = measurement_group.getMeasureValue();
%             value_random = measurement_random.getMeasureValue();
%             
%                         
%             for i = 1:1:group.subjectnumber()
%                 subject = subjects{i};
%                 subjects_data_1(:, i) = subject.getData('MRI').getValue();  %#ok<AGROW> % MRI data % here we swaps dimensions to be compatible with permutation
%             end
%             
%             for i = 1:1:permuted_group.subjectnumber()
%                 subject = permuted_subjects{i};
%                 subjects_data_2(:, i) = subject.getData('MRI').getValue(); %#ok<AGROW>
%             end
%             
%             % compare
%             all_permutations_1 = cell(1, M);
%             all_permutations_2 = cell(1, M);
%             
%             start = tic;
%             for i = 1:1:M
%                 if verbose
%                     disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
%                 end
%                 
%                 if is_longitudinal
%                     [permutation_1, permutation_2] = Permutation.permute(subjects_1, subjects_2, is_longitudinal);
%                 else
%                     [permutation_1, permutation_2] = Permutation.permute(subjects_data_1, subjects_data_2, is_longitudinal);
%                 end
%                 
%                 A_permutated_1 = Correlation.getAdjacencyMatrix(permutation_1', correlation_rule, negative_weight_rule);  % swap dimensions again
%                 graph_permutated_1 = Graph.getGraph(graph_type, A_permutated_1, varargin{:});
%                 measure_permutated_1 = Measure.getMeasure(measure_code, graph_permutated_1, varargin{:});
%                 measure_permutated_value_1 = measure_permutated_1.getValue();
%                 
%                 A_permutated_2 = Correlation.getAdjacencyMatrix(permutation_2', correlation_rule, negative_weight_rule);
%                 graph_permutated_2 = Graph.getGraph(graph_type, A_permutated_2, varargin{:});
%                 measure_permutated_2 = Measure.getMeasure(measure_code, graph_permutated_2, varargin{:});
%                 measure_permutated_value_2 = measure_permutated_2.getValue();
%                 
%                 
%                 all_permutations_1(1, i) = {measure_permutated_value_1};
%                 all_permutations_2(1, i) = {measure_permutated_value_2};
%                 
%                 difference_all_permutations{1, i} = measure_permutated_value_2 - measure_permutated_value_1; %#ok<AGROW>
%                 if interruptible
%                     pause(interruptible)
%                 end
%             end
%             
%             difference_mean = cell2mat(value_random) - cell2mat(value_group);  % difference of the mean values of non permuted random group minus the non permuted group 
%             difference_all_permutations = cellfun(@(x) [x], difference_all_permutations, 'UniformOutput', false);  %#ok<NBRAK> % permutated group 1 - permutated group 2
%             
%             p1 = pvalue1(difference_mean, difference_all_permutations);  % singe tail,
%             p2 = pvalue2(difference_mean, difference_all_permutations);  % double tail
%             percentiles = quantiles(difference_all_permutations, 100);
%             if size(percentiles) == [1 1] %#ok<BDSCA>
%                 ci_lower = percentiles{1}(2);
%                 ci_upper = percentiles{1}(40); % 95 percent
%             elseif size(percentiles) == [size(difference_mean, 1) 1] %#ok<BDSCA>
%                 for i = 1:1:length(percentiles)
%                     percentil = percentiles{i};
%                     ci_lower{i, 1} = percentil(2);  %#ok<AGROW>
%                     ci_upper{i, 1} = percentil(40); %#ok<AGROW>
%                 end
%             else
%                 for i = 1:1:size(percentiles, 1)
%                     for j = 1:1:size(percentiles, 2)
%                         percentil = percentiles{i, j};
%                         ci_lower{i, j} = percentil(2); %#ok<AGROW>
%                         ci_upper{i, j} = percentil(40); %#ok<AGROW>
%                     end
%                 end
%             end
%             
%             % create randomComparisonClass
%             randomcomparison = RandomComparison.getRandomComparison('RandomComparisonST_MP_WU', ...
%                 analysis.getRandomComparisonID(measure_code, group, varargin{:}), ...
%                 analysis.getCohort().getBrainAtlases(), group, ...
%                 'RandomComparisonST_MP.measure_code', measure_code, ...
%                 'RandomComparisonST_MP.values_group', value_group, ...
%                 'RandomComparisonST_MP.values_random', value_random, ...
%                 'RandomComparisonST_MP.difference', difference_mean, ...
%                 'RandomComparisonST_MP.all_differences', difference_all_permutations, ...
%                 'RandomComparisonST_MP.p1', p1, ...
%                 'RandomComparisonST_MP.p2', p2, ....
%                 'RandomComparisonST_MP.confidence_min', ci_lower, ...
%                 'RandomComparisonST_MP.confidence_max', ci_upper, ...
%                 'RandomComparisonST_MP.number_of_permutations', M ...
%                 );
%         end
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
            measurements_1 = analysis.getMeasurement(measure_code, group_1, varargin{:});
            value_1 = measurements_1.getMeasureValue();
            
            measurements_2 = analysis.getMeasurement(measure_code, group_2, varargin{:});
            value_2 = measurements_2.getMeasureValue();
            
            difference_mean = cellfun(@(x, y) y - x, value_2, value_1, 'UniformOutput', false);

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
                
                graph_permutated_1 = get_graph_for_subjects(analysis, permutation_subjects_1);
                measure_permutated_1 = Measure.getMeasure(measure_code, graph_permutated_1, varargin{:});
                measure_permutated_value_1 = measure_permutated_1.getValue();

                graph_permutated_2 = get_graph_for_subjects(analysis, permutation_subjects_2);
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
                    p1(i, j) = {pvalue1(difference_mean{1}, difference_all_permutations(i*j, :))};  % singe tail,
                    p2(i, j) = {pvalue2(difference_mean{1}, difference_all_permutations(i*j, :))};  % double tail
                    qtl(i, j) = {quantiles(difference_all_permutations(i, j), 40)};
                    ci_lower(i, j) = {cellfun(@(x) x(2), qtl{i, j})};
                    ci_upper(i, j)  = {cellfun(@(x) x(40), qtl{i, j})};              
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
end