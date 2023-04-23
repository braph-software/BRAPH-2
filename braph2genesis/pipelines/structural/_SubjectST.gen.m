%% ¡header!
SubjectST < Subject (sub, subject with structural data) is a subject with structural data (e.g. sMRI).

%%% ¡description!
Subject with structural data (e.g. cortical thickness) for each brain region.
For example, structural data can be structural MRI.

%%% ¡_gui!

% % % %%%% ¡menu_importer!
% % % uimenu(menu_import, ...
% % %     'Label', 'Import TXT ...', ...
% % %     'Callback', {@cb_importer_TXT});
% % % function cb_importer_TXT(~, ~)
% % %     im = ImporterGroupSubjectST_TXT( ...
% % %         'ID', 'Import Group of SubjectSts from TXT', ...
% % %         'WAITBAR', true ...
% % %         );
% % %     im.uigetfile();
% % %     try
% % %         if isfile(im.get('FILE'))
% % %             gr = pe.get('EL');
% % %             
% % %             assert( ...
% % %                 all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
% % %                 [BRAPH2.STR ':SubjectST:' BRAPH2.BUG_FUNC], ...
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
% % %         warndlg(['Please, select a valid input Group of SubjectSts in TXT format. ' newline() ...
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
% % %     im = ImporterGroupSubjectST_XLS( ...
% % %         'ID', 'Import Group of SubjectSts from XLS', ...
% % %         'WAITBAR', true ...
% % %         );
% % %     im.uigetfile();
% % %     try
% % %         if isfile(im.get('FILE'))
% % %             gr = pe.get('EL');
% % %             
% % %             assert( ...
% % %                 all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
% % %                 [BRAPH2.STR ':SubjectST:' BRAPH2.BUG_FUNC], ...
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
% % %         warndlg(['Please, select a valid input Group of SubjectSTs in XLS format. ' newline() ...
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
% % %     ex = ExporterGroupSubjectST_TXT( ...
% % %         'ID', 'Export Brain Group of SubjectSTs to TXT', ...
% % %         'GR', el.copy(), ...
% % %         'WAITBAR', true ...
% % %         );
% % %     ex.uiputfile()
% % %     if ~strcmp(ex.get('FILE'), ExporterGroupSubjectST_TXT.getPropDefault('FILE'))
% % %         ex.get('SAVE');
% % %     end
% % % end
% % % 
% % % uimenu(menu_export, ...
% % %     'Label', 'Export XLS ...', ...
% % %     'Callback', {@cb_exporter_XLS});
% % % function cb_exporter_XLS(~, ~)
% % %     ex = ExporterGroupSubjectST_XLS( ...
% % %         'ID', 'Export Brain Group of SubjectSTs to XLS', ...
% % %         'GR', el.copy(), ...
% % %         'WAITBAR', true ...
% % %         );
% % %     ex.uiputfile()
% % %     if ~strcmp(ex.get('FILE'), ExporterGroupSubjectST_XLS.getPropDefault('FILE'))
% % %         ex.get('SAVE');
% % %     end
% % % end

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'SubjectST'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject with structural data (e.g. cortical thickness) for each brain region. For example, structural data can be structural MRI.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectST'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectST ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectST label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectST notes'

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
ST (data, cvector) is a column vector with data for each brain region.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
check = (iscolumn(value) && isequal(size(value), [br_number, 1])) || (isempty(value) && br_number == 0); % Format.checkFormat(Format.CVECTOR, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['ST must be a column vector with the same number of element as the brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pr = PanelPropMatrix('EL', sub, 'PROP', SubjectST.ST, ...
    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    'COLUMNNAME', {}, ...
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
% % % im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('SubjectST')) filesep 'example data ST' filesep 'destrieux_atlas.xlsx']);
% % % ba = im_ba.get('BA');
% % % im_gr = ImporterGroupSubjectST_XLS( ...
% % %     'FILE', [fileparts(which('SubjectST')) filesep 'example data ST' filesep 'xls' filesep 'ST_Group_1.xlsx'], ...
% % %     'BA', ba, ...
% % %     'WAITBAR', true ...
% % %     );
% % % gr = im_gr.get('GR');
% % % 
% % % gui = GUIElement('PE', gr, 'CLOSEREQ', false);
% % % gui.get('DRAW')
% % % gui.get('SHOW')
% % % 
% % % gui.get('CLOSE')