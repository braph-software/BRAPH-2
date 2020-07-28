classdef ComparisonST_BUD < ComparisonST_WU
    % ComparisonST_BUD A comparison of structural data with BU graphs at fixed density
    % ComparisonST_BUD is a subclass of Comparison.
    %
    % ComparisonST_BUD stores a comparison between two groups.
    % The data from the groups it compares have a density.
    % Structural data can be for example MRI or PET data.
    %
    % ComparisonST_BUD constructor methods:
    %  ComparisonST_BUD              - Constructor
    %
    % ComparisonST_BUD get methods:
    %  getThreshold                 - returns the density
    %
    % ComparisonST_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisST_BUT, MeasurementST_BUT, RandomComparisonST_BUT. 
    
    properties (Access = protected)
        density  % density of the values
    end
    methods  % Constructor
        function c =  ComparisonST_BUD(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % ComparisonST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'density', THRESHOLD) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed THRESHOLD.
            %
            % ComparisonST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default THRESHOLD.
            %
            % See also MeasurementST_BUT, RandomComparisonST_BUT, AnalysisST_BUT.
            
            c = c@ComparisonST_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
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
            % GETCLASS returns the class of structural comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % comparison. In this case 'ComparisonST_BUD'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonST_BUD';
        end
        function name = getName()
            % GETNAME returns the name of structural comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonST_BUD.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Structural BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural comparison 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonST_BUD.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'ST comparison with structural data using binary graphs ' ...
                'calculated at a fixed density. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisST_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_BUT';
        end
    end
end