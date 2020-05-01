classdef Comparison < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        id  % unique identifier
        atlases  % cell array with brain atlases
        groups  % cell array with two groups
        settings  % settings of the measurement
    end
    methods (Access = protected)
        function c = Comparison(id, atlases, groups, varargin)
            c.id = tostring(id);
            
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(iscell(atlases)  && length(atlases)==1, ...
                ['BRAPH:Comparison:AtlasErr'], ...
                ['The input must be a cell containing BrainAtlas objects']) %#ok<NBRAK>
            c.atlases = atlases;
            
            assert(iscell(groups) && length(groups)==2, ...
                ['BRAPH:Comparison:GroupErr'], ...
                ['The input must be two Groups or a cell with two Group']) %#ok<NBRAK>
            c.groups = groups;
            
            c.settings = get_from_varargin(varargin, 'MeasurementSettings', varargin{:});
            
            c.initialize_data(atlases, groups, varargin{:});
            
        end
        function comparison_copy = copyElement(c)
            % It does not make a deep copy of atlases or groups
            
            % Make a shallow copy
            comparison_copy = copyElement@matlab.mixin.Copyable(c);
            
            % Make a deep copy of datadict
            comparison_copy.data_dict = containers.Map;
            data_codes = keys(c.data_dict);
            for i = 1:1:length(data_codes)
                data_code = data_codes{i};
                d = c.getData(data_code);
                comparison_copy.datadict(data_code) = d.copy();
            end
        end
    end
    methods (Abstract, Access = protected)
        initialize_data(c, varargin)  % initialize datadict
    end
    methods
        function id = getID(m)
            id = m.id;
        end
        function str = tostring(c)
            str = [Comparison.getClass(c)]; %#ok<NBRAK>
        end
        function disp(c)
            disp(['<a href="matlab:help ' Comparison.getClass(c) '">' Comparison.getClass(c) '</a>'])
            data_codes = c.getDataCodes();
            for i = 1:1:c.getDataNumber()
                data_code = data_codes{i};
                d = c.getData(data_code);
                disp([data_code ' = ' d.tostring()])
            end
        end
        function setBrainAtlases(c, atlases)
            % adds a atlas to the end of the cell array
            c.update_brainatlases(atlases);
        end
        function update_brainatlas(c, atlases)
            
            c.atlases = atlases;
            atlas = atlases{1};
            
            d1 = c.data_dict('type');
            d1.setBrainAtlas(atlas)
            
            d2 = c.data_dict('value');
            d2.setBrainAtlas(atlas);
        end
        function setGroups(c, groups)
            c.update_groups(groups);
        end
        function atlases = getBrainAtlases(c)
            atlases = c.atlases;
        end
        function groups = getGroups(c)
            groups = c.groups;
        end
        function update_groups(c, groups)
            c.groups = groups;
        end
    end
    methods (Static)
        function comparisonList = getList()
            comparisonList = subclasses( ...
                'Comparison', ...
                [fileparts(which('Comparison')) filesep 'comparisons'] ...
                );
        end
        function atlas_number = getBrainAtlasNumber(c)
            atlas_number =  eval([Comparison.getClass(c) '.getBrainAtlasNumber()']);
        end
        function group_number = getGroupNumber(c)
            group_number =  eval([Comparison.getClass(c) '.getGroupNumber()']);
        end
        function measurement_class = getClass(c)
            if isa(c, 'Comparison')
                measurement_class = class(c);
            else % mshould be a string with the measurement class
                measurement_class = c;
            end
        end
        function name = getName(c)
            name = eval([Comparison.getClass(c) '.getName()']);
        end
        function description = getDescription(c)
            % measurement description
            description = eval([Comparison.getClass(c) '.getDescription()']);
        end
        function sub = getComparison(comparisonClass, id, varargin) %#ok<*INUSD>
            sub = eval([comparisonClass '(id, varargin{:})']);
        end
    end
end