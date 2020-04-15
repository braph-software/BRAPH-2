classdef ComparisonDTI < Comparison
    methods
        function c =  ComparisonDTI(id, atlas, groups, varargin)
            
            c = c@Comparison(id, atlas, groups, varargin{:});
        end
    end
    methods (Access=protected)
        function initialize_datadict(c, varargin)
            
            atlases = c.getBrainAtlases();
            atlas = atlases{1};
            
            c.data_dict = containers.Map;
            c.data_dict('type') = DataScalar(atlas);
            c.data_dict('value') = DataConnectivity(atlas);
        end
    end
    methods (Static)
        function measurementClass = getClass(c) %#ok<*INUSD>
            measurementClass = 'ComparisonDTI';
        end
        function name = getName(c)
            name = 'Comparison DTI';
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
        function datalist = getDataList(c)
            % list of measurments data keys
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('type') = 'DataScalar';
            datalist('value') = 'DataConnectivity';
        end
        function sub = getComparison(comparisonClass, id, varargin)
            sub = eval([comparisonClass '(id, varargin{:})']);
        end
        function data_codes = getDataCodes(c)
            data_codes = Comparison.getDataCodes('ComparisonDTI');
        end
        function data_number = getDataNumber(c)
            data_number = Comparison.getDataNumber('ComparisonDTI');
        end
        function data_classes = getDataClasses(c)
            data_classes = Comparison.getDataClasses('ComparisonDTI');
        end
        function data_class = getDataClass(c, data_code) %#ok<INUSL>
            data_class = Comparison.getDataNumber(...
                'ComparisonDTI', data_code);
        end
    end
end