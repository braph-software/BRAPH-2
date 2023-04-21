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
pr = PanelPropStringTextArea('EL', a, 'PROP', AnalyzeEnsemble.NOTES, varargin{:});

%%% ¡prop!
TEMPLATE (parameter, item) is the analysis template to set the parameters.
%%%% ¡settings!
'AnalyzeEnsemble'
%%%% ¡postprocessing!
if a.prop_set(AnalyzeEnsemble.TEMPLATE, varargin{:})
    varargin = {};

    parameters = a.getProps(Category.PARAMETER);
    for i = 1:1:length(parameters)
        parameter = parameters(i);

        if parameter ~= AnalyzeEnsemble.TEMPLATE
            varargin{length(varargin) + 1} = parameter;
            varargin{length(varargin) + 1} = Callback('EL', a.get('TEMPLATE'), 'PROP', parameter);
        end
    end

    a.set(varargin{:});
end

%%% ¡prop!
GRAPH_TEMPLATE (parameter, item) is the graph template to set all graph and measure parameters.
%%%% ¡settings!
'Graph'

%%% ¡prop!
WAITBAR (gui, logical) detemines whether to show the waitbar.
%%%% ¡default!
true

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
value = IndexedDictionary('IT_CLASS', 'MeasureEnsemble', 'IT_KEY', MeasureEnsemble.MEASURE);
%%%% ¡gui!
pr = PPAnalyzeEnsemble_MeDict('EL', a, 'PROP', AnalyzeEnsemble.ME_DICT, 'WAITBAR', Callback('EL', a, 'TAG', 'WAITBAR'), varargin{:});

%%% ¡prop!
PFGD (gui, item) contains the panel figure of the graph dictionary.
%%%% ¡settings!
'PFAnalysisEnsemble'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    if isa(a.getr('PFGD'), 'NoValue')
        tmp_g = a.get('graph_template');
        
        if ~isempty(tmp_g) && Graph.is_graph(tmp_g) && ~Graph.is_multigraph(tmp_g)
            a.set('PFGD', PFAnalysisEnsemble('A', a))
        elseif ~isempty(tmp_g) && Graph.is_multigraph(tmp_g)
            a.set('PFGD', PFMultiAnalysisEnsemble('A', a))
        elseif ~isempty(tmp_g) && (Graph.is_multiplex(tmp_g) || Graph.is_ordered_multiplex(tmp_g)) && Graph.is_weighted(tmp_g)
            a.set('PFGD', PFMultiplexAnalysisEnsemble('A', a))
        elseif ~isempty(tmp_g) && (Graph.is_multiplex(tmp_g) || Graph.is_ordered_multiplex(tmp_g)) && Graph.is_binary(tmp_g)
            a.set('PFGD', PFMultiplexBinaryAnalysisEnsemble('A', a))
        else
            a.memorize('PFGD').set('A', a)
        end        
    end
end
%%%% ¡gui!
pr = PanelPropItem('EL', a, 'PROP', AnalyzeEnsemble.PFGD, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

%% ¡methods!
function me = getMeasureEnsemble(a, measure_class, varargin)
    %GETMEASURE returns measure.
    %
    % ME = GETMEASURE(A, MEASURE_CLASS) checks if the measure ensemble exists in the
    %  property ME_DICT. If not it creates a new measure M of class MEASURE_CLASS
    %  with properties defined by the graph settings. The user must call
    %  getValue() for the new measure M to retrieve the value of measure M.

    g_dict = a.memorize('G_DICT');
    for i = 1:1:g_dict.length()
        g_dict.getItem(i).memorize('A');
    end
    
    g = a.get('GRAPH_TEMPLATE');
    m_list = Graph.getCompatibleMeasureList(g);
    
    assert( ...
        contains(measure_class, m_list), ...
        [BRAPH2.STR ':' a.getClass() ':' BRAPH2.WRONG_INPUT], ...
        [BRAPH2.STR ':' a.getClass() ':' BRAPH2.WRONG_INPUT ' '], ...
        [a.getClass() ' utilizes Graphs of type ' g.getClass() '.' measure_class ' is not a compatible Measure with ' g.getClass() '. Please use Graph function getCompatibleMeasureList for more information.']);
    
    me_dict = a.memorize('ME_DICT');
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
% % % function pr = getPPCompareEnsemble_CPDict(a, varargin)
% % %     %GETPPCOMPAREENSEMBLE_CPDICT returns the comparison ensemble plot panel compatible with the analysis.
% % %     %
% % %     % PR = GEPPPCOMPAREGROUP_CPDICT(A) returns the comparison ensemble plot panel
% % %     %  that is compatible with the analyze ensemble.
% % %     %
% % %     % See also CompareEnsemble.
% % % 
% % %     pr = PropPlotIDict(varargin{:});
% % % end
