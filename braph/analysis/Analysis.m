classdef Analysis < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        cohort  % cohort
        measurement_dict  % indexed dictionary with measurements
    end
    methods (Access=protected)
        function analysis = Analysis(cohort, measurements, varargin)
            
            assert(isa(cohort, 'Cohort') && isequal(cohort.getSubjectClass(), analysis.getSubjectClass()), ...
                ['BRAPH:Analysis:SubjectClassErr'], ...
                ['The first argument must be a Cohort with subjects of class ' analysis.getSubjectClass()]) %#ok<NBRAK>
            analysis.cohort = cohort;
            
            analysis.measurement_dict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            if ~iscell(measurements)  % needs to be a cell, for cycle now can act on it.
                measurements = {measurements};
            end
            for i = 1:1:length(measurements)
                analysis.addMeasurement(measurements{i}, i);
            end
        end
        % function copyElement() %TODO
    end
    methods (Abstract, Access = protected)
        calculate_measurement_id(analysis, varargin)
        calculate_measurement(analysis)
    end
    methods
        function n = measurementnumber(analysis)
            n = length(analysis.measurement_dict);
        end
        function bool = contains_measurement(analysis, measurement)
            if isa(measurement, 'Measurement')  % is the object
                bool = false;
                for i = 1:1:analysis.measurementnumber()
                    if analysis.getMeasurement(i).getID() == measurement.getID()
                        bool = true;
                        break
                    end
                end
            elseif isa(measurement, 'double') % the measurement is the measurement_id
                measurement_index = measurement;
                bool = isKey(analysis.measurement_dict, measurement_index);
            else   % measurement is the measurement_id.
                bool =false;
                for j = 1:1:analysis.measurementnumber()
                    if analysis.getMeasurement(j).getID() == measurement
                        bool = true;
                        break;
                    end
                end
            end
        end
        function measurement_index = getMeasurementIndex(analysis, measurement)
            if isa(measurement, 'Measurement')  % if object
                for i = 1:1:analysis.measurementnumber()
                    if analysis.getMeasurement(i).getID() == measurement.getID()
                        measurement_index = i;
                        break;
                    end
                end
            else  %  measurement is the measuremet_id
                for j = 1:1:analysis.measurementnumber()
                    if analysis.getMeasurement(j).getID() == measurement
                        measurement_index = j;
                        break;
                    end
                end
            end
        end
        function measurement = getMeasurement(analysis, measurement_index)
            measurement = analysis.measurement_dict(measurement_index);
        end
        function measurement_ids = getMeasurementIDs(analysis)
            measurement_ids = cell(1, analysis.measurementnumber());
            for i = 1:1:analysis.measurementnumber()
                measurement = analysis.getMeasurement(i);
                measurement_ids{i} = measurement.getID();
            end
        end
        function cohort = getCohort(analysis)
            cohort = analysis.cohort;
        end
        function measurement = getNewMeasurement(analysis, id, measurement_class, varargin)
            measurement = Measurement.getMeasurement(id, measurement_class, ...
                analysis.getCohort().getBrainAtlases(), ....
                analysis.getCohort().getGroups(), varargin{:});
        end
        function measurement = createMeasurement(analysis, measurement_class, atlases, groups, varargin)
            measurement = Measurement.getMeasurement(analysis.calculate_measurement_id( ...
                measurement_class, atlases, groups) ...
                ,measurement_class, atlases, groups);
        end
        function addMeasurement(analysis, measurement, i)
            
            if nargin < 3 || i < 0 || i > analysis.measurementnumber()
                i = analysis.measurementnumber() + 1;
            end
            
            assert(isa(measurement, Measurement.getClass(measurement)), ...
                ['BRAPH:Analysis:MeasurementClassErr'], ...
                ['The input is not a Measuremente subclass.']) %#ok<NBRAK>
            
            if i <=  analysis.measurementnumber()
                for j =  analysis.measurementnumber():-1:i
                    analysis.measurement_dict(j+1) = analysis.measurement_dict(j);
                end
            end
            analysis.measurement_dict(i) = measurement;
        end
        function removeMeasurement(analysis, i)
            for j = i:1:analysis.measurementnumber()-1
                analysis.measurement_dict(j) = analysis.measurement_dict(j+1);
            end
            remove(analysis.measurement_dict, analysis.measurementnumber());
        end
        function replaceMeasurement(analysis, i, measurement)
            assert(isa(measurement, Measurement.getClass(measurement)), ...
                ['BRAPH:Cohort:MeasurementClassErr'], ...
                ['Input is not a subclass of Measurement.']) %#ok<NBRAK>
            
            if i > 0 || i <= analysis.measurementnumber()
                analysis.measurement_dict(i) = measurement;
            end
        end
        function invertMeasurements(analysis, i, j)
            if i > 0 && i <= analysis.measurementnumber() && j > 0 && j <= analysis.measurementnumber() && i ~= j
                measurement_i = analysis.getMeasurement(i);
                measurement_j = analysis.getMeasurement(j);
                analysis.replaceMeasurement(i, measurement_j)
                analysis.replaceMeasurement(j, measurement_i)
            end
        end
        function movetoMeasurement(analysis, i, j)
            if i > 0 && i <= analysis.measurementnumber() && j > 0 && j <= analysis.measurementnumber() && i ~= j
                measurement = analysis.getMeasurement(i);
                if i > j
                    analysis.removeMeasurement(i)
                    analysis.addMeasurement(measurement, j)
                else  % j < i
                    analysis.addMeasurement(measurement, j+1)
                    analysis.removeMeasurement(i)
                end
            end
        end
        function selected = removeMeasurements(analysis, selected)
            for i = length(selected):-1:1
                analysis.removeMeasurement(selected(i))
            end
            selected = [];
        end
        function [selected, added] = addaboveMeasurements(analysis, measurement_class, selected)
            for i = length(selected):-1:1  
                brainatlases = analysis.getCohort().getBrainAtlases();
                groups = analysis.getCohort().getGroups();
                measurement = Measurement.getMeasurement(analysis.calculate_measurement_id(measurement_class, brainatlases{:}, groups{:}), ...
                              measurement_class, brainatlases{:}, groups{:});
                analysis.addMeasurement(measurement, selected(i))
            end
            selected = selected + reshape(1:1:numel(selected), size(selected));
            added = selected - 1;
        end
        function [selected, added] = addbelowMeasurements(analysis, measurement_class, selected)
            for i = length(selected):-1:1  % changed to createMeasurement
                brainatlases = analysis.getCohort().getBrainAtlases();
                groups = analysis.getCohort().getGroups();
                measurement = Measurement.getMeasurement(analysis.calculate_measurement_id(measurement_class, brainatlases{:}, groups{:}),...
                              measurement_class, brainatlases{:}, groups{:});
                analysis.addMeasurement(measurement, selected(i) + 1)
            end
            selected = selected + reshape(0:1:numel(selected)-1, size(selected));
            added = selected + 1;
        end
        function selected = moveupMeasurements(analysis, selected)
            if ~isempty(selected)
                first_index_to_process = 1;
                unprocessable_length = 1;
                while first_index_to_process <= analysis.measurementnumber() ...
                        && first_index_to_process <= numel(selected) ...
                        && selected(first_index_to_process) == unprocessable_length
                    first_index_to_process = first_index_to_process + 1;
                    unprocessable_length = unprocessable_length + 1;
                end
                
                for i = first_index_to_process:1:numel(selected)
                    analysis.invertMeasurements(selected(i), selected(i)-1);
                    selected(i) = selected(i) - 1;
                end
            end
        end
        function selected = movedownMeasurements(analysis, selected)
            if ~isempty(selected)
                last_index_to_process = numel(selected);
                unprocessable_length = analysis.measurementnumber();
                while last_index_to_process > 0 ...
                        && selected(last_index_to_process) == unprocessable_length
                    last_index_to_process = last_index_to_process - 1;
                    unprocessable_length = unprocessable_length - 1;
                end
                
                for i = last_index_to_process:-1:1
                    analysis.invertMeasurements(selected(i), selected(i) + 1);
                    selected(i) = selected(i) + 1;
                end
            end
        end
        function selected = move2topMeasurements(analysis, selected)
            if ~isempty(selected)
                for i = 1:1:numel(selected)
                    analysis.movetoMeasurement(selected(i), i);
                end
                selected = reshape(1:1:numel(selected), size(selected));
            end
        end
        function selected = move2bottomMeasurements(analysis, selected)
            if ~isempty(selected)
                for i = numel(selected):-1:1
                    analysis.movetoMeasurement(selected(i), analysis.measurementnumber() - (numel(selected)-i));
                end
                selected = reshape(analysis.measurementnumber() - numel(selected)+1:1:analysis.measurementnumber(), size(selected));
            end
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