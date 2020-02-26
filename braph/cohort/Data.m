classdef Data < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        value  % data value
    end
    methods (Access=protected)
        function d = Data(value)
            d.value = value;
        end
    end
    methods
        function value = getValue(d)
            value = d.value;
        end
    end
    methods (Static)
        function data_list = getList()
            data_list = subclasses( ...
                'Data', ...
                [fileparts(which('Data')) filesep 'data'] ...
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
        function d = getData(data_code, varargin)
            d = eval([data_code '(varargin{:})']);
        end
    end
end