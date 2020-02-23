classdef BrainAtlas < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected) 
        name  % brain atlas name
        brdict  % dictionary with brain regions
    end
    methods
        function ba = BrainAtlas(name, brain_regions)
            
            ba.name = name;
            
            ba.brdict = containers.Map;
            for i = 1:1:length(brain_regions)
                br = brain_regions(i);
                ba.brdict(br.getLabel()) = br;
            end
        end
        function name = getName(ba)
            name = ba.name;
        end
        function bool = contains_brain_region(ba, label)
            bool = isKey(ba.brdict, label);
        end
        function br = getBrainRegion(ba, label)
            br = ba.brdict(label);
        end
    end
end