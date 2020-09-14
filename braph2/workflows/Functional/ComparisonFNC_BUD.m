classdef ComparisonFNC_BUD < ComparisonFNC_WU
    % ComparisonFNC_BUD A comparison of functional data with BU graphs at fixed density
    % ComparisonFNC_BUD is a subclass of Comparison.
    %
    % ComparisonFNC_BUD stores a comparison between two groups.
    % The data from the groups it compares have a density.
    % Functional data can be for example fMRI data.
    %
    % ComparisonFNC_BUD constructor methods:
    %  ComparisonFNC_BUD            - Constructor
    %
    % ComparisonFNC_BUD get methods:
    %  getThreshold                 - returns the density
    %
    % ComparisonFNC_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisFNC_BUT, MeasurementFNC_BUT, RandomComparisonFNC_BUT. 
    
    properties (Access = protected)
        density  % density of the values
    end
    methods  % Constructor
        function c =  ComparisonFNC_BUD(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % ComparisonFNC_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'density', THRESHOLD) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed THRESHOLD.
            %
            % ComparisonFNC_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default THRESHOLD.
            %
            % See also MeasurementFNC_BUT, RandomComparisonFNC_BUT, AnalysisFNC_BUT.
            
            c = c@ComparisonFNC_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
            density = get_from_varargin(0, 'density', varargin{:});
            c.setDensity(density)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity(c, density)
            % SETDENSITY sets the fixed density of the values
            %
            % SETDENSITY(C, DENSITY) sets the fixed density of the values.
            %
            % See also getDensity.
            
            c.density = density;
        end
    end
    methods  % Get functions
        function density = getDensity(c)
            % GETDENSITY returns the fixed density of the data values
            %
            % DENSITY = GETDENSITY(C) returns the fixed density of the 
            % data values.
            %
            % See also getMeasureValue, setDensity.
            
            density = c.density;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of functional comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % comparison. In this case 'ComparisonFNC_BUD'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonFNC_BUD';
        end
        function name = getName()
            % GETNAME returns the name of functional comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonFNC_BUD.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Functional BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional comparison 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonFNC_BUD.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'FNC comparison with functional data using binary graphs ' ...
                'calculated at a fixed density. ' ...
                'For example, it can use fMRI data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisFNC_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisFNC_BUT';
        end
    end
end