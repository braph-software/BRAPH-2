classdef DataScalar < Data
    methods
        function d = DataScalar(value, label)
            
            if nargin < 2
                label = 'scalar';
            end
            
            assert(isnumeric(value) && numel(value)==1, ...
                'BRAPH:DataScalar:WrongValue', ...
                'The value of DataScalar must be a scalar')
            
            d = d@Data(value, label);
        end
    end
end