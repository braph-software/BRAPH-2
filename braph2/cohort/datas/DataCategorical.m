classdef DataCategorical < Data
    methods
        function d = DataCategorical(atlas, value, varargin)
            
            if nargin < 2
                value = zeros(atlas.getBrainRegions().length(), atlas.getBrainRegions().length());
            end
                        
            d = d@Data(atlas, value, varargin{:});
        end
    end
    methods
        function setValue(d, value)

            regionnumber = d.getBrainAtlas().getBrainRegions().length();
            assert(isequal(size(value, 1), regionnumber), ...
                [BRAPH2.STR ':DataCategorical:' BRAPH2.WRONG_INPUT], ...
                [ ...
                'The value of DataCategorical must  must be a cell ' ...
                'with the same number of rows as the BrainAtlas, ' ...
                'in this case ' int2str(regionnumber) ' rows' ...
                ])

            d.value = value;
        end
    end
    methods (Static)
        function data_class = getClass()
            data_class = 'DataCategorical';
        end
        function name = getName()
            name = 'Categorical Data';
        end
        function description = getDescription()
            description = [ ...
                'A cell with categorical Data.' ...
                ]; %#ok<NBRAK>
        end
        function available_settings = getAvailableSettings(d) %#ok<INUSD>
            available_settings = {
                {'DataCategorical.Gender', BRAPH2.STRING, 'female', {'female', 'male', 'other'}}, ...
                {'DataCategorical.LevelEducation', BRAPH2.STRING, 'unknown', {'unknown', 'bahcherlo', 'master', 'phd', 'other'}}, ...
                {'DataCategorical.Age', BRAPH2.NUMERIC, 0, {}}
                };
        end
    end  
end