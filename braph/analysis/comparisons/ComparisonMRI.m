%comparasionMRI
classdef ComparisonMRI < Comparison
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
        function atlas_number = getBrainAtlasNumber(c)
            atlas_number =  1;
        end
        function group_number = getGroupNumber(c)
            group_number = 2;
        end
        function sub = getComparison(comparisonClass, id, varargin)
            sub = eval([comparisonClass '(id, varargin{:})']);
        end
    end
end