classdef AnalysisFNC_BUT < AnalysisFNC_WU
    % AnalysisFNC_BUT An analysis of functional data of fixed threshold binary undirected graphs
    % AnalysisFNC_BUT is a subclass of AnalysisFNC_WU and implements the methods
    % needed for functional analysis.
    %
    % AnalysisFNC_BUT implements AnalysisFNC_WU calculating methods
    % to obtain a functional data of fixed threshold binary undirected graphs
    % measurement, a random comprison or a comparison. AnalysisFNC_BUT
    % overrides the ID methods of its superclass.
    % Functional data can be for example fMRI data.
    %
    % AnalysisFNC_BUT constructor methods:
    %  AnalysisFNC_BUT              - Constructor
    %
    % AnalysisFNC_BUT calcultion methods (Access = protected):
    %  get_graph_for_subjects       - returns the graph of the correlated matrix
    %  calculate_measurement        - returns the measurement
    %  calculate_random_comparison  - returns the random comparison
    %  calculate_comparison         - returns the comparison
    %
    % AnalysisFNC_BUT descriptive methods (Static):
    %  getClass                     - returns the class of the analysis
    %  getName                      - returns the name of the analysis
    %  getDescription               - returns the description of the analysis
    %  getMeasurementClass          - returns the class of the measurement
    %  getRandomComparisonClass     - returns the class of the random comparison
    %  getComparisonClass           - returns the class of the comparison
    %  getAvailbleSettings          - returns the available settings
    %
    % See also Analysis, MeasurementFNC_BUT, RandomComparisonFNC_BUT, ComparisonFNC_BUT
    
    methods
        function analysis = AnalysisFNC_BUT(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            % AnalysisFNC_BUT(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates a functional analysis of fixed threshold with ID, LABEL,
            % COHORT, MEASUREMENTS, RANDOMCOMPARISON and COMPARISONS. It 
            % initializes the ANALYSISFNC_WU with default settings.
            %
            % AnalysisFNC_BUT(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates a functional analysis of fixed threshold with ID, LABEL,
            % COHORT, MEASUREMENTS, RANDOMCOMPARISON and COMPARISONS. It
            % initializes the ANALYSISFNC_WU with specified settings VALUES.
            %
            % See also MeasurementFNC_WU, RandomComparisonFNC_WU, ComparisonFNC_WU.
                 
            analysis = analysis@AnalysisFNC_WU(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin{:});
        end
    end
    methods  % ID functions
        function measurement_id = getMeasurementID(analysis, measure_code, group, varargin)
            % GETMEASUREMENTID returns a measurement ID
            %
            % MEASUREMENT_ID = GETMEASUREMENTID(ANALYSIS, MEASURE_CODE, GROUP, 'threshold', THRESHOLD)
            % creates a measurement ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and the THRESHOLD.
            %
            % See also getRandomComparisonID, getComparisonID.            
            
            measurement_id = getMeasurementID@AnalysisFNC_WU(analysis, measure_code, group, varargin{:});
            
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            measurement_id = [measurement_id ' threshold=' num2str(threshold)];          
        end
        function randomcomparison_id = getRandomComparisonID(analysis, measure_code, group, varargin)
            % GETRANDOMCOMPARISONID returns a random comparison ID
            %
            % RANDOMCOMPARISON_ID = GETRANDOMCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP, 'threshold', THRESHOLD)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and the THRESHOLD.
            %
            % See also getMeasurementID, getComparisonID.            
         
            randomcomparison_id = getRandomComparisonID@AnalysisFNC_WU(analysis, measure_code, group, varargin{:});
            
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            randomcomparison_id = [randomcomparison_id ' threshold=' num2str(threshold)];
        end
        function comparison_id = getComparisonID(analysis, measure_code, group_1, group_2, varargin)
            % GETCOMPARISONID returns a comparison ID
            %
            % COMPARISON_ID = GETCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2, 'threshold', THRESHOLD)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, GROUP_1 and GROUP_2, and the THRESHOLD.
            %
            % See also getMeasurementID, getRandomComparisonID.
            
            comparison_id = getComparisonID@AnalysisFNC_WU(analysis, measure_code, group_1, group_2, varargin{:});
            
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            comparison_id = [comparison_id ' threshold=' num2str(threshold)];
        end
    end
    methods (Access = protected)
        function g = get_graph_for_subjects(analysis, subjects, varargin)
            % GET_GRAPH_FOR_SUBJECTS returns the graph created with the correlation matrix
            %
            % G = GET_GRAPH_FOR_SUBJECTS(ANALYSIS, SUBJECTS, PROPERY, VALUE, ...) creates a
            % graph with the correlation matrix made of the data of
            % subjects. It will binarize the matrix depending on the
            % PROPERTY and VALUE.
            %
            % See also calculate_measurement.
            
            atlases = analysis.cohort.getBrainAtlases();
            atlas = atlases{1};
            
            subject_number = numel(subjects);
            
            data = zeros(subject_number, atlas.getBrainRegions().length());
            for i = 1:1:subject_number
                subject = subjects{i};
                data(i, :) = subject.getData('FNC').getValue();  % st data
            end
            
            correlation_rule = analysis.getSettings('AnalysisFNC.CorrelationRule');
            negative_weight_rule = analysis.getSettings('AnalysisFNC.NegativeWeightRule');
            A = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);
            
            threshold = get_from_varargin(0, 'threshold', varargin{:});
            A = binarize(A, 'treshold', threshold, varargin{:});
            
            graph_type = AnalysisFNC_WU.getGraphType();
            g = Graph.getGraph(graph_type, A);
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            % GETCLASS returns the class of functional analysis
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % analysis. In this case AnalysisFNC_BUT.
            %
            % See also getList, getName, getDescription.
            
            analysis_class = 'AnalysisFNC_BUT';
        end
        function name = getName()
            % GETNAME returns the name of functional analysis
            %
            % NAME = GETNAME() returns the name of the analysis.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Analysis Functional BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional analysis
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of AnalysisFNC_BUT.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'Analysis based on functional data of fixed threshold using ' ...
                'weighted graphs e.g. cortical thickness for each brain region. ' ...
                'It provides a single graph for each subject group. ' ...
                'Functional data can be for example fMRI data.' ...
                ];
        end
        function graph_type = getGraphType()
            % GETGRAPHTYPE returns the compatible type of graph
            %
            % GRAPH_TYPE = GETGRAPHTYPE() returns the compatible type of 
            % graph 'GraphBU'.
            %
            % See also getSubjectClass.
            
            graph_type = 'GraphBU';
        end
        function measurement_class = getMeasurementClass()
            % GETMEASUREMENTCLASS returns the class of functional analysis measurement
            %
            % MEASUREMENT_CLASS = GETMEASUREMENT_CLASS() returns the
            % class of AnalysisFNC_BUT measurement, 'MeasurementFNC_BUT'.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class =  'MeasurementFNC_BUT';
        end
        function randomcomparison_class = getRandomComparisonClass()
            % GETRANDOMCOMPARISONCLASS returns the class of functional analysis randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS()
            % returns the class of AnalysisFNC_BUT randomcomparison,
            % 'RandomComparisonFNC_BUT'.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = 'RandomComparisonFNC_BUT';
        end
        function comparison_class = getComparisonClass()
            % GETCOMPARISONCLASS returns the class of functional analysis comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS() returns the
            % class of AnalysisFNC_BUT comparison, 'ComparisonFNC_BUT'.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = 'ComparisonFNC_BUT';
        end
    end
end