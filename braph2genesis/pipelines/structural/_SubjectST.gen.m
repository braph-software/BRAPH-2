%% ¡header!
SubjectST < Subject (sub, subject with structural data) is a subject with structural data (e.g. sMRI).

%%% ¡description!
Subject with structural data (e.g. cortical thickness) for each brain region.
For example, structural data can be structural MRI.

%%% ¡seealso!
Element, Subject

%%% ¡gui!

%%%% ¡menu_importer!
uimenu(menu_import, ...
    'Label', 'Import TXT ...', ...
    'Callback', {@cb_importer_TXT});
function cb_importer_TXT(~, ~)
    im = ImporterGroupSubjectST_TXT( ...
        'ID', 'Import Group of SubjectSts from TXT', ...
        'WAITBAR', true ...
        );
    im.uigetfile();
    try
        if isfile(im.get('FILE'))
            % pe.set('EL', im.get('GR')); 
            % pe.reinit();
            
            gr = pe.get('EL');
            
            assert( ...
                all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
                [BRAPH2.STR ':SubjectST:' BRAPH2.BUG_FUNC], ...
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
        warndlg(['Please, select a valid input Group of SubjectSts in TXT format. ' newline() ...
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
    im = ImporterGroupSubjectST_XLS( ...
        'ID', 'Import Group of SubjectSts from XLS', ...
        'WAITBAR', true ...
        );
    im.uigetfile();
    try
        if isfile(im.get('FILE'))
            % pe.set('EL', im.get('GR')); 
            % pe.reinit();
            
            gr = pe.get('EL');
            
            assert( ...
                all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
                [BRAPH2.STR ':SubjectST:' BRAPH2.BUG_FUNC], ...
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
        warndlg(['Please, select a valid input Group of SubjectSTs in XLS format. ' newline() ...
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
    ex = ExporterGroupSubjectST_TXT( ...
        'ID', 'Export Brain Group of SubjectSTs to TXT', ...
        'GR', el.copy(), ...
        'WAITBAR', true ...
        );
    ex.uiputfile()
    if ~strcmp(ex.get('FILE'), ExporterGroupSubjectST_TXT.getPropDefault('FILE'))
        ex.get('SAVE');
    end
end

uimenu(menu_export, ...
    'Label', 'Export XLS ...', ...
    'Callback', {@cb_exporter_XLS});
function cb_exporter_XLS(~, ~)
    ex = ExporterGroupSubjectST_XLS( ...
        'ID', 'Export Brain Group of SubjectSTs to XLS', ...
        'GR', el.copy(), ...
        'WAITBAR', true ...
        );
    ex.uiputfile()
    if ~strcmp(ex.get('FILE'), ExporterGroupSubjectST_XLS.getPropDefault('FILE'))
        ex.get('SAVE');
    end
end

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
ST (data, cvector) is a column vector with data for each brain region.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').length();
check = (iscolumn(value) && isequal(size(value), [br_number, 1])) || (isempty(value) && br_number == 0); % Format.checkFormat(Format.CVECTOR, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['ST must be a column vector with the same number of element as the brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pr = PPSubjectST_ST('EL', sub, 'PROP', SubjectST.ST, varargin{:});

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
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectST')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx']);
ba = im_ba.get('BA');
im_gr = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('SubjectST')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba ...
    );
gr = im_gr.get('GR');
GUI('PE', gr, 'CLOSEREQ', false).draw()

close(gcf)