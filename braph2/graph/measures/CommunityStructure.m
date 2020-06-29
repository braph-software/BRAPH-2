classdef CommunityStructure < Measure
    methods
        function m  = CommunityStructure(g, varargin)
            m = m@Measure(g,  varargin{:});
        end
    end
    methods (Access=protected)
        function community_structure = calculate(m)
            g = m.getGraph();
            A = g.getA();
            
            % Different types of algorithm
            community_structure_algorithm = m.getSettings('CommunityStructureAlgorithm');
            if isequal(lower(community_structure_algorithm), 'louvain_bct')
                W = A;
                gamma = m.getSettings('CommunityStructureLBCTGamma');
                M0 = m.getSettings('CommunityStructureLBCTM0');
                B = m.getSettings('CommunityStructureLBCTB');
                
                W=double(W);                                % convert to double format
                n=length(W);                                % get number of nodes
                s=sum(sum(W));                              % get sum of edges
                
                if ~exist('B','var') || isempty(B)
                    type_B = 'modularity';
                elseif ischar(B)
                    type_B = B;
                else
                    type_B = 0;
                    if exist('gamma','var') && ~isempty(gamma)
                        warning('Value of gamma is ignored in generalized mode.')
                    end
                end
                if ~exist('gamma','var') || isempty(gamma)
                    gamma = 1;
                end
                
                if strcmp(type_B,'negative_sym') || strcmp(type_B,'negative_asym')
                    W0 = W.*(W>0);                          %positive weights matrix
                    s0 = sum(sum(W0));                      %weight of positive links
                    B0 = W0-gamma*(sum(W0,2)*sum(W0,1))/s0; %positive modularity
                    
                    W1 =-W.*(W<0);                          %negative weights matrix
                    s1 = sum(sum(W1));                      %weight of negative links
                    if s1                                   %negative modularity
                        B1 = W1-gamma*(sum(W1,2)*sum(W1,1))/s1;
                    else
                        B1 = 0;
                    end
                elseif min(min(W))<-1e-10
                    err_string = [
                        'The input connection matrix contains negative weights.\nSpecify ' ...
                        '''negative_sym'' or ''negative_asym'' objective-function types.'];
                    error(sprintf(err_string))
                end
                if strcmp(type_B,'potts') && any(any(W ~= logical(W)))
                    error('Potts-model Hamiltonian requires a binary W.')
                end
                
                if type_B
                    switch type_B
                        case 'modularity';      B = (W-gamma*(sum(W,2)*sum(W,1))/s)/s;
                        case 'potts';           B =  W-gamma*(~W);
                        case 'negative_sym';    B = B0/(s0+s1) - B1/(s0+s1);
                        case 'negative_asym';   B = B0/s0      - B1/(s0+s1);
                        otherwise;              error('Unknown objective function.');
                    end
                else                            % custom objective function matrix as input
                    B = double(B);
                    if ~isequal(size(W),size(B))
                        error('W and B must have the same size.')
                    end
                end
                if ~exist('M0','var') || M0 == 0
                    M0=1:n;
                elseif numel(M0)~=n
                    error('M0 must contain n elements.')
                end
                
                [~,~,Mb] = unique(M0);
                M = Mb;
                
                B = (B+B.')/2;                                          % symmetrize modularity matrix
                Hnm=zeros(n,n);                                         % node-to-module degree
                for m=1:max(Mb)                                         % loop over modules
                    Hnm(:,m)=sum(B(:,Mb==m),2);
                end
                
                Q0 = -inf;
                Q = sum(B(bsxfun(@eq,M0,M0.')));                        % compute modularity
                first_iteration = true;
                while Q-Q0>1e-10
                    flag = true;                                        % flag for within-hierarchy search
                    while flag
                        flag = false;
                        for u=randperm(n)                               % loop over all nodes in random order
                            ma = Mb(u);                                 % current module of u
                            dQ = Hnm(u,:) - Hnm(u,ma) + B(u,u);
                            dQ(ma) = 0;                                 % (line above) algorithm condition
                            
                            [max_dQ,mb] = max(dQ);                      % maximal increase in modularity and corresponding module
                            if max_dQ>1e-10                             % if maximal increase is positive
                                flag = true;
                                Mb(u) = mb;                             % reassign module
                                
                                Hnm(:,mb) = Hnm(:,mb)+B(:,u);           % change node-to-module strengths
                                Hnm(:,ma) = Hnm(:,ma)-B(:,u);
                            end
                        end
                    end
                    [~,~,Mb] = unique(Mb);                              % new module assignments
                    
                    M0 = M;
                    if first_iteration
                        M=Mb;
                        first_iteration=false;
                    else
                        for u=1:n                                       % loop through initial module assignments
                            M(M0==u)=Mb(u);                             % assign new modules
                        end
                    end
                    
                    n=max(Mb);                                          % new number of modules
                    B1=zeros(n);                                        % new weighted matrix
                    for u=1:n
                        for v=u:n
                            bm=sum(sum(B(Mb==u,Mb==v)));                % pool weights of nodes in same module
                            B1(u,v)=bm;
                            B1(v,u)=bm;
                        end
                    end
                    B=B1;
                    
                    Mb=1:n;                                             % initial module assignments
                    Hnm=B;                                              % node-to-module strength
                    
                    Q0=Q;
                    Q=trace(B);
                end
                community_structure = M;
                
            elseif  isequal(lower(community_structure_algorithm), 'louvain_general')
                B = A;
                limit = m.getSettings('CommunityStructureLGLimit');
                verbose = m.getSettings('CommunityStructureLGVerbose');
                randord = m.getSettings('CommunityStructureLGRandord');
                randmove = m.getSettings('CommunityStructureLGRandmove');
                
                %set default for maximum size of modularity matrix
                if nargin<2||isempty(limit)
                    limit = 10000;
                end
                
                %set level of reported/displayed text output
                if nargin<3||isempty(verbose)
                    verbose = 1;
                end
                if verbose
                    mydisp = @(s) disp(s);
                else
                    mydisp = @(s) [];
                end
                
                %set randperm- v. index-ordered
                if nargin<4||isempty(randord)
                    randord = 1;
                end
                if randord
                    myord = @(n) randperm(n);
                else
                    myord = @(n) 1:n;
                end
                
                %set move function (maximal (original Louvain) or random improvement)
                if nargin<5||isempty(randmove)
                    randmove=false;
                end
                if randmove
                    if ischar(randmove)
                        if any(strcmp(randmove,{'move','moverand','moverandw'}))
                            movefunction=randmove;
                        else
                            error('unknown value for ''randmove''');
                        end
                    else
                        % backwards compatibility: randmove=true
                        movefunction='moverand';
                    end
                else
                    movefunction='move';
                end
                
                % set initial partition
                if nargin<6||isempty(S0)
                    S0=[];
                end
                
                %initialise variables and do symmetry check
                if isa(B,'function_handle')
                    n=length(B(1));
                    S=(1:n)';
                    if isempty(S0)
                        S0=(1:n)';
                    else
                        if numel(S0)==n
                            group_handler('assign',S0);
                            S0=group_handler('return'); % tidy config
                        else
                            error('Initial partition does not have the right size for the modularity matrix')
                        end
                    end
                    %symmetry check (only checks symmetry of a small part of the matrix)
                    M=B;
                    it(:,1)=M(1);
                    ii=find(it(2:end)>0,3)+1;
                    ii=[1,ii'];
                    for i=2:length(ii)
                        it(:,i)=M(ii(i));
                    end
                    it=it(ii,:);
                    if norm(full(it-it'))>2*eps
                        error('Function handle does not correspond to a symmetric matrix. Deviation: %g', norm(full(it-it')))
                    end
                else
                    n = length(B);
                    S = (1:n)';
                    if isempty(S0)
                        S0=(1:n)';
                    else
                        if numel(S0)==n
                            % clean input partition
                            group_handler('assign',S0);
                            S0=group_handler('return');
                        else
                            error('Initial partition does not have the right size for the modularity matrix');
                        end
                    end
                    %symmetry check and fix if not symmetric
                    if nnz(B-B')
                        B=(B+B')/2; disp('WARNING: Forced symmetric B matrix')
                    end
                    M=B;
                end
                
                dtot=eps; %keeps track of total change in modularity
                y = S0;
                %Run using function handle, if provided
                while (isa(M,'function_handle')) %loop around each "pass" (in language of Blondel et al) with B function handle
                    clocktime=clock;
                    mydisp(['Merging ',num2str(length(y)),' communities  ',datestr(clocktime)]);
                    Sb=S;
                    yb=[];
                    while ~isequal(yb,y)
                        dstep=1;	%keeps track of change in modularity in pass
                        yb=[];
                        while (~isequal(yb,y))&&(dstep/dtot>2*eps)&&(dstep>10*eps) %This is the loop around Blondel et al's "first phase"
                            yb = y;
                            dstep=0;
                            group_handler('assign',y);
                            for i=myord(length(M(1)))
                                di=group_handler(movefunction,i,M(i));
                                dstep=dstep+di;
                            end
                            
                            dtot=dtot+dstep;
                            y=group_handler('return');
                            mydisp([num2str(max(y)),' change: ',num2str(dstep),...
                                ' total: ',num2str(dtot),' relative: ',num2str(dstep/dtot)]);
                        end
                        yb=y;
                    end
                    
                    %update partition
                    S=y(S); %group_handler implements tidyconfig
                    y = unique(y);  %unique also puts elements in ascending order
                    
                    %calculate modularity and return if converged
                    if isequal(Sb,S)
                        Q=0;
                        P=sparse(y,1:length(y),1);
                        for i=1:length(M(1))
                            Q=Q+(P*M(i))'*P(:,i);
                        end
                        Q=full(Q);
                        clear('group_handler');
                        clear('metanetwork_reduce');
                        return
                    end
                    
                    %check wether #groups < limit
                    t = length(unique(S));
                    if (t>limit)
                        metanetwork_reduce('assign',S); %inputs group information to metanetwork_reduce
                        M=@(i) metanetwork_i(B,i); %use function handle if #groups>limit
                    else
                        metanetwork_reduce('assign',S);
                        J = zeros(t);   %convert to matrix if #groups small enough
                        for c=1:t
                            J(:,c)=m.metanetwork_i(B,c);
                        end
                        B = J;
                        M=B;
                    end
                end
                
                % Run using matrix B
                S2 = (1:length(B))';
                Sb = [];
               
                while ~isequal(Sb,S2) %loop around each "pass" (in language of Blondel et al) with B matrix
                    clocktime=clock;
                    mydisp(['Merging ',num2str(max(y)),' communities  ',datestr(clocktime)]);
                    
                    Sb = S2;
                    yb = [];
                    while ~isequal(yb,y)
                        dstep=1;
                        while (~isequal(yb,y)) && (dstep/dtot>2*eps) && (dstep>10*eps) %This is the loop around Blondel et al's "first phase"
                            yb = y;
                            dstep=0;
                            group_handler('assign',y);
                            for i = myord(length(M))
                                di=group_handler(movefunction,i,M(:,i));
                                dstep=dstep+di;
                            end
                            dtot=dtot+dstep;
                            y=group_handler('return');
                            
                            mydisp([num2str(max(y)),' change: ',num2str(dstep),...
                                ' total: ',num2str(dtot),' relative: ',num2str(dstep/dtot)]);
                        end
                        yb=y;
                    end
                    
                    %update partition
                    S=y(S);
                    S2=y(S2);
                    
                    if isequal(Sb,S2)
                        P=sparse(y,1:length(y),1);
                        Q=full(sum(sum((P*M).*P)));
                        return
                    end
                    
                    M = m.metanetwork(B,S2);
                    y = unique(S2);  %unique also puts elements in ascending order
                end 
                
                community_structure = S;
            end            
        end
    end    
    methods (Static)
        function measure_class = getClass()
            measure_class = 'CommunityStructure';
        end
        function name = getName()
            name = 'Community Structure';
        end
        function description = getDescription()
            description = [ ...
                'The community structure of a graph is a' ...
                'subdivision of the network into non-overlapping' ...
                'groups of nodes which maximizes the number' ...
                'of whitin group edges, and minimizes the number' ...
                'of between group edges.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            available_settings = {
                'CommunityStructureAlgorithm', BRAPH2.STRING, 'louvain_bct', ...
                {'louvain_bct', 'louvain_general'}; ...
                'CommunityStructureLBCTGamma', BRAPH2.NUMERIC, 1, {}; ...
                'CommunityStructureLBCTM0', BRAPH2.NUMERIC, 0, {}; ...
                'CommunityStructureLBCTB', BRAPH2.STRING, 'modularity', ...
                {'modularity', 'potts', 'negative_sym', 'negative_asym'}; ...
                'CommunityStructureLGLimit', BRAPH2.NUMERIC, 1000, {}; ...
                'CommunityStructureLGVerbose', BRAPH2.LOGICAL, 1, {1, 0}; ...
                'CommunityStructureLGRandord', BRAPH2.LOGICAL, 1, {1, 0}; ...
                'CommunityStructureLGRandmove', BRAPH2.LOGICAL, 1, {1, 0}; ...
                };
        end
        function measure_format = getMeasureFormat()
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            measure_scope = Measure.UNILAYER;
        end
        function list = getCompatibleGraphList()
            list = { ...
                'GraphBU', ...
                'GraphBD', ...
                'GraphWU', ...
                'GraphWD', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWU', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            n = Measure.getCompatibleGraphNumber('CommunityStructure');
        end
        function M = metanetwork(J,S)
            %Computes new aggregated network (communities --> nodes)
            PP = sparse(1:length(S),S,1);
            M = PP'*J*PP;
        end
        function Mi = metanetwork_i(J,i)
            %ith column of metanetwork (used to create function handle)
            %J is a function handle
            ind=metanetwork_reduce('nodes',i);
            for j=ind(:)'
                metanetwork_reduce('reduce',J(j));
            end
            Mi=metanetwork_reduce('return');
        end
    end
end