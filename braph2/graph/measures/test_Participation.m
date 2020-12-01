% test Participation

%% Test 1: GraphBU
A = [
    0 1 1 1 0 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 1 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 0 1 1 0;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0
    ];

known_participation = {[0 4/9 3/8 4/9 12/25 0 0 0]'};

g = GraphBU(A);
participation = Participation(g);

assert(isequal(participation.getValue(), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0 1 1 1 0 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 1 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 0 1 1 0;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0
    ];

% out rule - default
known_participation_default_out = {[0 1/2 0 1/2 0 0 0 0]'};

g = GraphBD(A);
participation = Participation(g);

assert(isequal(participation.getValue(), known_participation_default_out), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for GraphBD.')

% in rule 
known_participation_in = {[0 -1 8/9 -1 5/9 0 0 1]'};

g = GraphBD(A);
participation = Participation(g, 'DirectedParticipationRule', 'in');

assert(isequal(participation.getValue(), known_participation_in), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for GraphBD.')

%% Test 3: MultiplexGraphBU
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {
    A11     A12
    A21     A22
    };
 
known_participation = {
                 [0 0 0 0]'
                 [0 0 0 0]'
                 };   
 
g = MultiplexGraphBU(A);
participation = Participation(g);

assert(isequal(participation.getValue(), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for MultiplexGraphBU.')

%% Test 4: GraphWU: Comparison with standard method 
A = randn(randi(10));
g = GraphWU(A); 

p = Participation(g);
participation = p.getValue();
Ci_used = p.getCi();

participation_bct = participation_coef(g.getA(), Ci_used{1});

assert(isequal(participation, {participation_bct}), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for BCT.')

%% Function to calculate participation from 2019_03_03_BCT

function P = participation_coef(W,Ci,flag)
%PARTICIPATION_COEF     Participation coefficient
%
%   P = participation_coef(W,Ci);
%
%   Participation coefficient is a measure of diversity of intermodular
%   connections of individual nodes.
%
%   Inputs:     W,      binary/weighted, directed/undirected connection matrix
%               Ci,     community affiliation vector
%               flag,   0, undirected graph (default)
%                       1, directed graph: out-degree
%                       2, directed graph: in-degree
%
%   Output:     P,      participation coefficient
%
%   Reference: Guimera R, Amaral L. Nature (2005) 433:895-900.
%
%
%   2008-2015
%   Mika Rubinov, UNSW/U Cambridge
%   Alex Fornito, University of Melbourne

%   Modification History:
%   Jul 2008: Original (Mika Rubinov)
%   Mar 2011: Weighted-network bug fixes (Alex Fornito)
%   Jan 2015: Generalized for in- and out-degree (Mika Rubinov)

if ~exist('flag','var')
    flag=0;
end

switch flag
    case 0 % no action required
    case 1 % no action required
    case 2; W=W.';
end

n=length(W);                        %number of vertices
Ko=sum(W,2);                        %degree
Gc=(W~=0)*diag(Ci);                 %neighbor community affiliation
Kc2=zeros(n,1);                     %community-specific neighbors

for i=1:max(Ci)
    Kc2=Kc2+(sum(W.*(Gc==i),2).^2);
end

P=ones(n,1)-Kc2./(Ko.^2);
P(~Ko)=0;                           %P=0 if for nodes with no (out)neighbors
end