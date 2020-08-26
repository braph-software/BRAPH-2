classdef Analysis < handle & matlab.mixin.Copyable
    % Analysis (Abstract) An analysis
    % Analysis provides the methods necessary for all analyses.
    % It is a subclss of handle & matlab.mixin.Copyable
    %
    % Analysis provides the methods necessary for all analysis subclasses.
    % Instances of this class cannot be created. Use one of the subclasses.
    % The subclasses must be created inside the corresponding workflow
    % ./braph2/workflows/...
    %
    % Analysis Constructor methods (Access = protected)
    %  Analysis                 - Constructor
    %
    % Analysis Abstract ID methods (Abstract)
    %  getMeasurementID         - asbtract method to be implemented
    %  getRandomComparisonID    - asbtract method to be implemented
    %  getComparisonID          - abstract method to be implemented
    %
    % Analysis set methods
    %  setID                    - sets the ID
    %  setLabel                 - sets the label
    %  setNotes                 - sets the notes
    %
    % Analysis get methods
    %  getID                    - returns the analysis ID
    %  getLabel                 - returns the analysis label
    %  getNotes                 - returns the analysis notes
    %  getCohort                - returns the analysis cohort
    %  getMeasurements          - returns the idict measurements
    %  getMeasurement           - returns the specified measurement
    %  getRandomComparisons     - returns the idict randomcomparisons
    %  getRandomComparison      - returns the specified randomcomparison
    %  getComparisons           - returns the idict comparisons
    %  getComparison            - returns the specified comparison
    %  getSettings              - returns the analysis settings structure
    %  selectMeasurements       - returns a list with selected measurements values
    %
    % Analysis plot methods (Abstract)
    %  getGraphPanel            - returns a correlation matrix graph uipanel
    %  getGlobalPanel           - returns a global measure uipanel
    %  getGlobalMeasurePlot     - returns a global measure plot
    %  getGlobalComparisonPlot  - returns a global comparison plot
    %  getGlobalRandomComparisonPlot - returns a global randomcomparison plot
    %
    % Analysis getAnalysis methods (Static)
    %  getAnalysis              - returns a new analysis
    %
    % Analysis Descriptive methods (Static)
    %  getList                  - returns a list of analysis subclasses
    %  getClass                 - returns the class of the analysis
    %  getName                  - returns the name of the analysis
    %  getDescription           - returns the description of the analysis
    %  getGraphType             - returns the compatible type of graph
    %  getSubjectClass          - returns the class of the subject
    %  getMeasurementClass      - returns the class of the measurement
    %  getRandomComparisonClass - returns the class of the randomcomparison
    %  getComparisonClass       - returns the class of the comparison
    %  getAvailableSettings     - returns the analysis available settings
    %
    % See also Measurement, RandomComparison, Comparison, IndexedDictionary.
    
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
            % ANALYSIS(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS)
            % creates an analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSIS with default settings.
            %
            % ANALYSIS(ID, LABEL, NOTES, COHORT, MEASUREMENTS, RANDOMCOMPARISON, COMPARISONS, PROPERTY, VALUE, ...)
            % creates an analysis with ID, LABEL, COHORT, MEASUREMENTS,
            % RANDOMCOMPARISON and COMPARISONS. It initializes the
            % ANALYSIS with specified settings VALUES.
            %
            % See also Measurement, RandomComparison, Comparison.
            
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
            % SETID sets the id
            %
            % SETID(ANALYSIS, ID) sets the id
            %
            % See also setLabel, setNotes.
            
            assert(ischar(id), ...
                [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')
            
            analysis.id = id;
        end
        function setLabel(analysis, label)
            % SETLABEL sets the label
            %
            % SETLABEL(ANALYSIS, LABEL) sets the label
            %
            % See also setID, setNotes.
            
            assert(ischar(label), ...
                [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')
            
            analysis.label = label;
        end
        function setNotes(analysis, notes)
            % SETNOTES sets the notes
            %
            % SETNOTES(ANALYSIS, NOTES) sets the notes
            %
            % See also setID, setLabel.
            
            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(analysis) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')
            
            analysis.notes = notes;
        end
    end
    methods  % Get functions
        function id = getID(analysis)
            % GETID returns the id
            %
            % ID = GETID(ANALYSIS) returns the id
            %
            % See also getLabel, getNotes.
            
            id = analysis.id;
        end
        function label = getLabel(analysis)
            % GETLABEL returns the label
            %
            % LABEL = GETLABEL(ANALYSIS) returns the label
            %
            % See also getID, getNotes.
            
            label = analysis.label;
        end
        function notes = getNotes(analysis)
            % GETNOTES returns the notes
            %
            % NOTES = GETNOTES(ANALYSIS) returns the notes
            %
            % See also getID, getLabel.
            
            notes = analysis.notes;
        end
        function cohort = getCohort(analysis)
            % GETCOHORT returns the cohort
            %
            % GETCOHORT(ANALYSIS) returns the cohort
            %
            % See also getMeasurements, getRandomComparisons, getComparisons.
            
            cohort = analysis.cohort;
        end
        function measurement_idict = getMeasurements(analysis)
            % GETMEASUREMENTS returns the measurements idict
            %
            % GETMEASUREMENTS(ANALYSIS) returns the measurements idict
            %
            % See also getMeasurement, getRandomComparisons, getComparisons.
            
            measurement_idict = analysis.measurement_idict;
        end
        function measurement = getMeasurement(analysis, measure_code, group, varargin)
            % GETMEASUREMENT returns a specified measurement
            %
            % MEASUREMENT = GETMEASUREMENT(ANALYSIS, MEASURE_CODE, GROUP)
            % checks if the measurement exists in measurement idict. If it
            % does not exist it will calculate the measurement MEASURE_CODE.
            % It uses default settings.
            %
            % MEASUREMENT = GETMEASUREMENT(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % checks if the measurement exists in measurement idict. If it
            % does not exist it will calculate the measurement MEASURE_CODE.
            % It passes the property VALUES to the calculating function.
            %
            % See also getRandomComparison, getComparison
            
            measurement_id = analysis.getMeasurementID(measure_code, group, varargin{:});
            if ~analysis.getMeasurements().contains(measurement_id)
                measurement = calculate_measurement(analysis, measure_code, group, varargin{:});
                analysis.getMeasurements().add(measurement_id, measurement)
            end
            measurement = analysis.getMeasurements().getValue(measurement_id);
        end
        function randomparison_idict = getRandomComparisons(analysis)
            % GETRANDOMCOMPARISONS returns the randomcomparisons idict
            %
            % GETRANDOMCOMPARISONS(ANALYSIS) returns the randomcomparisons idict
            %
            % See also getMeasurement, getRandomComparison, getComparisons.
            
            randomparison_idict = analysis.randomcomparison_idict;
        end
        function random_comparison = getRandomComparison(analysis, measure_code, group, varargin)
            % GETRANDOMCOMPARISON returns a specified randomcomparison
            %
            % RANDOMCOMPARISON = GETRANDOMCOMPARISON(ANALYSIS, MEASURE_CODE, GROUP)
            % checks if the randomcomparison exists in randomcopmarison idict.
            % If it does not exist it will calculate. It uses default settings.
            %
            % RANDOMCOMPARISON = RANDOMCOMPARISON(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % checks if the randomcomparison exists in randomcomparison idict.
            % If it does not exist it will calculate. It passes the
            % property VALUES to the calculating function.
            %
            % See also getRandomComparison, getComparison
            
            randomcomparison_id = analysis.getRandomComparisonID(measure_code, group, varargin{:});
            if ~analysis.getRandomComparisons().contains(randomcomparison_id)
                random_comparison = calculate_random_comparison(analysis, measure_code, group, varargin{:});
                analysis.getRandomComparisons().add(randomcomparison_id, random_comparison)
            end
            random_comparison = analysis.getRandomComparisons().getValue(randomcomparison_id);
        end
        function comparison_idict = getComparisons(analysis)
            % GETCOMPARISONS returns the comparisons idict
            %
            % GETCOMPARISONS(ANALYSIS) returns the comparisons idict
            %
            % See also getMeasurement, getRandomComparisons, getComparison.
            
            comparison_idict = analysis.comparison_idict;
        end
        function comparison = getComparison(analysis, measure_code, group_1, group_2, varargin)
            % GETCOMPARISON returns a specified comparison
            %
            % COMPARISON = GETCOMPARISON(ANALYSIS, MEASURE_CODE, GROUP)
            % checks if the comparison exists in comparison idict. If it
            % does not exist it will calculate. It uses default settings.
            %
            % COMPARISON = GETCOMPARISON(ANALYSIS, MEASURE_CODE, GROUP, PROPERTY, VALUE, ...)
            % checks if the comparison exists in comparison idict. If it
            % does not exist it will calculate. It passes the property VALUES
            % to the calculating function.
            %
            % See also getRandomComparison, getComparison
            
            comparison_id = analysis.getComparisonID(measure_code, group_1, group_2, varargin{:});
            if ~analysis.getComparisons().contains(comparison_id)
                comparison = calculate_comparison(analysis, measure_code, group_1, group_2, varargin{:});
                analysis.getComparisons().add(comparison_id, comparison)
            end
            comparison = analysis.getComparisons().getValue(comparison_id);
        end
        function res = getSettings(analysis, setting_code)
            % GETSETTINGS returns the settings structre
            %
            % RES = GETSETTINGS(ANALYSIS,SETTING_CODE) returns the settings
            % structure.
            %
            % See also getID, getLabel, getNotes.
            
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
        function list = selectMeasurements(analysis, measure_code, group, varargin) 
            % SELECTMEASUREMENTS returns a list with the group measurements values
            %
            % LIST = SELECTMEASUREMENTS(ANALYSIS, MEASURE_CODE, GROUP, VARARGIN)
            % returns a list containing the GROUP Measurements values of type
            % MEASURE_CODE.
            %
            % See also getSettings, getMeasurement, getCohort.
            
            analysis_case = get_from_varargin('', 'AnalysisCase', varargin{:});
            measurements = analysis.getMeasurements().getValues();
            group = analysis.getCohort().getGroups().getValue(group);
            filter = measurements(find(cellfun(@(x) isequal(x.getGroup(), group) ...
                && isequal(x.getMeasureCode, measure_code) , measurements)));    %#ok<FNDSB>
            list = cell(size(filter));
            for i = 1:1:length(filter)
                m = filter{i}; %#ok<NASGU>
                list{i} =  eval(['m' analysis_case]); %#ok<AGROW>
            end
        end
    end
    methods (Abstract)  % Plot abstract methods
        getGraphPanel(analysis, varargin)
        getGlobalPanel(analysis, varargin) 
        getGlobalMeasurePlot(analysis, ui_parent_axes, measure_code, group, varargin)
        getGlobalComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group_1, group_2, varargin)
        getGlobalRandomComparisonPlot(analysis, ui_parent_panel, ui_parent_axes, group, varargin)
    end
    methods (Static)  % getAnalysis
        function analysis = getAnalysis(analysis_class, id, label, notes, cohort, varargin) %#ok<INUSD>
            % GETANALYSIS returns an analysis object
            %
            % ANALYSIS = GETANALYSIS(ANALYSIS_CLASS, ID, LABEL, NOTES, COHORT)
            % returns an analysis object of class ANALYSIS_CLASS with ID,
            % LABEL, NOTES. It initializes with a COHORT and default settings.
            %
            % ANALYSIS = GETANALYSIS(ANALYSIS_CLASS, ID, LABEL, NOTES, COHORT, PROPERTY, VALUE, ...)
            % returns an analysis object of class ANALYSIS_CLASS with ID,
            % LABEL, NOTES. It initializes with a COHORT and properties
            % VALUES.
            %
            % See also getList, getClass.
            
            analysis = eval([analysis_class  '(id, label, notes, cohort, varargin{:})']);
        end
    end
    methods (Static)  % Descriptive functions
        function analysis_list = getList()
            % GETLIST returns the list of analysis subclasses
            %
            % ANALYSIS_LIST = GETLIST() returns the list of analysis
            % (cell array) that are subclasses of Analysis.
            %
            % See also getClass, getName, getDescription.
            
            analysis_list = subclasses('Analysis');
        end
        function analysis_class = getClass(analysis)
            % GETCLASS returns the class of analysis
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % analysis.
            %
            % See also getList, getName, getDescription, getGraphType.
            
            if isa(analysis, 'Analysis')
                analysis_class = class(analysis);
            else % analysis should be a string with the analysis class
                analysis_class = analysis;
            end
        end
        function name = getName(analysis)
            % GETNAME returns the name of analysis subclass
            %
            % NAME = GETNAME(ANALYSIS) returns the name of ANALYSIS.
            %
            % See also getList, getClass, getDescription.
            
            name = eval([Analysis.getClass(analysis) '.getName()']);
        end
        function description = getDescription(analysis)
            % GETDESCRIPTION returns the description of analysis subclass
            %
            % DESCRIPTION = GETDESCRIPTION(ANALYSIS) returns the description
            % of ANALYSIS.
            %
            % See also getList, getClass, getName, getGraphType.
            
            description = eval([Analysis.getClass(analysis) '.getDescription()']);
        end
        function graph_type = getGraphType(analysis)
            % GETGRAPHTYPE returns the type of graph comptible with the analysis
            %
            % GRAPH_TYPE = GETGRAPHTYPE(ANALYSIS) returns the type of graph
            % compatible with the ANALYSIS.
            %
            % See also getClass, getName, getDescription.
            
            graph_type = eval([Analysis.getClass(analysis) '.getGraphType()']);
        end
        function subject_class = getSubjectClass(analysis)
            % GETSUBJETCLASS returns the class of analysis subclass subject
            %
            % SUBJECT_CLASS = GETSUBJECT_CLASS(ANALYSIS) returns the class
            % of ANALYSIS subject.
            %
            % See also getList, getClass, getName, getDescription.
            
            subject_class = eval([Analysis.getClass(analysis) '.getSubjectClass()']);
        end
        function measurement_class = getMeasurementClass(analysis)
            % GETMEASUREMENTCLASS returns the class of analysis subclass measurement
            %
            % MEASUREMENT_CLASS = GETMEASUREMENT_CLASS(ANALYSIS) returns the
            % class of ANALYSIS measurement.
            %
            % See also getRandomComparisonClass, getComparisonClass.
            
            measurement_class = eval([Analysis.getClass(analysis) '.getMeasurementClass()']);
        end
        function randomcomparison_class = getRandomComparisonClass(analysis)
            % GETRANDOMCOMPARISONCLASS returns the class of analysis subclass randomcomparison
            %
            % RANDOMCOMPARISON_CLASS = GETRANDOMCOMPARISONCLASS(ANALYSIS)
            % returns the class of ANALYSIS randomcomparison.
            %
            % See also getMeasurementClass, getComparisonClass.
            
            randomcomparison_class = eval([Analysis.getClass(analysis) '.getRandomComparisonClass()']);
        end
        function comparison_class = getComparisonClass(analysis)
            % GETCOMPARISONCLASS returns the class of analysis subclass comparison
            %
            % COMPARISON_CLASS = GETCOMPARISONCLASS(ANALYSIS) returns the
            % class of ANALYSIS comparison.
            %
            % See also getMeasurementClass, getRandomComparisonClass.
            
            comparison_class = eval([Analysis.getClass(analysis) '.getComparisonClass()']);
        end
        function available_settings = getAvailableSettings(analysis)
            % GETAVAILABLESETTINGS returns the available settings of analysis subclass
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS(ANALYSIS) returns the
            % available settings of ANALYSIS.
            %
            % See also getClass, getName, getDescription
            
            available_settings = eval([Analysis.getClass(analysis) '.getAvailableSettings()']);
        end
    end    
    methods (Access = protected)  % Deep copy
        function analysis_copy = copyElement(analysis)
            % COPYELEMENT copies elements of analysis
            %
            % ANALYSIS_COPY = COPYELEMENT(ANALYSIS) copies elements of the
            % analysis ANALYSIS. Makes a deep copy of the idictionaries of
            % of the analysis.
            %
            % See also Cohort.
            
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