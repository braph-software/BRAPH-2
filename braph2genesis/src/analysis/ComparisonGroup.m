%% ¡header!
ComparisonGroup < Element (cp, group-based comparison results) contains the results of a group-based comparison.

%%% ¡description!
ComparisonGroup contains the results of a group-based comparison for a given measure.
Specifically, it contains the one-tailed and two-tailed p-values 
and the 95\% confidence interval.

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
C (data, item) is the group-based comparison.
%%%% ¡settings!
'CompareGroup'

%%% ¡prop!
MEASURE_CODE (data, string) is the measure code.

%%% ¡prop!
P1 (result, cell) is the one-tailed p-value.
%%%% ¡calculate!
value = {};

%%% ¡prop!
P2 (result, cell) is the two-tailed p-value.
%%%% ¡calculate!
value = {};

%%% ¡prop!
CIL (result, cell) is the lower value of the 95\% confidence interval.
%%%% ¡calculate!
value = {};

%%% ¡prop!
CIU (result, cell) is the upper value of the 95\% confidence interval.
%%%% ¡calculate!
value = {};
