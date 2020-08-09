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
    %   setValue                - set value
    %   getDataPanel            - returns data panel
    %
    % DataScalar static mehtods
    %   getClass                - returns the class
    %   getName                 - returns the name of the class
    %   getDescription          - returns the description of the class
    %   getAvailableSettings    - returns the available settings
    %
    % See also Data, DataFunctional, DataConnectivity, DataStructural.
    
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
        function setValue(d, value)
            % SETVALUE sets the value of the data into the object
            %
            % SETVALUE(D, VALUE) checks that the value of the data is
            % numeric and that it has the correct dimensions. If incorrect
            % it throws and error, if correct it sets the value to the
            % object.
            %
            % See also getValue, getDataPanel.
            
            assert(isnumeric(value) && numel(value)==1, ...
                [BRAPH2.STR ':DataScalar:' BRAPH2.WRONG_INPUT], ...
                'The value of DataScalar must be a scalar.')

            d.value = value;
        end
        function h = getDataPanel(d, ui_parent)          
            
            value_holder = d.value;
            h_panel = uicontrol('Parent', ui_parent);
            set(h_panel, 'Style', 'edit')
            set(h_panel, 'Units', 'normalized')
            set(h_panel, 'Position', [0.01 0.9 0.5 0.1])
            set(h_panel, 'String', value_holder)
            set(h_panel, 'Callback', {@cb_edit_scalar})
            
            function cb_edit_scalar(~, ~)
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