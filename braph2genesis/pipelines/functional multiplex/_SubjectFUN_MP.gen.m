%% ¡header!
SubjectFUN_MP < Subject (sub, subject with functional multiplex data) is a subject with functional multiplex data (e.g. multiplex fMRI).

%%% ¡description!
Subject with data for each brain region corresponding to L functional layers (e.g. activation timeseries).
For example, functional data can be fMRI or EEG.

%%% ¡seealso!
Element, Subject

%%% ¡gui!
%%%% ¡menu_importer!
uimenu(menu_import, ...
    'Label', 'Import TXT ...', ...
    'Callback', {@cb_importer_TXT});
function cb_importer_TXT(~, ~)
    im = ImporterGroupSubjectFUNMP_TXT( ...
        'ID', 'Import Group of SubjectFUNMPs from TXT', ...
        'WAITBAR', true ...
        );
    im.uigetdir();
    try
        if isfolder(im.get('DIRECTORY'))
            gr = pe.get('EL');
            
            assert( ...
                all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
                [BRAPH2.STR ':SubjectFUN_MP:' BRAPH2.BUG_FUNC], ...
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
        warndlg(['Please, select a valid input Group of SubjectFUNMPs in TXT format. ' newline() ...
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
    im = ImporterGroupSubjectFUNMP_XLS( ...
        'ID', 'Import Group of SubjectFUNMPs from XLS', ...
        'WAITBAR', true ...
        );
    im.uigetdir();
    try
        if isfolder(im.get('DIRECTORY'))
            gr = pe.get('EL');
            
            assert( ...
                all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
                [BRAPH2.STR ':SubjectFUN_MP:' BRAPH2.BUG_FUNC], ...
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
        warndlg(['Please, select a valid input Group of SubjectFUNMPs in XLS format. ' newline() ...
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
    ex = ExporterGroupSubjectFUNMP_TXT( ...
        'ID', 'Export Brain Group of SubjectFUNMps to TXT', ...
        'GR', el.copy(), ...
        'WAITBAR', true ...
        );
    ex.uigetdir()
    if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectFUNMP_TXT.getPropDefault('DIRECTORY'))
        ex.get('SAVE');
    end
end

uimenu(menu_export, ...
    'Label', 'Export XLS ...', ...
    'Callback', {@cb_exporter_XLS});
function cb_exporter_XLS(~, ~)
    ex = ExporterGroupSubjectFUNMP_XLS( ...
        'ID', 'Export Brain Group of SubjectFUNMps to XLS', ...
        'GR', el.copy(), ...
        'WAITBAR', true ...
        );
    ex.uigetdir()
    if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectFUNMP_XLS.getPropDefault('DIRECTORY'))
        ex.get('SAVE');
    end
end

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
L (data, scalar) is the number of layers of subject.
%%%% ¡default!
2

%%% ¡prop!
FUN_MP (data, cell) is a cell containing L matrices with each column corresponding to the time series of a brain region.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').length();
num_layers = sub.get('L');
check = (iscell(value) && isequal(length(value), num_layers)  && isequal( cellfun(@(v) size(v, 2), value), ones(1, num_layers)*br_number)) || (isempty(value) && br_number == 0); 
if check
    msg = 'All ok!';
else   
    msg = ['FUN_MP must be a cell with L matrices with the same number of columns as the number of brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pr = PPMultiplexFUNMP_FUNMP('EL', sub, 'PROP', SubjectFUN_MP.FUN_MP, varargin{:});
 
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