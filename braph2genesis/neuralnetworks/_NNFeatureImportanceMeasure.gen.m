%% ¡header!
NNFeatureImportanceMeasure < ConcreteElement (fim, feature importance for graph measure) is the feature importance for graph measure.

%%% ¡description!
A feature importance for graph measure (NNFeatureImportanceMeasure) provides 
the necessary mnethods to present the value of feature importance for all kinds of graph mearsures.

%%% ¡seealso!
NNFeatureImportanceBrainSurfacePP_Measure

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceMeasure.ID
%%%% ¡title!
NNFeatureImportanceMeasure ID

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceMeasure.LABEL
%%%% ¡title!
NNFeatureImportanceMeasure LABEL

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceMeasure.FI
%%%% ¡title!
Feature Importance Score

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the feature importance for graph measure.
%%%% ¡default!
'NNFeatureImportanceMeasure'

%%% ¡prop!
NAME (constant, string) is the name of the feature importance for graph measure.
%%%% ¡default!
'NNFeatureImportanceMeasure'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the feature importance for graph measure.
%%%% ¡default!
'A feature importance for graph measure (NNFeatureImportanceMeasure) provides the necessary mnethods to fit feature importance for all kinds of graph mearsures.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the feature importance for graph measure.
%%%% ¡settings!
'NNFeatureImportanceMeasure'

%%% ¡prop!
ID (data, string) is a few-letter code for the feature importance for graph measure.
%%%% ¡default!
'NNFeatureImportanceMeasure ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the feature importance for graph measure.
%%%% ¡default!
'NNFeatureImportanceMeasure label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph measure.
%%%% ¡default!
'NNFeatureImportanceMeasure notes'

%% ¡props!

%%% ¡prop!
G (data, item) is the measure graph.
%%%% ¡settings!
'Graph'

%%% ¡prop!
M (data, item) is the measure.
%%%% ¡settings!
'Measure'

%%% ¡prop!
FI (data, cell) is the feature importance value.
%%%% ¡calculate!
value = {};
%%%% ¡gui!
m = fim.get('M');
g = fim.get('G');

pr = PanelPropCell('EL', fim, 'PROP', NNFeatureImportanceMeasure.FI, varargin{:});

if m.get('SHAPE') == Measure.GLOBAL % __Measure.GLOBAL__
    pr.set( ...
        'TABLE_HEIGHT', s(4), ...
        'ROWNAME', {}, ...
        'COLUMNNAME', {} ...
        )
elseif m.get('SHAPE') == Measure.NODAL % __Measure.NODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', {} ...
        )
elseif m.get('SHAPE') == Measure.BINODAL % __Measure.BINODAL__
    pr.set( ...
        'TABLE_HEIGHT', s(40), ...
        'ROWNAME', g.getCallback('ANODELABELS'), ...
        'COLUMNNAME', g.getCallback('ANODELABELS') ...
        )
end

if g.get('LAYERNUMBER') == 1
    pr.set( ...
        'XSLIDERSHOW', false, ...
        'YSLIDERSHOW', false ...
        )
else % multigraph, multiplex, multilayer
    if m.get('SCOPE') == Measure.SUPERGLOBAL % __Measure.SUPERGLOBAL__
        if isempty(g.get('APARTITIONLABELS'))
            pr.set( ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', false ...
                )
        else
            pr.set( ...
                'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * length(g.get('APARTITIONLABELS'))), ...
                'XSLIDERSHOW', false, ...
                'YSLIDERSHOW', true, ...
                'YSLIDERLABELS', g.getCallback('APARTITIONLABELS'), ...
                'YSLIDERWIDTH', s(5) ...
                )
        end
    elseif m.get('SCOPE') == Measure.UNILAYER % __Measure.UNILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(pr.get('TABLE_HEIGHT'), s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', false, ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    elseif m.get('SCOPE') == Measure.BILAYER % __Measure.BILAYER__
        pr.set( ...
            'TABLE_HEIGHT', max(s(3) + pr.get('TABLE_HEIGHT'), s(3) + s(1) * g.get('LAYERNUMBER')), ...
            'XSLIDERSHOW', true, ...
            'XSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'XSLIDERHEIGHT', s(3), ...
            'YSLIDERSHOW', true, ...
            'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
            'YSLIDERWIDTH', s(5) ...
            )
    end
end

%% ¡tests!

%%% ¡excluded_props!
[NNFeatureImportanceMeasure.TEMPLATE]
