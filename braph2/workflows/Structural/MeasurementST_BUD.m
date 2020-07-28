classdef MeasurementST_BUD < MeasurementST_WU
    % MeasurementST_BUD A measurement of structural data with BU graphs at fixed density
    % MeasurementST_BUD is a subclass of MeasurementST_WU.
    %
    % MeasurementST_BUD store a measurement of structural data with BU
    % graphs at fixes density, for this it inherit the MeasurementST_WU
    % initialization of data. Structural data can be for example MRI or PET data.
    %
    % MeasurementST_BUD constructor methods:
    %  MeasurementST_BUD            - Constructor
    %
    % MeasurementST_BUD get methods:
    %  getThreshold                 - returns the density
    %
    % MeasurementST_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the measurement
    %  getName                      - returns the name of the measurement
    %  getDescription               - returns the description of the measurement
    %  getAnalysisClass             - returns the class of the analysis

    %
    % See also Comparison, AnalysisST_BUD, ComparisonST_BUD, RandomComparisonST_BUD. 
   
    properties (Access = protected)
        density  % density of the values
    end
    methods  % Constructor
        function m =  MeasurementST_BUD(id, label, notes, atlas, measure_code, group, varargin)
            % MEASUREMENTST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP, 'density',  THRESHOLD)
            % creates a measurement with ID, LABEL, ATLAS and MEASURE_CODE
            % with the data from GROUP, this data will have a fixed THRESHOLD. 
            %
            % MEASUREMENTST_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP) 
            % creates a comparison with ID, LABEL, ATLAS, MEASURE_CODE,
            % with the data from GROUP, this data will have a fixed default density.
            %
            % See also ComparisonST_BUT, RandomComparisonST_BUT, AnalysisST_BUT.
            
            m = m@MeasurementST_WU(id, label, notes, atlas, measure_code, group, varargin{:});

            density = get_from_varargin(0, 'density', varargin{:});
            m.setDensity(density)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity(m, density)
            % SETDENSITY sets the measure fixed density of values
            %
            % SETDENSITY(M, DENSITY) sets the measure fixed density of 
            % values.
            % 
            % See also getDensity.
            
            m.density = density;
        end
    end
    methods  % Get functions
        function density = getDensity(m)
            % GETDENSITY returns the fixed density of the data values
            %
            % DENSITY = GETDENSITY(M) returns the density of the data values.
            %
            % See also getMeasureValue.
            
            density = m.density;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural measurement BUD
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of 
            % measurement. In this case 'MeasurementST_BUD'.
            %
            % See also getList, getName, getDescription.
            
            class = 'MeasurementST_BUD';
        end
        function name = getName()
            % GETNAME returns the name of structural measurement BUT
            %
            % NAME = GETNAME() returns the name, Measurement ST BUT.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Measurement ST BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural measurement
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of MeasurementST_BUD.
            %
            % See also getList, getClass, getName
            
            description = [ ...
                'ST measurement with structural data using binary graphs ' ...
                'calculated at a fixed density. ' ...
                'For example, it can use MRI or PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis 
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the measurement is part of, 'AnalysisST_BUT'.
            %
            % See also getClass, getName, getDescription.
            
            analysis_class = 'AnalysisST_BUD';
        end     
    end
end 