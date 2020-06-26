classdef DataFunctional < Data
    % DataFunctional A Data Connectivity Matrix
    % DataFunctional implements Data and serves as a container for matrix
    % type data.
    % It is a subclass of Data.
    %
    % DataFunctional implements Data and serves as a container for matrix
    % type data. It checks if the value of the data being saved is numeric
    % and has the same number of rows as the Brain Atlas.
    %
    % DataFunctional methods:
    %   DataFunctional        - Constructor
    %
    % DataFunctional abstract methods:
    %   setValue                - checks the value and sets it to DataFunctional
    %
    % DataFunctional static mehtods
    %   getClass                - returns the class
    %   getName                 - returns the name of the class
    %   getDescription          - returns the description of the class
    %   getAvailableSettings    - returns the available settings
    %
    % See also Data, DataConnectivity, DataScalar, DataStructural.
    
    methods
        function d = DataFunctional(atlas, value, varargin)
            % DATAFUNCTIONAL(ATLAS, VALUE, 'PROPERTYVALUE1', 'VALUE1', ...)
            % creates DataFunctional object, checks if value is present,
            % and calls for the super class.
            %
            % See also Data, DataConnectivity, DataScalar, DataStructural.
            
            if nargin < 2
                value = zeros(atlas.getBrainRegions().length(), 10);
            end
            
            d = d@Data(atlas, value, varargin{:});
        end
    end
    methods
        function setValue(d, value)
            % SETVALUE sets the value of the data into the object.
            %
            % SETVALUE(D, VALUE) checks that the value of the data is
            % numeric and that it has the same number of rows as the atlas.
            % If incorrect it throws and error, if correct it sets the
            % value to the object.
            %
            % See also getValue.
            
            regionnumber = d.getBrainAtlas().getBrainRegions().length();
            assert(isnumeric(value) && size(value, 1)==regionnumber, ...
                [BRAPH2.STR ':DataFunctional:' BRAPH2.WRONG_INPUT], ...
                [ ...
                'The value of DataFunctional must be a matrix ' ...
                'with the same number of rows as the BrainAtlas, ' ...
                'in this case ' int2str(regionnumber) ' rows' ...
                ])
            
            d.value = value;
        end
    end
    methods (Static)
        function data_class = getClass()
            % GETCLASS returns the class of the data 
            %
            % DATA_CLASS = GETCLASS() reutrns the class of the data.
            %
            % See also  getName, getDescription, getAvailableSettings.
            
            data_class = 'DataFunctional';
        end
        function name = getName()
            % GETNAME returns the name of the data
            %
            % NAME = GETNAME(D) returns the name of the data.
            % 
            % See also getClass, getDescription, getAvailableSettings.
            
            name = 'Functional Brain Data';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the data.
            %
            % DESCRIPTION = GETDESCRIPTION(D) returns the description of
            % the data.
            % 
            % See also getClass, getName, getAvailableSettings.
            
            description = [ ...
                'A series of functional data corresponding ' ...
                'to one timeseries per brain region.' ...
                ];
        end
        function available_settings = getAvailableSettings(d) %#ok<INUSD>
            % GETAVAILABLESETTINGS returns the available settings of the data
            %
            % AVAILABLE_SETTINGS = GETAVAILABLESETTINGS(D) returns the
            % available settings of the data.
            % 
            % See also getClass, getName, getDescription.
            
            available_settings = {};
        end
    end  
end