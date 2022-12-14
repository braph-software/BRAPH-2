%% ¡header!
Measure < Element (m, graph measure) is a measure.

%%% ¡description!
Measure provides the methods necessary for all graph measures. 
Instances of this class should not be created. 
Use one of its subclasses instead.

%%% ¡seealso!
Graph

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the graph measure.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph measure.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph measure.
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', m, 'PROP', Measure.NOTES, varargin{:});

%%% ¡prop!
G (data, item) is the measure graph.
%%%% ¡settings!
'Graph'

%%% ¡prop!
M (result, cell) is the measure result.
%%%% ¡calculate!
value = {};
%%%% ¡gui!
g = m.get('G');

pr = PanelPropCell('EL', m, 'PROP', Measure.M, varargin{:});

if Measure.is_global(m)
    pr.set( ...
        'TAB_H', 3, ...
        'ROWNAME', '[]', ...
        'COLUMNNAME', '[]' ...
        )
elseif Measure.is_nodal(m)
    bas = g.get('BAS');
    if ~isempty(bas)
        ba = bas{1};
        br_ids = ba.get('BR_DICT').getKeys();
        rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
        
        pr.set( ...
            'TAB_H', 40, ...
            'ROWNAME', rowname, ...
            'COLUMNNAME', '[]' ...
            )
    end
    
elseif Measure.is_binodal(m)
    bas = m.get('G').get('BAS');
    if ~isempty(bas)
        ba = bas{1};
        br_ids = ba.get('BR_DICT').getKeys();
        rowname = ['{' sprintf('''%s'' ', br_ids{:}) '}'];
        
        pr.set( ...
            'TAB_H', 40, ...
            'ROWNAME', rowname, ...
            'COLUMNNAME', rowname ...
            )
    end   
end

if g.layernumber() == 1
    pr.set( ...
        'XSLIDER', false, ...
        'YSLIDER', false ...
        )
else % multilayer
    if  Measure.is_superglobal(m)
        if Graph.is_weighted(g)
            pr.set( ...
                'XSLIDER', false, ...
                'YSLIDER', false ...
                )
        else
            if isempty(g.get('LAYERTICKS'))
                ylayerlabels = PanelPropCell.getPropDefault('LAYERTICKS');
            else
                layerlabels = num2cell(g.get('LAYERTICKS'));
                if isa(g, "MultiplexBUD")
                    ylayerlabels = ['{' sprintf('''%d'' ', layerlabels{end:-1:1}) '}'];
                else
                    ylayerlabels = ['{' sprintf('''%.2f'' ', layerlabels{end:-1:1}) '}'];
                end
            end

            pr.set( ...
                'TAB_H', max(pr.get('TAB_H'), length(layerlabels)), ...
                'XSLIDER', false, ...
                'YSLIDER', true, ...
                'YSLIDERLABELS', ylayerlabels, ...
                'YSLIDERWIDTH', 5 ...
                )
        end
    elseif Measure.is_unilayer(m)
        if isempty(g.get('LAYERLABELS'))
            % xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            % xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(pr.get('TAB_H'), g.layernumber()), ...
            'XSLIDER', false, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    elseif Measure.is_bilayer(m)
        if isempty(g.get('LAYERLABELS'))
            xlayerlabels = PanelPropCell.getPropDefault('XSLIDERLABELS');
            ylayerlabels = PanelPropCell.getPropDefault('YSLIDERLABELS');
        else
            layerlabels = str2cell(g.get('LAYERLABELS'));
            xlayerlabels = ['{' sprintf('''%s'' ', layerlabels{:}) '}'];
            ylayerlabels = ['{' sprintf('''%s'' ', layerlabels{end:-1:1}) '}'];
        end
        
        pr.set( ...
            'TAB_H', max(3 + pr.get('TAB_H'), 3 + g.layernumber()), ...
            'XSLIDER', true, ...
            'XSLIDERLABELS', xlayerlabels, ...
            'XSLIDERHEIGHT', 3, ...
            'YSLIDER', true, ...
            'YSLIDERLABELS', ylayerlabels, ...
            'YSLIDERWIDTH', 5 ...
            )
    end
end

%%% ¡prop!
PFM (gui, item) contains the panel figure of the measure.
%%%% ¡settings!
'PFMeasure'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    if isa(m.getr('PFM'), 'NoValue')
        g = m.memorize('G');
        if Measure.is_global(m) && (Measure.is_unilayer(m) || Measure.is_superglobal(m))
            if Graph.is_multiplex(g) && Measure.is_unilayer(m)
                m.set('PFM', PFMeasureMultiplexGU('M', m))
            else
                m.set('PFM', PFMeasureGU('M', m))
            end  
        elseif Measure.is_nodal(m) && (Measure.is_unilayer(m) || Measure.is_superglobal(m))
            if Graph.is_multiplex(g) && Measure.is_unilayer(m)
                m.set('PFM', PFMeasureMultiplexNU('M', m))
            else
                m.set('PFM', PFMeasureNU('M', m))
            end  
        elseif Measure.is_binodal(m) && (Measure.is_unilayer(m) || Measure.is_superglobal(m))
            if Graph.is_multiplex(g) && Measure.is_unilayer(m)
                m.set('PFM', PFMeasureMultiplexBU('M', m))
            else
                m.set('PFM', PFMeasureBU('M', m))
            end
        elseif Measure.is_global(m) && Measure.is_bilayer(m)
            m.set('PFM', PFMeasureGB('M', m))
        elseif Measure.is_nodal(m) && Measure.is_bilayer(m)
            m.set('PFM', PFMeasureNB('M', m))
        elseif Measure.is_binodal(m) && Measure.is_bilayer(m)
            m.set('PFM', PFMeasureBB('M', m))
        else
            m.memorize('PFM').set('M', m)
        end
    end
end
%%%% ¡gui!
pr = PanelPropItem('EL', m, 'PROP', Measure.PFM, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});

%%% ¡prop!
PFBG (gui, item) contains the panel figure of the brain graph.
%%%% ¡settings!
'PFBrainGraph'
%%%% ¡postprocessing!
if ~braph2_testing % to avoid problems with isqual when the element is recursive
    if isa(m.getr('PFBG'), 'NoValue')
        g = m.memorize('G');
        if ~isempty(g) && ~isa(g, 'NoValue')
            if Graph.is_graph(g) % graph
                ba_list = g.memorize('BAS');
                if ~isempty(ba_list)
                    m.memorize('PFBG').set('ME', m, 'BA', ba_list{1})
                else
                    m.memorize('PFBG').set('ME', m);
                end
                
            elseif Graph.is_multigraph(g) % multigraph BUD BUT
                ba_list = g.memorize('BAS');
                if ~isempty(ba_list)
                    m.set('PFBG', PFBrainMultiGraph('ME', m, 'BA', ba_list{1}));
                else
                    m.set('PFBG', PFBrainMultiGraph('ME', m));
                end
            elseif Graph.is_multiplex(g) && Graph.is_weighted(g) % multiplexWU
                ba_list = g.memorize('BAS');
                if ~isempty(ba_list)
                    m.set('PFBG', PFBrainMultiplexGraph('ME', m, 'BA', ba_list{1}));
                else
                    m.set('PFBG', PFBrainMultiplexGraph('ME', m));
                end
            elseif Graph.is_multiplex(g) && Graph.is_binary(g)
                ba_list = g.memorize('BAS');
                if ~isempty(ba_list)
                    m.set('PFBG', PFBrainMultiplexBinaryGraph('ME', m, 'BA', ba_list{1}));
                else
                    m.set('PFBG', PFBrainMultiplexBinaryGraph('ME', m));
                end
            end
        
        else
            m.memorize('PFBG').set('ME', m)
        end
    end
end
%%%% ¡gui!
pr = PanelPropItem('EL', m, 'PROP', Measure.PFBG, ...
    'GUICLASS', 'GUIFig', ...
    varargin{:});


%% ¡constants!

% Measure shape
GLOBAL = 1  
GLOBAL_NAME = 'Global'
GLOBAL_DESCRIPTION = ['Global measure refers to global properties of ' ... 
'a single layer graph and, therefore, consists of a single number for each graph.']

NODAL = 2
NODAL_NAME = 'Nodal'
NODAL_DESCRIPTION = ['Nodal measure refers to properties of the nodes of' ... 
'a single layer graph and, therefore, consists of a vector of numbers, ' ...
'one for each node of the graph.']

BINODAL = 3
BINODAL_NAME = 'Binodal'
BINODAL_DESCRIPTION = ['Binodal measure refers to properties between nodes of' ... 
'a single layer graph and, therefore, consists of a matrix of numbers, ' ...
'one for each node of the graph.']

SHAPE_NUMBER = 3

SHAPE_NAME = {
    Measure.GLOBAL_NAME
    Measure.NODAL_NAME
    Measure.BINODAL_NAME
    }

SHAPE_DESCRIPTION = {
    Measure.GLOBAL_DESCRIPTION
    Measure.NODAL_DESCRIPTION
    Measure.BINODAL_DESCRIPTION
    }

% Measure scope
SUPERGLOBAL = 1
SUPERGLOBAL_NAME = 'Superglobal'
SUPERGLOBAL_DESCRIPTION = ['Superglobal measure consists of a single ' ...
    'number for each non single layer graphs.']

UNILAYER = 2
UNILAYER_NAME = 'Unilayer'
UNILAYER_DESCRIPTION = ['Unilayer measure consists of a vector with ' ... 
'nodal/binodal/global measures for every layer.']

BILAYER = 3
BILAYER_NAME = 'Bilayer'
BILAYER_DESCRIPTION = ['Bilayer measure consists of a matrix with '... 
    'nodal/binodal/global measures between layers.']

SCOPE_NUMBER = 3

SCOPE_NAME = {
    Measure.SUPERGLOBAL_NAME
    Measure.UNILAYER_NAME
    Measure.BILAYER_NAME
    }

SCOPE_DESCRIPTION = {
    Measure.SUPERGLOBAL_DESCRIPTION
    Measure.UNILAYER_DESCRIPTION
    Measure.BILAYER_DESCRIPTION
    }

% Parametricity
PARAMETRIC = 1
PARAMETRIC_NAME = 'Parametric'
PARAMETRIC_DESCRIPTION = ['Parametric measure consists of a measure ' ...
    'that outputs the results based on a parameter.']

NONPARAMETRIC = 2
NONPARAMETRIC_NAME = 'Non-parametric'
NONPARAMETRIC_DESCRIPTION = ['Non-parametric measure consists of a measure ' ...
    'where the results are not based on a parameter.']

PARAMETRICITY_NUMBER = 2

PARAMETRICITY_NAME = {
    Measure.PARAMETRIC_NAME
    Measure.NONPARAMETRIC_NAME
    }

PARAMETRICITY_DESCRIPTION = {
    Measure.PARAMETRIC_DESCRIPTION
    Measure.NONPARAMETRIC_DESCRIPTION
    }

%% ¡staticmethods!
function measure_shape = getMeasureShape(m)
    %GETMEASURESHAPE returns the measure shape.
    %
    % MEASURE_TYPE = GETMEASURESHAPE(M) returns the measure shape of measure M
    %  (e.g., GLOBAL, NODAL, BINODAL).
    %
    % MEASURE_TYPE = GETMEASURESHAPE(MEASURE_CLASS) returns the measure shape
    %  of the measure whose class is MEASURE_CLASS (e.g., GLOBAL, NODAL,
    %  BINODAL).
    %
    % See also is_binodal, is_global, is_nodal.

    
    if strcmp(Element.getClass(m), 'Measure')
        measure_shape = Measure.NODAL;
    else
        measure_shape = eval([Element.getClass(m) '.getMeasureShape()']);
    end
end
function bool = is_global(m)
    %IS_GLOBAL checks if measure is global.
    %
    % BOOL = IS_GLOBAL(M) returns true if the concrete measure M is global and
    %  false otherwise.
    %
    % BOOL = IS_GLOBAL(MEASURE_CLASS) returns true if the measure whose class
    %  is MEASURE_CLASS is global and false otherwise.
    %
    % See also getMeasureShape, is_binodal, is_nodal.

    bool = Measure.getMeasureShape(m) == Measure.GLOBAL;
end
function bool = is_nodal(m)
    %IS_NODAL checks if measure is nodal.
    %
    % BOOL = IS_NODAL(M) returns true if the concrete measure M is nodal and
    %  false otherwise.
    %
    % BOOL = IS_NODAL(MEASURE_CLASS) returns true if the measure whose class is
    %  MEASURE_CLASS is nodal and false otherwise.
    %
    % See also getMeasureShape, is_binodal, is_global.

    bool = Measure.getMeasureShape(m) == Measure.NODAL;
end
function bool = is_binodal(m)
    %IS_BINODAL checks if measure is bi-nodal.
    %
    % BOOL = IS_BINODAL(M) returns true if concrete measure M is binodal and
    %  false otherwise.
    %
    % BOOL = IS_BINODAL(MEASURE_CLASS) returns true if a  measure whose class
    %  is MEASURE_CALSS is binodal and false otherwise.
    %
    % See also getMeasureShape, is_global, is_nodal.

    bool = Measure.getMeasureShape(m) == Measure.BINODAL;
end
function measure_scope = getMeasureScope(m)
    %GETMEASURESCOPE returns the measure scope.
    %
    % MEASURE_SCOPE = GETMEASURESCOPE(M) returns the measure scope of measure M
    %  (e.g., SUPERGLOBAL, UNILAYER, BILAYER).
    %
    % MEASURE_SCOPE = GETMEASURESCOPE(MEASURE_CLASS) returns the measure scope
    %  of the measure whose class is MEASURE_CLASS (e.g., SUPERGLOBAL, UNILAYER,
    %  BILAYER).
    %
    % See also is_bilayer, is_superglobal, is_unilayer.

    if strcmp(Element.getClass(m), 'Measure')
        measure_scope = Measure.UNILAYER;
    else
        measure_scope = eval([Element.getClass(m) '.getMeasureScope()']);
    end
end
function bool = is_superglobal(m)
    %IS_SUPERGLOBAL checks if measure is superglobal.
    %
    % BOOL = IS_SUPERGLOBAL(M) returns true if the concrete measure M is
    %  superglobal and false otherwise.
    %
    % BOOL = IS_SUPERGLOBAL(MEASURE_CLASS) returns true if the measure whose
    %  class is MEASURE_CLASS is superglobal and false otherwise.
    %
    % See also getMeasureScope, is_bilayer, is_unilayer.

    bool = Measure.getMeasureScope(m) == Measure.SUPERGLOBAL;
end
function bool = is_unilayer(m)
    %IS_UNILAYER checks if measure is unilayer.
    %
    % BOOL = IS_UNILAYER(M) returns true if the concrete measure M is unilayer
    %  and false otherwise.
    %
    % BOOL = IS_UNILAYER(MEASURE_CLASS) returns true if the measure whose class
    %  is MEASURE_CLASS is unilayer and false otherwise.
    %
    % See also getMeasureScope, is_bilayer, is_superglobal.

    bool = Measure.getMeasureScope(m) == Measure.UNILAYER;
end
function bool = is_bilayer(m)
    %IS_BILYER checks if measure is bi-layer.
    %
    % BOOL = IS_BILYER(M) returns true if concrete measure M is bi-layer and
    %  false otherwise.
    %
    % BOOL = IS_BILYER(MEASURE_CLASS) returns true if a measure whose class is
    %  MEASURE_CALSS is bi-layer and false otherwise.
    %
    % See also getMeasureScope, is_superglobal, is_unilayer.

    bool = Measure.getMeasureScope(m) == Measure.BILAYER;
end
function parametricity = getMeasureParametricity(m)
    %GETMEASUREPARAMETRICITY returns the parametricity of the measure.
    %
    % PARAMETRICITY = GETMEASUREPARAMETRICITY(M) returns the parametricity of measure
    %  M (e.g., NONPARAMETRIC, PARAMETRIC).
    %
    % PARAMETRICITY = GETMEASUREPARAMETRICITY(MEASURE_CLASS) returns the parametricity
    %  of the measure whose class is MEASURE_CLASS (e.g., NONPARAMETRIC,
    %  PARAMETRIC).
    %
    % See also is_nonparametric, is_parametric.

    if strcmp(Element.getClass(m), 'Measure')
        parametricity = Measure.NONPARAMETRIC;
    else
        parametricity = eval([Element.getClass(m) '.getMeasureParametricity()']);
    end
end
function bool = is_parametric(m)
    %IS_PARAMETRIC checks if measure is parametric.
    %
    % BOOL = IS_PARAMETRIC(M) returns true if the concrete measure M is
    %  parametric and false otherwise.
    %
    % BOOL = IS_PARAMETRIC(MEASURE_CLASS) returns true if the measure whose
    %  class is MEASURE_CLASS is parametric and false otherwise.
    %
    % See also getMeasureParametricity, is_nonparametric.

    bool = Measure.getMeasureParametricity(m) == Measure.PARAMETRIC;
end
function bool = is_nonparametric(m)
    %IS_NONPARAMETRIC checks if measure is non-parametric.
    %
    % BOOL = IS_NONPARAMETRIC(M) returns true if the concrete measure M is
    %  non-parametric and false otherwise.
    %
    % BOOL = IS_NONPARAMETRIC(MEASURE_CLASS) returns true if the measure whose
    %  class is MEASURE_CLASS is non-parametric and false otherwise.
    %
    % See also getMeasureParametricity, is_parametric.

    bool = Measure.getMeasureParametricity(m) == Measure.NONPARAMETRIC;
end
function list = getCompatibleGraphList(m)
    %GETCOMPATIBLEGRAPHLIST returns the list of graphs.
    %
    % GRAPH_CLASS_LIST = GETCOMPATIBLEGRAPHLIST(M) returns a cell array of
    % compatible graph classes to the concrete measure M. M will not work if
    % the graph is not compatible.
    %
    % GRAPH_CLASS_LIST = GETCOMPATIBLEGRAPHLIST(MEASURE_CLASS)
    % returns a cell array of compatible graph classes to the measure
    % whose class is MEASURE_CLASS. M will not work if the
    % graph is not compatible. 
    %
    % See also getCompatibleGraphNumber, getMeasure.

    list = eval([Element.getClass(m) '.getCompatibleGraphList()']);
end
function n = getCompatibleGraphNumber(m)
    %GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs.
    %
    % N = GETCOMPATIBLEGRAPHNUMBER(M) returns the number of compatible graphs
    %  to the concrete measure M.
    %
    % N = GETCOMPATIBLEGRAPHNUMBER(MEASURE_CLASS) returns the number of
    %  compatible graphs to the a measure whose class is MEASURE_CLASS.
    %
    % See also getCompatibleGraphList, getMeasure.

    list = Measure.getCompatibleGraphList(m);
    n = numel(list);
end
function list = getList()
    % GETLIST returns the list of measures
    %
    % MEASURE_LIST = GETLIST() returns the list of measures (cell array)
    % that are subclasses of Measure.
    %
    % See also getClass, Measure.

    list = subclasses( ...
        'Measure', ...
        [fileparts(which('braph2')) filesep 'measures'] ...
        );
end