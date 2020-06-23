classdef DataFunctional < Data
    methods
        function d = DataFunctional(atlas, value)
            
            if nargin < 2
                value = zeros(atlas.getBrainRegions().length(), 10);
            end
            
            d = d@Data(atlas, value);
        end
    end
    methods
        function setValue(d, value)
            
            regionnumber = d.getBrainAtlas().getBrainRegions().length();
            assert(isnumeric(value) && size(value, 1)==regionnumber, ...
                [BRAPH2.STR ':DataFunctional:' BRAPH2.WRONG_INPUT], ...
                [ ...
                'The value of DataFunctional must be a matrix ' ...
                'with the same number of rows as the BrainAtlas, ' ...
                'in this case ' int2str(regionnumber) ' rows' ...
                ])
            
            d.value = value;
        end
    end
    methods (Static)
        function data_class = getClass()
            data_class = 'DataFunctional';
        end
        function name = getName()
            name = 'Functional Brain Data';
        end
        function description = getDescription()
            description = [ ...
                'A series of functional data corresponding ' ...
                'to one timeseries per brain region.' ...
                ];
        end
    end  
end