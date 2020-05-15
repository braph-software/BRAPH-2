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
    % BrainAtlas methods (Static) : 
    %   load_from_xls           - loads a xls file and creates a BrainAtlas
    %   save_to_xls             - saves a BrainAtlas to a xls file
    %   load_from_txt           - loads a txt file and creates a BrainAtlas
    %   save_to_txt             - saves a BrainAtlas to a txt file
    %   load_from_json          - loads a json file and creates a BrainAtlas
    %   save_to_json            - saves a BrainAtlas to a json file
    %
    % Additionally, it is possible to use the following IndexDictionary
    % methods through getBrainRegions():
    %   getBrainRegions()                   - returns the indexed dictionary br_idict with BrainRegions.
    %   getBrainRegions().tostring          - returns a string representing the indexed dictionary br_idict.
    %   getBrainRegions().disp              - displays the indexed dictionary br_idict.
    %   getBrainRegions().length            - returns the length of the indexed dictionary br_idict.
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
    %   getBrainRegions().getValues         - returns all the values.
    %   getBrainRegions().getKey            - returns the key of the index or value.
    %   getBrainRegions().getKeyFromIndex   - returns the key of the index.
    %   getBrainRegions().getKeyFromValue   - returns the key of the value.
    %   getBrainRegions().getKeyFromValueAll - returns all the keys of the same value.
    %   getBrainRegions().getKeys           - returns all the keys.
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
        id  % few-letter code (unique for each brain atlas)
        label  % extended name of the brain atlas
        notes  % notes about the brain atlas
% Add property for brain surface
        br_idict  % indexed dictionary with BrainRegions
    end
    methods  % Basic functions
        function atlas = BrainAtlas(id, label, notes, brain_regions)
            % BrainAtlas(NAME, BrainRegions) creates a BrainAtlas with
            % given name NAME and initializes the dictionary with
            % BRAIN_REGIONS (cell array of BrainRegions).
            %
            % See also BrainRegion.
            
            assert(iscell(brain_regions) && all(cellfun(@(br) isa(br, 'BrainRegion'), brain_regions)), ...
                [BRAPH2.STR ':' class(atlas) ':' BRAPH2.WRONG_INPUT], ...
                'The input brain_regions must be a cell array of BrainRegions.')
            
            atlas.setID(id)
            atlas.setLabel(label)
            atlas.setNotes(notes)
            
            atlas.br_idict = IndexedDictionary('BrainRegion');
            for i = 1:1:length(brain_regions)
                atlas.br_idict.add(brain_regions{i}.getID(), brain_regions{i}, i);
            end
        end        
        function str = tostring(atlas)
            % TOSTRING string with information about the BrainAtlas
            %
            % STRING = TOSTRING(ATLAS) returns string with the BrainAtlas name
            % and brain atlas size.
            %
            % See also disp().
            
            str = [class(atlas) ' ' atlas.getID() ' ' atlas.getLabel() ' with ' int2str(atlas.getBrainRegions().length()) ' brain regions'];
        end
        function disp(atlas)
            % TOSTRING displays information about the brain atlas
            %
            % DISP(ATLAS) displays information about the brainaltas name,
            % class, size. BrainRegions key, label, name and position.
            %
            % See also tostring().
            
            disp(['<a href="matlab:help ' class(atlas) '">' class(atlas) '</a>'])
            disp([' id: ' atlas.getID()])
            disp([' label: ' atlas.getLabel()])
            disp([' notes: ' atlas.getNotes()])
            disp([' size: ' int2str(atlas.getBrainRegions().length()) ' brain regions'])
            disp([' brain regions:']); %#ok<NBRAK>
            for i = 1:1:atlas.getBrainRegions().length()
                br = atlas.getBrainRegions().getValue(i);
                disp(['  ' int2str(i) ': ' br.getID() ' ' br.getLabel() ' ' mat2str(br.getPosition())]);
            end
        end
    end
    methods  % Set functions
        function setID(atlas, id)
            % STENAME sets the name of the BrainAtlas.
            %
            % SETNAME(ATLAS, NAME) sets the name of ATLAS to NAME.
            %
            % See also getName().
            
            assert(ischar(id), ...
                [BRAPH2.STR ':' class(atlas) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')
            
            atlas.id = id;
        end
        function setLabel(atlas, label)
            % STENAME sets the name of the BrainAtlas.
            %
            % SETNAME(ATLAS, NAME) sets the name of ATLAS to NAME.
            %
            % See also getName().
            
            assert(ischar(label), ...
                [BRAPH2.STR ':' class(atlas) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')
            
            atlas.label = label;
        end
        function setNotes(atlas, notes)
            % STENAME sets the name of the BrainAtlas.
            %
            % SETNAME(ATLAS, NAME) sets the name of ATLAS to NAME.
            %
            % See also getName().
            
            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(atlas) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')
            
            atlas.notes = notes;
        end
    end
    methods  % Get functions
        function id = getID(atlas)
            % GETNAME returns the name of the BrainAtlas.
            %
            % NAME = GETNAME(ATLAS) returns the name of the BrainAtlas.
            %
            % See also setName().
            
            id = atlas.id;
        end
        function label = getLabel(atlas)
            % GETNAME returns the name of the BrainAtlas.
            %
            % NAME = GETNAME(ATLAS) returns the name of the BrainAtlas.
            %
            % See also setName().
            
            label = atlas.label;
        end
        function notes = getNotes(atlas)
            % GETNAME returns the name of the BrainAtlas.
            %
            % NAME = GETNAME(ATLAS) returns the name of the BrainAtlas.
            %
            % See also setName().
            
            notes = atlas.notes;
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
        % Useful cellfun expressions:
        % cellfun(@(br) br.getID(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
        % cellfun(@(br) br.getLabel(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
        % cellfun(@(br) br.getNotes(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
        % cellfun(@(br) br.getX(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
        % cellfun(@(br) br.getY(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
        % cellfun(@(br) br.getZ(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
        % cellfun(@(br) br.getPosition(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
    end
    methods  % Plot functions
% bs = getPlotBrainSurf(atlas, varargin)
% ba = getPlotBrainAtlas(atlas, varargin)
% bg = getPlotBrainGraph(atlas, varargin)
    end
    methods (Access=protected)  % Deep copy
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
            atlas_copy.br_idict = atlas.br_idict.copy();
        end
    end    
    methods (Static)  % Save and load functions
%         function atlas = load_from_xls(varargin)
%             % LOAD_FROM_XLS loads brain atlas from XLS file
%             %
%             % ATLAS = LOAD_FROM_XLS('File', FILE) creates and initializes the
%             % brain atlas ATLAS by loading an XLS file ('*.xlsx' or '*.xls').
%             % It throws an error is the file does not exist
%             % or is in the wrong format.
%             %
%             % ATLAS = LOAD_FROM_XLS() it opens a dialog box to select the
%             % file. If no file is selected, it returns an empty BrainAtlas.
%             %
%             % ATLAS = LOAD_FROM_XLS('Msg', MSG) it opens a dialog box to select the
%             % file with message MSG.
%             %
%             % See also BrainAtlas, uigetfile, fopen.
%             
%             % Creates empty BrainAtlas
%             atlas = BrainAtlas('', {});
%             
%             % file (fullpath)
%             file = get_from_varargin('', 'File', varargin{:});
%             if isequal(file, '')  % select file
%                 msg = get_from_varargin(Constant.XLS_MSG_GETFILE, 'MSG', varargin{:});
%                 [filename, filepath, filterindex] = uigetfile(Constant.XLS_EXTENSION, msg);
%                 file = [filepath filename];
%                 
%                 if ~filterindex
%                     return
%                 end
%             end
%             
%             [~, ~, raw] = xlsread(file);
%             
%             atlas_name = raw{1,1};
%             atlas.setName(atlas_name);
%             
%             for i = 2:1:size(raw, 1)
%                 br_label = raw{i, 1};
%                 br_name = raw{i, 2};
%                 br_x = raw{i, 3};
%                 br_y = raw{i, 4};
%                 br_z = raw{i, 5};
%                 br = BrainRegion(br_label, br_name, br_x, br_y, br_z);
%                 atlas.getBrainRegions().add(br_label, br);
%             end
%         end
%         function save_to_xls(atlas, varargin)
%             % SAVE_TO_XLS saves brain atlas to XLS file
%             %
%             % SAVE_TO_XLS('File', FILE) saves the brain atlas ATLAS into
%             % the FILE in XLS format.
%             %
%             % SAVE_TO_XLS() it opens a dialog box to select the
%             % FILE into which the brain atlas ATLAS will be saved.
%             %
%             % SAVE_TO_XLS('Msg', MSG) it opens a dialog box to select the
%             % FILE with message MSG.
%             %
%             % See also BrainAtlas, uigetfile, writetable.
%                     
%             % file (fullpath)
%             file = get_from_varargin('', 'File', varargin{:});
%             if isequal(file, '')  % select file
%                 msg = get_from_varargin(Constant.XLS_MSG_PUTFILE, 'MSG', varargin{:});
%                 [filename, filepath, filterindex] = uiputfile(Constant.XLS_EXTENSION, msg);
%                 file = [filepath filename];
%                 
%                 if ~filterindex
%                     return
%                 end
%             end
%             
%             % gets brain region data
%             for i = 1:1:atlas.getBrainRegions().length()
%                 br_label{i, 1} = atlas.getBrainRegions().getValue(i).getLabel();
%                 br_names{i, 1} = atlas.getBrainRegions().getValue(i).getName(); %#ok<*AGROW>
%                 br_x{i, 1} = atlas.getBrainRegions().getValue(i).getX();
%                 br_y{i, 1} = atlas.getBrainRegions().getValue(i).getY();
%                 br_z{i, 1} = atlas.getBrainRegions().getValue(i).getZ();
%             end
%             
%             % creates table
%             tab = [
%                 {atlas.getName(), {},{},{},{}};
%                 table(br_label, br_names, br_x, br_y, br_z)
%                 ];
%             
%             % save
%             writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', 0);
%         end
%         function atlas = load_from_txt(varargin)
%             % LOAD_FROM_TXT loads brain atlas from XLS file
%             %
%             % ATLAS = LOAD_FROM_TXT('File', FILE) creates and initializes the
%             % brain atlas ATLAS by loading an TXT file ('*.txt').
%             % It throws an error is the file does not exist
%             % or is in the wrong format.
%             %
%             % ATLAS = LOAD_FROM_TXT() it opens a dialog box to select the
%             % file. If no file is selected, it returns an empty BrainAtlas.
%             %
%             % ATLAS = LOAD_FROM_TXT('Msg', MSG) it opens a dialog box to select the
%             % file with message MSG.
%             %
%             % See also BrainAtlas, uigetfile, readtable
%             
%             % Creates empty BrainAtlas
%             atlas = BrainAtlas('', {});
%             
%             % file (fullpath)
%             file = get_from_varargin('', 'File', varargin{:});
%             if isequal(file, '')  % select file
%                 msg = get_from_varargin(Constant.TXT_MSG_GETFILE, 'MSG', varargin{:});
%                 [filename, filepath, filterindex] = uigetfile(Constant.TXT_EXTENSION, msg);
%                 file = [filepath filename];
%                 
%                 if ~filterindex
%                     return
%                 end
%             end
%             
%             raw = readtable(file);
%             
%             atlas_name =  raw.Properties.VariableNames{1};
%             atlas.setName(atlas_name);
%             
%             for i = 1:1:size(raw, 1)
%                 br_label = char(raw{i, 1});
%                 br_name = char(raw{i, 2});
%                 br_x = raw{i, 3};
%                 br_y = raw{i, 4};
%                 br_z = raw{i, 5};
%                 br = BrainRegion(br_label, br_name, br_x, br_y, br_z);
%                 atlas.getBrainRegions().add(br_label, br);
%             end
%         end
%         function save_to_txt(atlas, varargin)
%             % SAVE_TO_TXT saves brain atlas to XLS file
%             %
%             % SAVE_TO_TXT('File', FILE) saves the brain atlas ATLAS into
%             % the FILE in TXT format.
%             %
%             % SAVE_TO_TXT() it opens a dialog box to select the
%             % FILE into which the brain atlas ATLAS will be saved.
%             %
%             % SAVE_TO_TXT('Msg', MSG) it opens a dialog box to select the
%             % FILE with message MSG.
%             %
%             % See also BrainAtlas, uigetfile, writetable.
%             
%             % file (fullpath)            
%             file = get_from_varargin('', 'File', varargin{:});
%             if isequal(file, '')  % select file
%                 msg = get_from_varargin(Constant.TXT_MSG_PUTFILE, 'MSG', varargin{:});
%                 [filename, filepath, filterindex] = uiputfile(Constant.TXT_EXTENSION, msg);
%                 file = [filepath filename];
%                 
%                 if ~filterindex
%                     return
%                 end
%             end
%             
%             % gets brain region data
%             for i = 1:1:atlas.getBrainRegions().length()
%                 br_label{i, 1} = atlas.getBrainRegions().getValue(i).getLabel();
%                 br_names{i, 1} = atlas.getBrainRegions().getValue(i).getName(); %#ok<*AGROW>
%                 br_x{i, 1} = atlas.getBrainRegions().getValue(i).getX();
%                 br_y{i, 1} = atlas.getBrainRegions().getValue(i).getY();
%                 br_z{i, 1} = atlas.getBrainRegions().getValue(i).getZ();
%             end
%             
%             % creates table
%             tab = [
%                 {atlas.getName(), {},{},{},{}};
%                 table(br_label, br_names, br_x, br_y, br_z)
%                 ];
%             
%             % save
%             writetable(tab, file, 'Delimiter', '\t', 'WriteVariableNames', 0);
%         end
%         function atlas = load_from_json(varargin)
%             % LOAD_FROM_JSON loads brain atlas from XLS file
%             %
%             % ATLAS = LOAD_FROM_JSON('File', FILE) creates and initializes the
%             % brain atlas ATLAS by loading an JSON file ('*.json').
%             % It throws an error is the file does not exist
%             % or is in the wrong format.
%             %
%             % ATLAS = LOAD_FROM_JSON() it opens a dialog box to select the
%             % file. If no file is selected, it returns an empty BrainAtlas.
%             %
%             % ATLAS = LOAD_FROM_JSON('Msg', MSG) it opens a dialog box to select the
%             % file with message MSG.
%             %
%             % See also BrainAtlas, uigetfile, jsondecode
%             
%             % Creates empty BrainAtlas
%             atlas = BrainAtlas('', {});
%             
%             % file (fullpath)
%             file = get_from_varargin('', 'File', varargin{:});
%             if isequal(file, '')  % select file
%                 msg = get_from_varargin(Constant.JSON_MSG_GETFILE, 'MSG', varargin{:});
%                 [filename, filepath, filterindex] = uigetfile(Constant.JSON_EXTENSION, msg);
%                 file = [filepath filename];
%                 
%                 if ~filterindex
%                     return
%                 end
%             end
%             
%             raw =  jsondecode(fileread(file));
%             
%             atlas_name =  fieldnames(raw);
%             brain_atlas = atlas_name{3};  % 1: BRAPH, 2:Version, 3:Name           
%             brain_atlas_structure = eval(['raw.' brain_atlas]);
%             atlas.setName(brain_atlas_structure.name);
%             intern_structure = fieldnames(brain_atlas_structure);
%             idict = intern_structure{2};  % 1:name, 2:idict
%             brain_atlas_intern_structure = eval(['brain_atlas_structure.' idict]);
%             
%             
%             for i = 1:1:numel(brain_atlas_intern_structure)
%                 intern_fields = brain_atlas_intern_structure(i);
%                 br_label = char(intern_fields.label);
%                 br_name = char(intern_fields.name);
%                 br_x = intern_fields.x;
%                 br_y = intern_fields.y;
%                 br_z = intern_fields.z;
%                 br = BrainRegion(br_label, br_name, br_x, br_y, br_z);
%                 atlas.getBrainRegions().add(br_label, br);
%             end
%         end
%         function save_to_json(atlas, varargin)
%             % SAVE_TO_JSON saves brain atlas to XLS file
%             %
%             % SAVE_TO_JSON('File', FILE) saves the brain atlas ATLAS into
%             % the FILE in JSON format.
%             %
%             % SAVE_TO_JSON() it opens a dialog box to select the
%             % FILE into which the brain atlas ATLAS will be saved.
%             %
%             % SAVE_TO_JSON('Msg', MSG) it opens a dialog box to select the
%             % FILE with message MSG.
%             %
%             % See also BrainAtlas, uigetfile, jsonencode, table.
%             
%             % file (fullpath)
%             file = get_from_varargin('', 'File', varargin{:});
%             if isequal(file, '')  % select file
%                 msg = get_from_varargin(Constant.JSON_MSG_PUTFILE, 'MSG', varargin{:});
%                 [filename, filepath, filterindex] = uiputfile(Constant.JSON_EXTENSION, msg);
%                 file = [filepath filename];
%                 
%                 if ~filterindex
%                     return
%                 end
%             end
%             
%             % gets brain region data
%             for i = 1:1:atlas.getBrainRegions().length()
%                 label{i, 1} = atlas.getBrainRegions().getValue(i).getLabel();
%                 name{i, 1} = atlas.getBrainRegions().getValue(i).getName(); %#ok<*AGROW>
%                 x{i, 1} = atlas.getBrainRegions().getValue(i).getX();
%                 y{i, 1} = atlas.getBrainRegions().getValue(i).getY();
%                 z{i, 1} = atlas.getBrainRegions().getValue(i).getZ();
%             end
%             
%             % creates structure to be saved
%             structure_to_be_saved = struct( ...
%                 'Braph', Constant.VERSION, ...
%                 'Build', Constant.BUILD, ...
%                 'BrainAtlas', struct( ...
%                     'name', atlas.getName(), ...
%                     'br_idict', table(label, name, x, y, z) ...
%                     ) ...
%                 );
%             
%             % save
%             Json_structure= jsonencode(structure_to_be_saved);
%             fid = fopen(file, 'w');
%             if fid == -1, error('Cannot create JSON file'); end
%             fwrite(fid, Json_structure, 'char');
%             fclose(fid);
%         end
    end
end
