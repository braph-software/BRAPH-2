classdef Measurement < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        id  % unique identifier
        atlases  % cell array with brain atlases
        group  % group
        settings  % settings of the measurement
    end
    methods (Access = protected)
        function m = Measurement(id, atlases, group, varargin)
            m.id = tostring(id);
            
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(iscell(atlases) && all(cellfun(@(x) isa(x, 'BrainAtlas'), atlases)), ...
                ['BRAPH:Measurement:AtlasErr'], ...
                ['The input must be a cell containing BrainAtlas objects']) %#ok<NBRAK>
            m.atlases = atlases;
            
            assert(isa(group, 'Group'), ...
                ['BRAPH:Measurement:GroupErr'], ...
                ['The input must be a Group object']) %#ok<NBRAK>
            m.group = group;
            
            m.settings = get_from_varargin(varargin, 'MeasurementSettings', varargin{:});
            
            m.initialize_data(atlases, group, varargin{:});

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
        initialize_data(m, varargin)  % initialize datadict
    end
    methods
        function id = getID(m)
            id = m.id;
        end
        function str = tostring(m)
            str = [Measurement.getClass(m) ' ' m.getID()];
        end
        function disp(m)
            disp(['<a href="matlab:help ' Measurement.getClass(m) '">' Measurement.getClass(m) '</a>'])
            disp(['id = ' m.getID()])
        end
        function setBrainAtlases(m, atlases)
            m.atlases = atlases;
        end
        function atlases = getBrainAtlases(m)
            atlases = m.atlases;
        end
        function setGroup(m, group)
            m.group = group;
        end
        function group = getGroup(m)
            group = m.group;
        end
    end
    methods (Static)
        function measurement_list = getList()
            measurement_list = subclasses('Measurement');
        end
        function measurement_class = getClass(m)
            if isa(m, 'Measurement')
                measurement_class = class(m);
            else  % m should be a string with the measurement class
                measurement_class = m;
            end
        end
        function name = getName(m)
            name = eval([Measurement.getClass(m) '.getName()']);
        end
        function description = getDescription(m)
            % measurement description
            description = eval([Measurement.getClass(m) '.getDescription()']);
        end
        function atlas_number = getBrainAtlasNumber(m)
            atlas_number =  eval([Measurement.getClass(m) '.getBrainAtlasNumber()']);
        end
        function analysis_class = getAnalysisClass(m)
            % measurement analysis class
            analysis_class = eval([Measurement.getClass(m) '.getAnalysisClass()']);
        end
        function subject_class = getSubjectClass(m)
            % measurement subject class
            subject_class = eval([Measurement.getClass(m) '.getSubjectClass()']);
        end        
        function sub = getMeasurement(measurement_class, id , atlases, group, varargin) %#ok<INUSD>
            sub = eval([measurement_class  '(id, atlases, group, varargin{:})']);
        end
    end
end