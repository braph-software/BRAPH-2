classdef BrainAtlas < handle & matlab.mixin.Copyable
    % BrainAtlas < handle & matlab.mixin.Copyable: A brain atlas
    % BrainAtlas represents a collection of brain regions. 
    %
    % BrainAtlas properties (GetAccess=protected, SetAccess=protected):
    %   name                    - name of the brain atlas.
    %   brdict                  - dictionary with brain regions
    %                             (key, value) = (int32, brain region)
    %
    % BrainAtlas methods (Access=protected)
    %   copyElement             - deep copy community structure.
    %
    % BrainAtlas methods:
    %   BrainAtlas              - Constructor.
    %   tostring                - returns a string representing the BrainAtlas.
    %   disp                    - displays the BrainAtlas.
    %   getName                 - returns the name of the BrainAtlas.
    %   brainregionnumber       - returns the number of regions.
    %   contains_brain_region   - boolean, checks if atlas contains BrainRegion.
    %   getBrainRegion          - returns a BrainRegion.
    %   getBrainRegions         - returns all BrainRegions.
    %   getBrainRegionLabels    - returns the label of all BrainRegions.
    %   getBrainRegionXs        - returns the x coordiante of all BrainRegions.
    %   getBrainRegionYs        - returns the y coordiante of all BrainRegions.
    %   getBrainRegionZs        - returns the z coordiante of all BrainRegions.
    %   getBrainRegionPositions - returns the positions of all BrainRegions.
    %   addBrainRegion          - adds a BrainRegion to the brain atlas.
    %   removeBrainRegion       - removes a BrainRegion from the BrainAtlas.
    %   replaceBrainRegion      - replaces a BrainRegion from the BrainAtlas.
    %   invertBrainRegions      - inverts the position of two BrainRegions.
    %   movetoBrainRegion       - moves a BrainRegion to a specified position.
    %   removeBrainRegions      - removes selected BrainRegions.
    %   addaboveBrainRegions    - adds empty BrainRegions above the selected.
    %   addbelowBrainRegions    - adds empty BrainRegions below the selected.
    %   moveupBrainRegions      - moves up selected BrainRegions.
    %   movedownBrainRegions    - moves down selected BrainRegions.
    %   move2topBrainRegions    - moves the selected BrainRegions to the top.
    %   move2bottomBrainRegions - moves the selected BrainRegions to the bottom.
    %
    % See also BrainRegion
    
    properties (GetAccess=protected, SetAccess=protected) 
        name  % BrainAtlas name
        brdict  % indexed dictionary with BrainRegions
    end
    methods (Access=protected)
        function atlas_copy = copyElement(atlas)
            % COPYELEMENT(ATLAS) deep copy of BrainAtlas
            %
            % ATLAS_COPY = COPYELEMENT(ATLAS) Makes a deep copy of the 
            % structure of the BrainAtlas.
            %
            % See also Cohort, Graph.
            
            % Make a shallow copy
            atlas_copy = copyElement@matlab.mixin.Copyable(atlas);
            
            % Make a shallow copy of brdict
            atlas_copy.brdict = copyElement@matlab.mixin.Copyable(atlas.brdict);
        end        
    end        
    methods
        function atlas = BrainAtlas(name, brain_regions)
            % BrainAtlas(NAME, BrainRegions) creates a BrainAtlas with
            % given name NAME and initializes the dictionary BRDICT with
            % given BrainRegions BRAIN_REGIONS.
            %
            % See also BrainRegion.
            
            % brain_regions must be a cell array of BrainRegion            
            assert(iscell(brain_regions), ...
                ['BRAPH:BrainAtlas:BrainRegionsErr'], ...
                ['The input brain regions should be a cell array of BrainRegion']) %#ok<NBRAK>
            
            % initialization of properties
            atlas.name = name;            
            atlas.brdict = IndexedDictionary('BrainRegion'); % containers.Map('KeyType', 'int32', 'ValueType', 'any');
            for i = 1:1:length(brain_regions)
                atlas.brdict.add(brain_regions{i}.getName(), brain_regions{i}, i);
            end
        end
        function str = tostring(atlas)
            % TOSTRING string with information about the BrainAtlas
            %
            % STRING = TOSTRING(ATLAS) returns string with the BrainAtlas name
            % and brain atlas size.
            %
            % See also disp().
            
            str = [class(atlas) ' ' atlas.getName() ' with ' int2str(atlas.brainregionnumber()) ' brain regions'];
        end
        function disp(atlas)
            % TOSTRING displays information about the brain atlas
            %
            % DISP(ATLAS) displays information about the brainaltas name,
            % class, size. BrainRegions key, label, name and position.
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
            % GETNAME returns the name of the BrainAtlas.
            %
            % NAME = GETNAME(ATLAS) returns the name of the BrainAtlas.
            %
            % See also brainregionnumber().
            
            name = atlas.name;
        end
        function n = brainregionnumber(atlas)
            % BRAINREGIONNUMBER returns the number of the BrainRegions.
            %
            % N = BRAINREGIONUMBER(ATLAS) returns the number of the brain
            % regions in BRDICT.
            %
            % See also brainregionnumber().
            
            n = atlas.brdict.length();
        end
        function bool = contains_brain_region(atlas, br_index)
            % CONTAINS_BRAIN_REGION checks BrainAtlas contains a BrainRegion.
            %
            % BOOL = CONTAINS_BRAIN_REGION(ATLAS, BR_INDEX) returns true if
            % a BrainRegion exists in the BrainAtlas dictionary BRDICT.
            %
            % See also getBrainRegion().
            
            bool = atlas.brdict.containsIndex(br_index);
        end
        function br = getBrainRegion(atlas, br_index)
            % GETBRAINREGION returns the brain region.
            %
            % BR = GETBRAINREGION(ATLAS, BRINDEX) returns the
            % BrainRegion indicated with BRINDEX from the dictionary
            % BRDICT.
            %
            % See also contains_brain_region().
            
            br = atlas.brdict.getValueFromIndex(br_index);
        end
        function brain_regions = getBrainRegions(atlas)
            % GETBRAINREGIONS returns all brain regions.
            %
            % BRS = GETBRAINREGIONS(ATLAS) returns all the
            % BrainRegions from the dictionary the BRDICT.
            %
            % See also getBrainRegionLabels().
            
            % !!!! can modify indexdictionary or like this:
            brain_regions = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                brain_regions{i} = atlas.getBrainRegion(i);
            end
        end
        function br_labels = getBrainRegionLabels(atlas)
            % GETBRAINREGIONLABELS returns all BrainRegion labels.
            %
            % BR_LABELS = GETBRAINREGIONLABELS(ATLAS) returns all the
            % BrainRegions labels from the dictionary the BRDICT.
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
            % BR_NAMES = GETBRAINREGIONNAMES(ATLAS) returns all the
            % BrainRegions names from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainLabels()
            
            br_names = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_names{i} = br.getName();
            end
        end
        function br_xs = getBrainRegionXs(atlas)
            % GETBRAINREGIONXS returns all BrainRegion x coordinates.
            %
            % BR_XS = GETBRAINREGIONXS(ATLAS) returns all the
            % BrainRegions x coordinates from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainLabels().
            
            br_xs = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_xs{i} = br.getX();
            end
        end
        function br_ys = getBrainRegionYs(atlas)
            % GETBRAINREGIONYS returns all BrainRegion y coordinates.
            %
            % BR_YS = GETBRAINREGIONYS(ATLAS) returns all the
            % BrainRegions y coordinates from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainLabels().
            
            br_ys = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_ys{i} = br.getY();
            end
        end
        function br_zs = getBrainRegionZs(atlas)
            % GETBRAINREGIONZS returns all BrainRegion z coordinates.
            %
            % BR_ZS = GETBRAINREGIONZS(ATLAS) returns all the
            % BrainRegions z coordinates from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainLabels().
            
            br_zs = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_zs{i} = br.getZ();
            end
        end
        function br_positions = getBrainRegionPositions(atlas)
            % GETBRAINREGIONPOSITIONS returns all BrainRegion positions.
            %
            % BR_POSITION = GETBRAINREGIONPOSITIONS(ATLAS) returns all the
            % BrainRegions positions from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainLabels().
            
            br_positions = cell(1, atlas.brainregionnumber());
            for i = 1:1:atlas.brainregionnumber()
                br = atlas.getBrainRegion(i);
                br_positions{i} = br.getPosition();
            end
        end
        function br_dict = getDictionary(atlas)
            br_dict = atlas.brdict;
        end
        
%         function addBrainRegion(atlas, br, i)
%             % ADDBRAINREGION adds a BrainRegion.
%             %
%             % ADDBRAINREGION(ATLAS, BrainRegion, INDEX) adds a BrainRegion
%             % to the BrainAtlas dictionary BRDICT specified INDEX. If INDEX 
%             % is empty it adds it to the end of BRDICT by default.
%             %
%             % See also removeBrainRegion(), replaceBrainRegion().
%             
%             if nargin < 3 || i < 0 || i > atlas.brainregionnumber()
%                 i = atlas.brainregionnumber() + 1;
%             end
% 
%             assert(isa(br, 'BrainRegion'), ...
%                     'BRAPH:BrainAtlas:ObjectNotBR', ...
%                     'Only BrainRegion objects can be added to a BrainAtlas' ...
%                     )
%             
%             if i <= atlas.brainregionnumber()
%                 for j = atlas.brainregionnumber():-1:i
%                     atlas.brdict(j+1) = atlas.brdict(j);
%                 end
%             end
%             atlas.brdict(i) = br;
%         end
%         function removeBrainRegion(atlas, i)
%             % REMOVEBRAINREGION adds a BrainRegion.
%             %
%             % REMOVEBRAINREGION(ATLAS, INDEX) removes a BrainRegion
%             % from the BrainAtlas dictionary BRDICT specified INDEX. 
%             %
%             % See also addBrainRegion(), replaceBrainRegion().
%             
%             for j = i:1:atlas.brainregionnumber()-1
%                 atlas.brdict(j) = atlas.brdict(j+1);
%             end
%             remove(atlas.brdict, atlas.brainregionnumber());
%         end
%         function replaceBrainRegion(atlas, i, br)
%             % REPLACEBRAINREGION replaces a BrainRegion.
%             %
%             % REPLACEBRAINREGION(ATLAS, INDEX, BrainRegion) replaces the
%             % BrainRegion at the INDEX position.
%             %
%             % See also addBrainRegion(), removeBrainRegion().
% 
%             assert(isa(br, 'BrainRegion'), ...
%                     'BRAPH:BrainAtlas:ObjectNotBR', ...
%                     'Only BrainRegion objects can be added to a BrainAtlas' ...
%                     )
%             
%             if i > 0 || i <= atlas.brainregionnumber()
%                 atlas.brdict(i) = br;
%             end
%             
%         end
%         function invertBrainRegions(atlas, i, j)
%             % INVERTBRAINREGIONS inverts position of two BrainRegions.
%             %
%             % INVERTBRAINREGIONS(ATLAS, INDEXI, INDEXJ) inverts the
%             % position of a BrainRegion at INDEXI with the position of a
%             % BrainRegion at INDEXJ.  
%             %
%             % See also addBrainRegion(), replaceBrainRegion().
%             
%             if i > 0 && i <= atlas.brainregionnumber() && j > 0 && j <= atlas.brainregionnumber() && i ~= j
%                 br_i = atlas.getBrainRegion(i);
%                 br_j = atlas.getBrainRegion(j);
%                 atlas.replaceBrainRegion(i, br_j)
%                 atlas.replaceBrainRegion(j, br_i)
%             end
%         end
%         function movetoBrainRegion(atlas, i, j)
%             % MOVETOBRAINREGION moves a BrainRegion to another position.
%             %
%             % MOVETOBRAINREGION(ATLAS, INDEXI, INDEXJ) moves a BrainRegion
%             % from position INDEXI to position INDEXJ.
%             %
%             % See also addBrainRegion(), replaceBrainRegion().
%             
%             if i > 0 && i <= atlas.brainregionnumber() && j > 0 && j <= atlas.brainregionnumber() && i ~= j
%                 br = atlas.getBrainRegion(i);
%                 if i > j
%                     atlas.removeBrainRegion(i)
%                     atlas.addBrainRegion(br, j)
%                 else  % j < i
%                     atlas.addBrainRegion(br, j+1)
%                     atlas.removeBrainRegion(i)
%                 end
%             end            
%         end
%         function selected = removeBrainRegions(atlas, selected)
%             % REMOVEBRAINREGIONS removes selected BrainRegions.
%             %
%             % SELECTED = REMOVEBRAINREGIONS(ATLAS, SELECTED) removes all
%             % BrainRegions whose positions in ATLAS are included in the
%             % array SELECTED. It returns an empty array.
%             %
%             % See also addaboveBrainRegions(), addbelowBrainRegions().
%             
%             for i = length(selected):-1:1
%                 atlas.removeBrainRegion(selected(i))
%             end
%             selected = [];
%         end
%         function [selected, added] = addaboveBrainRegions(atlas, selected)
%             % ADDABOVEBRAINREGIONS adds BrainRegions above a selection.
%             %
%             % [SELECTED, ADDED] = ADDABOVEBRAINREGIONS(ATLAS, SELECTED) adds new
%             % BrainRegions with default initialization above the selected
%             % positions in the array SELECTED. It returns a new reshaped 
%             % array of SELECTED and the new BrainRegions ADDED.
%             %
%             % See also removeBrainRegions(), addbelowBrainRegions().
%             
%             for i = length(selected):-1:1
%                 atlas.addBrainRegion(BrainRegion(), selected(i))
%             end
%             selected = selected + reshape(1:1:numel(selected), size(selected));
%             added = selected - 1;
%         end
%         function [selected, added] = addbelowBrainRegions(atlas, selected)
%             % ADDBELOWBRAINREGIONS adds BrainRegions below a selection.
%             %
%             % [SELECTED, ADDED] = ADDBELOWBRAINREGIONS(ATLAS, SELECTED) adds
%             % new BrainRegions with default initialization below the selected
%             % positions in the array SELECTED. It returns a new reshaped 
%             % array of SELECTED and the new BrainRegions ADDED.
%             %
%             % See also removeBrainRegions(), addaboveBrainRegions().
%             
%             for i = length(selected):-1:1
%                 atlas.addBrainRegion(BrainRegion(), selected(i) + 1)
%             end
%             selected = selected + reshape(0:1:numel(selected)-1, size(selected));
%             added = selected + 1;
%         end
%         function selected = moveupBrainRegions(atlas, selected)
%             % MOVEUPBRAINREGIONS moves up selected BrainRegions.
%             %
%             % SELECTED = MOVEUPBRAINREGIONS(ATLAS, SELECTED) moves up by one
%             % position all BrainRegions whose positions in ATLAS are included
%             % in the SELECTED array and returns their final positions.
%             %
%             % See also movedownBrainRegions().
%             
%             if ~isempty(selected)
%                 
%                 first_index_to_process = 1;
%                 unprocessable_length = 1;
%                 while first_index_to_process <= atlas.brainregionnumber() ...
%                         && first_index_to_process <= numel(selected) ...
%                         && selected(first_index_to_process) == unprocessable_length
%                     first_index_to_process = first_index_to_process + 1;
%                     unprocessable_length = unprocessable_length + 1;
%                 end
% 
%                 for i = first_index_to_process:1:numel(selected)
%                     atlas.invertBrainRegions(selected(i), selected(i)-1);
%                     selected(i) = selected(i) - 1;
%                 end
%             end
%         end
%         function selected = movedownBrainRegions(atlas, selected)
%             % MOVEDOWNBRAINREGIONS moves down selected BrainRegions.
%             %
%             % SELECTED = MOVEDOWNBRAINREGIONS(ATLAS, SELECTED) moves down by
%             % one position all BrainRegions whose positions in ATLAS are included
%             % in the SELECTED array and returns their final positions.
%             %
%             % See also movedownBrainRegions().
%             
%             if ~isempty(selected)
% 
%                 last_index_to_process = numel(selected);
%                 unprocessable_length = atlas.brainregionnumber();
%                 while last_index_to_process > 0 ...
%                         && selected(last_index_to_process) == unprocessable_length
%                     last_index_to_process = last_index_to_process - 1;
%                     unprocessable_length = unprocessable_length - 1;
%                 end
% 
%                 for i = last_index_to_process:-1:1
%                     atlas.invertBrainRegions(selected(i), selected(i) + 1);
%                     selected(i) = selected(i) + 1;
%                 end
%             end
%         end
%         function selected = move2topBrainRegions(atlas, selected)
%             % MOVE2TOPBRAINREGIONS moves selected BrainRegions to top
%             %
%             % SELECTED = MOVE2TOPBRAINREGIONS(ATLAS, SELECTED) moves to top
%             % all BrainRegions whose positions in the ATLAS dictionary are 
%             % included in the SELECTED array and returns their final positions.
%             %
%             % See also move2bottomBrainRegions().
%             
%             if ~isempty(selected)
%                 for i = 1:1:numel(selected)
%                     atlas.movetoBrainRegion(selected(i), i);
%                 end
%                 selected = reshape(1:1:numel(selected), size(selected));
%             end
%         end
%         function selected = move2bottomBrainRegions(atlas, selected)
%             % MOVE2BOTTOMBRAINREGIONS moves selected BrainRegions to bottom
%             %
%             % SELECTED = MOVE2BOTTOMBRAINREGIONS(ATLAS, SELECTED) moves to 
%             % bottom all BrainRegions whose positions in the ATLAS dictionary are 
%             % included in the SELECTED array and returns their final positions.
%             %
%             % See also move2bottomBrainRegions().
%             
%             if ~isempty(selected)
%                 for i = numel(selected):-1:1
%                     atlas.movetoBrainRegion(selected(i), atlas.brainregionnumber() - (numel(selected)-i));
%                 end
%                 selected = reshape(atlas.brainregionnumber() - numel(selected)+1:1:atlas.brainregionnumber(), size(selected));
%             end
%         end
    end
end
