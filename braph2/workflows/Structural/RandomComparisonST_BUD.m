classdef RandomComparisonST_BUD < RandomComparisonST_WU
    % RandomComparisonST_BUD A random comparison of structural data with BU graphs at fixed density
    % RandomComparisonST_BUD is a subclass of RandomComparisonST_WU.
    %
    % RandomComparisonST_BUD store a comparison between a group and a randomly
    % generated group. The data from the groups it compares have a
    % density. Structural data can be for example MRI or PET data.
    %
    % RandomComparisonST_BUD constructor methods:
    %  RandomComparisonST_BUD       - Constructor
    %
    % RandomComparisonST_BUD get methods:
    %  getThreshold                 - returns the density
    %
    % RandomComparisonST_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisST_BUT, MeasurementST_BUT, ComparisonST_BUT.
    
    properties (Access = protected)
        density  % density of the values
    end
    methods  % Constructor
        function rc =  RandomComparisonST_BUD(id, label, notes, atlas, measure_code, group, varargin)
            % RandomComparisonST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'density', DENSITY)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed DENSITY.
            %
            % RandomComparisonST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed default DENSITY.
            %
            % See also MeasurementST_BUT, ComparisonST_BUT, AnalysisST_BUT.
            
            rc = rc@RandomComparisonST_WU(id, label, notes, atlas, measure_code, group, varargin{:});
            density = get_from_varargin(0, 'density', varargin{:});
            rc.setDensity(density)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity(rc, density)
            % SETDENSITY sets the measure fixed density of values
            %
            % SETDENSITY(RC, DENSITY) sets the measure fixed density of 
            % values.
            %
            % See also getDensity.

            rc.density = density;
        end
    end
    methods  % Get functions
        function density = getDensity(rc)
            % GETDENSITY returns thefixed density of the data values
            %
            % DENSITY = GETDENSITY(RC) returns thefixed density of the
            % data values.
            %
            % See also getMeasureValue, setDensity.
            
            density = rc.density;
        end
    end
    methods (Static)  % Descriptive functions
        function measurement_class = getClass() %#ok<*INUSD>
            % GETCLASS returns the class of structural random comparison BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonST_BUD'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonST_BUD';
        end
        function name = getName()
            % GETNAME returns the name of structural random comparison BUT
            %
            % NAME = GETNAME() returns the name, RandomComparison ST BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison ST BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural random comparison BUT
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonST_BUD.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = [ ...
                'ST random comparison with structural data using binary ' ...
                'graphs calculated at a fixed density. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'AnalysisST_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_BUT';
        end
    end
end