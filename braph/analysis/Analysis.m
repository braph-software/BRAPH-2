classdef Analysis < handle & matlab.mixin.Copyable
    properties (GetAccess = protected, SetAccess = protected)
        cohort  % cohort
        measurement_idict  % indexed dictionary with measurements
        randomcomparison_idict  % indexed dictionary with random comparison
        comparison_idict  % indexed dictionary with comparison
        settings  % settings structure for analysis
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
            
            available_settings = Analysis.getAvailableSettings(class(analysis));%
            settings = cell(length(available_settings), length(available_settings{1, 1}) - 2);
            for i = 1:1:length(available_settings)
                    a_s = available_settings{i};
                    available_setting_code = a_s{1, 1};
                    available_setting_default = a_s{1, 3};
                    settings{i, 1} = available_setting_code;
                    settings{i, 2} = get_from_varargin(available_setting_default, available_setting_code, varargin{:});
            end
            analysis.settings = settings;
        end
        % function copyElement() %TODO
    end
    methods (Abstract)
        getMeasurementID(analysis, measure_code, group, varargin)
        getRandomComparisonID(analysis, measure_code, group, varargin)
        getComparisonID(analysis, measure_code, groups, varargin)
    end
    methods (Abstract, Access = protected)
        calculate_measurement(analysis, measure_code, group, varargin)
        calculate_random_comparison(analysis, measure_code, group, varargin)
        calculate_comparison(analysis, measure_code, groups, varargin)
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
        function measurement = calculateMeasurement(analysis, measure_code, group, varargin)
            id = analysis.getMeasurementID(measure_code, group, varargin{:});
            if ~analysis.getMeasurements().contains(id)
                measurement = calculate_measurement(analysis, measure_code, group, varargin{:});
                analysis.getMeasurements().add(id, measurement)
            end
            measurement = analysis.getMeasurements().getValue(id);
        end
        function random_comparison = calculateRandomComparison(analysis, measure_code, group, varargin)
            id = analysis.getRandomComparisonID(analysis, measure_code, group, varargin{:});
            if ~analysis.getRandomComparison().contains(id)
                random_comparison = calculate_random_comparison(analysis, measure_code, group, varargin{:});
                analysis.getRandomComparisons().add(id, random_comparison)
            end
            random_comparison = analysis.getRandomComparisons().getValue(id);
        end
        function comparison = calculateComparison(analysis, measure_code, groups, varargin)
            id = analysis.getComparisonID(analysis, measure_code, groups, varargin{:});
            if ~analysis.getComparisons().contains(id)
                comparison = calculate_comparison(analysis, measure_code, groups, varargin{:});
                analysis.getComparison().add(id, comparison)
            end
            comparison = analysis.getComparison().getValue(id);
        end
        function res = getSettings(analysis, setting_code)
            if nargin<2
                res = analysis.settings;
            else
                for i = 1:1:length(analysis.settings)
                    if isequal(analysis.settings{i, 1}, setting_code)
                        res = get_from_varargin([], setting_code, analysis.settings{i, :});
                    end
                end
            end
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
        function measurmentList = getMeasurementClass(analysis)
            measurmentList = eval([Analysis.getClass(analysis) '.getMeasurementClass()']);
        end
        function randomcomparisonList = getRandomComparisonClass(analysis)
            randomcomparisonList = eval([Analysis.getClass(analysis) '.getRandomComparisonClass()']);
        end
        function comparisonList = getComparisonClass(analysis)
            comparisonList = eval([Analysis.getClass(analysis) '.getComparisonClass()']);
        end
        function description = getDescription(analysis)
            % analysis description
            description = eval([Analysis.getClass(analysis) '.getDescription()']);
        end
        function available_settings = getAvailableSettings(analysis)
            available_settings = eval([Analysis.getClass(analysis) '.getAvailableSettings()']);
        end
        function analysis = getAnalysis(analysis_class, varargin)
            analysis = eval([analysis_class '(varargin{:})']);
        end
    end
end