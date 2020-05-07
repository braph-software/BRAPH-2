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
            assert(iscell(atlases) && all(cellfun(@(x) isa(x, 'BrainAtlas'), atlases)), ...
                ['BRAPH:Comparison:AtlasErr'], ...
                ['The input must be a cell containing BrainAtlas objects']) %#ok<NBRAK>
            c.atlases = atlases;
            
            assert(iscell(groups) && length(groups)==2 && all(cellfun(@(x) isa(x, 'Group'), groups)), ...
                ['BRAPH:Comparison:GroupErr'], ...
                ['The input must be a cell array with two Group']) %#ok<NBRAK>
            c.groups = groups;
            
            c.settings = get_from_varargin(varargin, 'ComparisonSettings', varargin{:});
            
            c.initialize_data(atlases, groups, varargin{:});           
        end
        function comparison_copy = copyElement(c)
            % It does not make a deep copy of atlases or groups
            
            % Make a shallow copy
            comparison_copy = copyElement@matlab.mixin.Copyable(c);
            
        end
    end
    methods (Abstract, Access = protected)
        initialize_data(c, varargin)  % initialize datadict
    end
    methods
        function id = getID(c)
            id = c.id;
        end
        function str = tostring(c)
            str = [Comparison.getClass(c) ' ' c.getID()];
        end
        function disp(c)
            disp(['<a href="matlab:help ' Comparison.getClass(c) '">' Comparison.getClass(c) '</a>'])
            disp(['id = ' c.getID()])
        end
        function setBrainAtlases(c, atlases)
            c.atlases = atlases;
        end
        function atlases = getBrainAtlases(c)
            atlases = c.atlases;
        end
        function setGroups(c, groups)
            c.groups = groups;
        end
        function groups = getGroups(c)
            groups = c.groups;
        end
    end
    methods (Static)
        function comparison_list = getList()
            comparison_list = subclasses('Comparison');
        end
        function comparison_class = getClass(c)
            if isa(c, 'Comparison')
                comparison_class = class(c);
            else  % c should be a string with the comparison class
                comparison_class = c;
            end
        end
        function name = getName(c)
            name = eval([Comparison.getClass(c) '.getName()']);
        end
        function description = getDescription(c)
            % comparison description
            description = eval([Comparison.getClass(c) '.getDescription()']);
        end
        function atlas_number = getBrainAtlasNumber(c)
            atlas_number =  eval([Comparison.getClass(c) '.getBrainAtlasNumber()']);
        end
        function analysis_class = getAnalysisClass(c)
            % comparison analysis class
            analysis_class = eval([Comparison.getClass(c) '.getAnalysisClass()']);
        end
        function subject_class = getSubjectClass(c)
            % comparison subject class
            subject_class = eval([Comparison.getClass(c) '.getSubjectClass()']);
        end
        function sub = getComparison(comparisonClass, id, atlases, groups, varargin) %#ok<*INUSD>
            sub = eval([comparisonClass '(id, atlases, groups, varargin{:})']);
        end
    end
end
