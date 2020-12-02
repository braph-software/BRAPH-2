% test PathTransitivity

%% Test 1: GraphBU
A = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 0; 
    1 0 0 0
    ];

known_path_transitivity = {[
    0    2/3  2/3  0
    2/3  0    1    4/9
    2/3  1    0    4/9
    0    4/9  4/9  0
    ]};

g = GraphBU(A);
path_transitivity = PathTransitivity(g);

assert(isequal(path_transitivity.getValue(), known_path_transitivity), ...
    [BRAPH2.STR ':PathTransitivity:' BRAPH2.BUG_ERR], ...
    'PathTransitivity is not being calculated correctly for GraphBU.')

%% Test 2: MultiplexGraphBU
A11 = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 0; 
    1 0 0 0
    ];
A12 = eye(4);
A21 = eye(4);
A22 = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 0; 
    1 0 0 0
    ];
A = {
    A11     A12
    A21     A22
    };

known_path_transitivity = {[
    0    2/3  2/3  0
    2/3  0    1    4/9
    2/3  1    0    4/9
    0    4/9  4/9  0
    ]
    [
    0    2/3  2/3  0
    2/3  0    1    4/9
    2/3  1    0    4/9
    0    4/9  4/9  0
    ]};

g = MultiplexGraphBU(A);
path_transitivity = PathTransitivity(g);

assert(isequal(path_transitivity.getValue(), known_path_transitivity), ...
    [BRAPH2.STR ':PathTransitivity:' BRAPH2.BUG_ERR], ...
    'PathTransitivity is not being calculated correctly for MultiplexGraphBU.')

%% Test 3: Calculation GraphBU vs BCT
g = GraphBU(rand(3));
A = g.getA();

path_transitivity = PathTransitivity(g);
path_transitivity_value = path_transitivity.getValue();
path_transitivity_value = path_transitivity_value{1};

bct_path_transitivity = path_transitivity_standard_BU(A);

assert( isequal(path_transitivity_value, bct_path_transitivity), ...
    [BRAPH2.STR ':PathTransitivity:' BRAPH2.BUG_ERR], ...
    'PathTransitivity is not working for GraphWU: modified BCT comparision.')

%% Functions to calculate path transitivity adapted from 2019_03_03_BCT

function [SPL,hops,Pmat] = distance_wei_floyd(A, transform)
if exist('transform','var') && ~isempty(transform)
    
    switch transform
        
        case 'log'
            
            if any((A<0) & A>1)
                error('connection-strengths must be in the interval [0,1) to use the transform -log(w_ij) \n')
            else
                SPL = -log(A);
            end
            
        case 'inv'
            
            SPL = 1./A;
            
        otherwise
            
            error('Unexpected transform type. Only "log" and "inv" are accepted \n')
    end
    
else    % the input is a connection lengths matrix.
    SPL = A;
    SPL(SPL == 0) = inf;
end

n=size(A,2);

if nargout > 1
    flag_find_paths = true;
    hops = double(A ~= 0);
    Pmat = 1:n;
    Pmat = Pmat(ones(n,1),:);
else
    flag_find_paths = false;
end

for k=1:n
    i2k_k2j = bsxfun(@plus, SPL(:,k), SPL(k,:));
    
    if flag_find_paths
        path = bsxfun(@gt, SPL, i2k_k2j);
        [i,j] = find(path);
        hops(path) = hops(i,k) + hops(k,j)';
        Pmat(path) = Pmat(i,k);
    end
    
    SPL = min(SPL, i2k_k2j);
end

SPL(eye(n)>0)=0;

if flag_find_paths
    hops(eye(n)>0)=0;
    Pmat(eye(n)>0)=0;
end
end

function path = retrieve_shortest_path(s,t,hops,Pmat)
path_length = hops(s,t);
if path_length ~= 0
    path = nan(path_length+1,1);
    path(1) = s;
    for ind = 2:length(path)
        s = Pmat(s,t);
        path(ind) = s;
    end
else
    path = [];
end
end


function stdvalue_BU = path_transitivity_standard_BU(A, transform)
if ~exist('transform','var')
    transform = [];
end

n=length(A);
m=zeros(n,n);
T=zeros(n,n);

for i=1:n-1
    for j=i+1:n
        x=0;
        y=0;
        z=0;
        for k=1:n
            if A(i,k)~=0 && A(j,k)~=0 && k~=i && k~=j
                x=x+A(i,k)+A(j,k);
            end
            if k~=j
                y=y+A(i,k);
            end
            if k~=i
                z=z+A(j,k);
            end
        end
        m(i,j)=x/(y+z);
    end
end
m=m+m';

[~,hops,Pmat] = distance_wei_floyd(A,transform);

% --- path transitivity ---%%
for i=1:n-1
    for j=i+1:n
        x=0;
        path = retrieve_shortest_path(i,j,hops,Pmat);
        K=length(path);
        
        for t=1:K-1
            for l=t+1:K
                x=x+m(path(t),path(l));
            end
        end
        T(i,j)=2*x/(K*(K-1));
    end
end
T=T+T';
stdvalue_BU = T;
stdvalue_BU(isnan(stdvalue_BU)) = 0; % Should return zeros, not NaN
end