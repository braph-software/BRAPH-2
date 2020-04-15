classdef Measurement < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        id  % unique identifier
        group  % group
        atlases  % cell array with brain atlases
        settings  % settings of the measurement
        data_dict  % dictionary with data for measurements
    end
    methods (Access = protected)
        function m = Measurement(id, atlases, group, varargin)            
            m.id = tostring(id);
            
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(iscell(atlases)  && length(atlases)==1, ...
                ['BRAPH:Measurement:AtlasErr'], ...
                ['The input must be a cell containing  1 BrainAtlas object']) %#ok<NBRAK>
            m.atlases = atlases;
            
            assert(isa(group, 'Group'), ...
                ['BRAPH:Measurement:GroupErr'], ...
                ['The input must be a Group object']) %#ok<NBRAK>
            m.group = group;
            
            m.settings = get_from_varargin(varargin, 'MeasurementSettings', varargin{:});
            
            m.initialize_datadict(atlases, group, varargin{:});
            
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
            measurement_copy.data_dict = containers.Map;
            data_codes = keys(m.data_dict);
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
        function id = getID(m)
            id = m.id;
        end
        function str = tostring(m)
            str = [Measurement.getClass(m)]; %#ok<NBRAK>
        end
        function disp(m)
            disp(['<a href="matlab:help ' Measurement.getClass(m) '">' Measurement.getClass(m) '</a>'])
            disp(['id = ' Measurement.getID()])
            data_codes = m.getDataCodes();
            for i = 1:1:m.getDataNumber()
                data_code = data_codes{i};
                d = m.getData(data_code);
                disp([data_code ' = ' d.tostring()])
            end
        end
        function d = getData(m, data_code)
            d = m.data_dict(data_code);
        end
        function setBrainAtlases(m, atlases)
            % adds a atlas to the end of the cell array
            m.update_brainatlases(atlases);
        end
        function atlases = getBrainAtlases(m)
            atlases = m.atlases;
        end
        function setGroups(m, groups)
            m.update_groups(groups);
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
        function atlas_number = getBrainAtlasNumber(m)
            atlas_number =  eval([Measurement.getClass(m) '.getBrainAtlasNumber()']);
        end
        function group_number = getGroupNumber(m)
            group_number =  eval([Measurement.getClass(m) '.getGroupNumber()']);
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
        function datalist = getDataList(m)
            % list of measurments data keys
            datalist = eval([Measurement.getClass(m) '.getDataList()']);
        end
         function sub = getMeasurement(measurement_class, id , varargin) %#ok<INUSL>
            sub = eval([measurement_class  '(id, varargin{:})']);
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
    end
end