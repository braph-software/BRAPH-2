classdef Data < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        atlas  % brain atlas
        value  % data value (a matrix)
        settings  % settings structure for Data
    end
    methods (Access=protected)
        function d = Data(atlas, value, varargin)
            
            assert(isa(atlas, 'BrainAtlas'), ...
                [BRAPH2.STR ':Data:BrainAtlas' BRAPH2.WRONG_INPUT], ...
                'Data must be constructed with a BrainAtlas.')
            
            d.atlas = atlas;
            d.setValue(value);
            
            available_settings = Data.getAvailableSettings(class(d));
            if isempty(available_settings)
                settings = {};
            else
                settings = cell(length(available_settings), length(available_settings{1, 1}) - 2);
                for i = 1:1:length(available_settings)
                    a_s = available_settings{i};
                    available_setting_code = a_s{1, 1};
                    available_setting_default = a_s{1, 3};
                    settings{i, 1} = available_setting_code;
                    settings{i, 2} = get_from_varargin(available_setting_default, available_setting_code, varargin{:});
                end
            end
            d.settings = settings;
        end
    end
    methods  % Basic methods
        function str = tostring(d)
            str = [Data.getClass(d) ' ' int2str(size(d.getValue(), 1)) ' x ' int2str(size(d.getValue(), 2))];
        end
        function disp(d)
            disp(['<a href="matlab:help ' Data.getClass(d) '">' Data.getClass(d) '</a>'])
            disp([' size: ' int2str(size(d.getValue(), 1)) ' rows x ' int2str(size(d.getValue(), 2)) ' columns'])
        end
        function atlas = getBrainAtlas(d)
            atlas = d.atlas;
        end
        function value = getValue(d)
            value = d.value;
        end
        function setBrainAtlas(d, atlas)
            
            assert(d.getBrainAtlas().getBrainRegions().length() == atlas.getBrainRegions().length(), ...
                [BRAPH2.STR ':' d.getClass() ':' BRAPH2.WRONG_INPUT], ...
                ['When substituting the brain atlas in ' d.getClass() ', the size of the brain atlas must remain the same.'])
            
            d.atlas = atlas;
        end
    end
    methods (Abstract)  % setValue
        setValue(d, value)  % set the value of the data
    end
    methods (Static)  % Inspection methods
        function data_list = getList()
            data_list = subclasses( ...
                'Data', ...
                [fileparts(which('Data')) filesep 'datas'] ...
                );
        end
        function data_class = getClass(d)
            % data class (same as the data object name)
            
            if isa(d, 'Data')
                data_class = class(d);
            else % g should be a string with the data class
                data_class = d;
            end
        end
        function name = getName(d)
            % data name
            
            name = eval([Data.getClass(d) '.getName()']);
        end
        function description = getDescription(d)
            % data description
            
            description = eval([Data.getClass(d) '.getDescription()']);
        end
        function d = getData(data_class, atlas, varargin) %#ok<INUSD>
            d = eval([data_class '(atlas, varargin{:})']);
        end
        function available_settings = getAvailableSettings(d)
            available_settings = eval([Data.getClass(d) '.getAvailableSettings()']);        
        end
    end
    methods (Access=protected)  % Shallow Copy
        function d_copy = copyElement(d)
            % IMPORTANT! It does NOT make a deep copy of the BrainAtlas atlas
            
            % Make a shallow copy
            d_copy = copyElement@matlab.mixin.Copyable(d);
        end
    end    
end