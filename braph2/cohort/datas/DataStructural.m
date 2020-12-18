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
    %   setValue                - set value
    %   getDataPanel            - returns data panel
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
        function setValue(d, value)
            % SETVALUE sets the value of the data into the object
            %
            % SETVALUE(D, VALUE) checks that the value of the data is
            % numeric and that it has the correct dimensions. If incorrect
            % it throws and error, if correct it sets the value to the
            % object.
            %
            % See also getValue, getDataPanel.
            
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
        function h = getDataPanel(d, ui_parent)
            % GETDATAPANEL creates a uitable and returns it
            %
            % GETDATAPANEL(D, UIPARENT) creates a uitable with D values and
            % sets the uitable to the UIPARENT.
            %
            % See also setValue.
            
                value_holder = d.value;
                h_panel = uitable('Parent', ui_parent);
                
                % rownames
                atlas = d.atlas;
                brs = atlas.getBrainRegions().getValues();
                for j = 1:1:length(brs)
                    br = brs{j};
                    RowName{j} = br.getID(); %#ok<AGROW>
                end
                
                set(h_panel, 'Units', 'normalized')
                set(h_panel, 'Position', [0 0 1 1])
                set(h_panel, 'ColumnFormat', {'numeric'})
                set(h_panel, 'ColumnEditable', true)
                set(h_panel, 'RowName', RowName)
                set(h_panel, 'Data', value_holder)
                set(h_panel, 'CellEditCallback', {@cb_data_table})

            function cb_data_table(~, event)
                m = event.Indices(1);
                col = event.Indices(2);
                newdata = event.NewData;
                d.value(m, col) = newdata;
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
        function data_structure = getDataStructure()
            data_structure = 'matrix';
        end
    end  
end