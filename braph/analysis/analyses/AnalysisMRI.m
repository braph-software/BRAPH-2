classdef AnalysisMRI < Analysis
    methods
        function analysis = AnalysisMRI(cohort, measurements, varargin)
            
            analysis = analysis@Analysis(cohort, measurements, varargin{:});
        end
    end
    methods (Access = protected)
        function initializeIndexedDictionary(analysis, measurements, varargin)
            available_classes =  analysis.getMeasurementsClass();
            % hard coded
            analysis.comparison_idict = IndexedDictionary(available_classes{1});
            analysis.measurement_idict = IndexedDictionary(available_classes{2});
            analysis.randomparison_idict = IndexedDictionary(available_classes{3});  
            if iscell(measurements)                
                for i = 1:1:length(measurements)
                    if isequal(class(measurements{i}), 'ComparisonMRI')
                        analysis.comparison_idict.add(measurements{i}.getName(), measurements{i});
                    elseif isequal(class(measurements{i}), 'MeasurementMRI')
                        analysis.measurement_idict.add(measurements{i}.getName(), measurements{i});
                    elseif isequal(class(measurements{i}), 'RandomComparisonMRI')
                        analysis.measurement_idict.add(measurements{i}.getName(), measurements{i});
                    end
                end                
            else
                if isequal(class(measurements), 'ComparisonMRI')
                    analysis.comparison_idict.add(measurements.getName(), measurements);
                elseif isequal(class(measurements), 'MeasurementMRI')
                    analysis.measurement_idict.add(measurements.getName(), measurements);
                elseif isequal(class(measurements), 'RandomComparisonMRI')
                    analysis.measurement_idict.add(measurements.getName(), measurements);
                end
            end
        end 
    end
    methods (Static)
        function analysis_class = getClass()
            analysis_class = 'AnalysisMRI';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectMRI';
        end
        function name = getName()
            name = 'Analysis Structural MRI';
        end
        function description = getDescription()
            description = [ ...
                'Analysis based on structural MRI data, ' ...
                'such as cortical thickness for each brain region' ...
                ];
        end
          function measurement_classes = getMeasurementsClass()
            measurement_list = Measurement.getList();
            comparison_list = Comparison.getList();
            randomparison_list = RandomComparison.getList();  
            
            % filter fmri
            comparison_list = setdiff(comparison_list, {'ComparisonfMRI'});
            
            
            measurement_classes = [ comparison_list, measurement_list, randomparison_list];
        end
    end
end