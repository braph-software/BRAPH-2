classdef RandomComparison < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        id  % unique identifier
        label  % random comparison label
        notes  % random comparison notes
        atlases  % cell array with brain atlases
        group  %  group
        measure_code  % measure code
        settings  % settings of the RandomComparison
    end
    methods (Access = protected)  % Constructor
        function rc = RandomComparison(id, label, notes, atlases, measure_code, group, varargin)

            rc.setID(id)
            rc.setLabel(label)
            rc.setNotes(notes)
            
            rc.setBrainAtlases(atlases)

            rc.setGroups(group_1, group_2)
            
            varargin = get_from_varargin(varargin, 'RandomComparisonSettings', varargin{:});  % returns varargin if no key 'RandomComparisonSettings'
            available_settings = RandomComparison.getAvailableSettings(class(rc));
            settings = cell(1, size(available_settings, 1));
            for i = 1:1:size(available_settings, 1)
                available_setting_code = available_settings{i, 1};
                available_setting_default = available_settings{i, 3};
                % TODO check that the value of the setting is amongst the acceptable values
                settings{2 * i - 1} = available_setting_code;
                settings{2 * i} = get_from_varargin(available_setting_default, available_setting_code, varargin{:});
            end
            rc.settings = settings;  % initialize the property settings
            
            rc.initialize_data(varargin{:});           
        end
    end
    methods (Abstract, Access = protected)  % Abstract function
        initialize_data(rc, varargin)  % initialize datadict
    end
    methods  % Basic functions
        function str = tostring(rc)
            str = [RandomComparison.getClass(rc)]; %#ok<NBRAK>
        end
        function disp(rc)
            disp(['<a href="matlab:help ' RandomComparison.getClass(rc) '">' RandomComparison.getClass(rc) '</a>'])
            disp(['id = ' rc.getID()])
        end
    end
    methods  % Set functions
        function setID(rc, id)

            assert(ischar(id), ...
                [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')

            rc.id = id;
        end
        function setLabel(rc, label)

            assert(ischar(label), ...
                [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')

            rc.label = label;
        end        
        function setNotes(rc, notes)

            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')

            rc.notes = notes;
        end
        function setBrainAtlases(rc, atlases)
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(iscell(atlases) && all(cellfun(@(x) isa(x, 'BrainAtlas'), atlases)), ...
                [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a cell containing BrainAtlas objects')
            rc.atlases = atlases;
        end
        function setGroups(rc, group)
            assert(isa(group, 'Group'), ...
                [BRAPH2.STR ':' class(rc) ':' BRAPH2.WRONG_INPUT], ...
                'The input must be a Group object')
            rc.group = group;
        end
    end
    methods  % Get functions
        function id = getID(rc)
            id = rc.id;
        end
        function label = getLabel(rc)

            label = rc.label;
        end
        function notes = getNotes(rc)

            notes = rc.notes;
        end
        function atlases = getBrainAtlases(rc)
            atlases = rc.atlases;
        end
        function measure_code = getMeasureCode(rc)
            measure_code = rc.measure_code;
        end
        function group = getGroup(rc)
            group = rc.group;
        end
        function res = getSettings(rc, setting_code)

            if nargin<2
                res = rc.settings;
            else
                res = get_from_varargin([], setting_code, rc.settings{:});
            end
        end
    end
    methods (Static)  % Descriptive functions
        function randomcomparisonlist = getList()
            randomcomparisonlist = subclasses('RandomComparison');
        end
        function randomcomparisonclass = getClass(rc)
            if isa(rc, 'RandomComparison')
                randomcomparisonclass = class(rc);
            else % mshould be a string with the RandomComparison class
                randomcomparisonclass = rc;
            end
        end
        function name = getName(rc)
            name = eval([RandomComparison.getClass(rc) '.getName()']);
        end
        function description = getDescription(rc)
            % RandomComparison description
            description = eval([RandomComparison.getClass(rc) '.getDescription()']);
        end
        function atlas_number = getBrainAtlasNumber(rc)
            atlas_number =  eval([RandomComparison.getClass(rc) '.getBrainAtlasNumber()']);
        end  
        function analysis_class = getAnalysisClass(c)
            % comparison analysis class
            analysis_class = eval([RandomComparison.getClass(c) '.getAnalysisClass()']);
        end
        function subject_class = getSubjectClass(c)
            % comparison subject class
            subject_class = eval([RandomComparison.getClass(c) '.getSubjectClass()']);
        end
        function available_settings = getAvailableSettings(rc)

            available_settings = eval([Measurement.getClass(rc) '.getAvailableSettings()']);
        end
        function sub = getRandomComparison(randomComparisonClass, id, label, notes, atlas, measure_code, group, varargin) %#ok<INUSD>
            sub = eval([randomComparisonClass '(id, label, notes, atlas, measure_code, group, varargin{:})']);
        end
    end
    methods (Access =  protected)  % Shallow copy
        function randomcomparison_copy = copyElement(rc)
            % It does not make a deep copy of atlases or group
            
            % Make a shallow copy
            randomcomparison_copy = copyElement@matlab.mixin.Copyable(rc);
            
        end
    end
end