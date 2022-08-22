%% ¡header!
ImporterROINIFTI < Importer (im, importer of brain ROIS) imports a brain rois from an NIFTI file.

%%% ¡description!
ImporterROINIFTI imports a brain rois from an NIFTI file.
It will throw an error is problems occur during the import.
It throws an error is problems occur during the import.

%%% ¡seealso!
Element, Importer.

%% ¡props!

%%% ¡prop!
FILE (data, string) is the NIFTI file from where to load the brain roi.

%%% ¡prop!
ROI_DICT (result, idict) is a brain roi dictionary.
%%%% ¡settings!
'BrainROISurface'
%%%% ¡calculate!
% creates empty BrainSurface
roi_dict = IndexedDictionary('IT_CLASS', 'BrainROISurface', 'IT_KEY', 1);

% analyzes file
file = im.get('FILE');
if ~isfile(file)
    file = [fileparts(which('braph2')) filesep 'rois' filesep file];
end

if isempty(file)
    error([BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.CANCEL_IO], ...
        [BRAPH2.STR ':ImporterBrainSurfaceNV:' BRAPH2.CANCEL_IO]);
elseif isfile(file)
    wb = braph2waitbar(im.get('WAITBAR'), .15, 'Reading brain roi file ...');
    
    % get data
    data = niftiread('aal.nii');    
    
    % create rois and fill dictionary of rois
    n = length(data);
    
    for i = 1:n
        tmp_data = data;
        tmp_data(tmp_data~=(i)) = 0;
        tmp_data(tmp_data==(i)) = 1;
        smoth_data = smooth3(tmp_data);
        iss_data = isosurface(smoth_data);
        if ~isempty(iss_data.faces) && ~isempty(iss_data.vertices)            
            b_roi = BrainROISurface('ID', num2str(i), ...
                'FACES', iss_data.faces, ...
                'VERTICES', iss_data.vertices);
            roi_dict.add(b_roi);
        end
    end
    
    braph2waitbar(wb, 'close')
end

value = roi_dict;

%% ¡methods!
function uigetfile(im)
    % UIGETFILE opens a dialog box to get the NIFTI file from where to load the brain atlas.
    
    [filename, filepath, filterindex] = uigetfile({'*.nii'}, 'Select NIFTI file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end