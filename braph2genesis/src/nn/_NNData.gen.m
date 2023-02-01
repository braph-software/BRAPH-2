%% ¡header!
NNData < Element (nnd, data for neural network) produces a dataset to train or test a neural netowrk model.  

%% ¡description!
This NN data generates a group of NN subjects, each of which contains the 
input as structural, adjacency matrices, or graph measures from all of the 
modalities. The generated NN group can be used to train or test neural 
network models.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
ID (data, string) is a few-letter code for the graph analysis.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph analysis.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph analysis.

%%% ¡prop!
WAITBAR (metadata, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

%%% ¡prop!
INPUT_TYPE (parameter, option) is the input type for training or testing the NN.
%%%% ¡gui!
pr = PPNNDataInputType('EL', nnd, 'PROP', NNData.INPUT_TYPE, 'WAITBAR', Callback('EL', nnd, 'TAG', 'WAITBAR'), varargin{:});

%%% ¡prop!
G (parameter, item) is the graph for calculating the graph measures.
%%%% ¡settings!
'Graph'

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'Graph'

%%% ¡prop!
MEASURES (parameter, idict) is the graph measures as input to NN.
%%%% ¡settings!
'MeasureEnsemble'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MeasureEnsemble', 'IT_KEY', MeasureEnsemble.MEASURE);
%%%% ¡postprocessing!
if ~braph2_testing && isempty(nnd.get('MEASURES').get('IT_LIST'))
    if ~strcmp(nnd.get('INPUT_TYPE'), 'structural_data')
        nnd.getMeasureEnsemble('Degree');
    end
end
%%%% ¡gui!
pr = PPNNDataMeasures('EL', nnd, 'PROP', NNData.G, 'WAITBAR', Callback('EL', nnd, 'TAG', 'WAITBAR'), varargin{:});

%%% ¡prop!
ANALYZE_ENSEMBLE (data, item) contains the graphs of the group.
%%%% ¡settings!
'AnalyzeEnsemble'

%%% ¡prop!
TARGET_NAME (data, string) is the name of the traget.
%%%% ¡default!
'diagnosis'

%%% ¡prop!
GR (data, item) is a group of subjects defined as subject class.
%%%% ¡settings!
'Group'

%%% ¡prop!
GR_NN (result, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'


%%% ¡prop!
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'NNData'
%%%% ¡postprocessing!
if nnd.prop_set(NNData.TEMPLATE, varargin{:})
    varargin = {};
    
    parameters = nnd.getProps(Category.PARAMETER);
    for i = 1:1:length(parameters)
        parameter = parameters(i);
        
        if parameter ~= NNData.TEMPLATE
            varargin{length(varargin) + 1} = parameter;
            varargin{length(varargin) + 1} = Callback('EL', nnd.get('TEMPLATE'), 'PROP', parameter);
        end
    end
    
    nnd.set(varargin{:});
end

%% ¡methods!
function me = getMeasureEnsemble(nnd, measure_class, varargin)
    %GETMEASURE returns measure.
    %
    % ME = GETMEASURE(NND, MEASURE_CLASS) checks if the measure ensemble exists in the
    %  property ME_DICT. If not it creates a new measure M of class MEASURE_CLASS
    %  with properties defined by the graph settings. The user must call
    %  getValue() for the new measure M to retrieve the value of measure M.
  
    g = nnd.get('GRAPH_TEMPLATE');
    m_list = Graph.getCompatibleMeasureList(g);
    a = nnd.getPropDefault('ANALYZE_ENSEMBLE');
    a.set('GR', nnd.get('GR'));
    if isempty(a.get('G_DICT').getItems)
        a.memorize('G_DICT').add(g);
    end
    
    if ~isempty(m_list)
        assert( ...
            contains(measure_class, m_list), ...
            [BRAPH2.STR ':' a.getClass() ':' BRAPH2.WRONG_INPUT], ...
            [BRAPH2.STR ':' a.getClass() ':' BRAPH2.WRONG_INPUT ' '], ...
            [a.getClass() ' utilizes Graphs of type ' g.getClass() '.' measure_class ' is not a compatible Measure with ' g.getClass() '. Please use Graph function getCompatibleMeasureList for more information.']);
    else
        return
    end
    me_dict = nnd.memorize('MEASURES');
    if me_dict.containsKey(measure_class)
        me = me_dict.getItem(measure_class);
    else
        me = MeasureEnsemble( ...
            'ID', measure_class, ...
            'A', a, ...
            'MEASURE', measure_class, ...
            'MEASURE_TEMPLATE', eval([measure_class '(varargin{:})']) ...
            );
        me_dict.add(me);
    end
end
function m_value = getCalculatedMeasure(nnd, g, measure_class)
    me_dict = nnd.get('MEASURES');
    if me_dict.containsKey(measure_class)
        me = me_dict.getItem(measure_class);
    else
        me = MeasureEnsemble( ...
            'ID', measure_class, ...
            'A', nnd.get('ANALYZE_ENSEMBLE'), ...
            'MEASURE', measure_class, ...
            'MEASURE_TEMPLATE', eval([measure_class '(varargin{:})']) ...
            );
        me_dict.add(me);
    end
    core_measure = me.get('MEASURE_TEMPLATE');
    % get parameters from core measure
    j = 1;
    varargin = {};
    if Measure.getPropNumber() ~= core_measure.getPropNumber()
        for i = Measure.getPropNumber() + 1:core_measure.getPropNumber()
            if ~isa(core_measure.getr(i), 'NoValue')
                varargin{j} = core_measure.getPropTag(i);
                varargin{j + 1} = core_measure.getr(i);
            end
            j = j + 2;
        end
        varargin = varargin(~cellfun('isempty', varargin));
    end
    
    m_value = g.getMeasure(me.get('MEASURE'), varargin{:}).get('M');
end
