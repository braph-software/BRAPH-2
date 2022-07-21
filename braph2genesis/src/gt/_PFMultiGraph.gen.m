%% ¡header!
PFMultiGraph < PFGraph (pf, panel figure multigraph) is a plot of a multigraph.

%%% ¡description!
% % % PFGraph manages the plot of the single layer graph. 
% % % This class provides the common methods needed to manage the plot of 
% % % the graph. 

%%% ¡seealso!
PanelFig, Graph, MultigraphBUT, MultigraphBUT

%% ¡properties!
p  % handle for panel
h_axes % handle for the axes

h_plot

%% ¡props_update!
%%% ¡prop!
ST_ADJACENCY (figure, item) determines the colormap settings.
%%%% ¡settings!
'SettingsGraph'
%%%% ¡default!
SettingsGraph('WEIGHTED', true, 'BINARY', false, 'BINARY_VALUE', 50, 'HIST', false)
%%%% ¡gui!
pr = SettingsGraphPP('EL', pf, 'PROP', PFMultiGraph.ST_ADJACENCY, varargin{:});

%% ¡props!

%%% ¡prop!
DT (figure, string) is the id of the selected density or layer.
%%%% ¡default!
'1'
%%%% ¡gui!
g = pf.get('G');
pr = PP_DTID('EL', pf, 'PROP', PFMultiGraph.DT, ...
    'G', g, ...
    varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)

    pf.p = draw@PFGraph(pf, varargin{:});
    % axes
    pf.h_axes = pf.get('ST_AXIS').h();

    % output
    if nargout > 0
        p_out = pf.p;
    end
end
function h = plotAdjacency(pf)
    
    % select correct matrix
    index = str2double(pf.get('DT'));
    multigraph = pf.get('G').get('A');
    correct_graph = multigraph{index, index};
    % plot
    if pf.get('ST_ADJACENCY').get('BINARY')
        h = pf.plotb(correct_graph);
    elseif pf.get('ST_ADJACENCY').get('HIST')
        h = pf.hist(correct_graph);
    else
        h = pf.plotw(correct_graph);
    end
end