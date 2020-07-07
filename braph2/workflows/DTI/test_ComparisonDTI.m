% test ComparisonDTI

br1 = BrainRegion('BR1', 'brain region 1', 'notes 1', 1, 1.1, 1.11);
br2 = BrainRegion('BR2', 'brain region 2', 'notes 2', 2, 2.2, 2.22);
br3 = BrainRegion('BR3', 'brain region 3', 'notes 3', 3, 3.3, 3.33);
br4 = BrainRegion('BR4', 'brain region 4', 'notes 4', 4, 4.4, 4.44);
br5 = BrainRegion('BR5', 'brain region 5', 'notes 5', 5, 5.5, 5.55);
atlas = BrainAtlas('BA', 'brain atlas', 'notes', 'BrainMesh_ICBM152.nv', {br1, br2, br3, br4, br5});

subject_class = Comparison.getSubjectClass('ComparisonDTI');

sub1 = Subject.getSubject(subject_class, 'id1', 'label 1', 'notes 1', atlas);
sub2 = Subject.getSubject(subject_class, 'id2', 'label 2', 'notes 2', atlas);
sub3 = Subject.getSubject(subject_class, 'id3', 'label 3', 'notes 3', atlas);
sub4 = Subject.getSubject(subject_class, 'id4', 'label 4', 'notes 4', atlas);
sub5 = Subject.getSubject(subject_class, 'id5', 'label 5', 'notes 5', atlas);

group = Group(subject_class, 'id', 'label', 'notes', {sub1, sub2, sub3, sub4, sub5});

graph_type = AnalysisDTI.getGraphType();
measures = Graph.getCompatibleMeasureList(graph_type);

%% Test 1: Instantiation
for i = 1:1:numel(measures)
    comparison = ComparisonDTI('c1', 'label', 'notes', atlas, measures{i}, group, group);
end