classdef AnalysisFNC_MP_WU < Analysis
    % AnalysisFNC_MP_WU An analysis of functional multiplex data with weighted undirected graphs
    % AnalysisFNC_MP_WU is a subclass of Analysis and implements the methods
    % needed for functional multiplex analysis.
    %
    % AnalysisFNC_MP_WU implements the abstract analysis calculting methods
    % to obtain a functional measurement, a random comparison or a
    % comparison. AnalysisFNC_MP_WU also implements the ID methods to get
    % the correct signature of the analysis.
    % Connectivity data can be for example fMRI data.
    %
    % AnalysisFNC_MP_WU constructor methods:
    %  AnalysisFNC_MP_WU               - Constructor
    %
    % AnalysisFNC_MP_WU ID methods:
    %  getMeasurementID             - returns the measurement ID
    %  getRandomComparisonID        - returns the random comparison ID
    %  getComparisonID              - returns the comparison ID
    %
    % AnalysisFNC_MP_WU calcultion methods (Access = protected):
    %  get_graph_for_group          - returns the graph of the correlated matrix
    %  get_graph_for_subject        - returns the graph of the correlated matrix
    %  calculate_measurement        - returns the measurement
    %  calculate_random_comparison  - returns the random comparison
    %  calculate_comparison         - returns the comparison
    %
    % AnalysisFNC_MP_WU descriptive methods (Static):
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
    % AnalysisFNC_MP_WU Plot panel methods
    %  getGraphPanel                - creates a uipanel
    %  getGlobalPanel               - creates a global uipanel for GUIAnalysis
    %  getNodalPanel                - creates a nodal uipanel for GUIAnalysis
    %  getGlobalMeasurePlot         - returns a global measurement plot
    %  getGlobalComparisonPlot      - returns a global comparison plot
    %  getGlobalRandomComparisonPlot - returns a global randomcomparison plot
    %  getNodalMeasurePlot          - returns a nodal measure plot
    %  getNodalComparisonPlot       - returns a nodal comparison plot
    %  getNodalRandomComparisonPlot - returns a nodal randomcomparison plot
    %  getBinodalMeasurePlot      - returns a binodal measure plot
    %  getBinodalComparisonPlot   - returns a binodal comparison plot
    %  getBinodalRandomComparisonPlot - returns a binodal randomcomparison plot
    %
    % See also Analysis, MeasurementCON_WU, RandomComparisonCON_WU, ComparisonCON_WU
    
    methods  % Constructor
        function analysis = AnalysisFNC_MP_WU(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            % ANALYSISFNC_WU(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates a functional analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSISFNC_WU with default settings.
            %
            % ANALYSISFNC_WU(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates a functional analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSISFNC_WU with specified settings VALUES.
            %
            % See also MeasurementFNC_WU, RandomComparisonFNC_WU, ComparisonFNC_WU.
            
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
    methods (Access = protected)  % Calculation functions
        function graphs = get_graphs_for_group(analysis, group, varargin)
            % GET_GRAPH_FOR_GROUP returns the graphs created with the group data
            %
            % G = GET_GRAPH_FOR_GROUP(ANALYSIS, GROUP) creates graphs
            % with the correlation matrix made of the data of subjects of
            % the group
            %
            % See also calculate_measurement.
            
            % will return an array of graphs
            subjects = group.getSubjects();
            subject_number = numel(subjects);
            graphs = cell(1, subject_number);
            T = analysis.getSettings('AnalysisFNC.Repetition');
            fmin = analysis.getSettings('AnalysisFNC.FrecuencyRuleMin');
            fmax = analysis.getSettings('AnalysisFNC.FrecuencyRuleMax');
            covariates_keys = get_from_varargin({}, 'FNC_MP_Covariates', varargin{:});
            T = str2double(T);
            fmin = str2double(fmin);
            fmax = str2double(fmax);
            
            for i = 1:1:subject_number
                subject = subjects{i};
                layers = subject.getNumberOfLayers();
                
                for j = 1:1:layers
                    id = ['FNC_MP_' num2str(j)];
                    data = subject.getData(id).getValue();
                    
                    for k = 1:1:length(covariates_keys)
                        covs = subject.getData(covariates_keys{k}).getValue();
                        covariates = [covs{:}];  % comma or ;
                    end
                    
                    % filter data
                    fs = 1 / T;
                    if fmax > fmin && T > 0
                        NFFT = 2 * ceil(size(data, 1) / 2);
                        ft = fft(data, NFFT);  % Fourier transform
                        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
                        ft(f < fmin | f > fmax, :) = 0;
                        data = ifft(ft, NFFT);
                    end
                    
                    correlation_rule = analysis.getSettings('AnalysisFNC.CorrelationRule');
                    negative_weight_rule = analysis.getSettings('AnalysisFNC.NegativeWeightRule');
                    A{j, j} = Correlation.getAdjacencyMatrix(data', correlation_rule, negative_weight_rule, covariates);  %#ok<AGROW> % correlation is a column based operation
                end
                
                A(cellfun('isempty', A)) = eye(length(A(1,1)));
                
                graph_type = analysis.getGraphType();
                g = Graph.getGraph(graph_type, A);
                graphs{i} = g;
            end
        end
        function graph = get_graph_for_subject(analysis, subject, varargin)
            % GET_GRAPH_FOR_SUBJECT returns the graph created with the correlation matrix
            %
            % G = GET_GRAPH_FOR_SUBJECT(ANALYSIS, SUBJECT, PROPERY, VALUE, ...) creates a
            % graph with the correlation matrix made of the data of
            % subject. It will binarize the matrix depending on the
            % PROPERTY and VALUE.
            %
            % See also calculate_measurement.
            
            T = analysis.getSettings('AnalysisFNC.Repetition');
            fmin = analysis.getSettings('AnalysisFNC.FrecuencyRuleMin');
            fmax = analysis.getSettings('AnalysisFNC.FrecuencyRuleMax');
            layers = subject.getNumberOfLayers();            
            covariates_keys = get_from_varargin({}, 'FNC_MP_Covariates', varargin{:});
            
            correlation_rule = analysis.getSettings('AnalysisFNC.CorrelationRule');
            negative_weight_rule = analysis.getSettings('AnalysisFNC.NegativeWeightRule');
            
            T = str2double(T);
            fmin = str2double(fmin);
            fmax = str2double(fmax);
            
            for j = 1:1:layers
                id = ['FNC_MP_' num2str(j)];
                data = subject.getData(id).getValue();
                
                for k = 1:1:length(covariates_keys)
                    covs = subject.getData(covariates_keys{k}).getValue();
                    covariates = [covs{:}];  % comma or ;
                end
                
                % filter data
                fs = 1 / T;
                if fmax > fmin && T > 0
                    NFFT = 2 * ceil(size(data, 1) / 2);
                    ft = fft(data, NFFT);  % Fourier transform
                    f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
                    ft(f < fmin | f > fmax, :) = 0;
                    data = ifft(ft, NFFT);
                end
                
                A{j, j} = Correlation.getAdjacencyMatrix(data', correlation_rule, negative_weight_rule, covariates_rule, covariates);  %#ok<AGROW> % correlation is a column based operation
            end
            
            A(cellfun('isempty', A)) = eye(length(A(1,1)));
            
            graph_type = analysis.getGraphType();
            graph = Graph.getGraph(graph_type, A);
        end
        function measurement = calculate_measurement(analysis, measure_code, group, varargin) %#ok<*INUSL>
            % CALCULATE_MEASUREMENT returns a measurement
            %
            % MEASUREMENT = CALCULTE_MEASUREMENT(ANALYSIS, MEASURE_CODE, GROUP)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subjects. It will return a measurement with the
            % calculated measure. The function will utilize default
            % settings.
            %
            % MEASUREMENT = CALCULTE_MEASUREMENT(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subjects. It will return a measurement with the
            % calculated measure. The function will utilize VALUE settings.
            %
            % See also calculate_random_comparison, calculate_comparison.
            
            graphs = analysis.get_graphs_for_group(group, varargin{:});
            measures = cell(1, group.subjectnumber());
            for i = 1:1:group.subjectnumber()
                measure = Measure.getMeasure(measure_code, graphs{i}, varargin{:});
                measurement_parameter_values{i} = measure.getParameterValues(); %#ok<AGROW>
                measures{i} = cell2mat(measure.getValue());
            end
            
            % get layers info
            subs = group.getSubjects();
            sub = subs{1};
            layers = sub.getNumberOfLayers();
            
            measure_average = mean(reshape(cell2mat(measures), [size(measures{1}, 1), size(measures{1}, 2), group.subjectnumber()]), 3);
            
            measurement = Measurement.getMeasurement(analysis.getMeasurementClass(), ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                '', ...  % meaurement label
                '', ...  % meaurement notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group,  ...
                'FNC_MP_Layers', layers, ...
                'MeasurementFNC_MP.values', measures, ...
                'MeasurementFNC_MP.average_value', measure_average, ...
                'MeasurementFNC_MP.ParameterValues', measurement_parameter_values, ...
                varargin{:});
        end
        function randomcomparison = calculate_random_comparison(analysis, measure_code, group, varargin)
            % CALCULATE_RANDOM_COMPARISON returns a random comparison
            %
            % RANDOMCOMPARISON = CALCULATE_RANDOM_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subjects and random data. It will compare the measures
            % obtained and will return a random comparison. The function
            % will utilize default settings.
            %
            % RANDOMCOMPARISON = CALCULATE_RANDOM_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP subjects and random data. It will compare the measures
            % obtained and will return a random comparison. The function
            % will utilize VALUE settings.
            %
            % See also calculate_measurement, calculate_comparison.
            
            % rules
            attempts_per_edge = get_from_varargin(5, 'AttemptsPerEdge', varargin{:});
            number_of_weights = get_from_varargin(1, 'NumberOfWeights', varargin{:});
            verbose = get_from_varargin(false, 'Verbose', varargin{:});
            interruptible = get_from_varargin(0.001, 'Interruptible', varargin{:});
            M = get_from_varargin(1e+3, 'RandomizationNumber', varargin{:});
            
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
            
            % Measurements for the group
            measurement_group = analysis.getMeasurement(measure_code, group, varargin{:});
            values_group = measurement_group.getMeasureValues();
            parameter_value_group = measurement_group.getMeasureParameterValues();
            average_value_group = mean(reshape(cell2mat(values_group), [size(values_group{1}, 1), size(values_group{1}, 2), group.subjectnumber()]), 3);
            
            graphs = analysis.get_graphs_for_group(group, varargin{:});
            
            % Randomization
            all_randomizations = cell(1, M);
            all_differences = cell(1, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                for j = 1:1:length(graphs)
                    g = graphs{j};
                    g_random = g.randomize('AttemptsPerEdge', attempts_per_edge, 'NumberOfWeights', number_of_weights);
                    measure_random = g_random.getMeasure(measure_code);
                    measure_random_packed = measure_random.getValue();
                    values_randomizations{j}  =  measure_random_packed{1}; %#ok<AGROW>
                end
                mean_groups = mean(reshape(cell2mat(values_group), [size(values_group{1}, 1), size(values_group{1}, 2), group.subjectnumber()]), 3);
                mean_randomizations = mean(reshape(cell2mat(values_randomizations), [size(values_randomizations{1}, 1), size(values_randomizations{1}, 2), group.subjectnumber()]), 3);
                all_randomizations{1, i} = mean_randomizations;
                all_differences{1, i} =  mean_groups - mean_randomizations;
                
                if interruptible
                    pause(interruptible)
                end
            end
            
            all_random = all_randomizations{1};
            for i = 2:1:M
                all_random = all_random + all_randomizations{i};
            end
            average_value_random = {all_random / M};
            
            value_random = values_randomizations;
            
            difference = {average_value_group - average_value_random{1}};
            
            % Statistical analysis
            p1 = pvalue1(difference, all_differences);  % singe tail,
            p2 = pvalue2(difference, all_differences);  % double tail
            
            qtl = quantiles(all_differences, 40);
            ci_lower = {cellfun(@(x) x(2), qtl)};
            ci_upper = {cellfun(@(x) x(40), qtl)};
            
            % create randomComparisonClass
            randomcomparison = RandomComparison.getRandomComparison(analysis.getRandomComparisonClass(), ...
                analysis.getRandomComparisonID(measure_code, group, varargin{:}), ...
                '', ...  % random comparison label
                '', ...  % random comparison notes
                analysis.getCohort().getBrainAtlases(), ...
                measure_code, ...
                group, ...
                'RandomComparisonFNC.RandomizationNumber', M, ...
                'RandomComparisonFNC.value_group', values_group, ...
                'RandomComparisonFNC.value_random', value_random, ...
                'RandomComparisonFNC.average_value_group', {average_value_group}, ...
                'RandomComparisonFNC.average_value_random', average_value_random, ...
                'RandomComparisonFNC.difference', difference, ...
                'RandomComparisonFNC.all_differences', all_differences, ...
                'RandomComparisonFNC.p1', p1, ...
                'RandomComparisonFNC.p2', p2, ....
                'RandomComparisonFNC.confidence_min', ci_lower, ...
                'RandomComparisonFNC.confidence_max', ci_upper, ...
                'RandomComparisonFNC.ParameterValues', parameter_value_group, ...
                varargin{:} ...
                );
        end
        function comparison = calculate_comparison(analysis, measure_code, group_1, group_2, varargin)
            % CALCULATE_COMPARISON returns a comparison
            %
            % COMPARISON = CALCULATE_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP_1 subjects and GROUP_2 data. It will compare the measures
            % obtained and will return a comparison. The function
            % will utilize default settings.
            %
            % COMPARISON = CALCULATE_COMPARISON(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2, PROPERTY, VALUE, ...)
            % calculates a measure of type MEASURE_CODE utilizing the data
            % from GROUP_1 subjects and GROUP_2 data. It will compare the measures
            % obtained and will return a comparison. The function
            % will utilize VALUE settings.
            %
            % See also calculate_random_comparison, calculate_measurement.
            
            comparison = [];
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            % GETCLASS returns the class of functional analysis
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % analysis. In this case AnalysisFNC_MP_WU.
            %
            % See also getList, getName, getDescription.
            analysis_class = 'AnalysisFNC_MP_WU';
        end
        function name = getName()
            % GETNAME returns the name of functional analysis
            %
            % NAME = GETNAME() returns the name of ANALYSIS.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Analysis Functional Multiplex WU';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional analysis
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of AnalysisFNC_MP_WU.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'Analysis using FNC functional multiplex matrix, ' ...
                'e.g. activation timeseries for each brain region. ' ...
                'It provides a graph for each subject.' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the compatible type of graph
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns the compatible type of
            % graph 'GraphWU'.
            %
            % See also getSubjectClass.
            
            graph_type = 'MultiplexGraphWU';
        end
        function subject_class = getSubjectClass()
            % GETSUBJETCLASS returns the class of functional analysis subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS() returns the class
            % of AnalysisFNC_MP_WU subject, 'SubjectFNC'.
            %
            % See also getList, getClass, getName, getDescription.
            
            subject_class = 'SubjectFNC_MP';
        end
        function measurement_class = getMeasurementClass()
            % GETMEASUREMENTCLASS returns the class of functional analysis measurement
            %
            % MEASUREMENT_CLASS = GETMEASUREMENT_CLASS() returns the
            % class of AnalysisFNC_MP_WU measurement, 'MeasurementFNC_WU'.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class =  'MeasurementFNC_MP_WU';
        end
        function randomcomparison_class = getRandomComparisonClass()
            % GETRANDOMCOMPARISONCLASS returns the class of functional analysis randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS()
            % returns the class of AnalysisST_WU randomcomparison,
            % 'RandomComparisonFNC_WU'.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = 'RandomComparisonFNC_MP_WU';
        end
        function comparison_class = getComparisonClass()
            % GETCOMPARISONCLASS returns the class of functional analysis comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS() returns the
            % class of AnalysisFNC_MP_WU comparison, 'ComparisonFNC_WU'.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = 'ComparisonFNC_MP_WU';
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the available settings of functional analysis
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS(M) returns the
            % available settings of AnalysisFNC_MP_WU.
            %
            % See also getClass, getName, getDescription
            
            available_settings = {
                {'AnalysisFNC.CorrelationRule', BRAPH2.STRING, 'pearson', Correlation.CORRELATION_RULE_LIST}, ...
                {'AnalysisFNC.NegativeWeightRule', BRAPH2.STRING, 'zero', Correlation.NEGATIVE_WEIGHT_RULE_LIST}, ...
                {'AnalysisFNC.Longitudinal', BRAPH2.LOGICAL, false, {false, true}}, ...
                {'AnalysisFNC.FrecuencyRuleMin', BRAPH2.NUMERIC, 0, {}}, ...
                {'AnalysisFNC.FrecuencyRuleMax', BRAPH2.NUMERIC, Inf, {}}, ...
                {'AnalysisFNC.Repetition', BRAPH2.NUMERIC, 1, {}}...
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
            
            
        end
        function global_panel = getGlobalPanel(analysis, varargin)
            % GETGLOBALPANEL creates the global uipanel for GUIAnalysis
            %
            % GLOBAL_PANEL = GETGLOBALPANEL(ANALYSIS, PROPERTY, VALUE, ...)
            % creates a uipanel that contains information about global
            % measures in Measurement, RandomComparison and Comparison.
            %
            % See also getGraphPanel, getMainPanelMeasurePlot, getBrainView
            
            
        end
        function nodal_panel = getNodalPanel(analysis, varargin)
            % GETNODALPANEL creates the nodal uipanel for GUIAnalysis
            %
            % NODAL_PANEL = GETNODALPANEL(ANALYSIS, PROPERTY, VALUE, ...)
            % creates a uipanel that contains information about nodal
            % measures in Measurement, RandomComparison and Comparison.
            %
            % See also getGraphPanel, getMainPanelMeasurePlot, getGlobalPanel
            
        end
        function binodal_panel = getBinodalPanel(analysis, varargin)
            % GETBINODALPANEL creates the binodal uipanel for GUIAnalysis
            %
            % BINODAL_PANEL = GETBINODALPANEL(ANALYSIS, PROPERTY, VALUE, ...)
            % creates a uipanel that contains information about binodal
            % measures in Measurement, RandomComparison and Comparison.
            %
            % See also getGraphPanel, getMainPanelMeasurePlot, getGlobalPanel, getBrainView
            
            
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
            
        end
        function brain_graph_panel = getBrainGraphPanel(analysis, brain_axes, brain_graph)
            % GETBRAINGRAPHPANEL creates a braingraph panel
            %
            % BRAIN_GRAPH_PANEL = GETBRAINGRAPHPANEL(ANAlYSIS, AXES, PLOTBRAINGRAPH)
            % creates a brain graph panel to manage the type of
            % PLOTBRAINGRAPH that the GUIAnalysis plots in the AXES.
            %
            % See also getBrainView,
            
        end
        function h = getMCRPanel(analysis, brain_axes, bg)
            % sets position of figure
            
        end
    end
    methods (Static)  % Save and load functions
        function analysis = load_from_xls(tmp, varargin)
            % directory
            directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(directory, '')  % no path, open gui
                msg = get_from_varargin(BRAPH2.MSG_GETDIR, 'MSG', varargin{:});
                directory = uigetdir(msg);
            end
            
            % find all subfolders
            sub_folders = dir(directory);
            sub_folders = sub_folders([sub_folders(:).isdir] == 1);
            sub_folders = sub_folders(~ismember({sub_folders(:).name}, {'.', '..'}));
            
            if isa(tmp, 'Analysis')
                analysis = tmp;
                subject_class = analysis.getCohort().getSubjectClass(); %#ok<NASGU>
            else
                % analysis information
                file_analysis = [directory filesep() 'analysis_info.xlsx'];
                analysis_id = '';
                analysis_label = '';
                analysis_notes = '';
                
                if exist(file_analysis, 'file')
                    v = ver('MATLAB');  % read version matlab
                    if v.Release >= "(R2020a)"
                        raw_analysis = readcell(file_analysis);
                    else
                        raw_analysis = readtable(file_analysis, 'ReadVariableNames', 0);
                        raw_analysis = table2cell(raw_analysis);
                    end
                    analysis_id = raw_analysis{1, 2};
                    analysis_label = raw_analysis{2, 2};
                    analysis_notes = raw_analysis{3, 2};
                    type_of_analysis = raw_analysis{4, 2};
                    cohort_id = raw_analysis{5, 2};
                end
                
                cohort = tmp;
                subject_class = cohort.getSubjectClass();
                if isequal(type_of_analysis, 'AnalysisFNC_MP_WU')
                    analysis = AnalysisFNC_MP_WU(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
                elseif isequal(type_of_analysis, 'AnalysisFNC_BUT')
                    analysis = AnalysisFNC_BUT(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
                elseif isequal(type_of_analysis, 'AnalysisFNC_BUD')
                    analysis = AnalysisFNC_BUD(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
                else
                    errordlg('Type of Analysis does not exist.');
                end
                
                % load analysis
                for i = 1:1:length(sub_folders)
                    path = [directory filesep() sub_folders(i).name];
                    
                    % find all xls or xlsx files per sub folder
                    files = dir(fullfile(path, '*.xlsx'));
                    files2 = dir(fullfile(path, '*.xls'));
                    len = length(files);
                    for j = 1:1:length(files2)
                        files(len + j, 1) = files2(j, 1);
                    end
                    
                    % measurements
                    if isequal(sub_folders(i).name, 'measurements')
                        measurement_idict = analysis.getMeasurements();
                        for k = 1:1:length(files)
                            % get info main
                            v = ver('MATLAB');  % read version matlab
                            if v.Release >= "(R2020a)"
                                raw_main = readcell(fullfile(path, files(k).name));
                            else
                                raw_main = readtable(fullfile(path, files(k).name), 'ReadVariableNames', 0);
                                raw_main = table2cell(raw_main);
                            end
                            meas_id = raw_main{1, 2};
                            meas_lab = raw_main{2, 2};
                            meas_notes = raw_main{3, 2};
                            measure_code = raw_main{4, 2};
                            raw_group = raw_main{5, 2};
                            
                            if ismissing(meas_lab)
                                meas_lab = '';
                            end
                            if ismissing(meas_notes)
                                meas_notes = '';
                            end
                            
                            % get group
                            group = analysis.getCohort().getGroups().getValue(raw_group);
                            
                            % get values
                            raw_values = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 2, 'ReadVariableNames', 0));
                            raw_avgs = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 3, 'ReadVariableNames', 0));
                            
                            % create measurement
                            measurement = Measurement.getMeasurement(analysis.getMeasurementClass(), ...
                                meas_id, ...
                                meas_lab, ...  % meaurement label
                                meas_notes, ...  % meaurement notes
                                analysis.getCohort().getBrainAtlases(), ...
                                measure_code, ...
                                group,  ...
                                'MeasurementCON.values', num2cell(raw_values, 1), ...
                                'MeasurementCON.average_value', raw_avgs, ...
                                varargin{:});
                            measurement_idict.add(measurement.getID(), measurement, k);
                        end
                    elseif isequal(sub_folders(i).name, 'comparisons')
                        comparison_idict = analysis.getComparisons();
                        for k = 1:1:length(files)
                            % get info main
                            v = ver('MATLAB');  % read version matlab
                            if v.Release >= "(R2020a)"
                                raw_main = readcell(fullfile(path, files(k).name));
                            else
                                raw_main = readtable(fullfile(path, files(k).name), 'ReadVariableNames', 0);
                                raw_main = table2cell(raw_main);
                            end
                            comp_id = raw_main{1, 2};
                            comp_lab = raw_main{2, 2};
                            comp_notes = raw_main{3, 2};
                            measure_code = raw_main{4, 2};
                            raw_group1 = raw_main{5, 2};
                            raw_group2 = raw_main{6, 2};
                            
                            if ismissing(comp_lab)
                                comp_lab = '';
                            end
                            if ismissing(comp_notes)
                                comp_notes = '';
                            end
                            
                            % get groups
                            group1 = analysis.getCohort().getGroups().getValue(raw_group1);
                            group2 = analysis.getCohort().getGroups().getValue(raw_group2);
                            
                            % get values
                            
                            raw_values_g1 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 2, 'ReadVariableNames', 0));
                            raw_values_g2 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 3, 'ReadVariableNames', 0));
                            raw_avgs_g1 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 4, 'ReadVariableNames', 0));
                            raw_avgs_g2 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 5, 'ReadVariableNames', 0));
                            raw_difference = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 5, 'ReadVariableNames', 0));
                            raw_all_difference = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 7, 'ReadVariableNames', 0));
                            raw_p1 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 8, 'ReadVariableNames', 0));
                            raw_p2 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 9, 'ReadVariableNames', 0));
                            raw_cimin = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 10, 'ReadVariableNames', 0));
                            raw_cimax = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 11, 'ReadVariableNames', 0));
                            
                            comparison = Comparison.getComparison(analysis.getComparisonClass(), ...
                                comp_id, ...
                                comp_lab, ...  % comparison label
                                comp_notes, ...  % comparison notes
                                analysis.getCohort().getBrainAtlases(), ...
                                measure_code, ...
                                group1, ...
                                group2, ...
                                'ComparisonCON.values_1', num2cell(raw_values_g1, 1), ...
                                'ComparisonCON.average_values_1', num2cell(raw_avgs_g1, 1), ...
                                'ComparisonCON.values_2', num2cell(raw_values_g2, 1), ...
                                'ComparisonCON.average_values_2', num2cell(raw_avgs_g2, 1), ...
                                'ComparisonCON.difference', {raw_difference}, ...
                                'ComparisonCON.all_differences', num2cell(raw_all_difference, 1), ...
                                'ComparisonCON.p1', {raw_p1}, ...
                                'ComparisonCON.p2', {raw_p2}, ...
                                'ComparisonCON.confidence_min', {raw_cimin}, ...
                                'ComparisonCON.confidence_max', {raw_cimax}, ...
                                varargin{:});
                            
                            comparison_idict.add(comparison.getID(), comparison, k);
                        end
                    elseif isequal(sub_folders(i).name, 'randomcomparisons')
                        random_comparison_idict = analysis.getRandomComparisons();
                        for k = 1:1:length(files)
                            % get info main
                            v = ver('MATLAB');  % read version matlab
                            if v.Release >= "(R2020a)"
                                raw_main = readcell(fullfile(path, files(k).name));
                            else
                                raw_main = readtable(fullfile(path, files(k).name), 'ReadVariableNames', 0);
                                raw_main = table2cell(raw_main);
                            end
                            ran_comp_id = raw_main{1, 2};
                            ran_comp_lab = raw_main{2, 2};
                            ran_comp_notes = raw_main{3, 2};
                            measure_code = raw_main{4, 2};
                            raw_group = raw_main{5, 2};
                            
                            if ismissing(ran_comp_lab)
                                ran_comp_lab = '';
                            end
                            if ismissing(ran_comp_notes)
                                ran_comp_notes = '';
                            end
                            
                            % get groups
                            group = analysis.getCohort().getGroups().getValue(raw_group);
                            
                            % get values
                            raw_values_g1 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 2, 'ReadVariableNames', 0));
                            raw_values_g2 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 3, 'ReadVariableNames', 0));
                            raw_avgs_g1 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 4, 'ReadVariableNames', 0));
                            raw_avgs_g2 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 5, 'ReadVariableNames', 0));
                            raw_difference = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 5, 'ReadVariableNames', 0));
                            raw_all_difference = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 7, 'ReadVariableNames', 0));
                            raw_p1 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 8, 'ReadVariableNames', 0));
                            raw_p2 = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 9, 'ReadVariableNames', 0));
                            raw_cimin = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 10, 'ReadVariableNames', 0));
                            raw_cimax = table2array(readtable(fullfile(path, files(k).name), 'Sheet', 11, 'ReadVariableNames', 0));
                            
                            random_comparison = RandomComparison.getRandomComparison(analysis.getRandomComparisonClass(), ...
                                ran_comp_id, ...
                                ran_comp_lab, ...  % comparison label
                                ran_comp_notes, ...  % comparison notes
                                analysis.getCohort().getBrainAtlases(), ...
                                measure_code, ...
                                group, ...
                                'RandomComparisonCON.value_group', num2cell(raw_values_g1, 1), ...
                                'RandomComparisonCON.value_random', num2cell(raw_values_g2, 1), ...
                                'RandomComparisonCON.average_value_group', num2cell(raw_avgs_g1, 1), ...
                                'RandomComparisonCON.average_value_random', num2cell(raw_avgs_g2, 1), ...
                                'RandomComparisonCON.difference', {raw_difference}, ...
                                'RandomComparisonCON.all_differences', num2cell(raw_all_difference, 1), ...
                                'RandomComparisonCON.p1', {raw_p1}, ...
                                'RandomComparisonCON.p2', {raw_p2}, ....
                                'RandomComparisonCON.confidence_min', {raw_cimin}, ...
                                'RandomComparisonCON.confidence_max', {raw_cimax}, ...
                                varargin{:});
                            
                            random_comparison_idict.add(random_comparison.getID(), random_comparison, k);
                        end
                    else
                        continue;
                    end
                end
            end
        end
        function save_to_xls(analysis, varargin)
            % save to folders separting by type of analysis
            
            % get saving info
            % get Root Directory
            root_directory = get_from_varargin('', 'RootDirectory', varargin{:});
            if isequal(root_directory, '')  % no path, open gui
                msg = get_from_varargin(BRAPH2.MSG_PUTDIR, 'MSG', varargin{:});
                root_directory = uigetdir(msg);
            end
            
            analyses = {'measurements', 'comparisons', 'randomcomparisons'};
            for i = 1:1:3
                type_of_analysis = analyses{i};
                if ~exist([root_directory filesep() type_of_analysis], 'dir')
                    mkdir(root_directory, type_of_analysis);
                end
            end
            
            % get analysis info
            cohort = analysis.getCohort();
            measurements = analysis.getMeasurements();
            comparisons = analysis.getComparisons();
            random_comparisons = analysis.getRandomComparisons();
            
            % save analysis main file id, label, notes.
            analysis_main_file = [root_directory filesep() 'analysis_info.xlsx'];
            basic_info = {
                'Analysis ID:', analysis.getID();
                'Analysis Label:',  analysis.getLabel();
                'Analysis Notes:', analysis.getNotes();
                'Type of Analysis:', analysis.getClass();
                'Cohort:',  cohort.getID();
                'Number of Measurements:', measurements.length();
                'Number of Comparisons:', comparisons.length();
                'Number of Random Comparisons:' random_comparisons.length();
                };
            
            % writecell(basic_info, analysis_main_file, 'Sheet', 1);
            writetable(cell2table(basic_info), analysis_main_file, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A1');
            
            % warning xls sheets off
            warning( 'off', 'MATLAB:xlswrite:AddSheet' ) ;
            
            % measurements could ask for just certain measures
            for i = 1:1:measurements.length()
                m = measurements.getValue(i);
                file_measurement = [root_directory filesep() 'measurements' filesep() m.getID() '.xlsx'];
                measurement_data = {
                    'Measurement ID:', m.getID();
                    'Measurement Label:', m.getLabel();
                    'Measurement Notes:', m.getNotes();
                    'Measure:', m.getMeasureCode();
                    'Group:', m.getGroup().getID();
                    'Values (Sheet 2):', size(m.getMeasureValues);
                    'Group Average (Sheet 3):', size(m.getGroupAverageValue());
                    };
                
                % writecell(measurement_data, file_measurement, 'Sheet', 1);
                writetable(cell2table(measurement_data), file_measurement, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A1');
                % writematrix([m.getMeasureValues{:}], file_measurement, 'Sheet', 2);
                writetable(array2table([m.getMeasureValues{:}]), file_measurement, 'Sheet', 2, 'WriteVariableNames', 0, 'Range', 'A1');
                % writematrix(m.getGroupAverageValue, file_measurement, 'Sheet', 3);
                writetable(array2table(m.getGroupAverageValue), file_measurement, 'Sheet', 3, 'WriteVariableNames', 0, 'Range', 'A1');
            end
            
            % comparisons
            for i = 1:1:comparisons.length()
                c = comparisons.getValue(i);
                Values1 = c.getGroupValue(1);
                Values2 = c.getGroupValue(2);
                Avg_1 = c.getGroupAverageValue(1);
                Avg_2 = c.getGroupAverageValue(2);
                [g1, g2] = c.getGroups();
                file_comparisons = [root_directory filesep() 'comparisons' filesep() c.getID() '.xlsx'];
                comparisons_data = {
                    'Comparison ID:', c.getID();
                    'Comparison Label:', c.getLabel();
                    'Comparison Notes:', c.getNotes();
                    'Measure:', c.getMeasureCode();
                    'Group 1:', g1.getID();
                    'Group 2:', g2.getID();
                    'Values Group 1 (Sheet 2):', size(Values1);
                    'Values Group 2 (Sheet 3):', size(Values2);
                    'Group 1 Average Value (Sheet 4):', size(Avg_1);
                    'Group 2 Average Value (Sheet 5):', size(Avg_2);
                    'Difference (Sheet 6):', size(c.getDifference());
                    'All Differences (Sheet 7):', size(c.getAllDifferences());
                    'P1 (Sheet 8):', size(c.getP1());
                    'P2 (Sheet 9):', size(c.getP2());
                    'Minimum Confidence Interval (Sheet 10):', size(c.getConfidenceIntervalMin());
                    'Maximum Confidence Interval (Sheet 11):', size(c.getConfidenceIntervalMax());
                    };
                
                writetable(cell2table(comparisons_data), file_comparisons, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([Values1{:}]), file_comparisons, 'Sheet', 2, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([Values2{:}]), file_comparisons, 'Sheet', 3, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([Avg_1{:}]), file_comparisons, 'Sheet', 4, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([Avg_2{:}]), file_comparisons, 'Sheet', 5, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([c.getDifference{:}]), file_comparisons, 'Sheet', 6, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([c.getAllDifferences{:}]), file_comparisons, 'Sheet', 7, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([c.getP1{:}]), file_comparisons, 'Sheet', 8, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([c.getP2{:}]), file_comparisons, 'Sheet', 9, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([c.getConfidenceIntervalMin{:}]), file_comparisons, 'Sheet', 10, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([c.getConfidenceIntervalMax{:}]), file_comparisons, 'Sheet', 11, 'WriteVariableNames', 0, 'Range', 'A1');
            end
            
            % random comparisons
            for i = 1:1:random_comparisons.length()
                rc = random_comparisons.getValue(i);
                Values1 = rc.getGroupValue();
                Values2 = rc.getRandomValue();
                Avg_1 = rc.getAverageValue();
                Avg_2 = rc.getAverageRandomValue();
                file_random_comparisons = [root_directory filesep() 'randomcomparisons' filesep() rc.getID() '.xlsx'];
                random_comparisons_data = {
                    'Random Comparison ID:', rc.getID();
                    'Random Comparison Label:', rc.getLabel();
                    'Random Comparison Notes:', rc.getNotes();
                    'Measure:', c.getMeasureCode();
                    'Groups:', rc.getGroup().getID();
                    'Values Group 1 (Sheet 2):', size(Values1);
                    'Values Random Group (Sheet 3):', size(Values2);
                    'Group 1 Average Value (Sheet 4):', size(Avg_1);
                    'Random Group Average Value (Sheet 5):', size(Avg_2);
                    'Difference (Sheet 6):', size(rc.getDifference());
                    'All Differences (Sheet 7):', size(rc.getAllDifferences());
                    'P1 (Sheet 8):', size(rc.getP1());
                    'P2 (Sheet 9):', size(rc.getP2());
                    'Minimum Confidence Interval (Sheet 10):', size(rc.getConfidenceIntervalMin());
                    'Maximum Confidence Interval (Sheet 11):', size(rc.getConfidenceIntervalMax());
                    };
                
                writetable(cell2table(random_comparisons_data), file_random_comparisons, 'Sheet', 1, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([rc.getGroupValue{:}]), file_random_comparisons, 'Sheet', 2, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([rc.getRandomValue{:}]), file_random_comparisons, 'Sheet', 3, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([rc.getAverageValue{:}]), file_random_comparisons, 'Sheet', 4, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([rc.getAverageRandomValue{:}]), file_random_comparisons, 'Sheet', 5, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([rc.getDifference{:}]), file_random_comparisons, 'Sheet', 6, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([rc.getAllDifferences{:}]), file_random_comparisons, 'Sheet', 7, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([rc.getP1{:}]), file_random_comparisons, 'Sheet', 8, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([rc.getP2{:}]), file_random_comparisons, 'Sheet', 9, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([rc.getConfidenceIntervalMin{:}]), file_random_comparisons, 'Sheet', 10, 'WriteVariableNames', 0, 'Range', 'A1');
                writetable(array2table([rc.getConfidenceIntervalMax{:}]), file_random_comparisons, 'Sheet', 11, 'WriteVariableNames', 0, 'Range', 'A1');
            end
            
            % warning on
            warning('on', 'all')
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
                
                if isequal(type_of_analysis, 'AnalysisFNC_MP_WU')
                    analysis = AnalysisFNC_MP_WU(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
                elseif isequal(type_of_analysis, 'AnalysisFNC_BUT')
                    analysis = AnalysisFNC_BUT(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
                elseif isequal(type_of_analysis, 'AnalysisFNC_BUD')
                    analysis = AnalysisFNC_BUD(analysis_id, analysis_label, analysis_notes, cohort, {}, {}, {});
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
                    'MeasurementFNC.values', num2cell(raw.Measurements(i).value', 1), ...
                    'MeasurementFNC.average_value', raw.Measurements(i).avgvalue, ...
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
                    'ComparisonFNC.values_1', num2cell(raw.Comparisons(i).value1', 1), ...
                    'ComparisonFNC.average_values_1', num2cell(raw.Comparisons(i).avgvalue1', 1), ...
                    'ComparisonFNC.values_2', num2cell(raw.Comparisons(i).value2', 1), ...
                    'ComparisonFNC.average_values_2', num2cell(raw.Comparisons(i).avgvalue2', 1), ...
                    'ComparisonFNC.difference', {raw.Comparisons(i).difference'}, ...
                    'ComparisonFNC.all_differences', num2cell(raw.Comparisons(i).alldifferences', 1), ...
                    'ComparisonFNC.p1', {raw.Comparisons(i).p1'}, ...
                    'ComparisonFNC.p2', {raw.Comparisons(i).p2'}, ...
                    'ComparisonFNC.confidence_min', {raw.Comparisons(i).confidencemin'}, ...
                    'ComparisonFNC.confidence_max', {raw.Comparisons(i).confidencemax'}, ...
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
                    'RandomComparisonFNC.value_group', num2cell(raw.RandomComparisons(i).value', 1), ...
                    'RandomComparisonFNC.value_random', num2cell(raw.RandomComparisons(i).ranvalue', 1), ...
                    'RandomComparisonFNC.average_value_group', num2cell(raw.RandomComparisons(i).avgvalue', 1), ...
                    'RandomComparisonFNC.average_value_random', num2cell(raw.RandomComparisons(i).ranavgvalue', 1), ...
                    'RandomComparisonFNC.difference', {raw.RandomComparisons(i).difference'}, ...
                    'RandomComparisonFNC.all_differences', num2cell(raw.RandomComparisons(i).alldifferences', 1), ...
                    'RandomComparisonFNC.p1', {raw.RandomComparisons(i).p1'}, ...
                    'RandomComparisonFNC.p2', {raw.RandomComparisons(i).p2'}, ....
                    'RandomComparisonFNC.confidence_min', {raw.RandomComparisons(i).confidencemin'}, ...
                    'RandomComparisonFNC.confidence_max', {raw.RandomComparisons(i).confidencemax'}, ...
                    varargin{:});
                
                random_comp_idict.add(random_comparison.getID(), random_comparison, i);
            end
            
        end
        function structure = save_to_json(analysis, varargin)
            % get info
            cohort = analysis.getCohort();
            atlases = cohort.getBrainAtlases();
            atlas = atlases{1}; %#ok<NASGU>
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
                Measurements_structure(i).value = meas.getMeasureValues();
                Measurements_structure(i).avgvalue = meas.getGroupAverageValue();
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
                Comparisons_structure(i).avgvalue1 = comp.getGroupAverageValue(1);
                Comparisons_structure(i).avgvalue2 = comp.getGroupAverageValue(2);
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
                RandomComparisons_structure(i).avgvalue = ran_comp.getAverageValue();
                RandomComparisons_structure(i).ranavgvalue = ran_comp.getAverageRandomValue();
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
                'Cohort', SubjectFNC.save_to_json(cohort), ...
                'Measurements', Measurements_structure, ...
                'Comparisons', Comparisons_structure, ...
                'RandomComparisons', RandomComparisons_structure ...
                );
        end
    end
end