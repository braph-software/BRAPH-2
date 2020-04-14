classdef RandomComparison < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        group  % group
        atlases  % cell array with brain atlases
        settings  % settings of the RandomComparison
        data_dict  % dictionary with data for RandomComparisons
    end
    methods (Access = protected)
        function m = RandomComparison(atlases, group, varargin)
            
            assert(iscell(atlases), ...
                ['BRAIN:RandomComparison:AtlasErr'], ...
                ['The input must be a cell containing BrainAtlas objects']) %#ok<NBRAK>
            m.atlases = atlases;
            
              assert(isa(group, 'Group'), ...
                ['BRAIN:RandomComparison:GroupErr'], ...
                ['The input must be a Group object']) %#ok<NBRAK>
            m.group = group;
            
            m.settings = get_from_varargin(varargin, 'RandomComparisonSettings', varargin{:});
            
            m.initialize_datadict(atlases, group, varargin{:});
            
            data_codes = m.getDataCodes();
            for i = 1:1:numel(data_codes)
                data_code = data_codes{i};
                value = get_from_varargin(m.getData(data_code).getValue, ...
                    data_code, varargin);
                m.getData(data_code).setValue(value);
            end
        end
        function RandomComparison_copy = copyElement(m)
            % It does not make a deep copy of atlases or groups
            
            % Make a shallow copy
            RandomComparison_copy = copyElement@matlab.mixin.Copyable(m);
            
            % Make a deep copy of datadict
            RandomComparison_copy.data_dict = containers.Map;
            data_codes = keys(m.data_dict);
            for i = 1:1:length(data_codes)
                data_code = data_codes{i};
                d = m.getData(data_code);
                RandomComparison_copy.datadict(data_code) = d.copy();
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
            str = [RandomComparison.getClass(m)]; %#ok<NBRAK>
        end
        function disp(m)
            disp(['<a href="matlab:help ' RandomComparison.getClass(m) '">' RandomComparison.getClass(m) '</a>'])
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
        function randomComparisonList = getList()
            randomComparisonList = subclasses( ...
                'RandomComparison', ...
                [fileparts(which('RandomComparison'))  filesep 'randomcomparisons'] ...
                );
        end
        function atlas_number = getBrainAtlasNumber(m)
            atlas_number =  eval([RandomComparison.getClass(m) '.getBrainAtlasNumber()']);
        end
        function group_number = getGroupNumber(m)        
            group_number =  eval([RandomComparison.getClass(m) '.getGroupNumber()']);
        end
        function RandomComparisonClass = getClass(m)
            if isa(m, 'RandomComparison')
                RandomComparisonClass = class(m);
            else % mshould be a string with the RandomComparison class
                RandomComparisonClass = m;
            end
        end
        function name = getName(m)
            name = eval([RandomComparison.getClass(m) '.getName()']);
        end
        function description = getDescription(m)
            % RandomComparison description
            description = eval([RandomComparison.getClass(m) '.getDescription()']);
        end              
        function datalist = getDataList(m)
            % list of measurments data keys
            datalist = eval([RandomComparison.getClass(m) '.getDataList()']);
        end
        function sub = getRandomComparison(randomComparisonClass, varargin)
            sub = eval([randomComparisonClass '(varargin{:})']);
        end
        function data_codes = getDataCodes(m)
            datalist = RandomComparison.getDataList(m);
            data_codes = keys(datalist);
        end
        function data_number = getDataNumber(m)
            datalist = RandomComparison.getDataList(m);
            data_number = length(datalist);
        end
        function data_classes = getDataClasses(m)
            datalist = RandomComparison.getDataList(m);
            data_classes = values(datalist);
        end
        function data_class = getDataClass(m, data_code)
            datalist = RandomComparison.getDataList(m);
            data_class = datalist(data_code);
        end
    end
end