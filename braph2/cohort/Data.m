classdef Data < handle & matlab.mixin.Copyable
    % Data (Abstract) A data item
    % Data provides the methods necessary for all data types
    % It is a subclass of handle and matlab.mixin.Copyable
    %
    % Data provides the methods necessary for data subclasses to store the
    % subject data. 
    %
    % Data methods:
    %   Data                    - Constructor
    %
    % Data basic methods:
    %   tostring                - returns a string representing the Data
    %   disp                    - displays the Data
    %   getValue                - returns the value
    %   setBrainAtlas           - sets the Brain Atlas to Data
    %   getBrainAtlas           - returns the brain atlas    
    % 
    % Data abstract methods:
    %   setValue                - set value
    %   getDataPanel            - returns data panel
    %
    % Data static mehtods
    %   getList                 - returns the list of subclasses
    %   getClass                - returns the class
    %   getName                 - returns the name of the class
    %   getDescription          - returns the description of the class
    %   getData                 - returns the data
    %   getAvailableSettings    - returns the available settings
    %
    % See also Cohort, Subject, Group.
    
    properties (GetAccess=protected, SetAccess=protected)
        atlas  % brain atlas
        value  % data value (a matrix)
        settings  % settings structure for Data
    end
    methods (Access=protected)
        function d = Data(atlas, value, varargin)
            % DATA(ATLAS, VALUE, 'PROPERTYRULE1', 'VALUE1', ...) creates a
            % Data object to store Subject data using the ATLAS and VALUE,
            % with a list of PROPERTYRULES if needed.
            %
            % See also Subject, Cohort, Group.
            
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
    methods  % basic methods
        function str = tostring(d)
            % TOSTRING string with information about data
            %
            % STRING = TOSTRING(D) returns string with the data class, 
            % size and value.
            %
            % See also disp.
            
            str = [Data.getClass(d) ' ' int2str(size(d.getValue(), 1)) ' x ' int2str(size(d.getValue(), 2))];
        end
        function disp(d)
            % TOSTRING displays information about data
            %
            % DISP(D) displays information about the data class, size and
            % value.
            %
            % See also tostring.
            
            disp(['<a href="matlab:help ' Data.getClass(d) '">' Data.getClass(d) '</a>'])
            disp([' size: ' int2str(size(d.getValue(), 1)) ' rows x ' int2str(size(d.getValue(), 2)) ' columns'])
        end
        function value = getValue(d)
            % GETVALUE returns the value of data
            %
            % VALUE = GETVALUE(D) returns the value of the data.
            %
            % See also getBrainAtlas.
            
            value = d.value;
        end        
        function setBrainAtlas(d, atlas)
            % SETBRAINATLAS sets the brain atlas to the data object
            %
            % SETBRAINATLAS(D, ATLAS) sets the brian atlas ATLAS to the 
            % data object.
            %
            % See also SetValue.
            
            assert(d.getBrainAtlas().getBrainRegions().length() == atlas.getBrainRegions().length(), ...
                [BRAPH2.STR ':' d.getClass() ':' BRAPH2.WRONG_INPUT], ...
                ['When substituting the brain atlas in ' d.getClass() ', the size of the brain atlas must remain the same.'])
            
            d.atlas = atlas;
        end
        function atlas = getBrainAtlas(d)
            % GETBRAINATLAS returns the brain atlas
            %
            % ATLAS = GETBRAINATLAS(D) returns the brain atlas.
            %
            % See also getValue.
            
            atlas = d.atlas;
        end
    end
    methods (Abstract)  % abstract methods
        setValue(d, value)  % set the value of the data
        getDataPanel(d, ui_parent)  % returns data panel
    end
    methods (Static)  % inspection methods
        function data_list = getList()
            % GETLIST returns a list with all subclasses
            %
            % DATA_LIST = GETLIST() returns a list with all subclasses.
            %
            % See also getClass, getName, getDescription, getData, getAvailableSettings.
            
            data_list = subclasses( ...
                'Data', ...
                [fileparts(which('Data')) filesep 'datas'] ...
                );
        end
        function data_class = getClass(d)
            % GETCLASS returns the class of the data 
            %
            % DATA_CLASS = GETCLASS(D) returns the class of the data.
            %
            % See also getList, getName, getDescription, getData, getAvailableSettings.
            
            if isa(d, 'Data')
                data_class = class(d);
            else % g should be a string with the data class
                data_class = d;
            end
        end
        function name = getName(d)
            % GETNAME returns the name of the data
            %
            % NAME = GETNAME(D) returns the name of the data.
            % 
            % See also getList, getClass, getDescription, getData, getAvailableSettings.
            
            name = eval([Data.getClass(d) '.getName()']);
        end
        function description = getDescription(d)
            % GETDESCRIPTION returns the description of the data
            %
            % DESCRIPTION = GETDESCRIPTION(D) returns the description of
            % the data.
            % 
            % See also getList, getClass, getName, getData, getAvailableSettings.
            
            description = eval([Data.getClass(d) '.getDescription()']);
        end
        function d = getData(data_class, atlas, varargin) %#ok<INUSD>
            % GETDATA returns the data
            %
            % D = GETDATA(DATA_CLASS, ATLAS, VARARGIN) returns the data
            % 
            % See also getList, getClass, getName, getDescription, getAvailableSettings.
          
            d = eval([data_class '(atlas, varargin{:})']);
        end
        function available_settings = getAvailableSettings(d)
            % GETAVAILABLESETTINGS returns the available settings of the data
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS(D) returns the
            % available settings of the data.
            % 
            % See also getList, getClass, getName, getDescription, getData.
            
            available_settings = eval([Data.getClass(d) '.getAvailableSettings()']);        
        end
        function data_structure = getDataStructure(d)
            data_structure = eval([Data.getClass(d) '.getDataStructure()']);
        end
    end
    methods (Access=protected)  % shallow copy
        function d_copy = copyElement(d)
            % COPYELEMENT(D) deep copy of data
            %
            % D_COPY = COPYELEMENT(D) Makes a shallow copy of the
            % structure of the data. It does not make a deep copy of
            % BrainAtlas.
            %
            % See also Cohort, Subject, Group.
            
            % IMPORTANT! It does NOT make a deep copy of the BrainAtlas atlas            
            % Make a shallow copy
            d_copy = copyElement@matlab.mixin.Copyable(d);
        end
    end    
end