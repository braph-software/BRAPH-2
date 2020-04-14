classdef Comparison < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        groups  % cell array with two groups
        atlases  % cell array with brain atlases
        settings  % settings of the measurement
        data_dict  % dictionary with data for measurements
    end
    methods (Access = protected)
        function c = Comparison(atlases, groups, varargin)
            
            assert(iscell(atlases), ...
                ['BRAPH:Comparison:AtlasErr'], ...
                ['The input must be a cell containing BrainAtlas objects']) %#ok<NBRAK>
            c.atlases = atlases;
            
            assert(iscell(groups), ...
                ['BRAPH:Comparison:GroupErr'], ...
                ['The input must be a cell containing Groups objects']) %#ok<NBRAK>
            c.groups = groups;
            
            c.settings = get_from_varargin(varargin, 'MeasurementSettings', varargin{:});
            
            c.initialize_datadict(atlases, groups, varargin{:});
            
            data_codes = c.getDataCodes();
            for i = 1:1:numel(data_codes)
                data_code = data_codes{i};
                value = get_from_varargin(c.getData(data_code).getValue, ...
                    data_code, varargin);
                c.getData(data_code).setValue(value);
            end
        end
        function comparison_copy = copyElement(m)
            % It does not make a deep copy of atlases or groups
            
            % Make a shallow copy
            comparison_copy = copyElement@matlab.mixin.Copyable(m);
            
            % Make a deep copy of datadict
            comparison_copy.data_dict = containers.Map;
            data_codes = keys(m.data_dict);
            for i = 1:1:length(data_codes)
                data_code = data_codes{i};
                d = m.getData(data_code);
                comparison_copy.datadict(data_code) = d.copy();
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
            str = [Comparison.getClass(m)]; %#ok<NBRAK>
        end
        function disp(m)
            disp(['<a href="matlab:help ' Comparison.getClass(m) '">' Comparison.getClass(m) '</a>'])
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
        function comparisonList = getList()
            comparisonList = subclasses( ...
                'Comparison', ...
                [fileparts(which('Comparison')) filesep 'comparisons'] ...
                );    
        end
        function atlas_number = getBrainAtlasNumber(m)
            atlas_number =  eval([Comparison.getClass(m) '.getBrainAtlasNumber()']);
        end
        function group_number = getGroupNumber(m)        
            group_number =  eval([Comparison.getClass(m) '.getGroupNumber()']);
        end
        function measurementClass = getClass(m)
            if isa(m, 'Comparison')
                measurementClass = class(m);
            else % mshould be a string with the measurement class
                measurementClass = m;
            end
        end
        function name = getName(m)
            name = eval([Comparison.getClass(m) '.getName()']);
        end
        function description = getDescription(m)
            % measurement description
            description = eval([Comparison.getClass(m) '.getDescription()']);
        end              
        function datalist = getDataList(m)
            % list of measurments data keys
            datalist = eval([Comparison.getClass(m) '.getDataList()']);
        end
        function sub = getComparison(comparisonClass, varargin)
            sub = eval([comparisonClass '(varargin{:})']);
        end
        function data_codes = getDataCodes(m)
            datalist = Comparison.getDataList(m);
            data_codes = keys(datalist);
        end
        function data_number = getDataNumber(m)
            datalist = Comparison.getDataList(m);
            data_number = length(datalist);
        end
        function data_classes = getDataClasses(m)
            datalist = Comparison.getDataList(m);
            data_classes = values(datalist);
        end
        function data_class = getDataClass(m, data_code)
            datalist = Comparison.getDataList(m);
            data_class = datalist(data_code);
        end
    end
end