classdef AnalysisfMRI < Analysis
    methods
        function analysis = AnalysisfMRI(cohort, measurements, varargin)
            
            analysis = analysis@Analysis(cohort, measurements, varargin{:});
        end
    end
    methods (Access = protected)
        function initializeIndexedDictionary(analysis, measurements, varargin)
            available_classes =  analysis.getMeasurementsClass();
            % mix between hard coded and class not existing yet.
            analysis.comparison_idict = IndexedDictionary(available_classes{1});
            analysis.measurement_idict = IndexedDictionary('MeasurementfMRI');
            analysis.randomparison_idict = IndexedDictionary('RandomComparisonfMRI'); 
           if iscell(measurements)                
                for i = 1:1:length(measurements)
                    if isequal(class(measurements{i}), 'ComparisonfMRI')
                        analysis.comparison_idict.add(measurements{i}.getName(), measurements{i});
                    elseif isequal(class(measurements{i}), 'MeasurementfMRI')
                        analysis.measurement_idict.add(measurements{i}.getName(), measurements{i});
                    elseif isequal(class(measurements{i}), 'RandomComparisonfMRI')
                        analysis.measurement_idict.add(measurements{i}.getName(), measurements{i});
                    end
                end                
            else
                if isequal(class(measurements), 'ComparisonfMRI')
                    analysis.comparison_idict.add(measurements.getName(), measurements);
                elseif isequal(class(measurements), 'MeasurementfMRI')
                    analysis.measurement_idict.add(measurements.getName(), measurements);
                elseif isequal(class(measurements), 'RandomComparisonfMRI')
                    analysis.measurement_idict.add(measurements.getName(), measurements);
                end
            end
        end 
    end
    methods (Static)
        function analysis_class = getClass()
            analysis_class = 'AnalysisfMRI';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectfMRI';
        end
        function name = getName()
            name = 'Analysis Functional fMRI';
        end
        function measurement_classes = getMeasurementsClass()
            measurement_list = Measurement.getList();
            path_struct = dir([fileparts(which('Measurement')) filesep 'measurements']);
            count_folders = sum([path_struct(~ismember({path_struct.name},{'.','..'})).isdir]);
            measurement_classes = cell(1, count_folders);
            for i = 1:1:length(measurement_list)
                if contains(measurement_list{i}, 'fMRI')
                    measurement_classes{i} = measurement_list{i};
                end
            end
            measurement_classes = measurement_classes(:,cellfun(@ischar,measurement_classes(1,:)));
        end
        function description = getDescription()
            description = [ ...
                'Analysis using functional MRI data, ' ...
                'such as activation timeseries for each brain region' ...
                ];
        end
        
    end
end