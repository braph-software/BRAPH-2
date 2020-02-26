classdef Data < handle
    properties (GetAccess=protected, SetAccess=protected)
        atlas  % brain atlas
        value  % data value
    end
    methods (Access=protected)
        function d = Data(atlas, value)
            
            assert(isa(atlas, 'BrainAtlas'), ...
                'BRAPH:Data:BrainAtlas', ...
                'Data must be constructed with a BrainAtlas.')
            
            d.atlas = atlas;
            d.setValue(value);
        end
    end
    methods
        function str = tostring(d)
            str = [Data.getClass(d) ' ' int2str(size(d.getValue(), 1)) ' x ' int2str(size(d.getValue(), 2))]; %#ok<NBRAK>
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
    end
    methods (Abstract)
        setValue(d, value)  % set the value of the data
    end
    methods (Static)
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
    end
end