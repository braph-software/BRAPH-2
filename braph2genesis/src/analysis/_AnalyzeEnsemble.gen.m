%% ¡header!
AnalyzeEnsemble < Element (a, ensemble-based graph analysis) is a ensemble-based graph analysis.

%%% ¡description!
AnalyzeEnsemble provides the methods necessary for all ensemble-based analysis subclasses.
Instances of this class should not be created. 
Use one of its subclasses instead.

%%% ¡seealso!
CompareEnsemble

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the graph analysis.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph analysis.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph analysis.
%%%% ¡gui!
pr = PlotPropString('EL', a, 'PROP', AnalyzeEnsemble.NOTES, 'LINES', 'multi', 'EDITHEIGHT', 4.5, varargin{:});

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class.
%%%% ¡settings!
'Group'

%%% ¡prop!
G_DICT (result, idict) is the graph ensemble obtained from this analysis.
%%%% ¡settings!
'Graph'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'Graph');

%%% ¡prop!
ME_DICT (result, idict) contains the calculated measures of the graph ensemble.
%%%% ¡settings!
'MeasureEnsemble'
%%%% ¡calculate!
value = IndexedDictionary('IT_CLASS', 'MeasureEnsemble', 'IT_KEY', 4);
%%%% ¡gui!
g = a.get('G_Dict').getItem(1);
if g.getGraphType() == 4
    pr = PPAnalyzeEnsembleMP_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble.ME_DICT, 'WAITBAR', true, varargin{:});
else
    pr = PPAnalyzeEnsemble_ME_DICT('EL', a, 'PROP', AnalyzeEnsemble.ME_DICT, 'WAITBAR', true, varargin{:});
end

%% ¡methods!
function me = getMeasureEnsemble(a, measure_class, varargin)
    %GETMEASURE returns measure.
    %
    % ME = GETMEASURE(A, MEASURE_CLASS) checks if the measure ensemble exists in the
    %  property ME_DICT. If not it creates a new measure M of class MEASURE_CLASS
    %  with properties defined by the graph settings. The user must call
    %  getValue() for the new measure M to retrieve the value of measure M.

    me_dict = a.memorize('ME_DICT');
    g_dict = a.memorize('G_DICT');
    g = g_dict.getItem(1);
    if me_dict.containsKey(measure_class)
        me = me_dict.getItem(measure_class);
    else
        me = MeasureEnsemble( ...
            'ID', measure_class, ...
            'A', a, ...
            'MEASURE', measure_class, ...
            'MEASUREPARAM', g.getMeasure(measure_class), ...
            varargin{:} ...
            );
        me_dict.add(me);
    end
end
function pr = getPPCompareEnsemble_CPDict(a, varargin)
    %GETPPCOMPAREENSEMBLE_CPDICT returns the comparison ensemble plot panel compatible with the analysis.
    %
    % PR = GEPPPCOMPAREGROUP_CPDICT(A) returns the comparison ensemble plot panel
    %  that is compatible with the analyze ensemble.
    %
    % See also CompareEnsemble.

    pr = PropPlotIDict(varargin{:});
end