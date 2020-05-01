classdef ComparisonfMRI < Comparison
    properties
        measure_code  % class of measure
        values_1  % array with the values of the measure for each subject of group 1
        values_2  % array with the values of the measure for each subject of group 1
        average_value_1  % average value of group 1
        average_value_2  % average value of group 1
        difference   % difference
        all_differences  % all differences obtained through the permutation test
        p_single  % p value single tailed
        p_double  % p value double tailed
        confidence_interval_min  % min value of the 95% confidence interval
        confidence_interval_max  % max value of the 95% confidence interval
    end
    methods
        function c =  ComparisonfMRI(id, atlas, groups, varargin)
            c = c@Comparison(id, atlas, groups, varargin{:});
        end
        function measure_code = getMeasureCode(c)
            measure_code = c.measure_code;
        end
        function values = getGroupValue(c, index) %#ok<*INUSL>
            values = eval(['c.values_' tostring(index)]);
        end
        function average_value = getAverageValue(c, index)
            average_value = eval(['c.average_value_' tostring(index)]);
        end
        function difference = getDifference(c)
            difference = c.difference;
        end
        function all_differences = getAllDifferences(c)
            all_differences = c.all_differences;
        end
        function p_single = getPSingleTail(c)
            p_single = c.p_single;
        end
        function p_double = getPDoubleTail(c)
            p_double = c.p_double;
        end
        function percentile = getPercentiles(c)
            percentile = c.percentiles;
        end
    end
    methods (Access=protected)
        function initialize_data(c, varargin)
            atlases = c.getBrainAtlases();
            atlas = atlases{1};
            groups =  c.getGroups();
            
            c.measure_code = get_from_varargin('', ...
                'ComparisonfMRI.measure_code', ...
                varargin{:});            

        end
    end
    methods (Static)
        function measurementClass = getClass(c) %#ok<*INUSD>
            measurementClass = 'ComparisonfMRI';
        end
        function name = getName(c)
            name = 'Comparison fMRI';
        end
        function analysis_class = getAnalysisClass(c)
            analysis_class = 'AnalysisfMRI';
        end
        function subject_class = getSubjectClass(c)
            subject_class = 'SubjectfMRI';
        end
        function description = getDescription(c)
            % measurement description missing
            description = '';
        end
        function atlas_number = getBrainAtlasNumber(c)
            atlas_number =  1;
        end
        function group_number = getGroupNumber(c)
            group_number = 2;
        end
        function sub = getComparison(comparisonClass, id, atlas, groups, varargin)
            sub = eval([comparisonClass '(id, atlas, groups varargin{:})']);
        end
    end
end