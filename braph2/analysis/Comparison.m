classdef Comparison < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        id  % unique identifier
        label  % comparison label
        notes  % comparison notes
        atlases  % cell array with brain atlases
        measure_code  % measure code
        groups  % cell array with two groups
        settings  % settings of the measurement
    end
    methods (Access = protected)  % Constructor
        function c = Comparison(id, label, notes, atlases, measure_code, groups, varargin)

            c.setID(id)
            c.setLabel(label)
            c.setNotes(notes)
            
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(iscell(atlases) && all(cellfun(@(x) isa(x, 'BrainAtlas'), atlases)), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a cell containing BrainAtlas objects')
            c.atlases = atlases;
            
            assert(ischar(measure_code), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'The measure code must be a string.')
            m.measure_code = measure_code;

            assert(iscell(groups) && length(groups) == 2 && all(cellfun(@(x) isa(x, 'Group'), groups)), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a cell array with two groups')
            c.groups = groups;
            
            varargin = get_from_varargin(varargin, 'ComparisonSettings', varargin{:});  % returns varargin if no key 'ComparisonSettings'
            available_settings = Comparison.getAvailableSettings(class(c));
            settings = cell(1, size(available_settings, 1));
            for i = 1:1:size(available_settings, 1)
                available_setting_code = available_settings{i, 1};
                available_setting_default = available_settings{i, 3};
                % TODO check that the value of the setting is amongst the acceptable values
                settings{2 * i - 1} = available_setting_code;
                settings{2 * i} = get_from_varargin(available_setting_default, available_setting_code, varargin{:});
            end
            c.settings = settings;  % initialize the property settings
            
            c.initialize_data(atlases, groups, varargin{:});           
        end
    end
    methods (Abstract, Access = protected)  % Abstract function
        initialize_data(c, varargin)  % initialize datadict
    end
    methods  % Basic functions
        function str = tostring(c)
            str = [Comparison.getClass(c) ' ' c.getID()];
        end
    end
    methods  % Set functions
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
    methods  % Get functions
        function id = getID(c)
            id = c.id;
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
    methods (Access = protected)  % Shallow copy
        function comparison_copy = copyElement(c)
            % It does not make a deep copy of atlases or groups
            
            % Make a shallow copy
            comparison_copy = copyElement@matlab.mixin.Copyable(c);
        end
    end
end
