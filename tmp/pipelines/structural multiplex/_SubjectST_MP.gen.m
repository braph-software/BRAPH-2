%% ¡header!
SubjectST_MP < Subject (sub, subject with structural multiplex data) is a subject with structural multiplex data (e.g. multiplex sMRI).

%%% ¡description!
Subject with data for each brain region correspponding to L structural layers (e.g. cortical thickness).
For example, structural data can be structural MRI.

%%% ¡seealso!
Element, Subject

%%% ¡gui!
% % % %%%% ¡menu_importer!
% % % calling_class = plot_element.get('El');
% % % if isa(calling_class, 'Group')
% % %     importers = {'ImporterGroupSubjectSTMPTXT', 'ImporterGroupSubjectSTMPXLS'};
% % %     for k = 1:length(importers)
% % %         imp = importers{k};
% % %         uimenu(ui_menu_import, ...
% % %             'Label', [imp ' ...'], ...
% % %             'Callback', {@cb_importers});
% % %     end
% % % end
% % % function cb_importers(src, ~)
% % %     src_name = erase(src.Text, ' ...');
% % %     imp_el = eval([src_name '()']);          
% % %     imp_el.uigetdir();
% % %     tmp_el = imp_el.get('GR');
% % %     plot_element.set('El', tmp_el); 
% % %     plot_element.reinit();
% % % end
% % % 
% % % %%%% ¡menu_exporter!
% % % calling_class = plot_element.get('El');
% % % if isa(calling_class, 'Group')
% % %     exporters = {'ExporterGroupSubjectSTMPTXT', 'ExporterGroupSubjectSTMPXLS'};
% % %     for k = 1:length(exporters)
% % %         exp = exporters{k};
% % %         uimenu(ui_menu_export, ...
% % %             'Label', [exp ' ...'], ...
% % %             'Callback', {@cb_exporters});
% % %     end
% % % end
% % % function cb_exporters(src, ~)
% % %     src_name = erase(src.Text, ' ...');
% % %     tmp_el = plot_element.get('EL'); %#ok<NASGU>
% % %     exmp_el = eval([src_name '(' '''GR''' ', tmp_el)']); % el is a group passed from Group   
% % %     exmp_el.uigetdir();
% % %     exmp_el.get('SAVE');
% % % end

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
ST_MP (data, cell) is a cell containing L vectors, each with data for each brain region.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').length();
num_layers = sub.get('L');
check = (iscell(value) && isequal(length(value), num_layers)  && isequal( cellfun(@(v) size(v, 1), value), ones(1, num_layers) * br_number)) || (isempty(value) && br_number == 0); 
if check
    msg = 'All ok!';
else   
    msg = ['ST_MP must be a column vector with the same number of element as the brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
% % % pl = PPMultiplexSubjectData('EL', sub, 'PROP', SubjectST_MP.ST_MP, varargin{:});
 
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