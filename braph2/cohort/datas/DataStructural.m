classdef DataStructural < Data
    % DataStructurral A data column vector
    % DataStructurral implements Data and serves as a container for column
    % type data.
    % It is a subclass of Data.
    %
    % DataStructurral implements Data and serves as a container for column
    % type data. It checks if the value of the data being saved is numeric
    % and has the same number of elements as the Brain Atlas.
    %
    % DataStructurral methods:
    %   DataStructurral         - Constructor
    %
    % DataStructurral abstract methods:
    %   setValue                - checks the value and sets it to DataStructurral
    %
    % DataStructurral static mehtods
    %   getClass                - returns the class
    %   getName                 - returns the name of the class
    %   getDescription          - returns the description of the class
    %   getAvailableSettings    - returns the available settings
    %
    % See also Data, DataFunctional, DataScalar, DataConnectivity.
    
    methods
        function d = DataStructural(atlas, value, varargin)
            % DATASTRUCTURAL(ATLAS, VALUE) creates DataStructurral object
            % and calls for the superclass.
            %
            % See also Data, DataFunctional, DataScalar, DataConnectivity.
            
            if nargin < 2
                value = zeros(atlas.getBrainRegions().length(), 1);
            end
            
            d = d@Data(atlas, value, varargin{:});
        end
    end
    methods
        function setValue(d, value)
            % SETVALUE sets the value of the data into the object
            %
            % SETVALUE(D, VALUE) checks that the value of the data is
            % numeric and that it has the correct dimensions. If incorrect
            % it throws and error, if correct it sets the value to the
            % object.
            %
            % See also getValue.
            
            regionnumber = d.getBrainAtlas().getBrainRegions().length();
            assert(isnumeric(value) && isequal(size(value), [regionnumber, 1]), ...
                [BRAPH2.STR ':DataStructural:' BRAPH2.WRONG_INPUT], ...
                [ ...
                'The value of DataStructural must be a column vector ' ...
                'with the same number of element as the BrainAtlas, ' ...
                'in this case ' int2str(regionnumber) ' elements' ...
                ])

            d.value = value;
        end
    end
    methods (Static)
        function data_class = getClass()
            % GETCLASS returns the class of the data 
            %
            % DATA_CLASS = GETCLASS() returns the class of the data.
            %
            % See also  getName, getDescription, getAvailableSettings.
            
            data_class = 'DataStructural';
        end
        function name = getName()
            % GETNAME returns the name of the data
            %
            % NAME = GETNAME(D) returns the name of the data.
            % 
            % See also getClass, getDescription, getAvailableSettings.
            
            name = 'Structural Brain Data';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the data
            %
            % DESCRIPTION = GETDESCRIPTION(D) returns the description of
            % the data.
            % 
            % See also getClass, getName, getAvailableSettings.
            
            description = [ ...
                'A series of structural data corresponding ' ...
                'to one scalar value per brain region.' ...
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