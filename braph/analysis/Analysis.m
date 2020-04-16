classdef Analysis < handle & matlab.mixin.Copyable
    properties (GetAccess = protected, SetAccess = protected)
        cohort  % cohort
        measurement_idict  % indexed dictionary with measurements
        randomcomparison_idict  % indexed dictionary with random comparison
        comparison_idict  % indexed dictionary with comparison
    end
    methods (Access = protected)
        function analysis = Analysis(cohort, measurements, randomcomparisons, comparisons, varargin)
            
            assert(isa(cohort, 'Cohort') && isequal(cohort.getSubjectClass(), analysis.getSubjectClass()), ...
                ['BRAPH:Analysis:SubjectClassErr'], ...
                ['The first argument must be a Cohort with subjects of class ' analysis.getSubjectClass()]) %#ok<NBRAK>
            analysis.cohort = cohort;
            
            analysis.measurement_idict = IndexedDictionary(analysis.getMeasurementClass());
            if ~iscell (measurements)
                measurements = {measurements};
            end
            for i = 1:1:length(measurements)
                measurement = measurements{i};
                assert(isequal(measurement.getClass(), analysis.getMeasurementClass()), ...
                    ['BRAPH:Analysis:Constructor'], ...
                    ['Input is not of class Measurement']) %#ok<NBRAK>
                analysis.measurement_idict.add(measurement.getID(), measurement);
            end

            analysis.randomcomparison_idict = IndexedDictionary(analysis.getRandomComparisonClass());
            if ~iscell(randomcomparisons)
                randomcomparisons = {randomcomparisons};
            end
            for i = 1:1:length(randomcomparisons)
                randomcomparison = randomcomparisons{i};
                assert(isequal(randomcomparison.getClass(), analysis.getRandomComparisonClass()), ...
                    ['BRAPH:Analysis:Constructor'], ...
                    ['Input is not of class Randomcomparison']) %#ok<NBRAK>
                analysis.randomcomparison_idict.add(randomcomparison.getID(), randomcomparison);
            end
            
            analysis.comparison_idict = IndexedDictionary(analysis.getComparisonClass());
            if ~iscell (comparisons)
                comparisons = {comparisons};
            end
            for i = 1:1:length(comparisons)
                comparison = comparisons{i};
                assert(isequal(comparison.getClass(), analysis.getComparisonClass()), ...
                    ['BRAPH:Analysis:Constructor'], ...
                    ['Input is not of class Comparison']) %#ok<NBRAK>
                analysis.comparison_idict.add(comparison.getID(), comparison);
            end
        end
        % function copyElement() %TODO
    end
    methods (Abstract)
        getMeasurementID(analysis, varargin)
        getRandomComparisonID(analysis, varargin)
        getComparisonID(analysis, varargin)        
    end
    methods
        function cohort = getCohort(analysis)
            cohort = analysis.cohort;
        end
        function measurement_idict = getMeasurements(analysis)
            measurement_idict = analysis.measurement_idict;
        end
        function randomparison_idict = getRandomComparisons(analysis)
            randomparison_idict = analysis.randomcomparison_idict;
        end
        function comparison_idict = getComparisons(analysis)
            comparison_idict = analysis.comparison_idict;
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
        function name = getName(analysis)
            % analysis name            
            name = eval([Analysis.getClass(analysis) '.getName()']);
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
        function description = getDescription(analysis)
            % analysis description            
            description = eval([Analysis.getClass(analysis) '.getDescription()']);
        end
        function analysis = getAnalysis(analysis_class, varargin)
            analysis = eval([analysis_class '(varargin{:})']);
        end
    end
end