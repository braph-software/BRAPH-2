%% ¡header!
AnalyzeGroup < Element (a, group-based graph analysis) is a group-based graph analysis.

%%% ¡description!
AnalyzeGroup provides the methods necessary for all group-based analysis subclasses.
Instances of this class should not be created. 
Use one of its subclasses instead.

%%% ¡seealso!
CompareGroup

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the graph analysis.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph analysis.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph analysis.

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class.
%%%% ¡settings!
'Group'

%%% ¡prop!
G (result, item) is the graph obtained from this analysis.
%%%% ¡settings!
'Graph'
%%%% ¡calculate!
value = Graph();
%%%% ¡gui!
pr = PPAnalyzeGroup_G('EL', a, 'PROP', AnalyzeGroup.G, 'WAITBAR', true, varargin{:});

%% ¡staticmethods!
function pp = getPPCompareGroup_CpDict(a) 
    %GEPPPCOMPAREGROUP_CPDICT returns the comparison plot panel compatible with the analysis.
    %
    % PR = GEPPPCOMPAREGROUP_CPDICT(A) returns the comparison plot panel
    %  that is compatible with the analyze group.
    %
    % See also CompareGroup.
    
    pp = eval([Element.getClass(a) '.getAnalysisGroupCompatibleComparePP()']);
end