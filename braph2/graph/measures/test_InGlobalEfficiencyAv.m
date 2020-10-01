% test InGlobalEfficiencyAv

%% Test 1: GraphBD
A = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_in_global_efficiency_av = {mean([1/4 1/4 1/4 1/4 0])};

g = GraphBD(A);
in_global_efficiency_av = InGlobalEfficiencyAv(g);

assert(isequal(in_global_efficiency_av.getValue(), known_in_global_efficiency_av), ...
    [BRAPH2.STR ':InGlobalEfficiencyAv:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiencyAv is not being calculated correctly for GraphBD.')

%% Test 2: GraphWD
A = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_in_global_efficiency_av = {mean([1/20 1/40 1/40 1/20 0])};

g = GraphWD(A);
in_global_efficiency_av = InGlobalEfficiencyAv(g);

assert(isequal(in_global_efficiency_av.getValue(), known_in_global_efficiency_av), ...
    [BRAPH2.STR ':InGlobalEfficiencyAv:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiencyAv is not being calculated correctly for GraphWD.')

%% Test 3: MultiplexGraphBD
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

known_in_global_efficiency_av = {
                        mean([1/4 1/4 1/4 1/4 0])
                        mean([1/4 1/4 1/4 1/4 0])
                        };


g = MultiplexGraphBD(A);
in_global_efficiency_av = InGlobalEfficiencyAv(g);

assert(isequal(in_global_efficiency_av.getValue(), known_in_global_efficiency_av), ...
    [BRAPH2.STR ':InGlobalEfficiencyAv:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiencyAv is not being calculated correctly for MultiplexGraphBD.')

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

known_in_global_efficiency_av = {
                        mean([1/20 1/40 1/40 1/20 0])
                        mean([1/20 1/40 1/40 1/20 0])
                        };


g = MultiplexGraphWD(A);
in_global_efficiency_av = InGlobalEfficiencyAv(g);

assert(isequal(in_global_efficiency_av.getValue(), known_in_global_efficiency_av), ...
    [BRAPH2.STR ':InGlobalEfficiencyAv:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiencyAv is not being calculated correctly for MultiplexGraphWD.')

%% Test 5: GraphBD: Calculation vs BCT
A = rand(randi(5));
g = GraphBD(A);

in_global_efficiency_av = InGlobalEfficiencyAv(g).getValue();
in_global_efficiency_av = in_global_efficiency_av{1};
in_global_efficiency_av_bct = efficiency_bin(g.getA());

assert(isequal(round(in_global_efficiency_av, 4), in_global_efficiency_av_bct), ...
    [BRAPH2.STR ':InGlobalEfficiencyAv:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiencyAv is not being calculated correctly for BCT.')

function E = efficiency_bin(A,local)
%EFFICIENCY_BIN     Global efficiency, local efficiency.
%
%   Eglob = efficiency_bin(A);
%   Eloc = efficiency_bin(A,1);
%
%   The global efficiency is the average of inverse shortest path length,
%   and is inversely related to the characteristic path length.
%
%   The local efficiency is the global efficiency computed on the
%   neighborhood of the node, and is related to the clustering coefficient.
%
%   Inputs:     A,              binary undirected or directed connection matrix
%               local,          optional argument
%                                   local=0 computes global efficiency (default)
%                                   local=1 computes local efficiency
%
%   Output:     Eglob,          global efficiency (scalar)
%               Eloc,           local efficiency (vector)
%
%
%   Algorithm: algebraic path count
%
%   Reference: Latora and Marchiori (2001) Phys Rev Lett 87:198701.
%              Fagiolo (2007) Phys Rev E 76:026107.
%              Rubinov M, Sporns O (2010) NeuroImage 52:1059-69
%
%
%   Mika Rubinov, U Cambridge
%   Jonathan Clayden, UCL
%   2008-2013

% Modification history:
% 2008: Original (MR)
% 2013: Bug fix, enforce zero distance for self-connections (JC)
% 2013: Local efficiency generalized to directed networks

n=length(A);                                %number of nodes
A(1:n+1:end)=0;                             %clear diagonal
A=double(A~=0);                             %enforce double precision

if exist('local','var') && local            %local efficiency
    E=zeros(n,1);
    for u=1:n
        V=find(A(u,:)|A(:,u).');            %neighbors
        sa=A(u,V)+A(V,u).';                 %symmetrized adjacency vector
        e=distance_inv(A(V,V));             %inverse distance matrix
        se=e+e.';                           %symmetrized inverse distance matrix
        numer=sum(sum((sa.'*sa).*se))/2;    %numerator
        if numer~=0
            denom=sum(sa).^2 - sum(sa.^2);  %denominator
            E(u)=numer/denom;               %local efficiency
        end
    end
else                                        %global efficiency
    e=distance_inv(A);
    E=sum(e(:))./(n^2-n);
end

% E(isnan(E)) = 0;
    function D=distance_inv(A_)
        l=1;                                        %path length
        Lpath=A_;                                   %matrix of paths l
        D=A_;                                       %distance matrix
        n_=length(A_);
        
        Idx=true;
        while any(Idx(:))
            l=l+1;
            Lpath=Lpath*A_;
            Idx=(Lpath~=0)&(D==0);
            D(Idx)=l;
        end
        
        D(~D | eye(n_))=inf;                        %assign inf to disconnected nodes and to diagonal
        D=1./D;                                     %invert distance
    end
end