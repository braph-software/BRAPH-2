classdef AnalysisFNC_BUD < AnalysisFNC_WU
    % AnalysisFNC_BUD An analysis of functional data of fixed density binary undirected graphs
    % AnalysisFNC_BUD is a subclass of AnalysisFNC_WU and inherits the methods
    % needed for functional analysis.
    %
    % AnalysisFNC_BUD inhertis AnalysisFNC_WU calculating methods
    % to obtain a functional data of fixed density binary undirected graphs
    % measurement, a random comprison or a comparison. AnalysisFNC_BUD
    % overrides the ID methods of its superclass.
    % Functional data can be for example fMRI data.
    %
    % AnalysisFNC_BUD constructor methods:
    %  AnalysisFNC_BUD              - Constructor
    %
    % AnalysisFNC_BUD calcultion methods (Access = protected):
    %  get_graph_for_subjects       - returns the graph of the correlated matrix
    %  calculate_measurement        - returns the measurement
    %  calculate_random_comparison  - returns the random comparison
    %  calculate_comparison         - returns the comparison
    %
    % AnalysisFNC_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the analysis
    %  getName                      - returns the name of the analysis
    %  getDescription               - returns the description of the analysis
    %  getMeasurementClass          - returns the class of the measurement
    %  getRandomComparisonClass     - returns the class of the random comparison
    %  getComparisonClass           - returns the class of the comparison
    %  getAvailbleSettings          - returns the available settings
    %
    % See also Analysis, MeasurementFNC_BUD, RandomComparisonFNC_BUD, ComparisonFNC_BUD
    
    methods
        function analysis = AnalysisFNC_BUD(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            % AnalysisFNC_BUD(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates a functional analysis of fixed density with ID, LABEL,
            % COHORT, MEASUREMENTS, RANDOMCOMPARISON and COMPARISONS. It 
            % initializes the ANALYSISFNC_WU with default settings.
            %
            % AnalysisFNC_BUD(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates a functional analysis of fixed density with ID, LABEL,
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
            % MEASUREMENT_ID = GETMEASUREMENTID(ANALYSIS, MEASURE_CODE, GROUP, 'density', DENSITY)
            % creates a measurement ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and the DENSITY.
            %
            % See also getRandomComparisonID, getComparisonID.            
            
            measurement_id = getMeasurementID@AnalysisFNC_WU(analysis, measure_code, group, varargin{:});
            
            density = get_from_varargin(0, 'density', varargin{:});
            measurement_id = [measurement_id ' density=' num2str(density)];          
        end
        function randomcomparison_id = getRandomComparisonID(analysis, measure_code, group, varargin)
            % GETRANDOMCOMPARISONID returns a random comparison ID
            %
            % RANDOMCOMPARISON_ID = GETRANDOMCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP, 'density', DENSITY)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, the GROUP and the DENSITY.
            %
            % See also getMeasurementID, getComparisonID.            
         
            randomcomparison_id = getRandomComparisonID@AnalysisFNC_WU(analysis, measure_code, group, varargin{:});
            
            density = get_from_varargin(0, 'density', varargin{:});
            randomcomparison_id = [randomcomparison_id ' density=' num2str(density)];
        end
        function comparison_id = getComparisonID(analysis, measure_code, group_1, group_2, varargin)
            % GETCOMPARISONID returns a comparison ID
            %
            % COMPARISON_ID = GETCOMPARISONID(ANALYSIS, MEASURE_CODE, GROUP_1, GROUP_2, 'density', DENSITY)
            % creates a random comparison ID with the ANALYSIS class, the
            % MEASURE_CODE, GROUP_1 and GROUP_2, and the DENSITY.
            %
            % See also getMeasurementID, getRandomComparisonID.
            
            comparison_id = getComparisonID@AnalysisFNC_WU(analysis, measure_code, group_1, group_2, varargin{:});
            
            density = get_from_varargin(0, 'density', varargin{:});
            comparison_id = [comparison_id ' density=' num2str(density)];
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
            
            density = get_from_varargin(0, 'density', varargin{:});
            A = binarize(A, 'density', density, varargin{:});
            
            graph_type = AnalysisFNC_WU.getGraphType();
            g = Graph.getGraph(graph_type, A);
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_class = getClass()
            % GETCLASS returns the class of functional analysis
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % analysis. In this case AnalysisFNC_BUD.
            %
            % See also getList, getName, getDescription.
            
            analysis_class = 'AnalysisFNC_BUD';
        end
        function name = getName()
            % GETNAME returns the name of functional analysis
            %
            % NAME = GETNAME() returns the name of the analysis.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Analysis Functional BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional analysis
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of AnalysisFNC_BUD.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'Analysis based on functional data of fixed density using ' ...
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
            % class of AnalysisFNC_BUD measurement, 'MeasurementFNC_BUD'.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class =  'MeasurementFNC_BUD';
        end
        function randomcomparison_class = getRandomComparisonClass()
            % GETRANDOMCOMPARISONCLASS returns the class of functional analysis randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS()
            % returns the class of AnalysisFNC_BUD randomcomparison,
            % 'RandomComparisonFNC_BUD'.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = 'RandomComparisonFNC_BUD';
        end
        function comparison_class = getComparisonClass()
            % GETCOMPARISONCLASS returns the class of functional analysis comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS() returns the
            % class of AnalysisFNC_BUD comparison, 'ComparisonFNC_BUD'.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = 'ComparisonFNC_BUD';
        end
    end
end