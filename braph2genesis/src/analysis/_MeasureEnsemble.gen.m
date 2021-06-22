%% ¡header!
MeasureEnsemble < Element (me, graph ensemble measure) is a graph ensemble measure.

%%% ¡description!
Measure provides the methods necessary for a graph ensemble measure.

%%% ¡seealso!
AnalyzeEnsemble, CompareEnsemble

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the graph ensemble measure.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph ensemble measure.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph ensemble measure.

%%% ¡prop!
MEASURE (data, string) is the measure class.

%%% ¡prop!
MEASUREPARAM(data, item) is the example measure parameters 
%%%% ¡settings!
'Measure'

%%% ¡prop!
A (data, item) is the ensemble-based graph analysis.
%%%% ¡settings!
'AnalyzeEnsemble'


%%% ¡prop!
M (result, cell) is the measure result.
%%%% ¡calculate!
core_measure = me.get('MEASUREPARAM');
% get parameters from core measure
j = 1;
if Measure.getPropNumber() ~= core_measure.getPropNumber()
    for i = Measure.getPropNumber() + 1:core_measure.getPropNumber()
        if ~isa(core_measure.getr(i), 'NoValue')
            varargin{j} = core_measure.getPropTag(i);
            varargin{j + 1} = core_measure.getr(i);
        end
        j = j + 2;
    end
end
varargin = varargin(~cellfun('isempty', varargin));

m_list = cellfun(@(x) x.getMeasure(me.get('MEASURE'), varargin{:}).get('M'), me.get('A').get('G_DICT').getItems, 'UniformOutput', false);

if isempty(m_list)
    m_av = {};
else
    m_av = cell(size(m_list{1}));
    for i = 1:1:size(m_list{1}, 1)
        for j = 1:1:size(m_list{1}, 2)
            m_ij_list = cellfun(@(x) x{i, j}, m_list, 'UniformOutput', false);
            m_av{i, j} = mean(cat(ndims(m_ij_list{1}) + 1, m_ij_list{:}), ndims(m_ij_list{1}) + 1);
        end
    end
end

value = m_av;
%%%% ¡gui!
pl = PPMeasureEnsembleM('EL', me, 'PROP', MeasureEnsemble.M, varargin{:});