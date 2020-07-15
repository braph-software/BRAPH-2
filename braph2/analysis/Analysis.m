classdef Analysis < handle & matlab.mixin.Copyable
    % Analysis (Abstract) An analysis
    % Analysis provides the methods necessary for all analysis.
    % It is a subclss of handle & matlab.mixin.Copyable
    %
    % Analysis provides the methods necessary for all analysis subclass. 
    % Instances of this class cannot be created. Use one of the subclasses.
    % The subclasses must be created inside the corresponding workflow
    % ./braph2/workflows/... 
    %
    % Analysis Constructor methods (Access = protected)
    %  Analysis                 - Constructor
    %
    % Analysis Abstract methods (Abstract)
    %  getMeasurement           - asbtract method to be implemented
    %  getRandomComparison      - asbtract method to be implemented
    %  getComparison            - abstract method to be implemented
    %
    % Analysis set methods
    %
    %
    %
    
    
    properties (GetAccess = protected, SetAccess = protected)
        id  % analysis id
        label  % analysis label
        notes  % analysis notes
        cohort  % cohort
        measurement_idict  % indexed dictionary with measurements
        randomcomparison_idict  % indexed dictionary with random comparison
        comparison_idict  % indexed dictionary with comparison
        settings  % settings structure for analysis
    end
    methods (Access = protected)  % Constructor
        function analysis = Analysis(id, label, notes, cohort, measurements, randomcomparisons, comparisons, varargin)
            
            analysis.setID(id)
            analysis.setLabel(label)
            analysis.setNotes(notes)

            assert(isa(cohort, 'Cohort') && isequal(cohort.getSubjectClass(), analysis.getSubjectClass()), ...
                [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                ['The first argument must be a Cohort with subjects of class ' analysis.getSubjectClass()])
            analysis.cohort = cohort;
            
            analysis.measurement_idict = IndexedDictionary(analysis.getMeasurementClass());
            assert(iscell(measurements), ...
                [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                ['The second input must be a cell array of Measurement objects of class ' analysis.getMeasurementClass()])
            for i = 1:1:length(measurements)
                measurement = measurements{i};
                assert(isequal(measurement.getClass(), analysis.getMeasurementClass()), ...
                    [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                    ['The second input must be a cell array of Measurement objects of class ' analysis.getMeasurementClass()])
                analysis.measurement_idict.add(measurement.getID(), measurement);
            end
            
            analysis.randomcomparison_idict = IndexedDictionary(analysis.getRandomComparisonClass());
            assert(iscell(randomcomparisons), ...
                [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                ['The third input must be a cell array of RandomComparison objects of class ' analysis.getRandomComparisonClass()])
            for i = 1:1:length(randomcomparisons)
                randomcomparison = randomcomparisons{i};
                assert(isequal(randomcomparison.getClass(), analysis.getRandomComparisonClass()), ...
                    [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                    ['The third input must be a cell array of RandomComparison objects of class ' analysis.getRandomComparisonClass()])
                analysis.randomcomparison_idict.add(randomcomparison.getID(), randomcomparison);
            end
            
            analysis.comparison_idict = IndexedDictionary(analysis.getComparisonClass());
            assert(iscell(comparisons), ...
                [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                ['The fourth input must be a cell array of Comparison objects of class ' analysis.getComparisonClass()])
            for i = 1:1:length(comparisons)
                comparison = comparisons{i};
                assert(isequal(comparison.getClass(), analysis.getComparisonClass()), ...
                    [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                    ['The fourth input must be a cell array of Comparison objects of class ' analysis.getComparisonClass()])
                analysis.comparison_idict.add(comparison.getID(), comparison);
            end
            
            available_settings = Analysis.getAvailableSettings(class(analysis));
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
    end
    methods (Abstract)  % ID functions
        getMeasurementID(analysis, measure_code, group, varargin)
        getRandomComparisonID(analysis, measure_code, group, varargin)
        getComparisonID(analysis, measure_code, group_1, group_2, varargin)
    end
    methods (Abstract, Access = protected)  % Calculation functions
        calculate_measurement(analysis, measure_code, group, varargin)
        calculate_random_comparison(analysis, measure_code, group, varargin)
        calculate_comparison(analysis, measure_code, group_1, group_2, varargin)
    end
    methods  % Set functions
        function setID(analysis, id)
            
            assert(ischar(id), ...
                [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')

            analysis.id = id;
        end
        function setLabel(analysis, label)

            assert(ischar(label), ...
                [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')
            
            analysis.label = label;
        end        
        function setNotes(analysis, notes)

            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')
            
            analysis.notes = notes;
        end        
    end
    methods  % Get functions
        function id = getID(analysis)
            
            id = analysis.id;
        end
        function label = getLabel(analysis)
            
            label = analysis.label;
        end
        function notes = getNotes(analysis)

            notes = analysis.notes;
        end
        function cohort = getCohort(analysis)
            cohort = analysis.cohort;
        end
        function measurement_idict = getMeasurements(analysis)
            measurement_idict = analysis.measurement_idict;
        end
        function measurement = getMeasurement(analysis, measure_code, group, varargin)
            measurement_id = analysis.getMeasurementID(measure_code, group, varargin{:});
            if ~analysis.getMeasurements().contains(measurement_id)
                measurement = calculate_measurement(analysis, measure_code, group, varargin{:});
                analysis.getMeasurements().add(measurement_id, measurement)
            end
            measurement = analysis.getMeasurements().getValue(measurement_id);
        end
        function randomparison_idict = getRandomComparisons(analysis)
            randomparison_idict = analysis.randomcomparison_idict;
        end
        function random_comparison = getRandomComparison(analysis, measure_code, group, varargin)
            randomcomparison_id = analysis.getRandomComparisonID(measure_code, group, varargin{:});
            if ~analysis.getRandomComparisons().contains(randomcomparison_id)
                random_comparison = calculate_random_comparison(analysis, measure_code, group, varargin{:});
                analysis.getRandomComparisons().add(randomcomparison_id, random_comparison)
            end
            random_comparison = analysis.getRandomComparisons().getValue(randomcomparison_id);
        end
        function comparison_idict = getComparisons(analysis)
            comparison_idict = analysis.comparison_idict;
        end
        function comparison = getComparison(analysis, measure_code, group_1, group_2, varargin)
            comparison_id = analysis.getComparisonID(measure_code, group_1, group_2, varargin{:});
            if ~analysis.getComparisons().contains(comparison_id)
                comparison = calculate_comparison(analysis, measure_code, group_1, group_2, varargin{:});
                analysis.getComparisons().add(comparison_id, comparison)
            end
            comparison = analysis.getComparisons().getValue(comparison_id);
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
    methods (Static)  % getAnalysis
        function analysis = getAnalysis(analysis_class, id, label, notes, cohort, varargin) %#ok<INUSD>
            analysis = eval([analysis_class  '(id, label, notes, cohort, varargin{:})']);
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_list = getList()
            analysis_list = subclasses('Analysis');
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
        function description = getDescription(analysis)
            % analysis description
            description = eval([Analysis.getClass(analysis) '.getDescription()']);
        end
        function subject_class = getSubjectClass(analysis)
            % cohort class
            subject_class = eval([Analysis.getClass(analysis) '.getSubjectClass()']);
        end
        function measurement_class = getMeasurementClass(analysis)
            measurement_class = eval([Analysis.getClass(analysis) '.getMeasurementClass()']);
        end
        function randomcomparison_class = getRandomComparisonClass(analysis)
            randomcomparison_class = eval([Analysis.getClass(analysis) '.getRandomComparisonClass()']);
        end
        function comparison_class = getComparisonClass(analysis)
            comparison_class = eval([Analysis.getClass(analysis) '.getComparisonClass()']);
        end
        function available_settings = getAvailableSettings(analysis)
            available_settings = eval([Analysis.getClass(analysis) '.getAvailableSettings()']);
        end
    end    
    methods (Access = protected)  % Deep copy    
        function analysis_copy = copyElement(analysis)
            % shallow copy of Analysis
            analysis_copy = copyElement@matlab.mixin.Copyable(analysis);
            
            % deep copy of cohort
            analysis_copy.cohort = analysis.getCohort().copy();
            
            % deep copy of measurement
            analysis_copy.measurement_idict = IndexedDictionary(analysis_copy.getMeasurementClass());
            for measurement_i = 1:1:analysis.getMeasurements().length()
                measurement = analysis.getMeasurements().getValue(measurement_i);
                measurement_copy = measurement.copy();
                measurement_copy.setBrainAtlases(analysis_copy.cohort.getBrainAtlases());
                group = measurement.getGroup();
                group_copy = analysis_copy.cohort.getGroups().getValue(group.getID());
                measurement_copy.setGroup(group_copy);
                analysis_copy.measurement_idict.add(tostring(measurement_copy.getID()), measurement_copy, measurement_i);
            end
            
            % deep copy of randomcomparison
            analysis_copy.randomcomparison_idict = IndexedDictionary(analysis_copy.getRandomComparisonClass());
            for randomcomparisons_i = 1:1:analysis.getRandomComparisons().length()
                randomcomparison = analysis.getRandomComparisons().getValue(randomcomparisons_i);
                randomcomparison_copy = randomcomparison.copy();
                randomcomparison_copy.setBrainAtlases(analysis_copy.cohort.getBrainAtlases());
                group = randomcomparison.getGroup();
                group_copy = analysis_copy.cohort.getGroups().getValue(group.getID());
                randomcomparison_copy.setGroup(group_copy);
                analysis_copy.randomcomparison_idict.add(tostring(randomcomparison_copy.getID()), randomcomparison_copy, randomcomparisons_i);
            end
            
            % deep copy of comparisons
            analysis_copy.comparison_idict = IndexedDictionary(analysis_copy.getComparisonClass());
            for comparisons_i = 1:1:analysis.getComparisons().length()
                comparison = analysis.getComparisons().getValue(comparisons_i);
                comparison_copy = comparison.copy();
                comparison_copy.setBrainAtlases(analysis_copy.cohort.getBrainAtlases());
                [group1, group2] = comparison.getGroups();
                group1_copy = analysis_copy.cohort.getGroups().getValue(group1.getID());
                group2_copy = analysis_copy.cohort.getGroups().getValue(group2.getID());
                comparison_copy.setGroups(group1_copy, group2_copy);
                analysis_copy.comparison_idict.add(tostring(comparison_copy.getID()), comparison_copy, comparisons_i);
            end
        end
    end
end