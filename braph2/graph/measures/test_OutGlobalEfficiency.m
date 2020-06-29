% test OutGlobalEfficiency

%% Test 1: GraphBD
A = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_out_global_efficiency = {[1/4 1/4 1/4 1/4 0]'};

g = GraphBD(A);
out_global_efficiency = OutGlobalEfficiency(g);

assert(isequal(out_global_efficiency.getValue(), known_out_global_efficiency), ...
    [BRAPH2.STR ':OutGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiency is not being calculated correctly for GraphBD.')

%% Test 2: GraphWD
A = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_out_global_efficiency = {[1/40 1/20 1/20 1/40 0]'};

g = GraphWD(A);
out_global_efficiency = OutGlobalEfficiency(g);

assert(isequal(out_global_efficiency.getValue(), known_out_global_efficiency), ...
    [BRAPH2.STR ':OutGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiency is not being calculated correctly for GraphWD.')

%% Test 3: MultiplexGraphBU
A11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A12 = eye(5);
A21 = eye(5);
A22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A = {
    A11     A12
    A21     A22
    };

known_out_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]'
                        [1/4 1/4 1/4 1/4 0]'
                        };


g = MultiplexGraphBD(A);
out_global_efficiency = OutGlobalEfficiency(g);

assert(isequal(out_global_efficiency.getValue(), known_out_global_efficiency), ...
    [BRAPH2.STR ':OutGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiency is not being calculated correctly for MultiplexGraphBD.')

%% Test 4: MultiplexGraphWD
A11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A12 = eye(5);
A21 = eye(5);
A22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A = {
    A11     A12
    A21     A22
    };

known_out_global_efficiency = {
                        [1/40 1/20 1/20 1/40 0]'
                        [1/40 1/20 1/20 1/40 0]'
                        };


g = MultiplexGraphWD(A);
out_global_efficiency = OutGlobalEfficiency(g);

assert(isequal(out_global_efficiency.getValue(), known_out_global_efficiency), ...
    [BRAPH2.STR ':OutGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiency is not being calculated correctly for MultiplexGraphWD.')

%% Test 4: GraphWD: Calculation vs BCT
A = rand(randi(5));

g = GraphWD(A);
out_global_efficiency = OutGlobalEfficiency(g).getValue();
out_global_efficiency = out_global_efficiency{1};
out_global_efficiency_bct = efficiency_wei(g.getA());

assert(isequal(round(mean(out_global_efficiency), 4), round(out_global_efficiency_bct, 4)), ...
    [BRAPH2.STR ':OutGlobalEfficiency:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiency is not being calculated correctly for BCT.')


function E = efficiency_wei(W, local)
%EFFICIENCY_WEI     Global efficiency, local efficiency.
%
%   Eglob = efficiency_wei(W);
%   Eloc = efficiency_wei(W,2);
%
%   The global efficiency is the average of inverse shortest path length,
%   and is inversely related to the characteristic path length.
%
%   The local efficiency is the global efficiency computed on the
%   neighborhood of the node, and is related to the clustering coefficient.
%
%   Inputs:     W,
%                   weighted undirected or directed connection matrix
%
%               local,
%                   optional argument
%                   local=0  computes the global efficiency (default).
%                  	local=1  computes the original version of the local
%                               efficiency.
%               	local=2  computes the modified version of the local
%                               efficiency (recommended, see below).
%
%   Output:     Eglob,
%                   global efficiency (scalar)
%               Eloc,
%                   local efficiency (vector)
%
%   Notes:
%       The  efficiency is computed using an auxiliary connection-length
%   matrix L, defined as L_ij = 1/W_ij for all nonzero L_ij; This has an
%   intuitive interpretation, as higher connection weights intuitively
%   correspond to shorter lengths.
%       The weighted local efficiency broadly parallels the weighted
%   clustering coefficient of Onnela et al. (2005) and distinguishes the
%   influence of different paths based on connection weights of the
%   corresponding neighbors to the node in question. In other words, a path
%   between two neighbors with strong connections to the node in question
%   contributes more to the local efficiency than a path between two weakly
%   connected neighbors. Note that the original weighted variant of the
%   local efficiency (described in Rubinov and Sporns, 2010) is not a
%   true generalization of the binary variant, while the modified variant
%   (described in Wang et al., 2016) is a true generalization.
%       For ease of interpretation of the local efficiency it may be
%   advantageous to rescale all weights to lie between 0 and 1.
%
%   Algorithm:  Dijkstra's algorithm
%
%   References: Latora and Marchiori (2001) Phys Rev Lett 87:198701.
%               Onnela et al. (2005) Phys Rev E 71:065103
%               Fagiolo (2007) Phys Rev E 76:026107.
%               Rubinov M, Sporns O (2010) NeuroImage 52:1059-69
%               Wang Y et al. (2016) Neural Comput 21:1-19.
%
%   Mika Rubinov, U Cambridge/Janelia HHMI, 2011-2017

%Modification history
% 2011: Original (based on efficiency.m and distance_wei.m)
% 2013: Local efficiency generalized to directed networks
% 2017: Added the modified local efficiency and updated documentation.

n = length(W);                                              % number of nodes
ot = 1 / 3;                                                 % one third

L = W;                                                      % connection-length matrix
A = W > 0;                                                  % adjacency matrix
L(A) = 1 ./ L(A);
A = double(A);

if exist('local','var') && local                            % local efficiency
    E = zeros(n, 1);
    cbrt_W = W.^ot;
    switch local
        case 1
            for u = 1:n
                V  = find(A(u, :) | A(:, u).');             % neighbors
                sw = cbrt_W(u, V) + cbrt_W(V, u).';       	% symmetrized weights vector
                di = distance_inv_wei(L(V, V));             % inverse distance matrix
                se = di.^ot + di.'.^ot;                     % symmetrized inverse distance matrix
                numer = (sum(sum((sw.' * sw) .* se)))/2;   	% numerator
                if numer~=0
                    sa = A(u, V) + A(V, u).';              	% symmetrized adjacency vector
                    denom = sum(sa).^2 - sum(sa.^2);        % denominator
                    E(u) = numer / denom;                   % local efficiency
                end
            end
        case 2
            cbrt_L = L.^ot;
            for u = 1:n
                V  = find(A(u, :) | A(:, u).');            	% neighbors
                sw = cbrt_W(u, V) + cbrt_W(V, u).';       	% symmetrized weights vector
                di = distance_inv_wei(cbrt_L(V, V));      	% inverse distance matrix
                se = di + di.';                             % symmetrized inverse distance matrix
                numer=(sum(sum((sw.' * sw) .* se)))/2;      % numerator
                if numer~=0
                    sa = A(u, V) + A(V, u).';             	% symmetrized adjacency vector
                    denom = sum(sa).^2 - sum(sa.^2);        % denominator
                    E(u) = numer / denom;                 	% local efficiency
                end
            end
    end
else
    di = distance_inv_wei(L);
    E = sum(di(:)) ./ (n^2 - n);                         	% global efficiency
end

E(isnan(E)) = 0;
    function D=distance_inv_wei(W_)
        
        n_=length(W_);
        D=inf(n_);                                                  % distance matrix
        D(1:n_+1:end)=0;
        
        for u=1:n_
            S=true(1,n_);                                           % distance permanence (true is temporary)
            W1_=W_;
            V=u;
            while 1
                S(V)=0;                                             % distance u->V is now permanent
                W1_(:,V)=0;                                         % no in-edges as already shortest
                for v=V
                    T=find(W1_(v,:));                               % neighbours of shortest nodes
                    D(u,T)=min([D(u,T);D(u,v)+W1_(v,T)]);           % smallest of old/new path lengths
                end
                
                minD=min(D(u,S));
                if isempty(minD)||isinf(minD)                       % isempty: all nodes reached;
                    break,                                          % isinf: some nodes cannot be reached
                end;
                
                V=find(D(u,:)==minD);
            end
        end
        
        D=1./D;                                                     % invert distance
        D(1:n_+1:end)=0;
    end
end