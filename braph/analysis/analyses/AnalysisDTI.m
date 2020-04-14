classdef AnalysisDTI < Analysis
    methods
        function analysis = AnalysisDTI(cohort, measurements, varargin)
            
            analysis = analysis@Analysis(cohort, measurements, varargin{:});
        end
    end
    methods (Access = protected)
        function initializeIndexedDictionary(analysis, measurements, varargin)
            available_classes =  analysis.getMeasurementsClass();
            % classes does not exist yet.
            analysis.comparison_idict = IndexedDictionary('ComparisonDTI'); 
            analysis.measurement_idict = IndexedDictionary('MeasurementDTI');         
            analysis.randomparison_idict = IndexedDictionary('RandomComparisonDTI');
            if iscell(measurements)                
                for i = 1:1:length(measurements)
                    if isequal(class(measurements{i}), 'ComparisonDTI')
                        analysis.comparison_idict.add(measurements{i}.getName(), measurements{i});
                    elseif isequal(class(measurements{i}), 'MeasurementDTI')
                        analysis.measurement_idict.add(measurements{i}.getName(), measurements{i});
                    elseif isequal(class(measurements{i}), 'RandomComparisonDTI')
                        analysis.measurement_idict.add(measurements{i}.getName(), measurements{i});
                    end
                end                
            else
                if isequal(class(measurements), 'ComparisonDTI')
                    analysis.comparison_idict.add(measurements.getName(), measurements);
                elseif isequal(class(measurements), 'MeasurementDTI')
                    analysis.measurement_idict.add(measurements.getName(), measurements);
                elseif isequal(class(measurements), 'RandomComparisonDTI')
                    analysis.measurement_idict.add(measurements.getName(), measurements);
                end
            end
        end 
    end
    methods (Static)
        function analysis_class = getClass()
            analysis_class = 'AnalysisDTI';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectDTI';
        end
        function measurement_classes = getMeasurementsClass()
            measurement_list = Measurement.getList();
            comparison_list = Comparison.getList();
            randomparison_list = RandomComparison.getList();            
            measurement_classes = [measurement_list, comparison_list, randomparison_list];
        end
        function name = getName()
            name = 'Analysis DTI';
        end
        function description = getDescription()
            description = [ ...
                'Analysis using DTI connectivity matrix,' ...
                'such as activation timeseries for each brain region' ...
                ];
        end        
    end
end