classdef BrainAtlas < handle & matlab.mixin.Copyable
    % BrainAtlas < handle & matlab.mixin.Copyable: A brain atlas
    % BrainAtlas represents a collection of brain regions. 
    %
    % BrainAtlas properties (GetAccess=protected, SetAccess=protected):
    %   name                    - name of the brain atlas.
    %   br_idict                - indexed dictionary with brain regions
    %
    % BrainAtlas methods (Access=protected)
    %   copyElement             - deep copy community structure.
    %
    % BrainAtlas methods:
    %   BrainAtlas              - Constructor.
    %   tostring                - returns a string representing the BrainAtlas.
    %   disp                    - displays the BrainAtlas.
    %   getName                 - returns the name of the BrainAtlas.
    %   getBrainRegions         - returns the indexed dictionary with BrainRegions.
    %   getBrainRegionLabels    - returns the label of all BrainRegions.
    %   getBrainRegionXs        - returns the x coordiante of all BrainRegions.
    %   getBrainRegionYs        - returns the y coordiante of all BrainRegions.
    %   getBrainRegionZs        - returns the z coordiante of all BrainRegions.
    %   getBrainRegionPositions - returns the positions of all BrainRegions.
    %
    % Additionally, it is possible to use the following IndexDictionary
    % methods through getBrainRegions():
    %   getBrainRegions()             - returns the indexed dictionary br_idict with BrainRegions.
    %   getBrainRegions().tostring    - returns a string representing the indexed dictionary br_idict.
    %   getBrainRegions().disp        - displays the indexed dictionary br_idict.
    %   getBrainRegions().length      - returns the length of the indexed dictionary br_idict.
    %   getBrainRegions().getValueClass     - returns the value_class of the indexed dictionary br_idict.
    %   getBrainRegions().contains          - bool, checks if the indexed dictionary br_idict contains the index, key or object
    %   getBrainRegions().containsIndex     - bool, checks if the indexed dictionary br_idict contains the index.
    %   getBrainRegions().containsKey       - bool, checks if the indexed dictionary br_idict contains the key.
    %   getBrainRegions().containsValue     - bool, checks if the indexed dictionary br_idict contains the value.
    %   getBrainRegions().getIndex          - returns the index of the key or value.
    %   getBrainRegions().getIndexFromValue - returns the index of the value.
    %   getBrainRegions().getIndexFromKey   - returns the index of the key.
    %   getBrainRegions().getIndexFromValueAll - returns all the indexes of the same value.
    %   getBrainRegions().getValue          - returns the value of the index or the key.
    %   getBrainRegions().getValueFromIndex - returns the value of the index.
    %   getBrainRegions().getValueFromKey   - returns the value of the key.
    %   getBrainRegions().getKey            - returns the key of the index or value.
    %   getBrainRegions().getKeyFromIndex   - returns the key of the index.
    %   getBrainRegions().getKeyFromValue   - returns the key of the value.
    %   getBrainRegions().getKeyFromValueAll   - returns all the keys of the same value.
    %   getBrainRegions().add               - adds a key and value to the indexed dictionary br_idict.
    %   getBrainRegions().remove            - removes the key and value from the indexed dictionary br_idict.
    %   getBrainRegions().replace           - replaces a key and value in the indexed dictionary br_idict.
    %   getBrainRegions().replaceKey        - replaces a key in the indexed dictionary br_idict.
    %   getBrainRegions().replaceValue      - replaces a value in the indexed dictionary br_idict.
    %   getBrainRegions().replaceValueAll   - replaces all values of same value in the indexed dictionary br_idict.
    %   getBrainRegions().invert            - inverts position of elements in the indexed dictionary br_idict.
    %   getBrainRegions().move_to           - move an element to a position in the indexed dictionary br_idict.
    %   getBrainRegions().remove_all        - removes all selected elements from the indexed dictionary br_idict.
    %   getBrainRegions().move_up           - moves an element up in the indexed dictionary br_idict
    %   getBrainRegions().move_down         - moves an element down in the indexed dictionary br_idict
    %   getBrainRegions().move_to_top       - moves an element to the top in the indexed dictionary br_idict
    %   getBrainRegions().move_to_bottom    - moves an element to the bottom in the indexed dictionary br_idict
    %   
    % See also BrainRegion
    
    properties (GetAccess=protected, SetAccess=protected) 
        name  % BrainAtlas name
        br_idict  % indexed dictionary with BrainRegions
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
            
            % Make a deep copy of br_idict
            atlas_copy.br_idict = IndexedDictionary(atlas.getBrainRegions().getValueClass());
            for i = 1:1:atlas.getBrainRegions().length()
                atlas_copy.br_idict.add(atlas.getBrainRegions().getKey(i), atlas.getBrainRegions().getValue(i), i);
            end
        end        
    end        
    methods
        function atlas = BrainAtlas(name, brain_regions)
            % BrainAtlas(NAME, BrainRegions) creates a BrainAtlas with
            % given name NAME and initializes the dictionary with
            % BRAIN_REGIONS (cell array of BrainRegions). 
            %
            % See also BrainRegion.
            
            % brain_regions must be a cell array of BrainRegion            
            assert(iscell(brain_regions), ...
                ['BRAPH:BrainAtlas:BrainRegionsErr'], ...
                ['The input brain regions should be a cell array of BrainRegion']) %#ok<NBRAK>
            
            % initialization of properties
            atlas.name = name;            
            atlas.br_idict = IndexedDictionary('BrainRegion'); % containers.Map('KeyType', 'int32', 'ValueType', 'any');
            for i = 1:1:length(brain_regions)
                atlas.br_idict.add(brain_regions{i}.getName(), brain_regions{i}, i);
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
        function br_idict = getBrainRegions(atlas)
            % GETBRAINREGIONS returns the indexed dictionary
            % 
            % BR_IDICT = GETBRAINREGIONS(ATLAS) returns the indexed
            % dictionary BR_IDICT. This function exposes to the user the
            % methods and functions of the INDEXEDDICTIONARY class.
            %
            % See also IndexedDictionary, getName().

            br_idict = atlas.br_idict;
        end
        function br_labels = getBrainRegionLabels(atlas)
            % GETBRAINREGIONLABELS returns all BrainRegion labels.
            %
            % BR_LABELS = GETBRAINREGIONLABELS(ATLAS) returns all the
            % BrainRegions labels from the dictionary the BRDICT.
            %
            % See also getBrainRegions(), getBrainNames().
            
            br_labels = cell(1, atlas.getBrainRegions().length());
            for i = 1:1:atlas.getBrainRegions().length()
                br = atlas.getBrainRegions().getValueFromIndex(i);
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
            
            br_names = cell(1, atlas.getBrainRegions().length());
            for i = 1:1:atlas.getBrainRegions().length()
                br = atlas.getBrainRegions().getValueFromIndex(i);
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
            
            br_xs = cell(1, atlas.getBrainRegions().length());
            for i = 1:1:atlas.getBrainRegions().length()
                br = atlas.getBrainRegions().getValueFromIndex(i);
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
            
            br_ys = cell(1, atlas.getBrainRegions().length());
            for i = 1:1:atlas.getBrainRegions().length()
                br = atlas.getBrainRegions().getValueFromIndex(i);
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
            
            br_zs = cell(1, atlas.getBrainRegions().length());
            for i = 1:1:atlas.getBrainRegions().length()
                br = atlas.getBrainRegions().getValueFromIndex(i);
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
            
            br_positions = cell(1, atlas.getBrainRegions().length());
            for i = 1:1:atlas.getBrainRegions().length()
                br = atlas.getBrainRegions().getValueFromIndex(i);
                br_positions{i} = br.getPosition();
            end
        end        
    end
end
