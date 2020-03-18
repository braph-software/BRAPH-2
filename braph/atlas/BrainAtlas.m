classdef BrainAtlas < handle & matlab.mixin.Copyable
    % BrainAtlas < handle & matlab.mixin.Copyable: A brain atlas
    % BrainAtlas represents a collection of brain regions. 
    %
    % BrainAtlas properties (GetAccess=protected, SetAccess=protected):
    %   name    -   name of the brain atlas.
    %   brdict  -   dictionary with brain regions
    %                  (key, value) = (int32, brain region)
    %
    % BrainAtlas methods (Access=protected)
    %   copyElement - deep copy community structure.
    %
    % BrainAtlas methods:
    %   BrainAtlas  -   Constructor.
    %   tostring    -   returns a string representing the brain atlas.
    %   disp        -   displays the brain atlas.
    %   getName     -   returns the name of the brain atlas.
    %   brainregionnumber     -   returns the number regions inside the
    %                             atlas.
    %   contains_brain_region -   boolean, checks if the atlas contains the 
    %                             brain region.
    %   getBrainRegion        -   returns a brain region.
    %   getBrainRegions       -   returns all brain regions.
    %   getBrainRegionLabels  -   returns the label of all brain regions.
    %   getBrainRegionXs      -   return the x coordiante of all brain
    %                             regions.
    %   getBrainRegionYs      -   return the y coordiante of all brain
    %                             regions.
    %   getBrainRegionZs      -   return the z coordiante of all brain
    %                             regions.
    %   getBrainRegionPositions -   return the positions of all brain
    %                               regions.
    %   addBrainRegion        -   adds a brain region to the brain atlas.
    %   removeBrainRegion     -   removes a brain region from the brain
    %                             atlas.
    %   replaceBrainRegion    -   replaces a brain region from the brain
    %                             atlas.
    %   invertBrainRegions    -   inverts the position of two brain regions
    %                             inside the brain atlas.
    %   movetoBrainRegion     -   moves a brain region to a specified
    %                             position inside the brain atlas.
    %   removeBrainRegions    -   remove selected brain regions from the
    %                             brain atlas.
    %   addaboveBrainRegions  -   adds empty brain regions above the selected
    %                             brain regions in the brain atlas.
    %   addbelowBrainRegions  -   adds empty brain regions below the selected
    %                             brain regions in  the brain atlas.
    %   moveupBrainRegions    -   moves up selected brain regions in the
    %                             brain atlas.
    %   movedownBrainRegions  -   moves down selected brain regions in the
    %                             bain atlas.
    %   move2topBrainRegions  -   moves the selected brain regions to the 
    %                             top of the brain atlas.
    %   move2bottomBrainRegions - moves the selected brain regions to the
    %                             bottom of the brain atlas. 
    %
    % See also BrainRegion
    
    properties (GetAccess=protected, SetAccess=protected) 
        name  % brain atlas name
        brdict  % dictionary with brain regions
    end
    methods (Access=protected)
        function atlas_copy = copyElement(atlas)
            % COPYELEMENT(ATLAS) copies elements of brain atlas.
            %
            % ATLAS_COPY = COPYELEMENT(ATLAS) copies elements of the brain
            % atlas ATLAS.  Makes a deep copy of the structure of the brain
            % atlas.
            %
            % See also Cohort, Graph.
            
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
            % BrainAtlas(NAME, BRAINREGIONS) creates a brain atlas with
            % given name NAME and initializes the dictionary BRDICT with
            % given brain regions BRAIN_REGIONS.
            %
            % See also BrainRegion.
            
            % brain_regions must be a cell array of BrainRegion            
            assert(iscell(brain_regions), ...
                ['BRAPH:BrainAtlas:BrainRegionsErr'], ...
                ['The input brain regions should be a cell array of BrainRegion']) %#ok<NBRAK>
            
            % initialization of properties
            atlas.name = name;            
            atlas.brdict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            for i = 1:1:length(brain_regions)
                atlas.addBrainRegion(brain_regions{i}, i);
            end
        end
        function str = tostring(atlas)
            % TOSTRING string with information about the brain atlas
            %
            % STR = TOSTRING(ATLAS) returns string with the brain altas name
            % and brain atlas size.
            %
            % See also disp().
            
            str = [class(atlas) ' ' atlas.getName() ' with ' int2str(atlas.brainregionnumber()) ' brain regions'];
        end
        function disp(atlas)
            % TOSTRING displays information about the brain atlas
            %
            % DISP(ATLAS) displays information about the brain altas name,
            % class, size. Brain regions key, label, name and position.
            %
            % See also tostring().
            
            disp(['<a href="matlab:help ' class(atlas) '">' class(atlas) '</a>'])
            disp([' size: ' int2str(atlas.brainregionnumber()) ' brain regions'])
            disp([' brain regions:']); %#ok<NBRAK>
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                disp(['  ' int2str(i) ' - ' br.getLabel() ' ' br.getName() ' ' mat2str(br.getPosition())]);
            end
        end
        function name = getName(atlas)
            % GETNAME returns the name of the brain atlas.
            %
            % STRING = GETNAME(ATLAS) returns the name of the brain atlas.
            %
            % See also brainregionnumber().
            
            name = atlas.name;
        end
        function n = brainregionnumber(atlas)
            % BRAINREGIONNUMBER returns the number of the brain regions.
            %
            % N = BRAINREGIONUMBER(ATLAS) returns the number of the brain
            % regions in BRDICT.
            %
            % See also brainregionnumber().
            
            n = length(atlas.brdict);
        end
        function bool = contains_brain_region(atlas, br_index)
            % CONTAINS_BRAIN_REGION checks if the brain atlas dictionary 
            % contains a brain region.
            %
            % BOOL = CONTAINS_BRAIN_REGION(ATLAS, BR_INDEX) returns true if
            % a brain region exists in the brain atlas dictionary BRDICT.
            %
            % See also getBrainRegion().
            
            bool = isKey(atlas.brdict, br_index);
        end
        function br = getBrainRegion(atlas, br_index)
            % GETBRAINREGION returns the brain region.
            %
            % BRAINREGION = GETBRAINREGION(ATLAS, BRINDEX) returns the
            % brain region indicated with BRINDEX from the dictionary
            % BRDICT.
            %
            % See also contains_brain_region().
            
            br = atlas.brdict(br_index);
        end
        function brain_regions = getBrainRegions(atlas)
            % GETBRAINREGIONS returns all brain regions.
            %
            % BRAINREGIONS = GETBRAINREGIONS(ATLAS) returns all the
            % brain regions from the dictionary the BRDICT.
            %
            % See also getBrainRegionLabels().
            
            brain_regions = values(atlas.brdict);
        end
        function br_labels = getBrainRegionLabels(atlas)
            % GETBRAINREGIONLABELS returns all brain region labels.
            %
            % ARRAY(LABEL) = GETBRAINREGIONLABELS(ATLAS) returns all the
            % brain regions labels from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainNames().
            
            br_labels = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_labels{i} = br.getLabel();
            end
        end
        function br_names = getBrainRegionNames(atlas)
            % GETBRAINREGIONNAMES returns all brain region names.
            %
            % ARRAY(STRING) = GETBRAINREGIONNAMES(ATLAS) returns all the
            % brain regions names from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainLabels()
            
            br_names = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_names{i} = br.getName();
            end
        end
        function br_xs = getBrainRegionXs(atlas)
            % GETBRAINREGIONXS returns all brain region x coordinates.
            %
            % ARRAY(DOUBLE) = GETBRAINREGIONXS(ATLAS) returns all the
            % brain regions x coordinates from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainLabels().
            
            br_xs = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_xs{i} = br.getX();
            end
        end
        function br_ys = getBrainRegionYs(atlas)
            % GETBRAINREGIONYS returns all brain region y coordinates.
            %
            % ARRAY(DOUBLE) = GETBRAINREGIONYS(ATLAS) returns all the
            % brain regions y coordinates from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainLabels().
            
            br_ys = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_ys{i} = br.getY();
            end
        end
        function br_zs = getBrainRegionZs(atlas)
            % GETBRAINREGIONZS returns all brain region z coordinates.
            %
            % ARRAY(DOUBLE) = GETBRAINREGIONZS(ATLAS) returns all the
            % brain regions z coordinates from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainLabels().
            
            br_zs = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_zs{i} = br.getZ();
            end
        end
        function br_positions = getBrainRegionPositions(atlas)
            % GETBRAINREGIONPOSITIONS returns all brain region positions.
            %
            % ARRAY(DOUBLE) = GETBRAINREGIONPOSITIONS(ATLAS) returns all the
            % brain regions positions from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainLabels().
            
            br_positions = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_positions{i} = br.getPosition();
            end
        end
        function addBrainRegion(atlas, br, i)
            % ADDBRAINREGION adds a brain region.
            %
            % ADDBRAINREGION(ATLAS, BRAINREGION, INDEX) adds a brain region
            % to the brain atlas dictionary BRDICT specified INDEX. If INDEX 
            % is empty it adds it to the end of BRDICT by default.
            %
            % See also removeBrainRegion(), replaceBrainRegion().
            
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
            end
            atlas.brdict(i) = br;
        end
        function removeBrainRegion(atlas, i)
            % REMOVEBRAINREGION adds a brain region.
            %
            % REMOVEBRAINREGION(ATLAS, INDEX) removes a brain region
            % from the brain atlas dictionary BRDICT specified INDEX. 
            %
            % See also addBrainRegion(), replaceBrainRegion().
            
            for j = i:1:atlas.brainregionnumber()-1
                atlas.brdict(j) = atlas.brdict(j+1);
            end
            remove(atlas.brdict, atlas.brainregionnumber());
        end
        function replaceBrainRegion(atlas, i, br)
            % REPLACEBRAINREGION replaces a brain region.
            %
            % REPLACEBRAINREGION(ATLAS, INDEX, BRAINREGION) replaces the
            % brain region at the INDEX position.
            %
            % See also addBrainRegion(), removeBrainRegion().

            assert(isa(br, 'BrainRegion'), ...
                    'BRAPH:BrainAtlas:ObjectNotBR', ...
                    'Only BrainRegion objects can be added to a BrainAtlas' ...
                    )
            
            if i > 0 || i <= atlas.brainregionnumber()
                atlas.brdict(i) = br;
            end
            
        end
        function invertBrainRegions(atlas, i, j)
            % INVERTBRAINREGIONS invert position of two brain regions.
            %
            % INVERTBRAINREGIONS(ATLAS, INDEXI, INDEXJ) inverts the
            % position of a brain region at INDEXI with the position of a
            % brain region at INDEXJ.  
            %
            % See also addBrainRegion(), replaceBrainRegion().
            
            if i > 0 && i <= atlas.brainregionnumber() && j > 0 && j <= atlas.brainregionnumber() && i ~= j
                br_i = atlas.getBrainRegion(i);
                br_j = atlas.getBrainRegion(j);
                atlas.replaceBrainRegion(i, br_j)
                atlas.replaceBrainRegion(j, br_i)
            end
        end
        function movetoBrainRegion(atlas, i, j)
            % MOVETOBRAINREGION move a brain region to another position.
            %
            % MOVETOBRAINREGION(ATLAS, INDEXI, INDEXJ) moves a brain region
            % from position INDEXI to position INDEXJ.
            %
            % See also addBrainRegion(), replaceBrainRegion().
            
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
            % REMOVEBRAINREGIONS removes selected brain regions.
            %
            % SELECTED = REMOVEBRAINREGIONS(ATLAS, SELECTED) removes all
            % brain regions whose positions in ATLAS are included in the
            % array SELECTED. It returns an empty array.
            %
            % See also addaboveBrainRegions(), addbelowBrainRegions().
            
            for i = length(selected):-1:1
                atlas.removeBrainRegion(selected(i))
            end
            selected = [];
        end
        function [selected, added] = addaboveBrainRegions(atlas, selected)
            % ADDABOVEBRAINREGIONS adds brain regions above a selection.
            %
            % [SELECTED, ADDED] = ADDABOVEBRAINREGIONS(ATLAS, SELECTED) adds new
            % brain regions with default initialization above the selected
            % positions in the array SELECTED. It returns a new reshaped 
            % array of SELECTED and the new brain regions ADDED.
            %
            % See also removeBrainRegions(), addbelowBrainRegions().
            
            for i = length(selected):-1:1
                atlas.addBrainRegion(BrainRegion(), selected(i))
            end
            selected = selected + reshape(1:1:numel(selected), size(selected));
            added = selected - 1;
        end
        function [selected, added] = addbelowBrainRegions(atlas, selected)
            % ADDBELOWBRAINREGIONS adds brain regions below a selection.
            %
            % [SELECTED, ADDED] = ADDBELOWBRAINREGIONS(ATLAS, SELECTED) adds
            % new brain regions with default initialization below the selected
            % positions in the array SELECTED. It returns a new reshaped 
            % array of SELECTED and the new brain regions ADDED.
            %
            % See also removeBrainRegions(), addaboveBrainRegions().
            
            for i = length(selected):-1:1
                atlas.addBrainRegion(BrainRegion(), selected(i) + 1)
            end
            selected = selected + reshape(0:1:numel(selected)-1, size(selected));
            added = selected + 1;
        end
        function selected = moveupBrainRegions(atlas, selected)
            % MOVEUPBRAINREGIONS moves up selected brain regions.
            %
            % SELECTED = MOVEUPBRAINREGIONS(ATLAS, SELECTED) moves up by one
            % position all brain regions whose positions in ATLAS are included
            % in the SELECTED array and returns their final positions.
            %
            % See also movedownBrainRegions().
            
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
            % MOVEDOWNBRAINREGIONS moves down selected brain regions.
            %
            % SELECTED = MOVEDOWNBRAINREGIONS(ATLAS, SELECTED) moves down by
            % one position all brain regions whose positions in ATLAS are included
            % in the SELECTED array and returns their final positions.
            %
            % See also movedownBrainRegions().
            
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
            % MOVE2TOPBRAINREGIONS moves selected brain regions to top
            %
            % SELECTED = MOVE2TOPBRAINREGIONS(ATLAS, SELECTED) moves to top
            % all brain regions whose positions in the ATLAS dictionary are 
            % included in the SELECTED array and returns their final positions.
            %
            % See also move2bottomBrainRegions().
            
            if ~isempty(selected)
                for i = 1:1:numel(selected)
                    atlas.movetoBrainRegion(selected(i), i);
                end
                selected = reshape(1:1:numel(selected), size(selected));
            end
        end
        function selected = move2bottomBrainRegions(atlas, selected)
            % MOVE2BOTTOMBRAINREGIONS moves selected brain regions to top
            %
            % SELECTED = MOVE2BOTTOMBRAINREGIONS(ATLAS, SELECTED) moves to 
            % bottom all brain regions whose positions in the ATLAS dictionary are 
            % included in the SELECTED array and returns their final positions.
            %
            % See also move2bottomBrainRegions().
            
            if ~isempty(selected)
                for i = numel(selected):-1:1
                    atlas.movetoBrainRegion(selected(i), atlas.brainregionnumber() - (numel(selected)-i));
                end
                selected = reshape(atlas.brainregionnumber() - numel(selected)+1:1:atlas.brainregionnumber(), size(selected));
            end
        end
    end
end
