classdef Analysis < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        cohort  % cohort
        measurement_idict  % indexed dictionary with measurements
        randomparison_idict  % indexed dictionary with random comparison
        comparison_idict  % indexed dictionary with comparison
    end
    methods (Access=protected)
        function analysis = Analysis(cohort, measurements, varargin)
            
            assert(isa(cohort, 'Cohort') && isequal(cohort.getSubjectClass(), analysis.getSubjectClass()), ...
                ['BRAPH:Analysis:SubjectClassErr'], ...
                ['The first argument must be a Cohort with subjects of class ' analysis.getSubjectClass()]) %#ok<NBRAK>
            analysis.cohort = cohort;
            
            analysis.initializeIndexedDictionary(measurements, varargin{:});      
        end
        % function copyElement() %TODO
    end
    methods(Abstract, Access = protected)
        initializeIndexedDictionary(analysis, measurements, varargin)
    end
    methods  
        function measurement = getNewMeasurement(analysis, measurement_class, varargin)
            measurement = Measurement.getMeasurement(measurement_class, ...
                analysis.cohort.getBrainAtlases(), ....
                analysis.cohort.getGroups(), varargin{:});
        end
        function measurement_idict = getMeasurements(analysis)
            measurement_idict = analysis.measurement_idict;
        end
        function comparison_idict = getComparisons(analysis)
            comparison_idict = analysis.comparison_idict;
        end
        function randomparison_idict = getRandomComparisons(analysis)
            randomparison_idict = analysis.randomparison_idict;
        end        
    end
    methods (Static)
        function analysis_list = getList()
            analysis_list = subclasses( ...
                'Analysis', ...
                [fileparts(which('Analysis')) filesep 'analyses'] ...
                );
        end
        function analysis_class = getClass(analysis)
            % analysis class (same as the analysis object name)
            
            if isa(analysis, 'Analysis')
                analysis_class = class(analysis);
            else % analysis should be a string with the analysis class
                analysis_class = analysis;
            end
        end
        function subject_class = getSubjectClass(analysis)
            % cohort class
            
            subject_class = eval([Analysis.getClass(analysis) '.getSubjectClass()']);
        end
        function measurmentList = getMeasurementsClass()
            measurmentList = eval([Analysis.getClass(analysis) '.getMeasurementsClass()']);
        end
        function name = getName(analysis)
            % analysis name
            
            name = eval([Analysis.getClass(analysis) '.getName()']);
        end
        function description = getDescription(analysis)
            % analysis description
            
            description = eval([Analysis.getClass(analysis) '.getDescription()']);
        end
        function analysis = getAnalysis(analysis_class, varargin)
            analysis = eval([analysis_class '(varargin{:})']);
        end
    end
end