classdef ComparisonCON_BUD < ComparisonCON_WU
    % ComparisonCON_BUD A comparison of connectivity data with BU graphs at fixed density
    % ComparisonCON_BUD is a subclass of Comparison.
    %
    % ComparisonCON_BUD store a comparison between two groups.
    % The data from the groups it compares have a density.
    % Connectivity data can be for example MRI or PET data.
    %
    % ComparisonCON_BUD constructor methods:
    %  ComparisonCON_BUD              - Constructor
    %
    % ComparisonCON_BUD get methods:
    %  getThreshold                 - returns the density
    %
    % ComparisonCON_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % See also Comparison, AnalysisCON_BUD, MeasurementCON_BUD, RandomComparisonCON_BUD. 
    
    properties (Access = protected)
        density  % density of the values
    end
    methods  % Constructor
        function c =  ComparisonCON_BUD(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % ComparisonCON_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'density', DENSITY) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed DENSITY.
            %
            % ComparisonCON_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2) 
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default DENSITY.
            %
            % See also MeasurementCON_BUD, RandomComparisonCON_BUD, AnalysisCON_BUD.
            
            c = c@ComparisonCON_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
            density = get_from_varargin(0, 'density', varargin{:});
            c.setDensity(density)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity(c, density)
            % SETDENSITY sets the measure value of the group
            %
            % SETDENSITY(C, DENSITY) sets the measure value of
            % the group.
            %
            % See also getDensity.
            
            c.density = density;
        end
    end
    methods  % Get functions
        function density = getDensity(c)
            % GETDENSITY returns the density of the data values
            %
            % T = GETDENSITY(C) returns the density of the data values.
            %
            % See also getMeasureValue, setDensity.
            
            density = c.density;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of connectivity comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % comparison. In this case 'ComparisonCON_BUD'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonCON_BUD';
        end
        function name = getName()
            % GETNAME returns the name of connectivity comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonCON_BUD.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Connectivity BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of connectivity comparison 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonCON_BUD.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'CON comparison with connectivity data using binary graphs ' ...
                'calculated at a fixed density. ' ...
                'For example, it can use DTI data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisCON_BUD'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisCON_BUD';
        end
    end
end