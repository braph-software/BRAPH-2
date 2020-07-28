classdef MeasurementCON_BUD < MeasurementCON_WU
    % MeasurementCON_BUD A measurement of connectivity data with BU graphs at fixed density
    % MeasurementCON_BUD is a subclass of MeasurementCON_WU.
    %
    % MeasurementCON_BUD store a measurement of connectivity data with BU
    % graphs at fixes density, for this it implements MeasurementCON_WU
    % initialization of data. Structural data can be for example DTI data.
    %
    % MeasurementCON_BUD constructor methods:
    %  MeasurementCON_BUD            - Constructor
    %
    % MeasurementCON_BUD get methods:
    %  getThreshold                 - returns the density
    %
    % MeasurementCON_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getAnalysisClass             - returns the class of the analysis

    %
    % See also Comparison, AnalysisCON_BUD, ComparisonCON_BUD, RandomComparisonCON_BUD. 
   
    properties (Access = protected)
        density  % density of the values
    end
    methods  % Constructor
        function m =  MeasurementCON_BUD(id, label, notes, atlas, measure_code, group, varargin)
            % MEASUREMENTCON_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'density',  DENSITY)
            % creates a measurement with ID, LABEL, ATLAS and MEASURE_CODE
            % with the data from GROUP, this data will have a fixed DENSITY. 
            %
            % MeasurementCON_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP) 
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP, this data will have a fixed default density.
            %
            % See also ComparisonCON_BUD, RandomComparisonCON_BUD, AnalysisCON_BUD.
            
            m = m@MeasurementCON_WU(id, label, notes, atlas, measure_code, group, varargin{:});

            density = get_from_varargin(0, 'density', varargin{:});
            m.setDensity(density)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity(m, density)
            % SETDENSITY sets the measure value of the group
            %
            % SETDENSITY(M, DENSITY) sets the measure value of 
            % the group.
            % 
            % See also getDensity.
            
            m.density = density;
        end
    end
    methods  % Get functions
        function density = getDensity(m)
            % GETDENSITY returns the density of the data values
            %
            % DENSITY = GETDENSITY(M) returns the density of the data values.
            %
            % See also getMeasureValue.
            
            density = m.density;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of connectivity measurement BUD
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % measurement. In this case 'MeasurementCON_BUD'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementCON_BUD';
        end
        function name = getName()
            % GETNAME returns the name of connectivity measurement BUD
            %
            % NAME = GETNAME() returns the name, Measurement CON BUD.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement CON BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of connectivity measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementCON_BUD.
            %
            % See also getList, getClass, getName
            
            description = [ ...
                'CON measurement with connectivity data using binary graphs ' ...
                'calculated at a fixed density. ' ...
                'For example, it can use DTI data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the measurement is part of, 'AnalysisCON_BUD'.
            %
            % See also getClass, getName, getDescription.
            
            analysis_class = 'AnalysisCON_BUD';
        end     
    end
end 