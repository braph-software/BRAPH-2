%% ¡header!
SubjectFUN_MP < Subject (sub, subject with functional multiplex data) is a subject with functional multiplex data (e.g. multiplex fMRI).

%%% ¡description!
Subject with data for each brain region corresponding to L functional layers (e.g. activation timeseries).
For example, functional data can be fMRI or EEG.

%%% ¡_gui!

% % % %%%% ¡menu_importer!
% % % uimenu(menu_import, ...
% % %     'Label', 'Import TXT ...', ...
% % %     'Callback', {@cb_importer_TXT});
% % % function cb_importer_TXT(~, ~)
% % %     im = ImporterGroupSubjectFUN_MP_TXT( ...
% % %         'ID', 'Import Group of SubjectFUN_MPs from TXT', ...
% % %         'WAITBAR', true ...
% % %         );
% % %     im.uigetdir();
% % %     try
% % %         if isfolder(im.get('DIRECTORY'))
% % %             gr = pe.get('EL');
% % %             
% % %             assert( ...
% % %                 all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
% % %                 [BRAPH2.STR ':SubjectFUN_MP:' BRAPH2.BUG_FUNC], ...
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
% % %         warndlg(['Please, select a valid input Group of SubjectFUN_MPs in TXT format. ' newline() ...
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
% % %     im = ImporterGroupSubjectFUN_MP_XLS( ...
% % %         'ID', 'Import Group of SubjectFUN_MPs from XLS', ...
% % %         'WAITBAR', true ...
% % %         );
% % %     im.uigetdir();
% % %     try
% % %         if isfolder(im.get('DIRECTORY'))
% % %             gr = pe.get('EL');
% % %             
% % %             assert( ...
% % %                 all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
% % %                 [BRAPH2.STR ':SubjectFUN_MP:' BRAPH2.BUG_FUNC], ...
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
% % %         warndlg(['Please, select a valid input Group of SubjectFUN_MPs in XLS format. ' newline() ...
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
% % %     ex = ExporterGroupSubjectFUN_MP_TXT( ...
% % %         'ID', 'Export Brain Group of SubjectFUNMps to TXT', ...
% % %         'GR', el.copy(), ...
% % %         'WAITBAR', true ...
% % %         );
% % %     ex.uigetdir()
% % %     if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectFUN_MP_TXT.getPropDefault('DIRECTORY'))
% % %         ex.get('SAVE');
% % %     end
% % % end
% % % 
% % % uimenu(menu_export, ...
% % %     'Label', 'Export XLS ...', ...
% % %     'Callback', {@cb_exporter_XLS});
% % % function cb_exporter_XLS(~, ~)
% % %     ex = ExporterGroupSubjectFUN_MP_XLS( ...
% % %         'ID', 'Export Brain Group of SubjectFUNMps to XLS', ...
% % %         'GR', el.copy(), ...
% % %         'WAITBAR', true ...
% % %         );
% % %     ex.uigetdir()
% % %     if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectFUN_MP_XLS.getPropDefault('DIRECTORY'))
% % %         ex.get('SAVE');
% % %     end
% % % end

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'SubjectFUN_MP'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject with data for each brain region corresponding to L functional layers (e.g. activation timeseries). For example, functional data can be fMRI or EEG.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectFUN_MP'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectFUN_MP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectFUN_MP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectFUN_MP notes'

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
L (data, scalar) is the number of layers of subject data.
%%%% ¡default!
2

%%% ¡prop!
LAYERTICKS (figure, rvector) are the layer tick positions.

%%% ¡prop!
LAYERLABELS (figure, string) are the layer labels (newline-separated string).

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
if isempty(sub.get('LAYERLABELS'))
    xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
else
    xlayerlabels = str2cell(g.get('LAYERLABELS'));
    xlayerlabels = ['{' sprintf('''%s'' ', xlayerlabels{end:-1:1}) '}'];
end

ba = sub.get('BA');
br_ids = ba.get('BR_DICT').getKeys();
rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];

pr = PanelPropCell('EL', sub, 'PROP', SubjectFUN_MP.FUN_MP, ...
    'TAB_H', 40, ...
    'XSLIDER', true, ...
    'XSLIDERLABELS', xlayerlabels, ...
    'YSLIDER', false, ...
    'ROWNAME', rowname, ...
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