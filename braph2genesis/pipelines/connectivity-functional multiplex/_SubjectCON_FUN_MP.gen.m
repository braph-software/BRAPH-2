%% ¡header!
SubjectCON_FUN_MP < Subject (sub, subject with connectivity and functional multiplex data) is a subject with connectivity and functional multiplex data (e.g. DTI and fMRI).

%%% ¡description!
Subject with a connectivity and functional multiplex data (e.g. obtained from DTI and fMRI).
The first layer contains a connectivity matrix and the second layer contains functional data.

%%% ¡seealso!
SubjectCON, SubjectFUN

%%% ¡_gui!

% % % %%%% ¡menu_importer!
% % % uimenu(menu_import, ...
% % %     'Label', 'Import TXT ...', ...
% % %     'Callback', {@cb_importer_TXT});
% % % function cb_importer_TXT(~, ~)
% % %     im = ImporterGroupSubjectCON_FUN_MP_TXT( ...
% % %         'ID', 'Import Group of SubjectConFunMps from TXT', ...
% % %         'WAITBAR', true ...
% % %         );
% % %     
% % %     if ~braph2_testing()
% % %         answer = questdlg('Please Upload a Connectivity Group', ...
% % %             'User Request', ...
% % %             'Ok', 'Cancel', 'Ok');
% % %         switch answer
% % %             case 'Ok'
% % %                 im.uigetdir('DIR_TYPE','DIRECTORY_CON');
% % %             case 'Cancel'
% % %                 return;
% % %         end
% % %     end
% % %     
% % %     if ~braph2_testing()
% % %         answerfun = questdlg('Please Upload a Functional Group', ...
% % %             'User Request', ...
% % %             'Ok', 'Cancel', 'Ok');
% % %         switch answerfun
% % %             case 'Ok'
% % %                 im.uigetdir('DIR_TYPE','DIRECTORY_FUN');
% % %             case 'Cancel'
% % %                 return;
% % %         end
% % %     end
% % %     
% % %     try
% % %         if isfolder(im.get('DIRECTORY_CON')) && isfolder(im.get('DIRECTORY_FUN'))
% % %             gr = pe.get('EL');
% % %             
% % %             assert( ...
% % %                 all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
% % %                 [BRAPH2.STR ':SubjectCON_FUN_MP:' BRAPH2.BUG_FUNC], ...
% % %                 'To import an element, all its properties must be unlocked.' ...
% % %                 )
% % %             
% % %             gr_new = im.get('GR');
% % %             for prop = 1:1:gr.getPropNumber()
% % %                 if gr.getPropCategory(prop) ~= Category.RESULT
% % %                     gr.set(prop, gr_new.get(prop))
% % %                 end
% % %             end
% % %             
% % %             pe.reinit(gr_new);
% % %         end
% % %     catch e
% % %         warndlg(['Please, select a valid input Group of SubjectCON_FUN_MP in TXT format. ' newline() ...
% % %             newline() ...
% % %             'Error message:' newline() ...
% % %             newline() ...
% % %             e.message newline()], 'Warning');
% % %     end
% % % end
% % % 
% % % uimenu(menu_import, ...
% % %     'Label', 'Import XLS ...', ...
% % %     'Callback', {@cb_importer_XLS});
% % % function cb_importer_XLS(~, ~)
% % %     im = ImporterGroupSubjectCON_FUN_MP_XLS( ...
% % %         'ID', 'Import Group of SubjectConFunMps from XLS', ...
% % %         'WAITBAR', true ...
% % %         );
% % %     answer = questdlg('Please Upload a Connectivity Group', ...
% % %         'Dessert Menu', ...
% % %         'Ok', 'Cancel', 'Ok');
% % %     switch answer
% % %         case 'Ok'
% % %             im.uigetdir('DIR_TYPE','DIRECTORY_CON');
% % %         case 'Cancel'
% % %             return;
% % %     end
% % %     answerfun = questdlg('Please Upload a Functional Group', ...
% % %         'Dessert Menu', ...
% % %         'Ok', 'Cancel', 'Ok');
% % %     switch answerfun
% % %         case 'Ok'
% % %             im.uigetdir('DIR_TYPE','DIRECTORY_FUN');
% % %         case 'Cancel'
% % %             return;
% % %     end
% % %     try
% % %         if isfolder(im.get('DIRECTORY_CON')) && isfolder(im.get('DIRECTORY_FUN'))
% % %             gr = pe.get('EL');
% % %             
% % %             assert( ...
% % %                 all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
% % %                 [BRAPH2.STR ':SubjectCON_FUN_MP:' BRAPH2.BUG_FUNC], ...
% % %                 'To import an element, all its properties must be unlocked.' ...
% % %                 )
% % %             
% % %             gr_new = im.get('GR');
% % %             for prop = 1:1:gr.getPropNumber()
% % %                 if gr.getPropCategory(prop) ~= Category.RESULT
% % %                     gr.set(prop, gr_new.get(prop))
% % %                 end
% % %             end
% % %             
% % %             pe.reinit(gr_new);
% % %         end
% % %     catch e
% % %         warndlg(['Please, select a valid input Group of SubjectCON_FUN_MPs in XLS format. ' newline() ...
% % %             newline() ...
% % %             'Error message:' newline() ...
% % %             newline() ...
% % %             e.message newline()], 'Warning');
% % %     end
% % % end
% % % 
% % % %%%% ¡menu_exporter!
% % % uimenu(menu_export, ...
% % %     'Label', 'Export TXT ...', ...
% % %     'Callback', {@cb_exporter_TXT});
% % % function cb_exporter_TXT(~, ~)
% % %     ex = ExporterGroupSubjectCON_FUN_MP_TXT( ...
% % %         'ID', 'Export Brain Group of SubjectConFunMps to TXT', ...
% % %         'GR', el.copy(), ...
% % %         'WAITBAR', true ...
% % %         );
% % %     ex.uigetdir()
% % %     if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectCON_FUN_MP_TXT.getPropDefault('DIRECTORY'))
% % %         ex.get('SAVE');
% % %     end
% % % end
% % % 
% % % uimenu(menu_export, ...
% % %     'Label', 'Export XLS ...', ...
% % %     'Callback', {@cb_exporter_XLS});
% % % function cb_exporter_XLS(~, ~)
% % %     ex = ExporterGroupSubjectCON_FUN_MP_XLS( ...
% % %         'ID', 'Export Brain Group of SubjectConFunMps to XLS', ...
% % %         'GR', el.copy(), ...
% % %         'WAITBAR', true ...
% % %         );
% % %     ex.uigetdir()
% % %     if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectCON_FUN_MP_XLS.getPropDefault('DIRECTORY'))
% % %         ex.get('SAVE');
% % %     end
% % % end

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'SubjectCON_FUN_MP'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject with a connectivity and functional multiplex data (e.g. obtained from DTI and fMRI). The first layer contains a connectivity matrix and the second layer contains functional data.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectCON_FUN_MP'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectCON_FUN_MP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectCON_FUN_MP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectCON_FUN_MP notes'

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.
%%%% ¡default!
{'CON', 'FUN'}

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the processed layer labels.
%%%% ¡calculate!
value = sub.get('LAYERLABELS');

%%% ¡prop!
CON_FUN_MP (data, cell) is a cell containing with connectivity and functional data.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
num_layers = 2;
check = (iscell(value) && isequal(length(value), num_layers)  && isequal(size(value{1}), [br_number, br_number]) && isequal(size(value{2}, 2), br_number)) || (isempty(value) && br_number == 0); 
if check
    msg = 'All ok!';
else   
    msg = ['CON_FUN_MP must be a cell with two matrices, ' ...
           'the first with the same number of rows and columns as the brain regions (' int2str(br_number) 'x' int2str(br_number) ', connectivity data), ' ...
           'and the second with the same number of columns as the brain regions (' int2str(br_number) ', functional data).'];
end
%%%% ¡gui!
pr = PanelPropCell('EL', sub, 'PROP', SubjectCON_FUN_MP.CON_FUN_MP, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', true, ...
    'XSLIDERLABELS', sub.getCallback('ALAYERLABELS'), ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    'COLUMNNAME', {'numbered'}, ... % % % Improve to make it different for the two layers, probably it requires changes to PanelPropCell
    varargin{:});

%%% ¡_prop!
% % % age (data, scalar) is a scalar number containing the age of the subject.
% % % %%%% ¡default!
% % % 0

%%% ¡_prop!
% % % sex (data, option) is an option containing the sex of the subject (female/male).
% % % %%%% ¡default!
% % % 'unassigned'
% % % %%%% ¡settings!
% % % {'Female', 'Male', 'unassigned'}

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡parallel!
false
%%%% ¡code!
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectCON_FUN_MP')) filesep 'example data CON-FUN_MP' filesep 'aal90_atlas.xlsx']);
ba = im_ba.get('BA');

gr = Group('SUB_CLASS', 'SubjectCON_FUN_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON_FUN_MP'));
for i = 1:1:10
    sub = SubjectCON_FUN_MP( ...
        'ID', ['SUB CON-FUN_MP ' int2str(i)], ...
        'LABEL', ['Subejct CON-FUN_MP ' int2str(i)], ...
        'NOTES', ['Notes on subject CON-FUN_MP ' int2str(i)], ...
        'BA', ba, ... % % %     'age', 75, ... % % %     'sex', 'female', ...
        'LAYERLABELS', {'con' 'fun'}, ...
        'CON_FUN_MP', {rand(ba.get('BR_DICT').get('LENGTH')), rand(10, ba.get('BR_DICT').get('LENGTH'))} ...
        );
    gr.get('SUB_DICT').get('ADD', sub)
end

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')