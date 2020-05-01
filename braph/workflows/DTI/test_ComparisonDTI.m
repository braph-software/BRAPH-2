% test ComparisionDTI
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

comparison_class = Comparison.getSubjectClass('ComparisonDTI');

sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
sub4 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 4);
sub5 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 5);
group = Group(subject_class, {sub1, sub2, sub3 sub4, sub5});

measures = {'Assortativity', 'Degree', 'Distance'};

%% Test 1: Instantiation
for i = 1:1:numel(measures)
    comparison = ComparisonDTI('c1', atlas,  repmat({group}, 1, ComparisonDTI.getGroupNumber()), atlas, group, 'ComparisonDTI.measure_code', measures{i});
    assert(~isempty(comparison), ...
        ['BRAPH:ComparisionDTI:Instantiation'], ...
        ['ComparisionDTI does not initialize correctly.']) %#ok<*NBRAK>
end

%% Test 2: Correct Size defaults
for i = 1:1:numel(measures)
    comparison = ComparisonDTI('c1', atlas,  repmat({group}, 1, ComparisonDTI.getGroupNumber()), atlas, group, 'ComparisonDTI.measure_code', measures{i});
    values_1 = Comparison.getGroupValue(1);
    average_value_1 = Comparison.getGroupAverageValue(1);
    values_2 = Comparison.getGroupValue(2);
    average_value_2 = Comparison.getGroupAverageValue(2);
    difference = Comparison.getDifference();  % difference
    all_differences = Comparison.getAllDifferences(); % all differences obtained through the permutation test
    p_single = Comparison.getPSingleTail(); % p value single tailed
    p_double = Comparison.getPDoubleTail();  % p value double tailed
    confidence_interval_min = Comparison.getConfidenceIntervalMin();  % min value of the 95% confidence interval
    confidence_interval_max = Comparison.getConfidenceIntervalMax(); % max value of the 95% confidence interval
end

%% Test 3: Comparison Initialization with values

% % setup
% dm = rand(3,1);
% dall = rand(5, 3);
% p_single = rand(3,1);
% p_double = rand(3,1);
% confidence_interval_min =  rand(3,1);
% confidence_interval_max =  rand(3,1);
% 
% for i = 1:1:group.subjectnumber()
%     values{i} = rand(atlas.getBrainRegions().length(), group.subjectnumber);
% end
% % act
% comparison = ComparisonDTI('c1', atlas, reptmat({group}, 1, ComparisonDTI.getGroupNumber()), ...
%     'ComparisonDTI.measure_code', 'Degree', ...
%     'ComparisonDTI.difference_mean', dm, ...
%     'ComparisonDTI.difference_all', dall, ...
%     'ComparisonDTI.p_single', p_single, ...
%     'ComparisonDTI.p_double', p_double, ...
%     'ComparisonDTI.percentiles', percentiles ...
    );