classdef DataString < Data
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
        function d = DataString(atlas, value, varargin)
            % DATACONNECTIVITY(ATLAS, VALUE) creates DataConnectivity
            % object and calls for the superclass.
            %
            % See also Data, DataFunctional, DataScalar, DataStructural.
            
            if nargin < 2
                value = '';
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
            % See also getValue, getDataPanel.
            
           
            assert(ischar(value), ...
                [BRAPH2.STR ':DataString:' BRAPH2.WRONG_INPUT], ...
                [ ...
                'The value of DataString must be a string ' ...
                'with value male, female or other. ' ...
                ])
            
            d.value = value;
        end
        function h = getDataPanel(d, ui_parent)
            % GETDATAPANEL creates a uitable and returns it
            %
            % GETDATAPANEL(D, UIPARENT) creates a uitable with D values and
            % sets the uitable to the UIPARENT.
            %
            % See also setValue.            
            
            h_panel = uicontrol('Parent', ui_parent, 'Units', 'normalized', ...
                'Position', [0.01 0.8 0.5 0.2]);                      
            set(h_panel, 'Style', 'edit')
            set(h_panel, 'String', '')
            set(h_panel, 'Callback', {@cb_data_string})            
            
            function cb_data_string(~, ~) 
                newdata = get(h_panel, 'String');
                d.value = newdata;
            end
            
            if nargout > 0
                h = h_panel;
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
            
            data_class = 'DataString';
        end
        function name = getName()
            % GETNAME returns the name of the data
            %
            % NAME = GETNAME(D) returns the name of the data.
            %
            % See also getClass, getDescription, getAvailableSettings.
            
            name = 'String';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of the data
            %
            % DESCRIPTION = GETDESCRIPTION(D) returns the description of
            % the data.
            %
            % See also getClass, getName, getAvailableSettings.
            
            description = [ ...
                'String.' ...
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
        function data_structure = getDataStructure()
            data_structure = 'char';
        end
    end    
end