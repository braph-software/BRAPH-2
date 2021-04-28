%EXAMPLE_FUN_WU
% Script example workflow FUN WU

clear variables %#ok<*NASGU>

path = fileparts(which('test_braph2'));
file = 'atlas_json';
filename = fullfile(path, file);

%% Load BrainAtlas
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
items = {br1};
idict_1 = IndexedDictionary( ...
    'id', 'idict', ...
    'it_class', 'BrainRegion', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', items ...
    );
ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'Notes', 'Notes on brain atlas.', 'br_dict', idict_1);

%% save to json
[json, ~, ~] = encodeJSON(ba);
fid = fopen(filename, 'w');
fprintf(fid, json);
fclose(fid);

%% import from json
fid = fopen(filename);
raw = fread(fid, inf);
str = char(raw');
fclose(fid);
tmp_ba = Element.decodeJSON(str);

assert(isequal(ba, tmp_ba), ...
    [BRAPH2.STR ':JSON:' BRAPH2.BUG_JSON], ...
    'Error in JSON encode/decode');