%% ¡header!
ImporterBrainAtlasXLS < Importer (im, importer of brain atlas from XLS/XLSX) imports a brain atlas from an XLS/XLSX file.

%%% ¡description!
ImporterBrainAtlasXLS imports a brain atlas from an XLS/XLSX file.
The TXT file consists of 6 columns. It reads as follows: 
BrainAtlas ID (column 1), BrainAtlas LABEL (column 2),
BrainRegions (column 3-5; coordinates x, y, z, one per column) and 
BrainAtlas NOTES (column 6).

%%% ¡seealso!
Element, Importer, ExporterBrainAtlasXLS.

%% ¡props!

%%% ¡prop!
FILE (data, string) is the XLS/XLSX file from where to load the brain atlas.

%%% ¡prop!
BA (result, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()
%%%% ¡calculate!
% creates empty BrainAtlas
ba = BrainAtlas();

% analyzes file
file = im.memorize('FILE');
if ~isfile(file) && is_braph_testing()
    im.uigetfile()
    file = im.memorize('FILE');
end
if isfile(file)
    f = waitbar(0, 'Reading File ...', 'Name', BRAPH2.NAME, 'Visible', 'off');
    set_icon(f)
    set(f, 'Visible', 'on');
    try
        [~, ~, raw] = xlsread(file);
        
        % adds props
        waitbar(.15, f, 'Loading your Brain Atlas ...');
        ba.set( ...
            'ID', raw{1, 1}, ...
            'LABEL', raw{2, 1}, ...
            'NOTES', raw{3, 1} ...
            );
        
        idict = ba.get('BR_DICT');
        
        % adds brain regions
        waitbar(.45, f, 'Loading your Brain Regions ...')
        for i = 5:1:size(raw, 1)
            waitbar(.5, f, ['Loading your Brain Region: ' num2str(i - 4) '/' num2str(size(raw, 1) - 4) ' ...'])
            br = BrainRegion( ...
                'ID', raw{i, 1}, ...
                'LABEL', raw{i, 2}, ...
                'X', raw{i, 3}, ...
                'Y', raw{i, 4}, ...
                'Z', raw{i, 5}, ...
                'NOTES', raw{i, 6} ...
                );
            idict.add(br);
        end
        ba.set('br_dict', idict);
    catch e
        warndlg('Please select a valid input.', 'Warning');
        close(f)        
        rethrow(e)
    end
elseif exist('BRAPH2ISTESTING') && is_braph_testing()
    error(BRAPH2.BUG_IO);
end
if exist('f', 'var')
    waitbar(1, f, 'Finishing')
    pause(.5)
    close(f)
end
value = ba;

%% ¡methods!
function uigetfile(im)
    % UIGETFILE opens a dialog box to set the XLS/XLSX file where to save the brain atlas.
    
    [filename, filepath, filterindex] = uigetfile({'*.xlsx';'*.xls'}, 'Select Excel file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end