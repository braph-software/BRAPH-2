%% ¡header!
SubjectST_MP < Subject (sub, subject with structural multiplex data) is a subject with structural multiplex data (e.g. multiplex sMRI).

%%% ¡description!
Subject with data for each brain region correspponding to L structural layers (e.g. cortical thickness).
For example, structural data can be structural MRI.

%%% ¡_gui!

% % % %%%% ¡menu_importer!
% % % uimenu(menu_import, ...
% % %     'Label', 'Import TXT ...', ...
% % %     'Callback', {@cb_importer_TXT});
% % % function cb_importer_TXT(~, ~)
% % %     im = ImporterGroupSubjectST_MP_TXT( ...
% % %         'ID', 'Import Group of SubjectStMPs from TXT', ...
% % %         'WAITBAR', true ...
% % %         );
% % %     im.uigetdir();
% % %     try
% % %         if isfolder(im.get('DIRECTORY'))
% % %             gr = pe.get('EL');
% % %             
% % %             assert( ...
% % %                 all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
% % %                 [BRAPH2.STR ':SubjectST_MP:' BRAPH2.BUG_FUNC], ...
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
% % %         warndlg(['Please, select a valid input Group of SubjectStMps in TXT format. ' newline() ...
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
% % %     im = ImporterGroupSubjectST_MP_XLS( ...
% % %         'ID', 'Import Group of SubjectStMPs from XLS', ...
% % %         'WAITBAR', true ...
% % %         );
% % %     im.uigetdir();
% % %     try
% % %         if isfolder(im.get('DIRECTORY'))            
% % %             gr = pe.get('EL');
% % %             
% % %             assert( ...
% % %                 all(cellfun(@(prop) ~gr.isLocked(prop), num2cell(gr.getProps()))), ...
% % %                 [BRAPH2.STR ':SubjectST_MP:' BRAPH2.BUG_FUNC], ...
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
% % %         warndlg(['Please, select a valid input Group of SubjectStMps in XLS format. ' newline() ...
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
% % %     ex = ExporterGroupSubjectST_MP_TXT( ...
% % %         'ID', 'Export Brain Group of SubjectST_MPs to TXT', ...
% % %         'GR', el.copy(), ...
% % %         'WAITBAR', true ...
% % %         );
% % %     ex.uigetdir()
% % %     if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectST_MP_TXT.getPropDefault('DIRECTORY'))
% % %         ex.get('SAVE');
% % %     end
% % % end
% % % 
% % % uimenu(menu_export, ...
% % %     'Label', 'Export XLS ...', ...
% % %     'Callback', {@cb_exporter_XLS});
% % % function cb_exporter_XLS(~, ~)
% % %     ex = ExporterGroupSubjectST_MP_XLS( ...
% % %         'ID', 'Export Brain Group of SubjectST_MPs to XLS', ...
% % %         'GR', el.copy(), ...
% % %         'WAITBAR', true ...
% % %         );
% % %     ex.uigetdir()
% % %     if ~strcmp(ex.get('DIRECTORY'), ExporterGroupSubjectST_MP_XLS.getPropDefault('DIRECTORY'))
% % %         ex.get('SAVE');
% % %     end
% % % end

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the subject.
%%%% ¡default!
'SubjectST_MP'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the subject.
%%%% ¡default!
'Subject with data for each brain region correspponding to L structural layers (e.g. cortical thickness). For example, structural data can be structural MRI.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the subject.
%%% ¡settings!
'SubjectST_MP'

%%% ¡prop!
ID (data, string) is a few-letter code for the subject.
%%%% ¡default!
'SubjectST_MP ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the subject.
%%%% ¡default!
'SubjectST_MP label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the subject.
%%%% ¡default!
'SubjectST_MP notes'

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
L (data, scalar) is the number of layers of subject data.
%%%% ¡default!
2

%%% ¡_prop!
% % % LAYERTICKS (figure, rvector) are the layer tick positions.

%%% ¡prop!
LAYERLABELS (metadata, stringlist) are the layer labels provided by the user.

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the processed layer labels.
%%%% ¡calculate!
value = g.get('LAYERLABELS');

%%% ¡prop!
ST_MP (data, cell) is a cell containing L vectors, each with data for each brain region.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').get('LENGTH');
num_layers = sub.get('L');
check = (iscell(value) && isequal(length(value), num_layers)  && isequal( cellfun(@(v) size(v, 1), value), ones(1, num_layers) * br_number)) || (isempty(value) && br_number == 0); 
if check
    msg = 'All ok!';
else   
    msg = ['ST_MP must be a column vector with the same number of element as the brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pr = PanelPropCell('EL', sub, 'PROP', SubjectST_MP.ST_MP, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', true, ...
    'XSLIDERLABELS', sub.getCallback('LAYERLABELS'), ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', sub.get('BA').get('BR_DICT').getCallback('KEYS'), ...
    'COLUMNNAME', {}, ...
    varargin{:});
% % % if isempty(sub.get('LAYERLABELS'))
% % %     xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
% % % else
% % %     xlayerlabels = str2cell(g.get('LAYERLABELS'));
% % %     xlayerlabels = ['{' sprintf('''%s'' ', xlayerlabels{end:-1:1}) '}'];
% % % end
% % % 
% % % ba = sub.get('BA');
% % % br_ids = ba.get('BR_DICT').getKeys();
% % % rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
% % % 
% % % pr = PanelPropCell('EL', sub, 'PROP', SubjectST_MP.ST_MP, ...
% % %     'TAB_H', 40, ...
% % %     'XSLIDER', true, ...
% % %     'XSLIDERLABELS', xlayerlabels, ...
% % %     'YSLIDER', false, ...
% % %     'ROWNAME', rowname, ...
% % %     'COLUMNNAME', '[]', ...
% % %     varargin{:});
 
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