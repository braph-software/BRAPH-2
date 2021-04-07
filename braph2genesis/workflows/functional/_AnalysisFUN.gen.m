%% ¡header!
AnalysisFUN < Analysis (a, graph analysis with functional data) is a graph analysis using functional data.

%% ¡description!
This graph analysis uses functional data and analyzes them using weighted undirected graphs,
binary undirected multigraphs with fixed thresholds,
or binary undirected multigraphs with fixed densities.

%% ¡props!

%%% ¡prop!
G_CLASS (parameter, option) is the graph class.
%%%% ¡settings!
{'GraphWUEnsemble', 'MultigraphBUTEnsemble', 'MultigraphBUDEnsemble'}
%%%% ¡default!
'GraphWUEnsemble'

%%% ¡prop!
THRESHOLDS (data, rvector) is the vector of thresholds.

%%% ¡prop!
DENSITIES (data, rvector) is the vector of densities.

%%% ¡prop!
DT (data, scalar) is the sampling time in seconds.
%%%% ¡default!
1
       
%%% ¡prop!
F_MIN (data, scalar) is the minimun frequency in Hz.
%%%% ¡default!
0

%%% ¡prop!
F_MAX (data, scalar) is the maximum frequency in Hz.
%%%% ¡default!
+Inf
        
%%% ¡prop!
CORRELATION_RULE (parameter, option) is the correlation type.
%%%% ¡settings!
Correlation.CORRELATION_RULE_LIST
%%%% ¡default!
Correlation.CORRELATION_RULE_LIST{1}

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.NEGATIVE_WEIGHT_RULE_LIST{1}
 
%% ¡props_update!

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%%% ¡prop!
G (result, item) is the graph obtained from this analysis, it can be GraphWUEnsemble, MultigraphBUTEnsemble, or MultigraphBUDEnsemble.
%%%% ¡settings!
'Graph'
%%%% ¡check_value!
check = any(strcmp(value.getClass(), a.getPropSettings('G_CLASS')));
%%%% ¡default!
GraphWUEnsemble()
%%%% ¡calculate!
ge = eval([a.get('G_CLASS') '()']);

ge.set('G_DICT', ge.get('G_DICT'))

gr = a.get('GR');
for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    data = sub.get('FUN');

    % filter data
    T = a.get('DT');
    fmin = a.get('F_MIN');
    fmax = a.get('F_MAX');
    fs = 1 / T;
    if fmax > fmin && T > 0
        NFFT = 2 * ceil(size(data, 1) / 2);
        ft = fft(data, NFFT);  % Fourier transform
        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
        ft(f < fmin | f > fmax, :) = 0;
        data = ifft(ft, NFFT);
    end

    data = data'; % correlation is a column based operation
    B = Correlation.getAdjacencyMatrix(data, a.get('CORRELATION_RULE'), a.get('NEGATIVE_WEIGHT_RULE'));
    
    % create graph
    switch ge.get('G_DICT').get('IT_CLASS')
        case 'GraphWU'
            g = GraphWU( ...
                'ID', ['g ' sub.get('ID')], ...
                'B', B ...
                );
        case 'MultigraphBUT'
            g = MultigraphBUT( ...
                'ID', ['g ' sub.get('ID')], ...
                'THRESHOLDS', a.get('THRESHOLDS'), ...
                'B', B ...
                );
        case 'MultigraphBUD'
            g = MultigraphBUD( ...
                'ID', ['g ' sub.get('ID')], ...
                'DENSITIES', a.get('DENSITIES'), ...
                'B', B ...
                );
    end
    ge.get('G_DICT').add(g)
end

value = ge;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_FUN