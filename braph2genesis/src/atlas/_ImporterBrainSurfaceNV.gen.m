%% ¡header!
ImporterBrainSurfaceNV < Importer (im, importer of brain surface from NV) imports a brain surface from a NV file.

%%% ¡description!
ImporterBrainSurfaceNV imports a brain surface from a NV file.

%%% ¡seealso!
Element, Importer, BrainSurface.

%% ¡props!

%%% ¡prop!
FILE (data, string) is the NV file from where to load the brain atlas.
%%%% ¡default!
'human_ICBM152.nv'

%%% ¡prop!
SURF (result, item) is a brain surface.
%%%% ¡settings!
'BrainSurface'
%%%% ¡calculate!
% creates empty BrainSurface
bs = BrainSurface();

% analyzes file
file = im.get('FILE');
if ~isfile(file)
    file = [fileparts(which('braph2')) filesep 'brainsurfs' filesep file];
end

if isfile(file)
    fid = fopen(file);
    vertex_number = fscanf(fid, '%f', 1);
    coord = fscanf(fid, '%f', [3, vertex_number]);
    tri_number = fscanf(fid, '%f', 1);
    tri = fscanf(fid, '%d', [3, tri_number])';
    fclose(fid);
    
    splits = split(file, filesep);
    name = splits{end};
    
    bs.set('ID', name)
    bs.set('vertex_number', vertex_number);
    bs.set('coordinates', coord);
    bs.set('triangles_number', tri_number);
    bs.set('triangles', tri);
end

value = bs;

%% ¡methods!
function uigetfile(im)
    % UIGETFILE opens a dialog box to set the NV file where to save the brain atlas.

    [filename, filepath, filterindex] = uigetfile('*.nv', 'Select NV file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end