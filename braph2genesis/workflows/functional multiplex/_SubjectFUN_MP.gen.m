%% ¡header!
SubjectFUN_MP < Subject (sub, subject with functional multiplex data) is a subject with functional multiplex data (e.g. multiplex fMRI).

%%% ¡description!
Subject with functional L layers multiplex data (e.g. activation timeseries) for each brain region.
For example, functional multiplex data can be fMRI or EEG.

%%% ¡seealso!
Element, Subject

%%% ¡gui!
%%%% ¡menu_importer!
importers = {'ImporterGroupSubjectFUNMPTXT', 'ImporterGroupSubjectFUNMPXLS'};

for k = 1:length(importers)
    imp = importers{k};
    uimenu(ui_menu_import, ...
        'Label', [imp ' ...'], ...
        'Callback', {@cb_importers});
end
function cb_importers(src, ~)
    src_name = erase(src.Text, ' ...');
    imp_el = eval([src_name '()']);          
    imp_el.uigetfile();
    tmp_el = imp_el.get('GR');
    delete(gcf)
    GUI(tmp_el)
end

%%%% ¡menu_exporter!
exporters = {'ExporterGroupSubjectFUNMPTXT', 'ExporterGroupSubjectFUNMPXLS'};
for k = 1:length(exporters)
    exp = exporters{k};
    uimenu(ui_menu_export, ...
        'Label', [exp ' ...'], ...
        'Callback', {@cb_exporters});
end
function cb_exporters(src, ~)
    src_name = erase(src.Text, ' ...');
    exmp_el = eval([src_name '(' '''GR''' ', el)']);    
    exmp_el.uigetdir();
    exmp_el.get('SAVE');
end

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
L (data, scalar) is the number of multiplex layers of subject.
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
pl = PPMultiplexSubjectData('EL', sub, 'PROP', SubjectFUN_MP.FUN_MP, varargin{:});
 
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