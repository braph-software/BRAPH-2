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
            %         % grousps
            if isa(atlas, 'Group')
                groups = {group};
            else
                assert(iscell(group) && length(group)==1, ...
                    ['BRAIN:MeasurmentMRI:GroupErr'], ...
                    ['The input must be a Group or a cell with one Group']) %#ok<NBRAK>
                groups = group;
            end
            m = m@Measurement(atlases, groups, varargin{:});
        end
    end
    % data : single datascalar & datastructer use only depending on the
    % measure.
     methods (Static)
        function measurementClass = getClass(m)
          measurementClass = 'MeasurementMRI';
        end
        function name = getName(m)
            name = 'Measurement MRI';
        end
        function description = getDescription(m)
            % measurement description missing
            description = '';
        end
        function atlasNumber = getAtlasesNumber(m)
            atlasNumber = numel(m.atlases);
        end
        function groupsNumber = getGroupsNumber(m)
            groupsNumber = numel(m.groups);
        end
        function datalist = getDataList(m)
            % list of measurments data keys
            datalist = containers.Map('KeyType', 'char', 'ValueType', 'char');
            datalist('graphMeasure') = 'DataScalar';
            datalist('graphValue') = 'DataScalar';  % all globals for now
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
        function bool = is_global(m)
            bool = true;
        end
        function bool = is_nodal(m)
            bool = false;
        end
        function bool = is_binodal(m)
            bool = false;
        end
        function list = getCompatibleDataTypeList(m)  % ???
            list = Measurement.getCompatibleDataTypeList('MeasurementMRI');
        end
        function n = getCompatibleDataTypeNumber(m)           
            n = Measurement.getCompatibleDataTypeNumber('MeasurementMRI');
        end
     end    
end