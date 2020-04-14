%comparasionMRI
classdef ComparisonMRI < Comparison
    methods
        function c =  ComparisonMRI(id, atlas, groups, varargin)
            
            if isa(atlas, 'BrainAtlas')
                atlases = {atlas};
            else
                assert(iscell(atlas) && length(atlas)==1, ...
                    ['BRAIN:ComparisonMRI:AtlasErr'], ...
                    ['The input must be a BrainAtlas or a cell with one BrainAtlas']) %#ok<NBRAK>
                atlases = atlas;
            end
            
            assert(iscell(groups) && length(groups)==2, ...
                ['BRAIN:ComparisonMRI:GroupErr'], ...
                ['The input must be two Groups or a cell with two Group']) %#ok<NBRAK>
            
            c = c@Comparison(id, atlases, groups, varargin{:});
        end
    end
    methods (Access=protected)
        function initialize_datadict(c, varargin)
            
            atlases = c.getBrainAtlases();
            atlas = atlases{1};
            
            c.data_dict = containers.Map;
            c.data_dict('type') = DataScalar(atlas);
            c.data_dict('value') = DataStructural(atlas);
        end
        function update_brainatlas(c, atlases)
            
            c.atlases = atlases;
            atlas = atlases{1};
            
            d1 = c.data_dict('type');
            d1.setBrainAtlas(atlas)
            
            d2 = c.data_dict('value');
            d2.setBrainAtlas(atlas);
        end
        function update_groups(c, groups)
            c.groups = groups;
        end
    end
    methods (Static)
        function measurementClass = getClass(c)
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
        function datalist = getDataList(c)
            % list of measurments data keys
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('type') = 'DataScalar';
            datalist('value') = 'DataScalar';  % all globals for now
        end
        function sub = getComparison(comparisonClass, id, varargin)
            sub = eval([comparisonClass '(id, varargin{:})']);
        end
        function data_codes = getDataCodes(c)
            data_codes = Comparison.getDataCodes('ComparisonMRI');
        end
        function data_number = getDataNumber(c)
            data_number = Comparison.getDataNumber('ComparisonMRI');
        end
        function data_classes = getDataClasses(c)
            data_classes = Comparison.getDataClasses('ComparisonMRI');
        end
        function data_class = getDataClass(c, data_code)
            data_class = Comparison.getDataNumber(...
                'ComparisonMRI', data_code);
        end
    end
end