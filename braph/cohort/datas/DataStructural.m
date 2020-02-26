classdef DataStructural < Data
    methods
        function d = DataStructural(atlas, value)
            
            if nargin < 2
                value = zeros(atlas.brainregionnumber(), 1);
            end
            
            assert(isnumeric(value) && isequal(size(value), [atlas.brainregionnumber(), 1]), ...
                'BRAPH:DataStructural:WrongValue', ...
                [ ...
                'The value of DataStructural must be a column vector ' ...
                'with the same number of element as the BrainAtlas, ' ...
                'in this case ' mat2str(atlas.brainregionnumber()) ...
                ])
            
            d = d@Data(atlas, value);
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
    end  
end