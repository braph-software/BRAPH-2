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
pr = PPAnalyzeGroup_G('EL', a, 'PROP', AnalyzeGroup.G, varargin{:});

%% ¡staticmethods!
function pp = getAnalysisGroupCompatibleComparePP(a) 
    % GETANALYSISGROUPCOMPATIBLECOMPAREPP returns the comparison pp compatible with the analysis.
    %
    % PP = GETANALYSISGROUPCOMPATIBLECOMPAREPP(A) returns the comparison pp
    % that is compatible with the analyze group.
    %
    % see also Element.
    
    pp = eval([Element.getClass(a) '.getAnalysisGroupCompatibleComparePP()']);
end