classdef BrainAtlas < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected) 
        name  % brain atlas name
    end
    methods
        function ba = BrainAtlas(name, regions)
            ba.name = name;
            
        end
    end
end