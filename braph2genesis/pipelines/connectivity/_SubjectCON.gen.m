%% ¡header!
SubjectCON < Subject (sub, subject with connectivity matrix) is a subject with connectivity matrix (e.g. DTI).

%%% ¡description!
Subject with a connectivity matrix (e.g. obtained from DTI).

%%% ¡_gui!

% % % %%%% ¡menu_importer!
% % % uimenu(menu_import, ...
% % %     'Label', 'Import TXT ...', ...
% % %     'Callback', {@cb_importer_TXT});
% % % function cb_importer_TXT(~, ~)
% % %     im = ImporterGroupSubjectCON_TXT( ...
% % %         'ID', 'Import Group of SubjectCons from TXT', ...
% % %         'WAITBAR', true ...
% % %         );
% % %     im.uigetdir();
% % %     try
% % %         if isfolder(im.get('DIRECTORY'))
% % %             gr = pe.get('EL');
% % %             
% % %             assert( ...
% % %                 all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
% % %                 [BRAPH2.STR ':SubjectCON:' BRAPH2.BUG_FUNC], ...
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
% % %         warndlg(['Please, select a valid input Group of SubjectCONs in TXT format. ' newline() ...
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
% % %     im = ImporterGroupSubjectCON_XLS( ...
% % %         'ID', 'Import Group of SubjectCons from XLS', ...
% % %         'WAITBAR', true ...
% % %         );
% % %     im.uigetdir();
% % %     try
% % %         if isfolder(im.get('DIRECTORY'))
% % %             gr = pe.get('EL');
% % %             
% % %             assert( ...
% % %                 all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
% % %                 [BRAPH2.STR ':SubjectCON:' BRAPH2.BUG_FUNC], ...
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
% % %         warndlg(['Please, select a valid input Group of SubjectCONs in XLS format. ' newline() ...
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
% % %     ex = ExporterGroupSubjectCON_TXT( ...
% % %         'ID', 'Export Brain Group of SubjectCons to TXT', ...
% % %         'GR', el.copy(), ...
% % %         'WAITBAR', true ...
% % %         );
% % %     ex.uigetdir()
% % %     if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectCON_TXT.getPropDefault('DIRECTORY'))
% % %         ex.get('SAVE');
% % %     end
% % % end
% % % 
% % % uimenu(menu_export, ...
% % %     'Label', 'Export XLS ...', ...
% % %     'Callback', {@cb_exporter_XLS});
% % % function cb_exporter_XLS(~, ~)
% % %     ex = ExporterGroupSubjectCON_XLS( ...
% % %         'ID', 'Export Brain Group of SubjectCons to XLS', ...
% % %         'GR', el.copy(), ...
% % %         'WAITBAR', true ...
% % %         );
% % %     ex.uigetdir()
% % %     if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectCON_XLS.getPropDefault('DIRECTORY'))
% % %         ex.get('SAVE');
% % %     end
% % % end

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'SubjectCON'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'SubjectCON with a connectivity matrix (e.g. obtained from DTI).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectCON'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectCON ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectCON label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectCON notes'

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
CON (data, smatrix) is an adjacency matrix.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
check = isequal(size(value), [br_number, br_number]); % Format.checkFormat(Format.SMATRIX, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['CON must be a square matrix with the dimensiton equal to the number of brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pr = PanelPropMatrix('EL', sub, 'PROP', SubjectCON.CON, ...
    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    'COLUMNNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    varargin{:});

%%% ¡_prop!
% % % age (data, scalar) is a scalar number containing the age of the subject.
% % % %%%% ¡_default!
% % % 0

%%% ¡_prop!
% % % sex (data, option) is an option containing the sex of the subject (female/male).
% % % %%%% ¡_default!
% % % 'unassigned'
% % % %%%% ¡_settings!
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
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectCON')) filesep 'example data CON' filesep 'desikan_atlas.xlsx']);
ba = im_ba.get('BA');
im_gr = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON')) filesep 'example data CON' filesep 'xls' filesep 'CON_Group_1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );
gr = im_gr.get('GR');

gui = GUIElement('PE', gr, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')