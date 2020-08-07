classdef DataScalar < Data
    % DataScalar A scalar data
    % DataScalar implements Data and serves as a container for scalar
    % type data.
    % It is a subclass of Data.
    %
    % DataScalar implements Data and serves as a container for scalar
    % type data. It checks if the value of the data being saved is numeric
    % and has the same dimensions as the Brain Atlas.
    %
    % DataScalar methods:
    %   DataScalar              - Constructor
    %
    % DataScalar abstract methods:
    %   setValue                - checks the value and sets it to DataConnectivity
    %
    % DataScalar static mehtods
    %   getClass                - returns the class
    %   getName                 - returns the name of the class
    %   getDescription          - returns the description of the class
    %   getAvailableSettings    - returns the available settings
    %
    % See also Data, DataFunctional, DataConnectivity, DataStructural.
    properties
        h_panel
    end
    methods
        function d = DataScalar(atlas, value, varargin)
            % DATASCALAR(ATLAS, VALUE) creates DataScalar object and calls
            % for the superclass.
            %
            % See also Data, DataFunctional, DataConnectivity, DataStructural.
            
            if nargin < 2
                value = 0;
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
            
            assert(isnumeric(value) && numel(value)==1, ...
                [BRAPH2.STR ':DataScalar:' BRAPH2.WRONG_INPUT], ...
                'The value of DataScalar must be a scalar.')

            d.value = value;
        end
        function h = getDataPanel(d, parent, varargin)
            title = get_from_varargin('Age', 'Title', varargin{:});
            
            
            value_holder = d.value;
            d.h_panel = uicontrol('Parent', parent);
            set(d.h_panel, 'Style', 'Text')
            set(d.h_panel, 'Units', 'normalized')
            set(d.h_panel, 'Position', [0.001 0.001 1 1])
            set(d.h_panel, 'String', [title ': ' num2str(value_holder)])
            
             if nargout > 0
                h = d.h_panel;
            end   
        end
    end
    methods (Static)
        function data_class = getClass()
            % GETCLASS returns the class of the data 
            %
            % DATA_CLASS = GETCLASS() returns the class of the data.
            %
            % See also  getName, getDescription, getAvailableSettings.
            
            data_class = 'DataScalar';
        end
        function name = getName()
            % GETNAME returns the name of the data
            %
            % NAME = GETNAME(D) returns the name of the data.
            % 
            % See also getClass, getDescription, getAvailableSettings.
            
            name = 'Scalar Value';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the data
            %
            % DESCRIPTION = GETDESCRIPTION(D) returns the description of
            % the data.
            % 
            % See also getClass, getName, getAvailableSettings.
            
            description = [ ...
                'A single number representing a scalar value.' ...
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