function A = generate_watts_strogatz(N, K, beta, inactive_nodes)
% A = WattsStrogatz(N, K, beta, inactive_nodes)
% Returns a weighted symmetric Watts-Strogatz adjacency matrix.
%
% N               total number of nodes
% K               each active node connects to its K next neighbors
% beta            rewiring probability
% inactive_nodes  nodes forced to have degree 0 (optional)
%
% Notes:
% - inactive nodes have no edges and are excluded from rewiring
% - graph generation is performed only on active nodes
% - output A is N x N, symmetric, weighted, with zero diagonal

    if nargin < 4
        inactive_nodes = [];
    end

    inactive_nodes = unique(inactive_nodes(:)');
    inactive_nodes = inactive_nodes(inactive_nodes >= 1 & inactive_nodes <= N);

    active_nodes = setdiff(1:N, inactive_nodes);
    N_active = numel(active_nodes);

    % initialise full output
    A = zeros(N);

    % trivial cases
    if N_active <= 1 || K == 0
        return
    end

    % safety checks
    if K >= N_active
        error('K must be smaller than the number of active nodes.')
    end

    % This construction connects each node to K forward neighbours,
    % leading to mean degree 2*K in the undirected graph.
    if 2*K >= N_active
        warning('K is large relative to the number of active nodes; the graph may be close to fully connected.')
    end

    % build Watts-Strogatz graph on active nodes only
    s = repelem((1:N_active)', 1, K);
    t = s + repmat(1:K, N_active, 1);
    t = mod(t - 1, N_active) + 1;

    % rewire target node of each edge with probability beta
    for source = 1:N_active
        switchEdge = rand(K, 1) < beta;

        newTargets = rand(N_active, 1);
        newTargets(source) = 0;                 % no self-loop
        newTargets(s(t == source)) = 0;         % avoid duplicate reverse edges
        newTargets(t(source, ~switchEdge)) = 0; % keep existing unswitched targets excluded

        [~, ind] = sort(newTargets, 'descend');
        t(source, switchEdge) = ind(1:nnz(switchEdge));
    end

    h = graph(s, t);
    A_active = full(adjacency(h));
    A_active(1:size(A_active,1)+1:end) = 0;

    % make weighted
    r = 0.5 * rand(size(A_active));
    A_active(A_active ~= 0) = A_active(A_active ~= 0) - r(A_active ~= 0);

    % force symmetry
    A_active = max(A_active, A_active.');

    % place active-node graph back into full matrix
    A(active_nodes, active_nodes) = A_active;
end
