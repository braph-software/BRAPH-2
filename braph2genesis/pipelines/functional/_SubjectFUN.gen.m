%% ¡header!
SubjectFUN < Subject (sub, subject with functional matrix) is a subject with functional matrix (e.g. fMRI).

%%% ¡description!
Subject with a functional matrix (e.g. obtained from fMRI).

%%% ¡seealso!
Element, Subject

%%% ¡gui!
%%%% ¡menu_importer!
uimenu(menu_import, ...
    'Label', 'Import TXT ...', ...
    'Callback', {@cb_importer_TXT});
function cb_importer_TXT(~, ~)
    im = ImporterGroupSubjectFUN_TXT( ...
        'ID', 'Import Group of SubjectCons from TXT', ...
        'WAITBAR', true ...
        );
    im.uigetdir();
    try
        if isfolder(im.get('DIRECTORY'))
            gr = pe.get('EL');
            
            assert( ...
                all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
                [BRAPH2.STR ':SubjectFUN:' BRAPH2.BUG_FUNC], ...
                'To import an element, all its properties must be unlocked.' ...
                )
            
            gr_new = im.get('GR');
            for prop = 1:1:gr.getPropNumber()
                if gr.getPropCategory(prop) ~= Category.RESULT
                    gr.set(prop, gr_new.get(prop))
                end
            end
            
            pe.reinit(gr_new);
        end
    catch e
        warndlg(['Please, select a valid input Group of SubjectCons in TXT format. ' newline() ...
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
    im = ImporterGroupSubjectFUN_XLS( ...
        'ID', 'Import Group of SubjectCons from XLS', ...
        'WAITBAR', true ...
        );
    im.uigetdir();
    try
        if isfolder(im.get('DIRECTORY'))
            gr = pe.get('EL');
            
            assert( ...
                all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
                [BRAPH2.STR ':SubjectFUN:' BRAPH2.BUG_FUNC], ...
                'To import an element, all its properties must be unlocked.' ...
                )
            
            gr_new = im.get('GR');
            for prop = 1:1:gr.getPropNumber()
                if gr.getPropCategory(prop) ~= Category.RESULT
                    gr.set(prop, gr_new.get(prop))
                end
            end
            
            pe.reinit(gr_new);
        end
    catch e
        warndlg(['Please, select a valid input Group of SubjectCons in XLS format. ' newline() ...
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
    ex = ExporterGroupSubjectFUN_TXT( ...
        'ID', 'Export Brain Group of SubjectCons to TXT', ...
        'GR', el.copy(), ...
        'WAITBAR', true ...
        );
    ex.uigetdir()
    if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectFUN_TXT.getPropDefault('DIRECTORY'))
        ex.get('SAVE');
    end
end

uimenu(menu_export, ...
    'Label', 'Export XLS ...', ...
    'Callback', {@cb_exporter_XLS});
function cb_exporter_XLS(~, ~)
    ex = ExporterGroupSubjectFUN_XLS( ...
        'ID', 'Export Brain Group of SubjectCons to XLS', ...
        'GR', el.copy(), ...
        'WAITBAR', true ...
        );
    ex.uigetdir()
    if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectFUN_XLS.getPropDefault('DIRECTORY'))
        ex.get('SAVE');
    end
end

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()

%%% ¡prop!
FUN (data, matrix) is an adjacency matrix.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').length();
check = size(value, 2) == br_number; % Format.checkFormat(Format.MATRIX, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['FUN must be a matrix with the same number of columns as the brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pr = PanelPropMatrix('EL', sub, 'PROP', SubjectFUN.FUN, ...
    'ROWNAME', 'pr.get(''EL'').get(''BA'').get(''BR_DICT'').getKeys()', ...
    'COLUMNNAME', '''numbered''', ...
    varargin{:});
 
%%% ¡prop!
age (data, scalar) is a scalar number containing the age of the subject.
%%%% ¡default!
0

%%% ¡prop!
sex (data, option) is an option containing the sex of the subject (female/male).
%%%% ¡default!
'unassigned'
%%%% ¡settings!
{'Female', 'Male', 'unassigned'}

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectFUN')) filesep 'example data FUN (fMRI)' filesep 'craddock_atlas.xlsx']);
ba = im_ba.get('BA');
im_gr = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectFUN')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba ...
    );
gr = im_gr.get('GR');
f = GUIElement('PE', gr, 'CLOSEREQ', false).draw();

close(f)