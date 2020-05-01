%comparasionMRI
classdef ComparisonMRI < Comparison
     properties
        measure_code  % class of measure
        values_1  % array with the values_1 of the measure for each subject of group 1
        values_2  % array with the values_1 of the measure for each subject of group 1
        all_differences  % all differences obtained through the permutation test
        confidence_interval_min  % min value of the 95% confidence interval
        confidence_interval_max  % max value of the 95% confidence interval
    end
    methods
        function c =  ComparisonMRI(id, atlas, groups, varargin)
            
            c = c@Comparison(id, atlas, groups, varargin{:});
        end
    end
    methods (Access=protected)
        function initialize_data(c, varargin)
            
            atlases = c.getBrainAtlases();
            atlas = atlases{1};
            

        end
    end
    methods (Static)
        function measurementClass = getClass(c) %#ok<*INUSD>
            measurementClass = 'ComparisonMRI';
        end
        function name = getName(c)
            name = 'Comparison MRI';
        end
        function description = getDescription(c)
            % measurement description missing
            description = '';
        end
        function analysis_class = getAnalysisClass(c)
            analysis_class = 'AnalysisMRI';
        end
        function subject_class = getSubjectClass(c)
            subject_class = 'SubjectMRI';
        end
        function atlas_number = getBrainAtlasNumber(c)
            atlas_number =  1;
        end
        function group_number = getGroupNumber(c)
            group_number = 2;
        end
        function sub = getComparison(comparisonClass, id, atlas, groups, varargin)
            sub = eval([comparisonClass '(id, atlas, groups, varargin{:})']);
        end
    end
end