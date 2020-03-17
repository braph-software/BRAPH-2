classdef Analysis < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected) 
        cohort  % cohort
        measurement_dict  % indexed dictionary with measurements
    end
    methods (Access=protected)
        function analysis = Analysis(cohort, varargin)
            
            assert(isa(cohort, 'Cohort') && isequal(cohort.getSubjectClass(), analysis.getSubjectClass()), ...
                ['BRAPH:Analysis:SubjectClassErr'], ...
                ['The first argument must be a Cohort with subjects of class ' analysis.getSubjectClass()]) %#ok<NBRAK>
            analysis.cohort = cohort;
        end
        % function copyElement() %TODO
    end
    methods
        % function n = measurementnumber(analysis) %TODO
        % function bool = contains_measurement(analysis, measurement) %TODO
        % function measurement_index = getMeasurementIndex(analysis, measurement) %TODO
        % function measurement = getMeasurement(analysis, measurement_index) %TODO
        % function measurement_ids = getMeasurementIDs(analysis) %TODO
        % function measurement = getNewMeasurement(analysis, varargin) %TODO
        % function addMeasurement(analysis, measurement, i) %TODO
        % function removeMeasurement(analysis, i) %TODO
        % function replaceMeasurement(analysis, i, measurement) %TODO
        % function invertMeasurements(analysis, i, j) %TODO
        % function movetoMeasurement(analysis, i, j) %TODO
        % function selected = removeMeasurements(analysis, selected) %TODO
        % function [selected, added] = addaboveMeasurements(analysis, selected) %TODO
        % function [selected, added] = addbelowMeasurements(analysis, selected) %TODO
        % function selected = moveupMeasurements(analysis, selected) %TODO
        % function selected = movedownMeasurements(analysis, selected) %TODO
        % function selected = move2topMeasurements(analysis, selected) %TODO
        % function selected = move2bottomMeasurements(analysis, selected) %TODO
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