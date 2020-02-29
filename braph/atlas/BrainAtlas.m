classdef BrainAtlas < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected) 
        name  % brain atlas name
        brdict  % dictionary with brain regions
    end
    methods (Access=protected)
        function atlas_copy = copyElement(atlas)
            
            % Make a shallow copy
            atlas_copy = copyElement@matlab.mixin.Copyable(atlas);
            
            % Make a deep copy of brdict
            atlas_copy.brdict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            brain_regions = values(atlas.brdict);
            for i = 1:1:length(brain_regions)
                br = brain_regions{i};
                atlas_copy.brdict(i) = br.copy();
            end
        end        
    end        
    methods
        function atlas = BrainAtlas(name, brain_regions)
            % brain_regions must be a cell array of BrainRegion
            
            atlas.name = name;
            
            atlas.brdict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            for i = 1:1:length(brain_regions)
                atlas.addBrainRegion(brain_regions{i}, i);
            end
        end
        function str = tostring(atlas)
            str = [class(atlas) ' ' atlas.getName() ' with ' int2str(atlas.brainregionnumber()) ' brain regions'];
        end
        function disp(atlas)
            disp(['<a href="matlab:help ' class(atlas) '">' class(atlas) '</a>'])
            disp([' size: ' int2str(atlas.brainregionnumber()) ' brain regions'])
            disp([' brain regions:']); %#ok<NBRAK>
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                disp(['  ' int2str(i) ' - ' br.getLabel() ' ' br.getName() ' ' mat2str(br.getPosition())]);
            end
        end
        function name = getName(atlas)
            name = atlas.name;
        end
        function n = brainregionnumber(atlas)
            n = length(atlas.brdict);
        end
        function bool = contains_brain_region(atlas, br_index)
            bool = isKey(atlas.brdict, br_index);
        end
        function br = getBrainRegion(atlas, br_index)
            br = atlas.brdict(br_index);
        end
        function brain_regions = getBrainRegions(atlas)
            brain_regions = values(atlas.brdict);
        end
        function br_labels = getBrainRegionLabels(atlas)
            br_labels = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_labels{i} = br.getLabel();
            end
        end
        function br_names = getBrainRegionNames(atlas)
            br_names = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_names{i} = br.getName();
            end
        end
        function br_xs = getBrainRegionXs(atlas)
            br_xs = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_xs{i} = br.getX();
            end
        end
        function br_ys = getBrainRegionYs(atlas)
            br_ys = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_ys{i} = br.getY();
            end
        end
        function br_zs = getBrainRegionZs(atlas)
            br_zs = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_zs{i} = br.getZ();
            end
        end
        function br_positions = getBrainRegionPositions(atlas)
            br_positions = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_positions{i} = br.getPosition();
            end
        end
        function addBrainRegion(atlas, br, i)
            
            if nargin < 3 || i < 0 || i > atlas.brainregionnumber()
                i = atlas.brainregionnumber() + 1;
            end

            assert(isa(br, 'BrainRegion'), ...
                    'BRAPH:BrainAtlas:ObjectNotBR', ...
                    'Only BrainRegion objects can be added to a BrainAtlas' ...
                    )
            
            if i <= atlas.brainregionnumber()
                for j = atlas.brainregionnumber():-1:i
                    atlas.brdict(j+1) = atlas.brdict(j);
                end
                atlas.brdict(i) = br;
            else
                atlas.brdict(i) = br;
            end
        end
        function removeBrainRegion(atlas, i)
            
            for j = i:1:atlas.brainregionnumber()-1
                atlas.brdict(j) = atlas.brdict(j+1);
            end
            remove(atlas.brdict, atlas.brainregionnumber());
        end
        function replaceBrainRegion(atlas, i, br)

            assert(isa(br, 'BrainRegion'), ...
                    'BRAPH:BrainAtlas:ObjectNotBR', ...
                    'Only BrainRegion objects can be added to a BrainAtlas' ...
                    )
            
            if i > 0 || i <= atlas.brainregionnumber()
                atlas.brdict(i) = br;
            end
            
        end
        function invertBrainRegions(atlas, i, j)
            
            if i > 0 && i <= atlas.brainregionnumber() && j > 0 && j <= atlas.brainregionnumber() && i ~= j
                br_i = atlas.getBrainRegion(i);
                br_j = atlas.getBrainRegion(j);
                atlas.replaceBrainRegion(i, br_j)
                atlas.replaceBrainRegion(j, br_i)
            end
        end
        function movetoBrainRegion(atlas, i, j)
            
            if i > 0 && i <= atlas.brainregionnumber() && j > 0 && j <= atlas.brainregionnumber() && i ~= j
                br = atlas.getBrainRegion(i);
                if i > j
                    atlas.removeBrainRegion(i)
                    atlas.addBrainRegion(br, j)
                else  % j < i
                    atlas.addBrainRegion(br, j+1)
                    atlas.removeBrainRegion(i)
                end
            end            
        end
        function selected = removeBrainRegions(atlas, selected)
            
            for i = length(selected):-1:1
                atlas.removeBrainRegion(selected(i))
            end
            selected = [];
        end
        function [selected, added] = addaboveBrainRegions(atlas, selected)
            
            for i = length(selected):-1:1
                atlas.addBrainRegion(BrainRegion(), selected(i))
            end
            selected = selected + reshape(1:1:numel(selected), size(selected));
            added = selected - 1;
        end
        function [selected, added] = addbelowBrainRegions(atlas, selected)
            
            for i = length(selected):-1:1
                atlas.addBrainRegion(BrainRegion(), selected(i) + 1)
            end
            selected = selected + reshape(0:1:numel(selected)-1, size(selected));
            added = selected + 1;
        end
        function selected = moveupBrainRegions(atlas, selected)
            
            if ~isempty(selected)
                
                first_index_to_process = 1;
                unprocessable_length = 1;
                while first_index_to_process <= atlas.brainregionnumber() ...
                        && first_index_to_process <= numel(selected) ...
                        && selected(first_index_to_process) == unprocessable_length
                    first_index_to_process = first_index_to_process + 1;
                    unprocessable_length = unprocessable_length + 1;
                end

                for i = first_index_to_process:1:numel(selected)
                    atlas.invertBrainRegions(selected(i), selected(i)-1);
                    selected(i) = selected(i) - 1;
                end
            end
        end
        function selected = movedownBrainRegions(atlas, selected)
            
            if ~isempty(selected)

                last_index_to_process = numel(selected);
                unprocessable_length = atlas.brainregionnumber();
                while last_index_to_process > 0 ...
                        && selected(last_index_to_process) == unprocessable_length
                    last_index_to_process = last_index_to_process - 1;
                    unprocessable_length = unprocessable_length - 1;
                end

                for i = last_index_to_process:-1:1
                    atlas.invertBrainRegions(selected(i), selected(i) + 1);
                    selected(i) = selected(i) + 1;
                end
            end
        end
        function selected = move2topBrainRegions(atlas, selected)
            
            if ~isempty(selected)
                for i = 1:1:numel(selected)
                    atlas.movetoBrainRegion(selected(i), i);
                end
                selected = reshape(1:1:numel(selected), size(selected));
            end
        end
        function selected = move2bottomBrainRegions(atlas, selected)
            
            if ~isempty(selected)
                for i = numel(selected):-1:1
                    atlas.movetoBrainRegion(selected(i), atlas.brainregionnumber() - (numel(selected)-i));
                end
                selected = reshape(atlas.brainregionnumber() - numel(selected)+1:1:atlas.brainregionnumber(), size(selected));
            end
        end
    end
end