classdef RandomComparisonCON_BUD < RandomComparisonCON_WU
    % RandomComparisonCON_BUD A random comparison of connectivity data with BU graphs at fixed density
    % RandomComparisonCON_BUD is a subclass of RandomComparisonST_WU.
    %
    % RandomComparisonCON_BUD store a comparison between a group and a randomly
    % generated group. The data from the groups it compares have a
    % density. Connectivity data can be for example DTI data.
    %
    % RandomComparisonCON_BUD constructor methods:
    %  RandomComparisonCON_BUD       - Constructor
    %
    % RandomComparisonCON_BUD get methods:
    %  getThreshold                 - returns the density
    %
    % RandomComparisonCON_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisCON_BUD, MeasurementCON_BUD, ComparisonCON_BUD.
    
    properties (Access = protected)
        density  % density of the values
    end
    methods  % Constructor
        function rc =  RandomComparisonCON_BUD(id, label, notes, atlas, measure_code, group, varargin)
            % RandomComparisonCON_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'density', DENSITY)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed DENSITY.
            %
            % RandomComparisonCON_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE,
            % between the data from GROUP and a random group. The data will
            % have a fixed default DENSITY.
            %
            % See also MeasurementCON_BUD, ComparisonCON_BUD, AnalysisCON_BUD.
            
            rc = rc@RandomComparisonCON_WU(id, label, notes, atlas, measure_code, group, varargin{:});
            density = get_from_varargin(0, 'density', varargin{:});
            rc.setDensity(density)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity(rc, density)
            % SETDENSITY sets the measure value of the group
            %
            % SETDENSITY(RC, DENSITY) sets the measure value of
            % the group.
            %
            % See also getDensity.

            rc.density = density;
        end
    end
    methods  % Get functions
        function density = getDensity(rc)
            % GETDENSITY returns the density of the data values
            %
            % DENSITY = GETDENSITY(RC) returns the density of the data values.
            %
            % See also getMeasureValue, setDensity.
            
            density = rc.density;
        end
    end
    methods (Static)  % Descriptive functions
        function measurement_class = getClass() %#ok<*INUSD>
            % GETCLASS returns the class of connectivity random comparison BUD
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % random comparison. In this case 'RandomComparisonCON_BUD'.
            %
            % See also getList, getName, getDescription.
            
            measurement_class = 'RandomComparisonCON_BUD';
        end
        function name = getName()
            % GETNAME returns the name of connectivity random comparison BUD
            %
            % NAME = GETNAME() returns the name, RandomComparison CON BUD.
            %
            % See also getList, getClass, getDescription.
            
            name = 'RandomComparison CON BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of connectivity random comparison BUD
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of RandomComparisonCON_BUD.
            %
            % See also getList, getClass, getName.
            
            % comparison description missing
            description = [ ...
                'CON random comparison with connectivity data using binary ' ...
                'graphs calculated at a fixed density. ' ...
                'For example, it can use DTI data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the random comparison is part of, 'AnalysisCON_BUD'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisCON_BUD';
        end
    end
end