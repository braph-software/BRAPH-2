classdef Data < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        label  % data label
        value  % data value
    end
    methods (Access=protected)
        function d = data(value, label)
                        
            d.label = tostring(label);
            d.value = value;
        end
    end
    methods
        function label = getLabel(d)
            label = d.label;
        end
        function value = getValue(d)
            value = d.value;
        end
    end
end