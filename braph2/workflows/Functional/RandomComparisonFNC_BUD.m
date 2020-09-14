classdef RandomComparisonFNC_BUD < RandomComparisonFNC_WU
    % RandomComparisonFNC_BUD A random comparison of functional data with BU graphs at fixed density
    % RandomComparisonFNC_BUD is a subclass of RandomComparisonFNC_WU.
    %
    % RandomComparisonFNC_BUD store a comparison between a group and a randomly
    % generated group. The data from the groups it compares have a
    % density. Functional data can be for example fMRI data.
    %
    % RandomComparisonFNC_BUD constructor methods:
    %  RandomComparisonFNC_BUD      - Constructor
    %
    % RandomComparisonFNC_BUD get methods:
    %  getThreshold                 - returns the density
    %
    % RandomComparisonFNC_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisFNC_BUT, MeasurementFNC_BUT, ComparisonFNC_BUT.
    
    properties (Access = protected)
        density  % density of the values
    end
    methods  % Constructor
        function rc =  RandomComparisonFNC_BUD(id, label, notes, atlas, measure_code, group, varargin)
            % RandomComparisonFNC_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'density', DENSITY)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed DENSITY.
            %
            % RandomComparisonFNC_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed default DENSITY.
            %
            % See also MeasurementFNC_BUT, ComparisonFNC_BUT, AnalysisFNC_BUT.
            
            rc = rc@RandomComparisonFNC_WU(id, label, notes, atlas, measure_code, group, varargin{:});
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
            % GETCLASS returns the class of functional random comparison BUT
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonFNC_BUD'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonFNC_BUD';
        end
        function name = getName()
            % GETNAME returns the name of functional random comparison BUT
            %
            % NAME = GETNAME() returns the name, RandomComparison FNC BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison FNC BUT';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of functional random comparison BUT
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonFNC_BUD.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = [ ...
                'FNC random comparison with functional data using binary ' ...
                'graphs calculated at a fixed density. ' ...
                'For example, it can use fMRI data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'AnalysisFNC_BUT'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisFNC_BUT';
        end
    end
end