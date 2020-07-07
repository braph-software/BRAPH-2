classdef Comparison < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        id  % unique identifier
        label  % comparison label
        notes  % comparison notes
        atlases  % cell array with brain atlases
        measure_code  % measure code
        group_1  % first group
        group_2  % second group
        settings  % settings of the measurement
    end
    methods (Access = protected)  % Constructor
        function c = Comparison(id, label, notes, atlases, measure_code, group_1, group_2, varargin)

            c.setID(id)
            c.setLabel(label)
            c.setNotes(notes)
            
            c.setBrainAtlases(atlases)
            
            assert(ischar(measure_code), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'The measure code must be a string.')
            m.measure_code = measure_code;

            c.setGroups(group_1, group_2)

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
            
            c.initialize_data(atlases, varargin{:});           
        end
    end
    methods (Abstract, Access = protected)  % Abstract function
        initialize_data(c, atlases, varargin)  % initialize datadict
    end
    methods  % Basic functions
        function str = tostring(c)
            str = [Comparison.getClass(c) ' ' c.getID()];
        end
        function disp(c)
            disp(['<a href="matlab:help ' Comparison.getClass(c) '">' Comparison.getClass(c) '</a>'])
            disp(['id = ' c.getID()])
        end
    end
    methods  % Set functions
        function setID(c, id)

            assert(ischar(id), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')

            c.id = id;
        end
        function setLabel(c, label)

            assert(ischar(label), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')

            c.label = label;
        end        
        function setNotes(c, notes)

            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')

            c.notes = notes;
        end        
        function setBrainAtlases(c, atlases)
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(iscell(atlases) && all(cellfun(@(x) isa(x, 'BrainAtlas'), atlases)), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a cell containing BrainAtlas objects')
            c.atlases = atlases;
        end
        function setGroups(c, group_1, group_2)
            assert(isa(group_1, 'Group'), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a Group object')
            c.group_1 = group_1;
            
            assert(isa(group_2, 'Group'), ...
                [BRAPH2.STR ':' class(c) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a Group object')
            c.group_2 = group_2;
        end
    end
    methods  % Get functions
        function id = getID(c)
            id = c.id;
        end
        function label = getLabel(c)

            label = c.label;
        end
        function notes = getNotes(c)

            notes = c.notes;
        end
        function atlases = getBrainAtlases(c)
            atlases = c.atlases;
        end
        function measure_code = getMeasureCode(c)
            measure_code = c.measure_code;
        end
        function [group_1, group_2] = getGroups(c)
            group_1 = c.group_1;
            group_2 = c.group_2;
        end
        function res = getSettings(c, setting_code)

            if nargin<2
                res = c.settings;
            else
                res = get_from_varargin([], setting_code, c.settings{:});
            end
        end
    end
    methods (Static)  % Descriptive functions
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
        function available_settings = getAvailableSettings(c)

            available_settings = eval([Measurement.getClass(c) '.getAvailableSettings()']);
        end
        function sub = getComparison(comparison_class, id, label, notes, atlases, measure_code, groups, varargin) %#ok<*INUSD>
            sub = eval([comparison_class '(id, label, notes, atlases, measure_code, groups, varargin{:})']);
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
