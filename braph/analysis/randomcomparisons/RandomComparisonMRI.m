%randomcomparisionmri vs random grphs
classdef RandomComparisonMRI < RandomComparison
    methods
        function rc =  RandomComparisonMRI(id, atlas, group, varargin)
            
            rc = rc@RandomComparison(id, atlas, group, varargin{:});
        end
    end
    methods (Access=protected)
        function initialize_datadict(rc, varargin)
            
            atlases = rc.getBrainAtlases();
            atlas = atlases{1};
            
            rc.data_dict = containers.Map;
            rc.data_dict('type') = DataScalar(atlas);
            rc.data_dict('value') = DataStructural(atlas);
        end
    end
    methods (Static)
        function measurementClass = getClass(rc) %#ok<*INUSD>
            measurementClass = 'RandomComparisonMRI';
        end
        function name = getName(rc)
            name = 'Random Comparison MRI';
        end
        function description = getDescription(rc)
            % measurement description missing
            description = '';
        end
        function atlas_number = getBrainAtlasNumber(rc)
            atlas_number =  1;
        end
        function group_number = getGroupNumber(rc)
            group_number = 1;  % 2 if random group created elsewhere
        end
        function datalist = getDataList(rc)
            % list of measurments data keys
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('type') = 'DataScalar';
            datalist('value') = 'DataScalar';  % all globals for now
        end
        function sub = getRandomComparison(randomComparisonClass, id, varargin)
            sub = eval([randomComparisonClass '(id, varargin{:})']);
        end
        function data_codes = getDataCodes(rc)
            data_codes = RandomComparison.getDataCodes('RandomComparisonMRI');
        end
        function data_number = getDataNumber(rc)
            data_number = RandomComparison.getDataNumber('RandomComparisonMRI');
        end
        function data_classes = getDataClasses(rc)
            data_classes = RandomComparison.getDataClasses('RandomComparisonMRI');
        end
        function data_class = getDataClass(rc, data_code) %#ok<INUSL>
            data_class = RandomComparison.getDataNumber(...
                'RandomComparisonMRI', data_code);
        end
    end
end