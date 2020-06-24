classdef DataScalar < Data
    methods
        function d = DataScalar(atlas, value)
            
            if nargin < 2
                value = 0;
            end
            
            d = d@Data(atlas, value);
        end
    end
    methods
        function setValue(d, value)
                        
            assert(isnumeric(value) && numel(value)==1, ...
                [BRAPH2.STR ':DataScalar:' BRAPH2.WRONG_INPUT], ...
                'The value of DataScalar must be a scalar.')

            d.value = value;
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
                ]; %#ok<NBRAK>
        end
        function available_settings = getAvailableSettings(d) %#ok<INUSD>
            available_settings = {
                {'DataScalar.Gender', BRAPH2.STRING, 'female', {'female', 'male', 'another'}}, ...
                {'DataScalar.LevelEducation', BRAPH2.STRING, 'unkown', {'unkown', 'bachelor', 'master', 'phd', 'another'}}, ...
                };
        end
    end  
end