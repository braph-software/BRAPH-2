%% ¡header!
BrainAtlas < Element (ba, brain atlas) is a brain atlas.

%%% ¡description!
BrainAtlas represents a brain atlas,
constituted by a collection of brain regions.  
BrainAtlas contains and manages brain regions inside an IndexedDictionary;
thus, it has access to all IndexedDictionary methods.
BrainAtlas can be imported/exported to .txt, .xls and .json files.

%%% ¡seealso!
Element, BrainRegion, BrainSurface, ImporterBrainAtlasXLS, ImporterBrainAtlasTXT, ExporterBrainAtlasXLS, ExporterBrainAtlasTXT

%%% ¡gui!
%%%% ¡menu_importer!
importers_names = {'ImporterBrainAtlasTXT', 'ImporterBrainAtlasXLS'};
for k = 1:length(importers_names)
    imp = importers_names{k};
    uimenu(ui_menu_import, ...
        'Label', [imp ' ...'], ...
        'Callback', {@cb_importers});
end

function cb_importers(src, ~)
    src_name = erase(src.Text, ' ...');
    imp_el = eval([src_name '()']);
    imp_el.uigetfile();
    tmp_el = imp_el.get('BA');
    delete(gcf)
    GUI(tmp_el)
end

%%%% ¡menu_exporter!
exporters_names = {'ExporterBrainAtlasTXT', 'ExporterBrainAtlasXLS'};
for k = 1:length(exporters_names)
    exp = exporters_names{k};
    uimenu(ui_menu_export, ...
        'Label', [exp ' ...'], ...
        'Callback', {@cb_exporters});
end
function cb_exporters(src, ~)
    src_name = erase(src.Text, ' ...');
    exmp_el = eval([src_name '(' '''BA''' ', el)']);
    exmp_el.uiputfile();
    exmp_el.get('SAVE');
end

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the brain atlas.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain atlas.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain atlas.

%%% ¡prop!
BR_DICT (data, idict) contains the brain regions of the brain atlas.
%%%% ¡settings!
'BrainRegion'
%%%% ¡gui!
pl = PPBrainAtlasIDict('EL', ba, 'PROP', BrainAtlas.BR_DICT, varargin{:});

%%% ¡prop!
SURF (data, item) contains the brain surface of the brain atlas.
%%%% ¡settings!
'BrainSurface'
%%%% ¡gui!
pl = PPBrainAtlasSurf('EL', ba, 'PROP', BrainAtlas.SURF, varargin{:});

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basic functions
%%%% ¡code!
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);

items = {br1, br2, br3, br4, br5, br6};

idict_1 = IndexedDictionary( ...
    'id', 'idict', ...
    'it_class', 'BrainRegion', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', items ...
    );
ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'Notes', 'Notes on brain atlas.', 'br_dict', idict_1);
assert(ischar(ba.tostring()), ...
    [BRAPH2.STR ':BrainAtlas:' BRAPH2.WRONG_OUTPUT], ...
    'BrainAtlas.tostring() must return a string.')

%%% ¡test!
%%%% ¡name!
Get methods
%%%% ¡code!
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);

items = {br1, br2, br3, br4, br5, br6};

idict_1 = IndexedDictionary( ...
    'id', 'idict', ...
    'it_class', 'BrainRegion', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', items ...
    );
ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'Notes', 'Notes on brain atlas.', 'br_dict', idict_1);

assert(isequal(ba.get('ID'), 'BA1'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainAtlas.get() does not work.')
assert(isequal(ba.get('LABEL'), 'brain atlas'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainAtlas.get() does not work.')
assert(isequal(ba.get('NOTES'), 'Notes on brain atlas.'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainAtlas.get() does not work.')
assert(isequal(ba.get('BR_DICT'), idict_1), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainAtlas.get() does not work.')

%%% ¡test!
%%%% ¡name!
Set methods
%%%% ¡code!
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);

items = {br1, br2, br3, br4, br5, br6};

idict_1 = IndexedDictionary( ...
    'id', 'idict', ...
    'it_class', 'BrainRegion', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', items ...
    );
ba = BrainAtlas();
ba.set('ID', 'BA1');
ba.set('LABEL', 'brain atlas');
ba.set('NOTES', 'Notes on brain atlas.');
ba.set('br_dict', idict_1);

assert(isequal(ba.get('ID'), 'BA1'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainAtlas.set() does not work.')
assert(isequal(ba.get('LABEL'), 'brain atlas'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainAtlas.set() does not work.')
assert(isequal(ba.get('NOTES'), 'Notes on brain atlas.'), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainAtlas.set() does not work.')
assert(isequal(ba.get('BR_DICT'), idict_1), ...
    [BRAPH2.STR ':' class(ba) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainAtlas.set() does not work.')

%%% ¡test!
%%%% ¡name!
Plot Brain Atlas GUI
%%%% ¡code!
br1 = BrainRegion('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'X', 1, 'Y', 1, 'Z', 1);
br2 = BrainRegion('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'X', 2, 'Y', 2, 'Z', 2);
br3 = BrainRegion('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'X', 3, 'Y', 3, 'Z', 3);
br4 = BrainRegion('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'X', 4, 'Y', 4, 'Z', 4);
br5 = BrainRegion('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'X', 5, 'Y', 5, 'Z', 5);
br6 = BrainRegion('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'X', 6, 'Y', 6, 'Z', 6);

items = {br1, br2, br3, br4, br5, br6};

idict_1 = IndexedDictionary( ...
    'id', 'idict', ...
    'it_class', 'BrainRegion', ...
    'it_key', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'it_list', items ...
    );
ba = BrainAtlas('ID', 'BA1', 'LABEL', 'brain atlas', 'Notes', 'Notes on brain atlas.', 'br_dict', idict_1);
GUI(ba);
set(gcf, 'CloseRequestFcn', 'closereq')
close(gcf)
