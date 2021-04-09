%% ¡header!
ComparisonGroup < Element (cp, group-based comparison results) contains the results of a group-based comparison.

%%% ¡description!
ComparisonGroup contains the results of a group-based comparison for a given measure.
Specifically, it contains the one-tailed and two-tailed p-values 
and the 95%% confidence interval.

%%% ¡seealso!
CompareGroup, AnalyzeGroup

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the group-based comparison results.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the group-based comparison results.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the group-based comparison results.

%%% ¡prop!
MEASURE (data, class) is the measure class.
%%%% ¡settings!
'Measure'

%%% ¡prop!
C (data, item) is the group-based comparison.
%%%% ¡settings!
'CompareGroup'

%%% ¡prop!
P1 (data, cell) is the one-tailed p-value.

%%% ¡prop!
P2 (data, cell) is the two-tailed p-value.

%%% ¡prop!
CIL (data, cell) is the lower value of the 95%% confidence interval.

%%% ¡prop!
CIU (data, cell) is the upper value of the 95%% confidence interval.
