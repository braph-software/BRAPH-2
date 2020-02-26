classdef DataScalar < Data
    methods
        function d = DataScalar(value)
            
            if nargin < 1
                value = 0;
            end
            
            assert(isnumeric(value) && numel(value)==1, ...
                'BRAPH:DataScalar:WrongValue', ...
                'The value of DataScalar must be a scalar')
            
            d = d@Data(value);
        end
    end
    methods (Static)
        function data_class = getClass()
            data_class = 'DataScalar';
        end
        function name = getName()
            name = 'Scalar Value';
        end
        function description = getDescription()
            description = [ ...
                'A single number representing a scalar value.' ...
                ];
        end
    end  
end