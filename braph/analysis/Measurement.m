classdef Measurement < handle & matlab.mixin.Copyable
    properties
        groups  % cell array with groups
        atlases  % cell array with brain atlases
        settings  % settings of the measurement
        datadict  % data for measurements
    end
    methods (Access = protected)
        function m = Measurement(atlases, groups, varargin)
            
            assert(iscell(groups), ...
                ['BRAIN:Measurement:GroupErr'], ...
                ['The input must be a cell containing Groups objects'])
            m.groups = groups;
            
            assert(iscell(atlases), ...
                ['BRAIN:Measurement:AtlasErr'], ...
                ['The input must be a cell containing BrainAtlas objects'])
            m.atlases = atlases;
            
            m.settings = get_from_varargin(varargin, ...
                'MeasurementSettings', varargin{:});
            
            m.initialize_datadict(atlases, groups, varargin{:});
            
            data_codes = m.getDataCodes();
            for i = 1:1:numel(data_codes)
                data_code = data_codes{i};
                value = get_from_varargin(m.getData(data_code).getValue, ...
                    data_code, varargin);
                m.getData(data_code).setValue(value);
            end
        end
        function measurement_copy = copyElement(m)
            % It does not make a deep copy of atlases or groups
            
            % Make a shallow copy
            measurement_copy = copyElement@matlab.mixin.Copyable(m);
            
            % Make a deep copy of datadict
            measurement_copy.datadict = containers.Map;
            data_codes = keys(m.datadict);
            for i = 1:1:length(data_codes)
                data_code = data_codes{i};
                d = m.getData(data_code);
                measurement_copy.datadict(data_code) = d.copy();
            end
        end
    end
    methods (Abstract, Access = protected)
        initialize_datadict(m, varargin)  % initialize datadict
        update_brainatlas(m, atlases)  % updates brainatlases
        update_groups(m, groups)  % updates groups
    end
    methods
        function str = tostring(m)
            str = [Measurement.getClass(m)];
        end
        function disp(m)
            disp(['<a href="matlab:help ' Measurement.getClass(m) '">' Measurement.getClass(m) '</a>'])
            data_codes = m.getDataCodes();
            for i = 1:1:m.getDataNumber()
                data_code = data_codes{i};
                d = m.getData(data_code);
                disp([data_code ' = ' d.tostring()])
            end
        end
        function d = getData(m, data_code)
            d = m.datadict(data_code);
        end
        function setBrainAtlases(m, atlases)
            % adds a atlas to the end of the cell array
            m.update_brainatlases(atlases);
        end
        function setGroups(m, groups)
            m.update_groups(groups);
        end
        function atlases = getBrainAtlases(m)
            atlases = m.atlases;
        end
        function groups = getGroups(m)
            groups = m.groups;
        end
    end
    methods (Static)
        function measurementList = getList()
            measurementList = subclasses( ...
                'Measurement', ...
                [fileparts(which('Measurement')) filesep 'measurements'] ...
                );
        end
        function measurementClass = getClass(m)
            if isa(m, 'Measurement')
                measurementClass = class(m);
            else % mshould be a string with the measurement class
                measurementClass = m;
            end
        end
        function name = getName(m)
            name = eval([Measurement.getClass(m) '.getName()']);
        end
        function description = getDescription(m)
            % measurement description
            description = eval([Measurement.getClass(m) '.getDescription()']);
        end
        function atlasNumber = getAtlasesNumber(m)
            atlasNumber = eval([Measurement.getClass(m) '.getAtlasesNumber()']);
        end
        function groupsNumber = getGroupsNumber(m)
            groupsNumber = eval([Measurement.getClass(m) '.getGroupsNumber()']);
        end
        function datalist = getDataList(m)
            % list of measurments data keys
            datalist = eval([Measurement.getClass(m) '.getDataList()']);
        end
        function sub = getMeasurement(measurementClass, varargin)
            sub = eval([measurementClass '(varargin{:})']);
        end
        function data_codes = getDataCodes(m)
            datalist = Measurement.getDataList(m);
            data_codes = keys(datalist);
        end
        function data_number = getDataNumber(m)
            datalist = Measurement.getDataList(m);
            data_number = length(datalist);
        end
        function data_classes = getDataClasses(m)
            datalist = Measurement.getDataList(m);
            data_classes = values(datalist);
        end
        function data_class = getDataClass(m, data_code)
            datalist = Measurement.getDataList(m);
            data_class = datalist(data_code);
        end
        function bool = is_global(m)
            bool = eval([Measurement.getClass(m) '.is_global()']);
        end
        function bool = is_nodal(m)
            bool = eval([Measurement.getClass(m) '.is_nodal()']);
        end
        function bool = is_binodal(m)
            bool = eval([Measurement.getClass(m) '.is_binodal()']);
        end
        function list = getCompatibleDataTypeList(m)  % ???
            measurement_class = Measurment.getClass(m);
            dataType_List = Measurement.getList();  % ????
            list = cell(1, numel(dataType_List));
            for i = 1:1:numel(dataType_List)
                datatype_code = dataType_List{i};
                
                if are_compatible(measurement_class, datatype_code)
                    list{i} = datatype_code;
                end
            end
            list(cellfun('isempty', list)) = [];
        end
        function n = getCompatibleDataTypeNumber(m)
            list = Measurement.getCompatibleDataTypeList(m);
            n = numel(list);
        end
    end
end