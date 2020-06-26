classdef DataStructural < Data
    methods
        function d = DataStructural(atlas, value, varargin)
            
            if nargin < 2
                value = zeros(atlas.getBrainRegions().length(), 1);
            end
            
            d = d@Data(atlas, value, varargin{:});
        end
    end
    methods
        function setValue(d, value)
                        
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
            data_class = 'DataStructural';
        end
        function name = getName()
            name = 'Structural Brain Data';
        end
        function description = getDescription()
            description = [ ...
                'A series of structural data corresponding ' ...
                'to one scalar value per brain region.' ...
                ];
        end
         function available_settings = getAvailableSettings(d) %#ok<INUSD>
            available_settings = {};
        end
    end  
end