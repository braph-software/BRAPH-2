classdef DataConnectivity < Data
    % DataConnectivity A data connectivity matrix
    % DataConnectivity implements Data and serves as a container for matrix
    % type data.
    % It is a subclass of Data.
    %
    % DataConnectivity implements Data and serves as a container for matrix
    % type data. It checks if the value of the data being saved is numeric
    % and has the same dimensions as the Brain Atlas.
    %
    % DataConnectivity methods:
    %   DataConnectivity        - Constructor
    %   setValue                - set value
    %   getDataPanel            - returns data panel
    %
    % DataConnectivity static mehtods
    %   getClass                - returns the class
    %   getName                 - returns the name of the class
    %   getDescription          - returns the description of the class
    %   getAvailableSettings    - returns the available settings
    %
    % See also Data, DataFunctional, DataScalar, DataStructural.
    
    methods
        function d = DataConnectivity(atlas, value, varargin)
            % DATACONNECTIVITY(ATLAS, VALUE) creates DataConnectivity
            % object and calls for the superclass.
            %
            % See also Data, DataFunctional, DataScalar, DataStructural.
            
            if nargin < 2
                value = zeros(atlas.getBrainRegions().length(), atlas.getBrainRegions().length());
            end
                        
            d = d@Data(atlas, value, varargin{:});
        end
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
            assert(isnumeric(value) && isequal(size(value), [regionnumber, regionnumber]), ...
                [BRAPH2.STR ':DataConnectivity:' BRAPH2.WRONG_INPUT], ...
                [ ...
                'The value of DataConnectivity must be a connectivity matrix ' ...
                'with the same number of rows and columns as the BrainAtlas, ' ...
                'in this case ' int2str(regionnumber) ' rows x ' int2str(regionnumber) ' columns' ...
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
            
            data_class = 'DataConnectivity';
        end
        function name = getName()
            % GETNAME returns the name of the data
            %
            % NAME = GETNAME(D) returns the name of the data.
            % 
            % See also getClass, getDescription, getAvailableSettings.
            
            name = 'Connectivity Matrix';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the data
            %
            % DESCRIPTION = GETDESCRIPTION(D) returns the description of
            % the data.
            % 
            % See also getClass, getName, getAvailableSettings.
            
            description = [ ...
                'A precalculated connectivity matrix.' ...
                ]; %#ok<NBRAK>
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