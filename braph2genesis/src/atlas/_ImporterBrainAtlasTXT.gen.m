%% ¡header!
ImporterBrainAtlasTXT < Importer (im, importer of brain atlas from TXT) imports a brain atlas from a TXT file.

%%% ¡description!
ImporterBrainAtlasTXT imports a brain atlas from a TXT file.
The TXT file consists of 6 columns. It reads as follows: 
BrainAtlas ID (column 1), BrainAtlas LABEL (column 2), 
BrainRegions (column 3-5; coordinates x, y, z, one per column) and 
BrainAtlas NOTES (column 6). Each column is separated by tabs.

%%% ¡seealso!
Element, Importer, ExporterBrainAtlasTXT.

%% ¡props!

%%% ¡prop!
FILE (data, string) is the TXT file from where to load the brain atlas.

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
file = im.get('FILE');
if ~isfile(file) && is_braph_testing()
    im.uigetfile()
    file = im.memorize('FILE');
end
if isfile(file)
    f = waitbar(0, 'Reading File ...', 'Name', BRAPH2.NAME, 'Visible', 'off');
    set_icon(f)
    set(f, 'Visible', 'on');
    try
        raw = textread(file, '%s', 'delimiter', '\t', 'whitespace', '');
        raw = raw(~cellfun('isempty', raw));  % remove empty cells
        
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
        for i = 4:6:size(raw, 1)
            waitbar(.5, f, ['Loading your Brain Region: ' num2str(i - 4) '/' num2str(size(raw, 1) - 3) ' ...'])
            br = BrainRegion( ...
                'ID', char(raw{i, 1}), ...
                'LABEL', char(raw{i+1, 1}), ...
                'X', str2double(raw{i+2, 1}), ...
                'Y', str2double(raw{i+3, 1}), ...
                'Z', str2double(raw{i+4, 1}), ...
                'NOTES', char(raw{i+5, 1}) ...
                );
            idict.add(br);
        end
        ba.set('br_dict', idict);
    catch e
        warndlg('Please select a valid input.', 'Warning');
        close(f)        
        rethrow(e)        
    end
elseif exist('BRAPH2ISTESTING') && ~BRAPH2ISTESTING
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
    % UIGETFILE opens a dialog box to set the TXT file where to save the brain atlas.
    [filename, filepath, filterindex] = uigetfile('*.txt', 'Select TXT file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end