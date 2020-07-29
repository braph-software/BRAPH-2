% test GUICohort
br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});
sub_class = 'SubjectST';
input_rule = 'ST';
input_data = rand(atlas.getBrainRegions().length(), 1);

%% INIT with cohort
% Create fictional cohort

sub11 = Subject.getSubject(sub_class, 'SubjectID11', 'label11', 'notes11', atlas, input_rule, input_data);
sub21 = Subject.getSubject(sub_class, 'SubjectID21', 'label21', 'notes21', atlas, input_rule, input_data);
sub31 = Subject.getSubject(sub_class, 'SubjectID31', 'label31', 'notes31', atlas, input_rule, input_data);
group11 = Group(sub_class, 'GroupName11', 'TestGroup11', 'notes11', {sub11, sub21, sub31});
cohort11 = Cohort('cohort11', 'label11', 'notes11', sub_class, atlas, {sub11, sub21, sub31});
cohort11.getGroups().add(group11.getID(), group11);
SubjectST.save_to_xls(cohort11);
SubjectST.save_to_txt(cohort11);
SubjectST.save_to_json(cohort11);


sub1 = Subject.getSubject(sub_class, 'SubjectID1', 'label1', 'notes1', atlas, input_rule, input_data);
sub2 = Subject.getSubject(sub_class, 'SubjectID2', 'label2', 'notes2', atlas, input_rule, input_data);
sub3 = Subject.getSubject(sub_class, 'SubjectID3', 'label3', 'notes3', atlas, input_rule, input_data);
group = Group(sub_class, 'GroupName1', 'TestGroup1', 'notes1', {sub1, sub2, sub3});

sub4 = Subject.getSubject(sub_class, 'SubjectID4', 'label4', 'notes4', atlas, input_rule, input_data);
sub5 = Subject.getSubject(sub_class, 'SubjectID5', 'label5', 'notes5', atlas, input_rule, input_data);
sub6 = Subject.getSubject(sub_class, 'SubjectID6', 'label6', 'notes6', atlas, input_rule, input_data);
group2 = Group(sub_class, 'GroupName2', 'TestGroup2', 'notes2', {sub4, sub5, sub6});

cohort = Cohort('cohorttest', 'label1', 'notes1', sub_class, atlas, {sub1, sub2, sub3, sub4, sub5, sub6});
cohort.getGroups().add(group.getID(), group);
cohort.getGroups().add(group2.getID(), group2);

GUICohort(cohort);