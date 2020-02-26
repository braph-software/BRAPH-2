classdef DataConnectivity < Data
    methods
        function d = DataConnectivity(atlas, value)
            
            if nargin < 2
                value = zeros(atlas.brainregionnumber(), atlas.brainregionnumber());
            end
            
            assert(isnumeric(value) && isequal(size(value), [atlas.brainregionnumber(), atlas.brainregionnumber()]), ...
                'BRAPH:DataConnectivity:WrongValue', ...
                [ ...
                'The value of DataConnectivity must be a connectivity matrix ' ...
                'with the same number of rows and columns as the BrainAtlas, ' ...
                'in this case ' mat2str(atlas.brainregionnumber()) ' rows x ' ...
                mat2str(atlas.brainregionnumber()) ' columns' ...
                ])
            
            d = d@Data(atlas, value);
        end
    end
    methods (Static)
        function data_class = getClass()
            data_class = 'DataConnectivity';
        end
        function name = getName()
            name = 'Connectivity Matrix';
        end
        function description = getDescription()
            description = [ ...
                'A precalculated connectivity matrix.' ...
                ]; %#ok<NBRAK>
        end
    end  
end