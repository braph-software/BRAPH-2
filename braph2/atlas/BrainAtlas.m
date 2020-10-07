classdef BrainAtlas < handle & matlab.mixin.Copyable
    % BrainAtlas  A brain atlas
    % BrainAtlas represents a collection of brain regions.
    % It is a subclass of handle and matlab.mixin.Copyable
    %
    % BrainAtlas contains and manages brain regions inside an IndexedDictionary; 
    % thus, it has access to all IndexedDictionary methods. 
    % BrainAtlas can be imported/exported to .txt, .xls and .json files.
    %
    % BrainAtlas methods:
    %   BrainAtlas              - Constructor
    %
    % BrainAtlas basic methods:
    %   tostring                - returns a string representing the BrainAtlas
    %   disp                    - displays the BrainAtlas
    %
    % BrainAtlas set methods:
    %   setID                   - sets the id of the BrainAtlas
    %   setLabel                - sets the label of the BrainAtlas
    %   setNotes                - sets the notes of the BrainAtlas
    %   setBrainSurfFile        - sets the brain surf file of the BrainAtlas
    %   getID                   - returns the id of the BrainAtlas
    %   getLabel                - returns the label of the BrainAtlas
    %   getNotes                - returns the notes of the BrainAtlas
    %   getBrainRegions         - returns the indexed dictionary with BrainRegions
    %   getBrainSurfFile        - returns the brain surf file name
    %
    % BrainAtlas plot methods:
    %   getPlotBrainSurf        - returns a PlotBrainSurf 
    %   getPlotBrainAtlas       - returns a PlotBrainAtlas
    %
    % BrainAtlas save and load methods (Static) : 
    %   load_from_xls           - loads a xls file and creates a BrainAtlas
    %   save_to_xls             - saves a BrainAtlas to a xls file
    %   load_from_txt           - loads a txt file and creates a BrainAtlas
    %   save_to_txt             - saves a BrainAtlas to a txt file
    %   load_from_json          - loads a json file and creates a BrainAtlas
    %   save_to_json            - saves a BrainAtlas to a json file
    %
    % Additionally, it is possible to use the following IndexDictionary
    % methods through getBrainRegions():
    %   getBrainRegions()                   - returns the indexed dictionary br_idict with BrainRegions
    %   getBrainRegions().tostring          - returns a string representing the indexed dictionary br_idict
    %   getBrainRegions().disp              - displays the indexed dictionary br_idict
    %   getBrainRegions().length            - returns the length of the indexed dictionary br_idict
    %   getBrainRegions().getValueClass     - returns the value_class of the indexed dictionary br_idict
    %   getBrainRegions().contains          - bool, checks if the indexed dictionary br_idict contains the index, key or object
    %   getBrainRegions().containsIndex     - bool, checks if the indexed dictionary br_idict contains the index
    %   getBrainRegions().containsKey       - bool, checks if the indexed dictionary br_idict contains the key
    %   getBrainRegions().containsValue     - bool, checks if the indexed dictionary br_idict contains the value
    %   getBrainRegions().getIndex          - returns the index of the key or value
    %   getBrainRegions().getIndexFromValue - returns the index of the value
    %   getBrainRegions().getIndexFromKey   - returns the index of the key
    %   getBrainRegions().getIndexFromValueAll - returns all the indexes of the same value
    %   getBrainRegions().getValue          - returns the value of the index or the key
    %   getBrainRegions().getValueFromIndex - returns the value of the index
    %   getBrainRegions().getValueFromKey   - returns the value of the key
    %   getBrainRegions().getValues         - returns all the values
    %   getBrainRegions().getKey            - returns the key of the index or value
    %   getBrainRegions().getKeyFromIndex   - returns the key of the index
    %   getBrainRegions().getKeyFromValue   - returns the key of the value
    %   getBrainRegions().getKeyFromValueAll - returns all the keys of the same value
    %   getBrainRegions().getKeys           - returns all the keys
    %   getBrainRegions().add               - adds a key and value to the indexed dictionary br_idict
    %   getBrainRegions().remove            - removes the key and value from the indexed dictionary br_idict
    %   getBrainRegions().replace           - replaces a key and value in the indexed dictionary br_idict
    %   getBrainRegions().replaceKey        - replaces a key in the indexed dictionary br_idict
    %   getBrainRegions().replaceValue      - replaces a value in the indexed dictionary br_idict
    %   getBrainRegions().replaceValueAll   - replaces all values of same value in the indexed dictionary br_idict
    %   getBrainRegions().invert            - inverts position of elements in the indexed dictionary br_idict
    %   getBrainRegions().move_to           - moves an element to a position in the indexed dictionary br_idict
    %   getBrainRegions().remove_all        - removes all selected elements from the indexed dictionary br_idict
    %   getBrainRegions().move_up           - moves an element up in the indexed dictionary br_idict
    %   getBrainRegions().move_down         - moves an element down in the indexed dictionary br_idict
    %   getBrainRegions().move_to_top       - moves an element to the top in the indexed dictionary br_idict
    %   getBrainRegions().move_to_bottom    - moves an element to the bottom in the indexed dictionary br_idict
    %
    % Useful cellfun expressions:
    %   cellfun(@(br) br.getID(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
    %   cellfun(@(br) br.getLabel(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
    %   cellfun(@(br) br.getNotes(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
    %   cellfun(@(br) br.getX(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
    %   cellfun(@(br) br.getY(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
    %   cellfun(@(br) br.getZ(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
    %   cellfun(@(br) br.getPosition(), atlas.getBrainRegions().getValues(), 'UniformOutput', false)
    %
    % See also BrainRegion, PlotBrainSurf, PlotBrainAtlas, IndexedDictionary.
    
    properties (GetAccess=protected, SetAccess=protected)
        id  % few-letter code (unique for each brain atlas)
        label  % extended name of the brain atlas
        notes  % notes about the brain atlas
        br_idict  % indexed dictionary with BrainRegions
        brain_surf_file  % file of the brain surf
    end
    methods  % Basic functions
        function atlas = BrainAtlas(id, label, notes, brain_surf_file, brain_regions)
            % BrainAtlas(ID, LABEL, NOTES, BRAIN_SURF_FILE, BRAIN_REGIONS) creates a BrainAtlas with
            % given ID, LABEL, NOTES, AND BRAIN_SURF_FILE and initializes the dictionary with
            % BRAIN_REGIONS (cell array of BrainRegions).
            %
            % See also BrainRegion, IndexedDictionary.
            
            assert(iscell(brain_regions) && all(cellfun(@(br) isa(br, 'BrainRegion'), brain_regions)), ...
                [BRAPH2.STR ':' class(atlas) ':' BRAPH2.WRONG_INPUT], ...
                'The input brain_regions must be a cell array of BrainRegions.')
            
            atlas.setID(id)
            atlas.setLabel(label)
            atlas.setNotes(notes)
            atlas.setBrainSurfFile(brain_surf_file)
            
            atlas.br_idict = IndexedDictionary('BrainRegion');
            for i = 1:1:length(brain_regions)
                atlas.br_idict.add(brain_regions{i}.getID(), brain_regions{i}, i);
            end
        end        
        function str = tostring(atlas)
            % TOSTRING string with information about the brain atlas
            %
            % STRING = TOSTRING(ATLAS) returns string with the BrainAtlas
            % class, ID, label and size.
            %
            % See also disp.
            
            str = [class(atlas) ' ' atlas.getID() ' ' atlas.getLabel() ' with ' int2str(atlas.getBrainRegions().length()) ' brain regions'];
        end
        function disp(atlas)
            % TOSTRING displays information about the brain atlas
            %
            % DISP(ATLAS) displays information about the atlas class, id,
            % label, notes, and size. BrainRegions key, id, label and position.
            %
            % See also tostring.
            
            disp(['<a href="matlab:help ' class(atlas) '">' class(atlas) '</a>'])
            disp([' id: ' atlas.getID()])
            disp([' label: ' atlas.getLabel()])
            disp([' notes: ' atlas.getNotes()])
            disp([' brain surf file: ' atlas.getBrainSurfFile()])
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
            % SETID sets the id of the BrainAtlas.
            %
            % SETID(ATLAS, ID) sets the id of ATLAS to ID.
            %
            % See also getID.
            
            assert(ischar(id), ...
                [BRAPH2.STR ':' class(atlas) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')
            
            atlas.id = id;
        end
        function setLabel(atlas, label)
            % SETLABEL sets the label of the BrainAtlas.
            %
            % SETLABEL(ATLAS, LABEL) sets the label of ATLAS to LABEL.
            %
            % See also getLabel.
            
            assert(ischar(label), ...
                [BRAPH2.STR ':' class(atlas) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')
            
            atlas.label = label;
        end
        function setNotes(atlas, notes)
            % SETNOTES sets the notes of the BrainAtlas.
            %
            % SETNOTES(ATLAS, NOTES) sets the notes of ATLAS to NAME.
            %
            % See also getNotes.
            
            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(atlas) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')
            
            atlas.notes = notes;
        end
        function setBrainSurfFile(atlas, brain_surf_file)
            % SETBRAINSURFFILE sets the surf file to the BrainAtlas.
            %
            % SETBRAINSURFFILE(ATLAS, BRAINSURFFILE) checks if the surf is a 
            % correct brain surf, then sets the surf file BRAINSURFFILE 
            % to the BrainAtlas ATLAS.
            %
            % See also getBrainSurfFile.
            
            assert(ischar(brain_surf_file), ...
                [BRAPH2.STR ':' class(atlas) ':' BRAPH2.WRONG_INPUT ], ...
                'Brain Surf File must be a string')
            
            
            % assert is part of the brainsurf folder
            assert(ismember(brain_surf_file, atlas.getBrainSurfList()), ...
                [BRAPH2.STR ':' class(atlas) ':' BRAPH2.WRONG_INPUT ], ...
                'Brain Surf File is not part of the available BrainSurf')
            
            
            atlas.brain_surf_file = brain_surf_file;
        end
    end
    methods  % Get functions
        function id = getID(atlas)
            % GETID returns the id of the atlas.
            %
            % ID = GETID(ATLAS) returns the id of the BrainAtlas.
            %
            % See also setID.
            
            id = atlas.id;
        end
        function label = getLabel(atlas)
            % GETLABEL returns the label of the atlas.
            %
            % LABEL = GETLABEL(ATLAS) returns the label of the BrainAtlas.
            %
            % See also setLabel.
            
            label = atlas.label;
        end
        function notes = getNotes(atlas)
            % GETNOTES returns the notes of the atlas.
            %
            % NOTES = GETNOTES(ATLAS) returns the notes of the BrainAtlas.
            %
            % See also setNotes.
            
            notes = atlas.notes;
        end
        function br_idict = getBrainRegions(atlas)
            % GETBRAINREGIONS returns the indexed dictionary
            %
            % BR_IDICT = GETBRAINREGIONS(ATLAS) returns the indexed
            % dictionary BR_IDICT. This function exposes to the user the
            % methods and functions of the INDEXEDDICTIONARY class.
            %
            % See also IndexedDictionary, getID.
            
            br_idict = atlas.br_idict;
        end
        function brain_surf_file = getBrainSurfFile(atlas)
            % GETBRAINSURFFILE returns the brain surf file 
            %
            % BRAIN_SRUF_FILE = GETBRAINSURFFILE(ATLAS) returns the brain
            % surf file of the atlas.
            %
            % See also setBrainSurfFile.
            
            brain_surf_file = atlas.brain_surf_file;
        end
    end
    methods  % Plot functions
        function bs = getPlotBrainSurf(atlas, varargin)
            % GETPLOTBRAINSURF returns the brain surf plot.
            %
            % GETPLOTBRAINSURF(ATLAS, VARARGIN) returns the handle of the
            % brain surf plot
            %
            % See also getPlotBrainAtlas.
            
            bs = PlotBrainSurf(atlas.getBrainSurfFile, varargin{:});
        end
        function ba = getPlotBrainAtlas(atlas, varargin)
            % GETPLOTBRAINATLAS returns the brain atlas surf and regions plot
            %
            % GETBRAINPLOTATLAS(ATLAS, VARARGIN) returns the handle of the
            % the brain atlas plot, which contains the surf and the
            % brain regions nodes.
            %
            % See also getPlotBrainSurf.           
           
            ba = PlotBrainAtlas(atlas, varargin{:});   
        end
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
        function brain_surf_list = getBrainSurfList()  
            % GETBRAINSURFLIST returns the available brain surfs names
            %
            % BRAIN_SURF_LIST = GETBRAINSURFLIST() returns an array
            % BRAIN_SURF_LIST containing the names of all brain surfs
            % inside brainsurfs folder.
            %
            % See also setBrainSurfFile.

            directory = [fileparts(which('braph2')) filesep 'atlas' filesep 'brainsurfs'];
            folder_struct = dir(directory);
            folder_struct = folder_struct(~ismember({folder_struct(:).name}, {'.', '..'}));  % remove '.' and '..'
            for i = 1:1:length(folder_struct)
                filename = folder_struct(i).name;
                if isequal(filename(end-2:end), '.nv')
                    brain_surf_list{i} = folder_struct(i).name;
                end
            end
            brain_surf_list(cellfun('isempty', brain_surf_list)) = [];
        end
        function atlas = load_from_xls(varargin)
            % LOAD_FROM_XLS loads brain atlas from XLS file
            %
            % ATLAS = LOAD_FROM_XLS('File', FILE) creates and initializes the
            % brain atlas ATLAS by loading an XLS file ('*.xlsx' or '*.xls').
            % It throws an error if the file does not exist
            % or is in the wrong format.
            %
            % ATLAS = LOAD_FROM_XLS() it opens a dialog box to select the
            % file. If no file is selected, it returns an empty BrainAtlas.
            %
            % ATLAS = LOAD_FROM_XLS('Msg', MSG) it opens a dialog box to select the
            % file with message MSG.
            %
            % See also BrainAtlas, uigetfile, fopen.
     
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.XLS_MSG_GETFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uigetfile(BRAPH2.XLS_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            [~, ~, raw] = xlsread(file);
            
            atlas_id = raw{1, 1};
            atlas_label = raw{2, 1};
            atlas_notes = raw{3, 1};
            atlas_surf = raw{4, 1};
            
            % Creates empty BrainAtlas
            atlas = BrainAtlas(atlas_id, atlas_label, atlas_notes, atlas_surf, {});
            
            for i = 5:1:size(raw, 1)
                br_id = raw{i, 1};
                br_label = raw{i, 2};                
                br_x = raw{i, 3};
                br_y = raw{i, 4};
                br_z = raw{i, 5};
                br_notes = raw{i, 6};
                br = BrainRegion(br_id, br_label, br_notes, br_x, br_y, br_z);
                atlas.getBrainRegions().add(br.getID(), br);
            end
        end
        function save_to_xls(atlas, varargin)
            % SAVE_TO_XLS saves brain atlas to XLS file
            %
            % SAVE_TO_XLS('File', FILE) saves the brain atlas ATLAS into
            % the FILE in XLS format.
            %
            % SAVE_TO_XLS() it opens a dialog box to select the
            % FILE into which the brain atlas ATLAS will be saved.
            %
            % SAVE_TO_XLS('Msg', MSG) it opens a dialog box to select the
            % FILE with message MSG.
            %
            % See also BrainAtlas, uigetfile, writetable.
                    
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.XLS_MSG_PUTFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uiputfile(BRAPH2.XLS_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            % gets brain region data
            for i = 1:1:atlas.getBrainRegions().length()
                br_label{i, 1} = atlas.getBrainRegions().getValue(i).getLabel();
                br_ids{i, 1} = atlas.getBrainRegions().getValue(i).getID(); %#ok<*AGROW>
                br_notes{i, 1} = atlas.getBrainRegions().getValue(i).getNotes(); 
                br_x{i, 1} = atlas.getBrainRegions().getValue(i).getX();
                br_y{i, 1} = atlas.getBrainRegions().getValue(i).getY();
                br_z{i, 1} = atlas.getBrainRegions().getValue(i).getZ();
            end
            
            % creates table
            tab = [
                {atlas.getID(), {}, {}, {}, {}, {}};
                {atlas.getLabel(), {}, {}, {}, {}, {}};
                {atlas.getNotes(), {}, {}, {}, {}, {}};
                {atlas.getBrainSurfFile(), {}, {}, {}, {}, {}};
                table(br_ids, br_label, br_x, br_y, br_z, br_notes)
                ];
            
            % save
            writetable(tab, file, 'Sheet', 1, 'WriteVariableNames', 0);
        end
        function atlas = load_from_txt(varargin)
            % LOAD_FROM_TXT loads brain atlas from TXT file
            %
            % ATLAS = LOAD_FROM_TXT('File', FILE) creates and initializes the
            % brain atlas ATLAS by loading an TXT file ('*.txt').
            % It throws an error is the file does not exist
            % or is in the wrong format.
            %
            % ATLAS = LOAD_FROM_TXT() it opens a dialog box to select the
            % file. If no file is selected, it returns an empty BrainAtlas.
            %
            % ATLAS = LOAD_FROM_TXT('Msg', MSG) it opens a dialog box to select the
            % file with message MSG.
            %
            % See also BrainAtlas, uigetfile, readtable
            
            % file (fullpath)
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.TXT_MSG_GETFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uigetfile(BRAPH2.TXT_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            raw = textread(file, '%s', 'delimiter', '\t', 'whitespace', ''); %#ok<DTXTRD>
            
            raw = raw(~cellfun('isempty', raw));  % remove empty cells
            
            atlas_ID =  raw{1, 1};            
            atlas_label = raw{2, 1};
            atlas_notes = raw{3, 1};
            atlas_surf = raw{4, 1};
            atlas_surf = strrep(atlas_surf, '_nv', '.nv');
  
            % Creates empty BrainAtlas
            atlas = BrainAtlas(atlas_ID, atlas_label, atlas_notes, atlas_surf, {});
            
            for i = 5:6:size(raw, 1)
                br_id = char(raw{i, 1});
                br_label = char(raw{i+1, 1});                
                br_x = str2double(raw{i+2, 1});
                br_y = str2double(raw{i+3, 1});
                br_z = str2double(raw{i+4, 1});
                br_notes = char(raw{i+5, 1});
                br = BrainRegion(br_id, br_label, br_notes, br_x, br_y, br_z);
                atlas.getBrainRegions().add(br.getID(), br);
            end
        end
        function save_to_txt(atlas, varargin)
            % SAVE_TO_TXT saves brain atlas to TXT file
            %
            % SAVE_TO_TXT('File', FILE) saves the brain atlas ATLAS into
            % the FILE in TXT format.
            %
            % SAVE_TO_TXT() it opens a dialog box to select the
            % FILE into which the brain atlas ATLAS will be saved.
            %
            % SAVE_TO_TXT('Msg', MSG) it opens a dialog box to select the
            % FILE with message MSG.
            %
            % See also BrainAtlas, uigetfile, writetable.
            
            % file (fullpath)            
            file = get_from_varargin('', 'File', varargin{:});
            if isequal(file, '')  % select file
                msg = get_from_varargin(BRAPH2.TXT_MSG_PUTFILE, 'MSG', varargin{:});
                [filename, filepath, filterindex] = uiputfile(BRAPH2.TXT_EXTENSION, msg);
                file = [filepath filename];
                
                if ~filterindex
                    return
                end
            end
            
            % gets brain region data
            for i = 1:1:atlas.getBrainRegions().length()
                br_label{i, 1} = atlas.getBrainRegions().getValue(i).getLabel();
                br_ids{i, 1} = atlas.getBrainRegions().getValue(i).getID(); %#ok<*AGROW>
                br_notes{i, 1} = atlas.getBrainRegions().getValue(i).getNotes();
                br_x{i, 1} = atlas.getBrainRegions().getValue(i).getX();
                br_y{i, 1} = atlas.getBrainRegions().getValue(i).getY();
                br_z{i, 1} = atlas.getBrainRegions().getValue(i).getZ();
            end
            
            % creates table
            tab = [
                {atlas.getID(), {}, {}, {}, {}, {}}
                {atlas.getLabel(), {}, {}, {}, {}, {}} 
                {atlas.getNotes(), {}, {}, {}, {}, {}} 
                {atlas.getBrainSurfFile(), {}, {}, {}, {}, {}}                 
                table(br_ids, br_label, br_x, br_y, br_z, br_notes)
                ];
            
            % save
            writetable(tab, file, 'Delimiter', '\t', 'WriteVariableNames', 0);
        end
        function atlas = load_from_json(varargin)
            % LOAD_FROM_JSON loads brain atlas from JSON file
            %
            % ATLAS = LOAD_FROM_JSON('File', FILE) creates and initializes the
            % brain atlas ATLAS by loading an JSON file ('*.json').
            % It throws an error is the file does not exist
            % or is in the wrong format.
            %
            % ATLAS = LOAD_FROM_JSON() it opens a dialog box to select the
            % file. If no file is selected, it returns an empty BrainAtlas.
            %
            % ATLAS = LOAD_FROM_JSON('Msg', MSG) it opens a dialog box to select the
            % file with message MSG.
            %
            % See also BrainAtlas, uigetfile, jsondecode
             
            raw =  JSON.Deserialize(varargin{:});
            
            atlas_id =  fieldnames(raw);
            brain_atlas = atlas_id{3};  % 1: BRAPH, 2:Version, 3:Name           
            brain_atlas_structure = eval(['raw.' brain_atlas]);
            atlas_surf = brain_atlas_structure.ba_surf;
            % Creates empty BrainAtlas
            atlas = BrainAtlas('', '', '', atlas_surf, {});
            atlas.setID(brain_atlas_structure.id);  
            atlas.setLabel(brain_atlas_structure.label);
            atlas.setNotes(brain_atlas_structure.notes);
            intern_structure = fieldnames(brain_atlas_structure);
            idict = intern_structure{5};  % 1:name, 2:label, 3:notes, 4:surf, 5:idict
            brain_atlas_intern_structure = eval(['brain_atlas_structure.' idict]);
            
            
            for i = 1:1:numel(brain_atlas_intern_structure)
                intern_fields = brain_atlas_intern_structure(i);
                br_label = char(intern_fields.label);
                br_id = char(intern_fields.id);
                br_notes = char(intern_fields.notes);
                br_x = intern_fields.x;
                br_y = intern_fields.y;
                br_z = intern_fields.z;
                br = BrainRegion(br_id, br_label, br_notes, br_x, br_y, br_z);
                atlas.getBrainRegions().add(br.getID(), br);
            end
        end
        function structure =  save_to_json(atlas, varargin)
            % SAVE_TO_JSON saves brain atlas to JSON file
            %
            % SAVE_TO_JSON('File', FILE) saves the brain atlas ATLAS into
            % the FILE in JSON format.
            %
            % SAVE_TO_JSON() it opens a dialog box to select the
            % FILE into which the brain atlas ATLAS will be saved.
            %
            % SAVE_TO_JSON('Msg', MSG) it opens a dialog box to select the
            % FILE with message MSG.
            %
            % See also BrainAtlas, uigetfile, jsonencode, table.
            
            % gets brain region data
            for i = 1:1:atlas.getBrainRegions().length()
                label{i, 1} = atlas.getBrainRegions().getValue(i).getLabel();
                id{i, 1} = atlas.getBrainRegions().getValue(i).getID(); %#ok<*AGROW>
                notes{i, 1} = atlas.getBrainRegions().getValue(i).getNotes();
                x{i, 1} = atlas.getBrainRegions().getValue(i).getX();
                y{i, 1} = atlas.getBrainRegions().getValue(i).getY();
                z{i, 1} = atlas.getBrainRegions().getValue(i).getZ();
            end
            
            % creates structure to be saved
            structure_to_be_saved = struct( ...
                'Braph', BRAPH2.NAME, ...
                'Build', BRAPH2.BUILD, ...
                'BrainAtlas', struct( ...
                'id', atlas.getID(), ...
                'label', atlas.getLabel(), ...
                'notes', atlas.getNotes(), ...
                'ba_surf', atlas.getBrainSurfFile(), ...
                'br_idict', table(id, label, x, y, z, notes) ...
                ) ...
                );
            
            % save
            structure = structure_to_be_saved;
        end
    end
end
