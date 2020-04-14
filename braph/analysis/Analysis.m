classdef Analysis < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        cohort  % cohort
        measurement_idict  % indexed dictionary with measurements
        randomcomparison_idict  % indexed dictionary with random comparison
        comparison_idict  % indexed dictionary with comparison
    end
    methods (Access=protected)
        function analysis = Analysis(cohort, measurements, randomcomparisons, comparisons, varargin)
            
            assert(isa(cohort, 'Cohort') && isequal(cohort.getSubjectClass(), analysis.getSubjectClass()), ...
                ['BRAPH:Analysis:SubjectClassErr'], ...
                ['The first argument must be a Cohort with subjects of class ' analysis.getSubjectClass()]) %#ok<NBRAK>
            analysis.cohort = cohort;
            
            % instantiation dictionaries
            analysis.measurement_idict = IndexedDictionary(analysis.getMeasurementClass());
            analysis.randomcomparison_idict = IndexedDictionary(analysis.getRandomComparisonClass());
            analysis.comparison_idict = IndexedDictionary(analysis.getComparisonClass());
            
            for i=1:1:length(measurements)
                if ~iscell (measurements)
                    measurements = {measurements};
                end
                measurement = measurements{i};
                assert(isequal(measurement.getClass(), analysis.getMeasurementClass()), ...
                    ['BRAPH:Analysis:Constructor'], ...
                    ['Input is not of class Measurement']) %#ok<NBRAK>
                analysis.measurement_idict.add(measurement.getID(), measurement);
            end
            for i=1:1:length(randomcomparisons)
                if ~iscell(randomcomparisons)
                    randomcomparisons = {randomcomparisons};
                end
                randomcomparison = randomcomparisons{i};
                assert(isequal(randomcomparison.getClass(), analysis.getRandomComparisonClass()), ...
                    ['BRAPH:Analysis:Constructor'], ...
                    ['Input is not of class Randomcomparison']) %#ok<NBRAK>
                analysis.randomcomparison_idict.add(randomcomparison.getID(), randomcomparison);
            end
            for i=1:1:length(comparisons)
                if ~iscell (comparisons)
                    comparisons = {comparisons};
                end
                comparison = comparisons{i};
                assert(isequal(comparison.getClass(), analysis.getComparisonClass()), ...
                    ['BRAPH:Analysis:Constructor'], ...
                    ['Input is not of class Comparison']) %#ok<NBRAK>
                analysis.comparison_idict.add(comparison.getID(), comparison);
            end
        end
        % function copyElement() %TODO
    end
    methods
        function measurement_idict = getMeasurements(analysis)
            measurement_idict = analysis.measurement_idict;
        end
        function comparison_idict = getComparisons(analysis)
            comparison_idict = analysis.comparison_idict;
        end
        function randomparison_idict = getRandomComparisons(analysis)
            randomparison_idict = analysis.randomcomparison_idict;
        end
        function comparison_id = calculate_comparison_id(analysis,  comparison_class, comparison_code, groups, varargin) % string
            grouppart = '';  % its needed
            for i = 1:1:length(groups)
                if isa(groups{i}, 'Group')
                    grouppart = [grouppart '' groups{i}];
                end
            end
            
            for i = 1:1:length(varargin)
                vararginpart = [vararginpart '' varargin{i}];
            end
            
            comparison_id = [measurement_class ' ' measure_code ' ' grouppart ' ' vararginpart];
        end
        function measurement_id = calculate_measurement_id(analysis,  measurement_class, measure_code, group, varargin)
            for i = 1:1:length(varargin)
                vararginpart = [vararginpart '' varargin{i}];
            end
            measurement_id = [measurement_class ' ' measure_code ' ' group ' ' vararginpart];
        end
        function randomcomparison_id = calculate_randomcomparison_id(analysis,  randomcomparison_class, randomcomparison_code, group, varargin)
            for i = 1:1:length(varargin)
                vararginpart = [vararginpart '' varargin{i}];
            end
            randomcomparison_id = [measurement_class ' ' randomcomparison_code ' ' group ' ' vararginpart];
        end
    end
    methods (Static)
        function analysis_list = getList()
            analysis_list = subclasses( ...
                'Analysis', ...
                [fileparts(which('Analysis')) filesep 'analyses'] ...
                );
        end
        function analysis_class = getClass(analysis)
            % analysis class (same as the analysis object name)
            
            if isa(analysis, 'Analysis')
                analysis_class = class(analysis);
            else % analysis should be a string with the analysis class
                analysis_class = analysis;
            end
        end
        function subject_class = getSubjectClass(analysis)
            % cohort class
            
            subject_class = eval([Analysis.getClass(analysis) '.getSubjectClass()']);
        end
        function measurmentList = getMeasurementClass()
            measurmentList = eval([Analysis.getClass(analysis) '.getMeasurementClass()']);
        end
        function randomcomparisonList = getRandomComparisonClass()
            randomcomparisonList = eval([Analysis.getClass(analysis) '.getRandomComparisonClass()']);
        end
        function comparisonList = getComparisonClass()
            comparisonList = eval([Analysis.getClass(analysis) '.getComparisonClass()']);
        end
        function name = getName(analysis)
            % analysis name
            
            name = eval([Analysis.getClass(analysis) '.getName()']);
        end
        function description = getDescription(analysis)
            % analysis description
            
            description = eval([Analysis.getClass(analysis) '.getDescription()']);
        end
        function analysis = getAnalysis(analysis_class, varargin)
            analysis = eval([analysis_class '(varargin{:})']);
        end
    end
end