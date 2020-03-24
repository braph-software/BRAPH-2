classdef DataConnectivity < Data
    methods
        function d = DataConnectivity(atlas, value)
            
            if nargin < 2
                value = zeros(atlas.brainregionnumber(), atlas.brainregionnumber());
            end
                        
            d = d@Data(atlas, value);
        end
    end
    methods
        function setValue(d, value)

            regionnumber = d.getBrainAtlas().brainregionnumber();
            assert(isnumeric(value) && isequal(size(value), [regionnumber, regionnumber]), ...
                'BRAPH:DataConnectivity:WrongValue', ...
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