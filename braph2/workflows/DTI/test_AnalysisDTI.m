% test AnalysisDTI

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

sub11 = SubjectDTI('ID11', 'label 11', 'notes 11', atlas, 'age', 20, 'DTI', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub12 = SubjectDTI('ID12', 'label 12', 'notes 12', atlas, 'age', 20, 'DTI', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub13 = SubjectDTI('ID13', 'label 13', 'notes 13', atlas, 'age', 20, 'DTI', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub14 = SubjectDTI('ID14', 'label 14', 'notes 14', atlas, 'age', 20, 'DTI', .5 + .5 * rand(atlas.getBrainRegions().length()));

group1 = Group('SubjectDTI', 'group 1 id', 'group 1 label', 'group 1 notes', {sub11, sub12, sub13, sub14}, 'GroupName', 'GroupTestDTI1');

sub21 = SubjectDTI('ID21', 'label 21', 'notes 21', atlas, 'age', 20, 'DTI', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub22 = SubjectDTI('ID22', 'label 22', 'notes 22', atlas, 'age', 20, 'DTI', .5 + .5 * rand(atlas.getBrainRegions().length()));
sub23 = SubjectDTI('ID23', 'label 23', 'notes 23', atlas, 'age', 20, 'DTI', .5 + .5 * rand(atlas.getBrainRegions().length()));

group2 = Group('SubjectDTI', 'group 2 id', 'group 2 label', 'group 2 notes', {sub21, sub22, sub23}, 'GroupName', 'GroupTestDTI2');

cohort = Cohort('Cohort DTI', 'cohort label', 'cohort notes', 'SubjectDTI', atlas, {sub11, sub12, sub13, sub14, sub21, sub22, sub23});
cohort.getGroups().add(group1.getID(), group1)
cohort.getGroups().add(group2.getID(), group2)

graph_type = AnalysisDTI.getGraphType();
measures = Graph.getCompatibleMeasureList(graph_type);

%% Test 1: Instantiation
analysis = AnalysisDTI('analysis id', 'analysis label', 'analysis notes', cohort, {}, {}, {});