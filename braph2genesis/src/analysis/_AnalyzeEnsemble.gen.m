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

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class.
%%%% ¡settings!
'Group'

%%% ¡prop!
G_DICT (result, idict) is the graph enemble obtained from this analysis.
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
pl = PPAnalyzeEnsembleMeasure('EL', a, 'PROP', AnalyzeEnsemble.ME_DICT, varargin{:});

%% ¡methods!
function me = getMeasureEnsemble(a, measure_class, varargin)
    %GETMEASURE returns measure.
    %
    % ME = GETMEASURE(A, MEASURE_CLASS) checks if the measure ensemble exists in the
    %  property ME_DICT. If not it creates a new measure M of class MEASURE_CLASS
    %  with properties defined by the graph settings. The user must call
    %  getValue() for the new measure M to retrieve the value of measure M.

    me_dict = a.memorize('ME_DICT');
    if me_dict.containsKey(measure_class)
        me = me_dict.getItem(measure_class);
    else
        me = MeasureEnsemble( ...
            'ID', measure_class, ...
            'A', a, ...
            'MEASURE', measure_class, ...
            varargin{:} ...
            );
        me_dict.add(me);
    end
end