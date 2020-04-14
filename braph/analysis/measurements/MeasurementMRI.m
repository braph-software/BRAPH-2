classdef MeasurementMRI < Measurement
    % single group of mri subjects
    methods
        function m =  MeasurementMRI(atlas, group, varargin)
            if isa(atlas, 'BrainAtlas')
                atlases = {atlas};
            else
                assert(iscell(atlas) && length(atlas)==1, ...
                    ['BRAIN:MeasurmentMRI:AtlasErr'], ...
                    ['The input must be a BrainAtlas or a cell with one BrainAtlas']) %#ok<NBRAK>
                atlases = atlas;
            end
            
            assert(isa(group, 'Group'), ...
                ['BRAIN:MeasurmentMRI:GroupErr'], ...
                ['The input must be a Group object']) %#ok<NBRAK>
            
            m = m@Measurement(atlases, group, varargin{:});
        end
    end
    methods (Access=protected)
        function initialize_datadict(m, varargin)
            
            atlases = m.getBrainAtlases();
            atlas = atlases{1};
            
            m.data_dict = containers.Map;
            m.data_dict('type') = DataScalar(atlas);
            m.data_dict('value') = DataStructural(atlas);
        end
        function update_brainatlas(m, atlases)
            
            m.atlases = atlases;
            atlas = atlases{1};
            
            d1 = m.data_dict('type');
            d1.setBrainAtlas(atlas)
            
            d2 = m.data_dict('value');
            d2.setBrainAtlas(atlas);
        end
        function update_groups(m, groups)
            m.groups = groups;
        end
    end
    methods (Static)
        function class = getClass(m)
            class = 'MeasurementMRI';
        end
        function name = getName(m)
            name = 'Measurement MRI';
        end
        function atlas_number = getBrainAtlasNumber(m)
            atlas_number =  1;
        end
        function group_number = getGroupNumber(m)
            group_number = 1;
        end
        function description = getDescription(m)
            % measurement description missing
            description = '';
        end
        function datalist = getDataList(m)
            % list of measurments data keys
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('type') = 'DataScalar';
            datalist('value') = 'DataScalar';  % all globals for now
        end
        function sub = getMeasurement(measurementClass, varargin)
            sub = eval([measurementClass '(varargin{:})']);
        end
        function data_codes = getDataCodes(m)
            data_codes = Measurement.getDataCodes('MeasurementMRI');
        end
        function data_number = getDataNumber(m)
            data_number = Measurement.getDataNumber('MeasurementMRI');
        end
        function data_classes = getDataClasses(m)
            data_classes = Measurement.getDataClasses('MeasurementMRI');
        end
        function data_class = getDataClass(m, data_code)
            data_class = Measuremente.getDataNumber(...
                'MeasurementMRI', data_code);
        end
    end
end