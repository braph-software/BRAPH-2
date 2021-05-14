%% ¡header!
SubjectFUN  < Subject (sub, subject with time series) is a subject with time series (e.g. fMRI).

%%% ¡description!
Subject with functional data (e.g. activation timeseries) for each brain region. 
For example, functional data can be fMRI or EEG.

%%% ¡seealso!
Element, Subject

%%% ¡gui!
%%%% ¡menu_importer!
importers = {'ImporterGroupSubjectFUNTXT', 'ImporterGroupSubjectFUNXLS'};

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
exporters = {'ExporterGroupSubjectFUNTXT', 'ExporterGroupSubjectFUNXLS'};
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
FUN (data, matrix) is a matrix with each column corresponding to the time series of a brain region.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').length();
check = size(value, 2) == br_number; % Format.checkFormat(Format.MATRIX, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['FUN must be a matrix with the same number of columns as the brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pl = PPSubjectData('EL', sub, 'PROP', SubjectFUN.FUN, varargin{:});
 
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