classdef BrainAtlas < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected) 
        name  % brain atlas name
        brdict  % dictionary with brain regions
    end
    methods
        function ba = BrainAtlas(name, brain_regions)
            % brain_regions must be a cell array of BrainRegion
            
            ba.name = name;
            
            ba.brdict = containers.Map;
            for i = 1:1:length(brain_regions)
                br = brain_regions{i};
                ba.brdict(br.getLabel()) = br;
            end
        end
        function str = tostring(ba)
            str = [class(ba) ' ' ba.getName() ' with ' int2str(ba.brainregionnumber()) ' brain regions'];
        end
        function disp(ba)
            disp(['<a href="matlab:help ' class(ba) '">' class(ba) '</a>'])
            disp([' size: ' int2str(ba.brainregionnumber()) ' brain regions'])
            disp([' brain regions:']); %#ok<NBRAK>
            
        end
        function name = getName(ba)
            name = ba.name;
        end
        function n = brainregionnumber(ba)
            n = length(ba.brdict);
        end
        function bool = contains_brain_region(ba, label)
            bool = isKey(ba.brdict, label);
        end
        function br = getBrainRegion(ba, label)
            br = ba.brdict(label);
        end
        function brain_regions = getBrainRegions(ba)
            brain_regions = values(ba.brdict);
        end
        function brain_region_labels = getBrainRegionLabels(ba)
            brain_region_labels = keys(ba.brdict);
            
        end
    end
end