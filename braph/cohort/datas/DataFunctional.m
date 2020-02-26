classdef DataFunctional < Data
    methods
        function d = DataFunctional(atlas, value)
            
            if nargin < 2
                value = zeros(atlas.brainregionnumber(), 10);
            end
            
            assert(isnumeric(value) && size(value, 1)==atlas.brainregionnumber(), ...
                'BRAPH:DataFunctional:WrongValue', ...
                [ ...
                'The value of DataFunctional must be a matrix ' ...
                'with the same number of rows as the BrainAtlas, ' ...
                'in this case ' mat2str(atlas.brainregionnumber()) 'rows' ...
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