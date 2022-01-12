%% ¡header!
SubjectCON_FUN_MP < Subject (sub, subject with connectivity and functional multiplex data) is a subject with connectivity and functional multiplex data (e.g. DTI and fMRI).

%%% ¡description!
Subject with a connectivity and functional multiplex data (e.g. obtained from DTI and fMRI).
The first layer contains a connectivity matrix and the second layer contains functional data.

%%% ¡seealso!
Element, Subject, SubjectCON, SubjectFUN

%%% ¡gui!
%%%% ¡menu_importer!
uimenu(menu_import, ...
    'Label', 'Import TXT ...', ...
    'Callback', {@cb_importer_TXT});
function cb_importer_TXT(~, ~)
    im = ImporterGroupSubjectCON_FUN_MP_TXT( ...
        'ID', 'Import Group of SubjectConFunMps from TXT', ...
        'WAITBAR', true ...
        );
    im.uigetdir('DIR_TYPE','DIRECTORY_CON');
    im.uigetdir('DIR_TYPE','DIRECTORY_FUN');
    try
        if isfolder(im.get('DIRECTORY_CON')) && isfolder(im.get('DIRECTORY_FUN'))
            gr = pe.get('EL');
            
            assert( ...
                all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
                [BRAPH2.STR ':SubjectCON_FUN_MP:' BRAPH2.BUG_FUNC], ...
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
        warndlg(['Please, select a valid input Group of SubjectCON_FUN_MP in TXT format. ' newline() ...
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
    im = ImporterGroupSubjectCON_FUN_MP_XLS( ...
        'ID', 'Import Group of SubjectConFunMps from XLS', ...
        'WAITBAR', true ...
        );
    im.uigetdir('DIR_TYPE','DIRECTORY_CON');
    im.uigetdir('DIR_TYPE','DIRECTORY_FUN');
    try
        if isfolder(im.get('DIRECTORY_CON')) && isfolder(im.get('DIRECTORY_FUN'))
            gr = pe.get('EL');
            
            assert( ...
                all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
                [BRAPH2.STR ':SubjectCON_FUN_MP:' BRAPH2.BUG_FUNC], ...
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
        warndlg(['Please, select a valid input Group of SubjectCON_FUN_MPs in XLS format. ' newline() ...
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
    ex = ExporterGroupSubjectCON_FUN_MP_TXT( ...
        'ID', 'Export Brain Group of SubjectConFunMps to TXT', ...
        'GR', el.copy(), ...
        'WAITBAR', true ...
        );
    ex.uigetdir()
    if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectCON_FUN_MP_TXT.getPropDefault('DIRECTORY'))
        ex.get('SAVE');
    end
end

uimenu(menu_export, ...
    'Label', 'Export XLS ...', ...
    'Callback', {@cb_exporter_XLS});
function cb_exporter_XLS(~, ~)
    ex = ExporterGroupSubjectCON_FUN_MP_XLS( ...
        'ID', 'Export Brain Group of SubjectConFunMps to XLS', ...
        'GR', el.copy(), ...
        'WAITBAR', true ...
        );
    ex.uigetdir()
    if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectCON_FUN_MP_XLS.getPropDefault('DIRECTORY'))
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
L (data, scalar) is the number of multiplex layers of subject.
%%%% ¡default!
2

%%% ¡prop!
CON_FUN_MP (data, cell) is a cell containing with connectivity and functional data.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').length();
num_layers = sub.get('L');
check = (iscell(value) && isequal(length(value), num_layers)  && isequal(size(value{1}), [br_number, br_number]) && isequal(size(value{2}, 2), br_number)) || (isempty(value) && br_number == 0); 
if check
    msg = 'All ok!';
else   
    msg = ['CON_FUN_MP must be a cell with two matrices, ' ...
           'the first with the same number of rows and columns as the brain regions (' int2str(br_number) 'x' int2str(br_number) ', connectivity data), ' ...
           'and the second with the same number of columns as the brain regions (' int2str(br_number) ', functional data).'];
end
%%%% ¡gui!
pr = PPSubjectCON_FUN_MP_CON_FUN_MP('EL', sub, 'PROP', SubjectCON_FUN_MP.CON_FUN_MP, varargin{:});
 
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