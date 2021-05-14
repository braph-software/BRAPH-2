%% ¡header!
SubjectCON < Subject (sub, subject with connectivity matrix) is a subject with connectivity matrix (e.g. DTI).

%%% ¡description!
Subject with a connectivity matrix (e.g. obtained from DTI).

%%% ¡seealso!
Element, Subject

%%% ¡gui!
%%%% ¡menu_importer!
importers = {'ImporterGroupSubjectCONTXT', 'ImporterGroupSubjectCONXLS'};
for k = 1:length(importers)
    imp = importers{k};
    uimenu(ui_menu_import, ...
        'Label', [imp ' ...'], ...
        'Callback', {@cb_importers});
end
function cb_importers(src, ~)
    src_name = erase(src.Text, ' ...');
    imp_el = eval([src_name '()']);          
    imp_el.uigetdir();
    tmp_el = imp_el.get('GR');
    plot_element.set('El', tmp_el); 
    plot_element.redraw();
end

%%%% ¡menu_exporter!
exporters = {'ExporterGroupSubjectCONTXT', 'ExporterGroupSubjectCONXLS'};
for k = 1:length(exporters)
    exp = exporters{k};
    uimenu(ui_menu_export, ...
        'Label', [exp ' ...'], ...
        'Callback', {@cb_exporters});
end
function cb_exporters(src, ~)
    src_name = erase(src.Text, ' ...');
    exmp_el = eval([src_name '(' '''GR''' ', el)']); % el is a group passed from Group
    exmp_el.uigetdir();
    exmp_el.get('SAVE');
end

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()

%%% ¡prop!
CON (data, smatrix) is an adjacency matrix.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').length();
check = isequal(size(value), [br_number, br_number]); % Format.checkFormat(Format.SMATRIX, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['CON must be a square matrix with the dimensiton equal to the number of brain regions (' int2str(br_number) ').'];
end
%%%% ¡gui!
pl = PPSubjectData('EL', sub, 'PROP', SubjectCON.CON, varargin{:});
 
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
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_CON_WU')) filesep 'example data CON (DTI)' filesep 'desikan_atlas.xlsx']);
ba = im_ba.get('BA');
im_gr1 = ImporterGroupSubjectCONXLS( ...
    'DIRECTORY', [fileparts(which('example_CON_WU')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName1'], ...
    'FILE_COVARIATES', [fileparts(which('example_CON_WU')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'covariates_age_sex' filesep 'GroupName1_age_sex.xlsx'], ...
    'BA', ba ...
    );
gr1 = im_gr1.get('GR');
GUI(gr1, 'CloseRequest', false)
close(gcf)