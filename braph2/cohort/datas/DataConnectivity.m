classdef DataConnectivity < Data
    methods
        function d = DataConnectivity(atlas, value, varargin)
            
            if nargin < 2
                value = zeros(atlas.getBrainRegions().length(), atlas.getBrainRegions().length());
            end
                        
            d = d@Data(atlas, value, varargin{:});
        end
    end
    methods
        function setValue(d, value)

            regionnumber = d.getBrainAtlas().getBrainRegions().length();
            assert(isnumeric(value) && isequal(size(value), [regionnumber, regionnumber]), ...
                [BRAPH2.STR ':DataConnectivity:' BRAPH2.WRONG_INPUT], ...
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
        function available_settings = getAvailableSettings(d) %#ok<INUSD>
            available_settings = {
                {'DataConnectivity.Gender', BRAPH2.STRING, 'female', {'female', 'male', 'another'}}, ...
                {'DataConnectivity.LevelEducation', BRAPH2.STRING, 'unkown', {'unkown', 'bachelor', 'master', 'phd', 'another'}}, ...
                };
        end
    end  
end