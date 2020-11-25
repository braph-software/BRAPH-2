classdef Statistics < handle & matlab.mixin.Copyable
    properties
        groups  % structure with groups involved in the statistic
        settings  % structure with the constructor varargin
        stat_dict  % all statistic return a dict first entry has keys of the rest of entries
    end
    methods (Access = protected)
        function s = Statistics(varargin)
            if length(varargin) == 1
                varargin = varargin{:};
            end
            
            available_settings = Statistics.getAvailableSettings(class(s));
            settings = cell(length(available_settings), length(available_settings{1, 1}) - 2);
            number_groups = 1;
            for i = 1:1:size(available_settings, 2)
                as = available_settings{i};
                available_setting_code = as{1, 1};
                available_setting_default = as{1, 3};
                settings{i, 1} = available_setting_code;
                settings{i, 2} = get_from_varargin(available_setting_default, available_setting_code, varargin{:});
                
                if isequal(available_setting_code, 'number_groups')
                    number_groups = settings{i, 2};
                end
            end
            s.settings = settings;
            
            groups = cell(1, number_groups);
            for i = 1:1:number_groups
                group_key = ['Group_' i];
                groups{2 * i -1} = group_key;
                groups{2 * i} = get_from_varargin([], group_key, varargin{:});
            end
            s.groups = groups;
        end
    end
    methods  % Basic methods
        function groups = getGroups(s)
            groups = s.groups;
        end
        function res = getSettings(s, setting_code)
            if nargin < 2
                res = s.settings;
            else
                res = get_from_varargin([], setting_code, s.settings{:});
            end
        end
         function bool = is_dict_init(s)
            % IS_VALUE_CALCULATED checks if values is calculated
            %
            % BOOL = IS_VALUE_CALCULATED(M) returns true  if value has been
            % already calculated.
            %
            % See also getValue.
            
            bool = ~isempty(s.stat_dict);
        end
        function stat_dict = getStatistics(s, varargin)
            % check for defaults, this may need to be recalculated every
            % time its a new default, for example for perm test M and
            % verbose vary.
            if ~s.is_dict_init()
                s.init_data_dict(varargin{:});
            end
            stat_dict = s.stat_dict;
        end
    end
    methods (Abstract, Access = protected)
        init_data_dict(s)
    end
    methods (Abstract)  % plot
        getStatisticPanel(s, ui_parent)  % returns a panel with settings
    end
    methods (Static)
        function statistic_class_list = getList()
            statistic_class_list = subclasses( ...
                'Statistics', ...
                [fileparts(which('Statistics')) filesep 'statistics'] ...
                );
        end
        function statistic_class = getClass(s)
            if isa(s, 'Statistics')
                statistic_class = class(s);
            else % g should be a string with the graph code
                statistic_class = s;
            end
        end
        function name = getName(s)
            name = eval([Statistics.getClass(s) '.getName()']);
        end
        function name = getDescription(s)
            name = eval([Statistics.getClass(s) '.getDescription()']);
        end
        function available_settings = getAvailableSettings(s)
            available_settings = eval([Statistics.getClass(s) '.getAvailableSettings()']);
        end
        function s = getStatistic(stat_code, varargin)
            s = eval([stat_code '(varargin{:})']);
        end
        function list = getCompatibleAnalysis(s)
            list = eval([Statistics.getClass(s) '.getCompatibleGraphList()']);
        end
    end
end