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
uimenu(menu_import, ...
    'Label', 'Import TXT ...', ...
    'Callback', {@cb_importer_TXT});
function cb_importer_TXT(~, ~)
    im = ImporterBrainAtlasTXT( ...
        'ID', 'Import Brain Atlas from TXT', ...
        'WAITBAR', true ...
        );
    im.uigetfile();
    try
        if isfile(im.get('FILE'))
            % pe.set('EL', im.get('PIP')); 
            % pe.reinit();

            ba = pe.get('EL');
            
            assert( ...
                all(cellfun(@(prop) ~ba.isLocked(prop), num2cell(ba.getProps()))), ...
                [BRAPH2.STR ':BrainAtlas:' BRAPH2.BUG_FUNC], ...
                'To import an element, all its properties must be unlocked.' ...
                )
            
            ba_new = im.get('BA');
            for prop = 1:1:ba.getPropNumber()
                if ba.getPropCategory(prop) ~= Category.RESULT
                    ba.set(prop, ba_new.get(prop))
                end
            end
            
            pe.reinit(ba_new);
        end
    catch e
        warndlg(['Please, select a valid input BrainAtlas in TXT format. ' newline() ...
            newline() ...
            'Error message:' newline() ...
            newline() ...
            e.message newline()], 'Warning');
    end
end

uimenu(menu_import, ...
    'Label', 'Import XLS ...', ...
    'Callback', {@cb_importer_XLS});
function cb_importer_XLS(~, ~)
    im = ImporterBrainAtlasXLS( ...
        'ID', 'Import Brain Atlas from XLS', ...
        'WAITBAR', true ...
        );
    im.uigetfile();
    try
        if isfile(im.get('FILE'))
            % pe.set('EL', im.get('PIP')); 
            % pe.reinit();

            ba = pe.get('EL');
            
            assert( ...
                all(cellfun(@(prop) ~ba.isLocked(prop), num2cell(ba.getProps()))), ...
                [BRAPH2.STR ':BrainAtlas:' BRAPH2.BUG_FUNC], ...
                'To import an element, all its properties must be unlocked.' ...
                )
            
            ba_new = im.get('BA');
            for prop = 1:1:ba.getPropNumber()
                if ba.getPropCategory(prop) ~= Category.RESULT
                    ba.set(prop, ba_new.get(prop))
                end
            end
            
            pe.reinit(ba_new);
        end
    catch e
        warndlg(['Please, select a valid input BrainAtlas in XLS format. ' newline() ...
            newline() ...
            'Error message:' newline() ...
            newline() ...
            e.message newline()], 'Warning');
    end
end

%%%% ¡menu_exporter!
uimenu(menu_export, ...
    'Label', 'Export TXT ...', ...
    'Callback', {@cb_exporter_TXT});
function cb_exporter_TXT(~, ~)
    ex = ExporterBrainAtlasTXT( ...
        'ID', 'Export Brain Atlas to TXT', ...
        'BA', el.copy(), ...
        'WAITBAR', true ...
        );
    ex.uiputfile()
    if ~strcmp(ex.get('FILE'), ExporterBrainAtlasTXT.getPropDefault('FILE'))
        ex.get('SAVE');
    end
end

uimenu(menu_export, ...
    'Label', 'Export XLS ...', ...
    'Callback', {@cb_exporter_XLS});
function cb_exporter_XLS(~, ~)
    ex = ExporterBrainAtlasXLS( ...
        'ID', 'Export Brain Atlas to XLS', ...
        'BA', el.copy(), ...
        'WAITBAR', true ...
        );
    ex.uiputfile()
    if ~strcmp(ex.get('FILE'), ExporterBrainAtlasXLS.getPropDefault('FILE'))
        ex.get('SAVE');
    end
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
pr = PPBrainAtlas_BRDict('EL', ba, 'PROP', BrainAtlas.BR_DICT, varargin{:});

%%% ¡prop!
SURF (metadata, item) contains the brain surface of the brain atlas.
%%%% ¡settings!
'BrainSurface'
%%%% ¡default!
ImporterBrainSurfaceNV('FILE', 'human_ICBM152.nv').get('SURF')
%%%% ¡gui!
pr = PPBrainAtlas_Surf('EL', ba, 'PROP', BrainAtlas.SURF, varargin{:});

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
