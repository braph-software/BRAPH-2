% test AnalysisMRI
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

sub1 = SubjectMRI(atlas, 'SubjectID', '1');
sub2 = SubjectMRI(atlas, 'SubjectID', '2');
sub3 = SubjectMRI(atlas, 'SubjectID', '3');
sub4 = SubjectMRI(atlas, 'SubjectID', '4');
sub5 = SubjectMRI(atlas, 'SubjectID', '5');
group1 = Group('SubjectMRI', {sub1, sub2, sub3, sub4, sub5}, 'GroupName', 'GroupTestMRI1');
group2 = Group('SubjectMRI', {sub1, sub2, sub3, sub4, sub5}, 'GroupName', 'GroupTestMRI2');

cohort = Cohort('Cohort MRI', 'SubjectMRI', atlas, {sub1, sub2, sub3, sub4, sub5});
cohort.getGroups().add(group1.getName(), group1)
cohort.getGroups().add(group2.getName(), group2)

%% Test 1: Instantiation
analysis = AnalysisMRI(cohort, {}, {}, {}); %#ok<*NASGU>

%% Test 2: Create correct ID
analysis = AnalysisMRI(cohort, {}, {}, {});
measurement_id = analysis.getMeasurementID('Degree');
comparison_id = analysis.getComparisonID('Distance');
randomcomparison_id = analysis.getRandomComparisonID('PathLength');

assert(ischar(measurement_id), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['.getMeasurementID() not creating an ID'])  %#ok<*NBRAK>
assert(ischar(randomcomparison_id), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['.getMeasurementID() not creating an ID']) 
assert(ischar(comparison_id), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['.getMeasurementID() not creating an ID']) 