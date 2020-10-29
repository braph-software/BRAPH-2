classdef MultilayerCommunityStructure < Measure
    % MultilayerCommunityStructure Multilayer community structure measure
    % MultilayerCommunityStructure provides the  Louvain-like multilayer 
    % community structure of a node for binary undirected (BU), binary
    % directed (BD), weighted undirected (WU), and weighted directed (WD) 
    % multiplex and multilayer graphs. 
    % 
    % MultilayerCommunityStructure methods:
    %   MultilayerCommunityStructure - constructor
    %
    % MultilayerCommunityStructure methods (Static)
    %   getClass                    - returns the multilayer community structure class
    %   getName                     - returns the name of multilayer community structure measure
    %   getDescription              - returns the description of multilayer community structure measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure
    %   getMeasure                  - returns the multilayer community structure class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
    
    properties (GetAccess=protected, SetAccess=protected)
        quality_function  % normalized quality function
    end
    methods
        function m  = MultilayerCommunityStructure(g, varargin)
            % MULTILAYERCOMMUNITYSTRUCTURE(G) creates multilayer community structure with default measure properties.
            % G is a multilayer (i.e., an instance of MultiplexGraphBD,
            % MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU). 
            %
            % See also Measure, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
            
            m = m@Measure(g,  varargin{:});
        end
    end
    methods (Access=protected)
        function multilayer_community_structure = calculate(m)
            % CALCULATE calculates the Louvain-like multilayer community structure value of a multiplex
            %
            % MULTILAYERCOMMUNITYSTRUCTURE = CALCULATE(M) returns the value of the 
            % Louvain-like multilayer community structure of a multilayer graph.
            %
            % See also Measure, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
    
            g = m.getGraph();  % graph from measure class
            N = g.nodenumber();  % number of nodes in each layer
            L = g.layernumber();  % number of layers
               
            limit = get_from_varargin(10000, 'MultilayerCommunityStructureLimit', m.getSettings());  % set default for maximum size of modularity matrix
            verbose = get_from_varargin(1, 'MultilayerCommunityStructureVerbose', m.getSettings());  % set level of reported/displayed text output
            randord = get_from_varargin(1, 'MultilayerCommunityStructureRandord', m.getSettings());  % set randperm
            randmove = get_from_varargin(1, 'MultilayerCommunityStructureRandmove', m.getSettings());  % set move function
            gamma = get_from_varargin(1, 'MultilayerCommunityStructureGamma', m.getSettings());
            omega = get_from_varargin(1, 'MultilayerCommunityStructureOmega', m.getSettings());
            S0 = get_from_varargin([], 'MultilayerCommunityStructureS0', m.getSettings());
            B = get_from_varargin([], 'MultilayerCommunityStructureB', m.getSettings());           
            
            % set randperm- v. index-ordered
            if randord
                myord = @(n) randperm(n);
            else
                myord = @(n) 1:n;
            end
            
            % set move function (maximal (original Louvain) or random improvement)
            if randmove
                if ischar(randmove)
                    if any(strcmp(randmove,{'move','moverand','moverandw'}))
                        movefunction = randmove;
                    else
                        error('unknown value for ''randmove''');
                    end
                else
                    % backwards compatibility: randmove=true
                    movefunction = 'moverand';
                end
            else
                movefunction = 'move';
            end
            
            if isempty(B)
                directionality_type =  g.getDirectionalityType(g.layernumber());
                directionality_firstlayer = directionality_type(1, 1);
                if g.is_multiplex(g) || g.is_multilayer(g)
                    A = cell(L, 1);
                    for i=1:L
                        A(i) = {g.getA(i)};
                    end
                    if directionality_firstlayer == Graph.UNDIRECTED  % undirected 
                        [B, twom] = m.multicat_undirected(A, gamma, omega, N(1), L);
                    else  % directed 
                        [B, twom] = m.multicat_directed(A, gamma, omega, N(1), L);
                    end
                elseif g.is_ordered_multiplex(g) || g.is_ordered_multilayer(g)
                    A = g.getA();  % 2D-cell array 
                    if directionality_firstlayer == Graph.UNDIRECTED  % undirected 
                        [B, twom] = m.multiord_undirected(A, gamma, omega, N(1), L);
                    else  % directed 
                        [B, twom] = m.multiord_directed(A, gamma, omega, N(1), L);
                    end
                end
            end
                
            % initialise variables and do symmetry check
            if isa(B,'function_handle')
                n = length(B(1));
                S = (1:n)';
                
                if isempty(S0)
                    S0 = (1:n)';
                else
                    if numel(S0) == n
                        group_handler('assign', S0);
                        S0 = group_handler('return'); % tidy config
                    else
                        error([BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT], ...
                            ['Initial partition size for the modularity matrix should be equal to %i,' ...
                            ' while it is ' tostring(numel(S0))], n)
                    end
                end
                
                % symmetry check (only checks symmetry of a small part of the matrix)
                M = B;
                it(:,1) = M(1);
                ii = find(it(2:end)>0,3) + 1;
                ii = [1,ii'];
                for i=2:length(ii)
                    it(:,i)=M(ii(i));
                end
                it = it(ii,:);
                if norm(full(it-it')) > 2*eps
                    error([BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT], ...
                        'Function handle does not correspond to a symmetric matrix. Deviation: %i', norm(full(it-it')))
                end
            else
                n = length(B);
                S = (1:n)';
                if isempty(S0)
                    S0 = (1:n)';
                else
                    if numel(S0)==n
                        % clean input partition
                        group_handler('assign', S0);
                        S0 = group_handler('return');
                    else
                        error([BRAPH2.STR ':MultilayerCommunityStructure:' BRAPH2.WRONG_INPUT], ...
                            ['Initial partition size for the modularity matrix should be equal to %i,' ...
                            ' while it is ' tostring(numel(S0))], n)
                    end
                end
                %symmetry check and fix if not symmetric
                if nnz(B-B')
                    B = (B+B')/2; 
%                     disp('WARNING: Forced symmetric B matrix')
                end
                M = B;
            end
            
            dtot = eps;  % keeps track of total change in modularity
            y = S0;
            % Run using function handle, if provided
            while (isa(M,'function_handle'))  % loop around each "pass" (in language of Blondel et al) with B function handle
                Sb = S;
                yb = [];
                while ~isequal(yb,y)
                    dstep = 1;  % keeps track of change in modularity in pass
                    yb = [];
                    while (~isequal(yb,y)) && (dstep/dtot>2*eps) && (dstep>10*eps)  % This is the loop around Blondel et al's "first phase"
                        yb = y;
                        dstep = 0;
                        group_handler('assign',y);
                        for i = myord(length(M(1)))
                            di = group_handler(movefunction, i, M(i));
                            dstep = dstep + di;
                        end
                        
                        dtot = dtot + dstep;
                        y = group_handler('return');
                    end
                    yb = y;
                end
                
                % update partition
                S = y(S);  % group_handler implements tidyconfig
                y = unique(y);  % unique also puts elements in ascending order
                
                % calculate modularity and return if converged
                if isequal(Sb,S)
                    Q = 0;
                    P = sparse(y,1:length(y),1);
                    for i=1:length(M(1))
                        Q = Q + (P*M(i))'*P(:,i);
                    end
                    Q = full(Q);
                    clear('group_handler');
                    clear('metanetwork_reduce');
                    return
                end
                
                % check wether #groups < limit
                t = length(unique(S));
                if (t > limit)
                    metanetwork_reduce('assign', S);  % inputs group information to metanetwork_reduce
                    M = @(i) m.metanetwork_i(B,i);  % use function handle if #groups > limit
                else
                    metanetwork_reduce('assign', S);
                    J = zeros(t);  % convert to matrix if #groups small enough
                    for c=1:t
                        J(:,c) = m.metanetwork_i(B,c);
                    end
                    B = J;
                    M = B;
                end
            end
            
            % Run using matrix B
            S2 = (1:length(B))';
            Sb = [];
            while ~isequal(Sb, S2)  % loop around each "pass" (in language of Blondel et al) with B matrix
                Sb = S2;
                yb = [];
                while ~isequal(yb,y)
                    dstep = 1;
                    while (~isequal(yb,y)) && (dstep/dtot > 2*eps) && (dstep > 10*eps)  % This is the loop around Blondel et al's "first phase"
                        yb = y;
                        dstep = 0;
                        group_handler('assign',y);
                        for i = myord(length(M))
                            di = group_handler(movefunction,i,M(:,i));
                            dstep = dstep+di;
                        end
                        dtot = dtot + dstep;
                        y = group_handler('return');                    
                    end
                    yb = y;
                end
                
                % update partition
                S = y(S);
                S2 = y(S2);
                
                if isequal(Sb,S2)
                    P = sparse(y,1:length(y),1);
                    Q = full(sum(sum((P*M).*P)));
                    %return
                end
                
                M = m.metanetwork(B, S2);
                y = unique(S2);  % unique also puts elements in ascending order
            end           
            m.quality_function = Q/twom;  % save normalized quality function
            S = reshape(S, N(1), L);
            multilayer_community_structure = cell(L, 1);
            for li = 1:1:L
                multilayer_community_structure(li) = {S(:, li)};
            end
        end
        function [B, twom] = multiord_undirected(m, A, gamma, omega, N, T)
            % MULTIORDUNDIRECTED returns the multilayer modularity matrix for ordered undirected networks
            %
            % [B, twom] = MULTIORDUNDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer 
            % Newman-Girvan modularity matrix for ordered undirected networks.
            %
            %   Input: A: Cell array of NxN adjacency matrices for each layer of an
            %          ordered undirected multilayer network
            %          gamma: intralayer resolution parameter
            %          omega: interlayer coupling strength
            %
            %   Output: B: function handle where B(i) returns the ith column of
            %          [NxT]x[NxT] flattened modularity tensor for the
            %           multilayer network with uniform ordinal coupling (T is
            %           the number of layers of the network)
            %           twom: normalisation constant
            %
            %   Example of usage: [B,twom]=multiord_f(A,gamma,omega);
            %          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
            %          postprocess_ordinal_multilayer.m for how to improve output
            %          multilayer partition
            %          Q=Q/twom;
            %          S=reshape(S,N,T);
            %
            %   [B,twom] = MULTIORD_F(A,GAMMA, OMEGA) with A a cell array of square
            %   symmetric matrices of equal size each representing an undirected network
            %   "layer" computes the multilayer Newman-Girvan modularity matrix using
            %   the quality function described in Mucha et al. 2010, with intralayer
            %   resolution parameter GAMMA, and with interlayer coupling OMEGA connecting
            %   nearest-neighbor ordered layers.  The null model used for the quality
            %   function is the Newman-Girvan null model (see e.g. Bazzi et al. for other
            %   possible null models). Once the mulilayer modularity matrix is computed,
            %   optimization can be performed by the generalized Louvain code GENLOUVAIN
            %   or ITERATED_GENLOUVAIN. The output B can be used with other heuristics,
            %   provided the same mapping is used to go from the multilayer tensor to
            %   the multilayer flattened matrix. That is, the node-layer tuple (i,s)
            %   is mapped to i + (s-1)*N. [Note that we can define a mapping between a
            %   multilayer partition S_m stored as an N by T matrix and the corresponding
            %   flattened partition S stored as an NT by 1 vector. In particular
            %   S_m = reshape(S,N,T) and S = S_m(:).]
            %
            %
            %   See also
            %       genlouvain heuristics:      GENLOUVAIN, ITERATED_GENLOUVAIN
            %       multilayer wrappers:        MULTICAT, MULTICATF, MULTIORD
            %       other heuristics:           SPECTRAL23
            %       Kernighan-Lin improvement:  KLNB
            %
            %   Notes:
            %     The matrices in the cell array A are assumed to be square,
            %     symmetric, and of equal size.  These assumptions are not checked here.
            %
            %     For smaller systems, it is potentially more efficient (and easier) to
            %     directly use the sparse quality/modularity matrix B in MULTIORD. For
            %     large systems with directed layer networks, use MULTIORDDIR_F.
            %
            %     This code serves as a template and can be modified for situations
            %     with other wrinkles (e.g., different intralayer null models,
            %     different numbers of nodes from layer-to-layer, or systems which are
            %     both multiplex and longitudinal).  That is, this code is only a
            %     starting point; it is by no means exhaustive.
            %
            %     By using this code, the user implicitly acknowledges that the authors
            %     accept no liability associated with that use.  (What are you doing
            %     with it anyway that might cause there to be a potential liability?!?)

            if nargin < 2 || isempty(gamma)
                gamma = 1;
            end
            
            if nargin < 3
                omega = 1;
            end
            
            if length(gamma) == 1
                gamma = repmat(gamma, T, 1);
            end
            
            ii=[]; jj=[]; vv=[];
            ki=[]; kj=[]; kv=[];
            twom = 0;
            for s=1:T
                indx = (1:N)' + (s-1)*N;
                [i, j, v] = find(A{s});
                ii = [ii; indx(i)]; 
                jj = [jj; indx(j)]; 
                vv = [vv; v];
                k = sum(A{s});
                mm = sum(k);
                twom = twom + mm;
                ki = [ki; indx];
                kj = [kj; ones(N,1)*s];
                kv = [kv; k(:)./mm];
            end
            AA = sparse(ii, jj, vv, N*T, N*T);
            K = sparse(ki, kj, kv, N*T, T);
            clear ii jj vv ki kj kv
            kvec = full(sum(AA));
            AA = AA + omega*spdiags(ones(N*T,2),[-N,N],N*T,N*T);
            B = @(i) AA(:,i) - gamma(ceil(i/(N+eps)))*K(:,ceil(i/(N+eps)))*kvec(i);
            twom = twom + 2*N*(T-1)*omega;
        end
        function [B, twom] = multiord_directed(m, A, gamma, omega, N, T)
            % MULTIORDDIRECTED returns the multilayer modularity matrix for ordered directed networks
            %
            % [B, twom] = MULTIORDDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer 
            % Leicht-Newman modularity matrix for ordered directed networks.
            %
            %   Input: A: Cell array of NxN adjacency matrices for each layer of an
            %          ordered directed multilayer network
            %          gamma: intralayer resolution parameter
            %          omega: interlayer coupling strength
            %
            %   Output: B: function handle where B(i) returns the ith column of
            %          [NxT]x[NxT] flattened modularity tensor for the
            %           multilayer network with uniform ordinal coupling (T is
            %           the number of layers of the network)
            %           twom: normalisation constant
            %
            %   Example of usage: [B,twom]=multiorddir_f(A,gamma,omega);
            %          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
            %          postprocess_ordinal_multilayer.m for how to improve output
            %          multilayer partition
            %          Q=Q/twom;
            %          S=reshape(S,N,T);
            %
            %   [B,twom] = MULTIORDDIR_F(A,GAMMA, OMEGA) with A a cell array of square
            %   matrices of equal size each representing an directed network "layer"
            %   computes the Leicht-Newman multilayer modularity matrix Susing the
            %   quality function described in Mucha et al. 2010, with intralayer
            %   resolution parameter GAMMA, and with interlayer coupling OMEGA
            %   connecting nearest-neighbor ordered layers. Once the mulilayer modularity
            %   matrix is computed, optimization can be performed by the generalized
            %   Louvain code GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used
            %   with other heuristics, provided the same mapping is used to go from the
            %   multilayer tensor to the multilayer flattened matrix. That is, the
            %   node-layer tuple (i,s) is mapped to i + (s-1)*N. [Note that we can
            %   define a mapping between a multilayer partition S_m stored as an N by T
            %   matrix and the corresponding flattened partition S stored as an NT by 1
            %   vector. In particular S_m = reshape(S,N,T) and S = S_m(:).]
            %
            %   See also
            %       genlouvain heuristics:      GENLOUVAIN, ITERATED_GENLOUVAIN
            %       multilayer wrappers:        MULTICAT, MULTICATF, MULTIORD
            %       other heuristics:           SPECTRAL23
            %       Kernighan-Lin improvement:  KLNB
            %
            %   Notes:
            %     The matrices in the cell array A are assumed to be square,
            %     and of equal size.  These assumptions are not checked here.
            %
            %     For smaller systems, it is potentially more efficient (and easier) to
            %     directly use the sparse quality/modularity matrix B in MULTIORD. For
            %     large systems with undirected layer networks, use MULTIORD_F.
            %
            %     This code serves as a template and can be modified for situations
            %     with other wrinkles (e.g., different intralayer null models,
            %     different numbers of nodes from layer-to-layer, or systems which are
            %     both multiplex and longitudinal).  That is, this code is only a
            %     starting point; it is by no means exhaustive.
            %
            %     By using this code, the user implicitly acknowledges that the authors
            %     accept no liability associated with that use.  (What are you doing
            %     with it anyway that might cause there to be a potential liability?!?)        
            
            if nargin < 2 || isempty(gamma)
                gamma = 1;
            end
            
            if nargin < 3 || isempty(omega)
                omega = 1;
            end

            if length(gamma) == 1
                gamma = repmat(gamma,T,1);
            end
            m = zeros(T,1);
            for i=1:T
                m(i) = sum(A{i}(:));
            end
            A = blkdiag(A{:});
            kout = sum(A,1);
            koutmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kout);
            kin = sum(A,2);
            kinmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kin);
            A = (A+A')./2;
            A = A + omega*spdiags(ones(N*T,2), [-N,N], N*T, N*T);
            
            B = @(i) A(:,i) - gamma(ceil(i./(N+eps))).*(kout(i).*kinmat(:,ceil(i./(N+eps)))+kin(i).*koutmat(:,ceil(i./(N+eps))))./(2*m(ceil(i./(N+eps))));
            twom = sum(m) + omega*2*N*(T-1);
        end
        function [B, twom] = multicat_undirected(m, A, gamma, omega, N, T)
            % MULTICATUNDIRECTED returns the multilayer modularity matrix for unordered undirected networks
            %
            % [B, twom] = MULTICATUNDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer 
            % Newman-Girvan modularity matrix for unordered undirected networks.
            %
            %   Input: A: Cell array of NxN adjacency matrices for each layer of an
            %          unordered multilayer undirected network
            %          gamma: intralayer resolution parameter
            %          omega: interlayer coupling strength
            %
            %   Output: B: [NxT]x[NxT] function handle where B(i) returns the ith column
            %           of the flattened modularity tensor for the
            %           multilayer network with uniform categorical coupling (T is
            %           the number of layers of the network)
            %           twom: normalisation constant
            %
            %   Example of usage: [B,twom]=multicat_f(A,gamma,omega);
            %          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
            %          postprocess_categorical_multilayer.m for how to improve output
            %          multilayer partition
            %          Q=Q/twom;
            %          S=reshape(S,N,T);
            %
            %   [B,twom] = MULTICAT(A,GAMMA, OMEGA) with A a cell array of square
            %   symmetric matrices of equal size each representing an undirected network
            %   "layer" computes the multilayer modularity matrix using the quality
            %   function described in Mucha et al. 2010, with intralayer resolution
            %   parameter GAMMA, and with interlayer coupling OMEGA connecting
            %   all-to-all categorical layers. Once the mulilayer modularity matrix is
            %   computed, optimization can be performed by the generalized Louvain code
            %   GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used with other
            %   heuristics, provided the same mapping is used to go from the multilayer
            %   tensor to the multilayer flattened matrix. That is, the node-layer tuple
            %   (i,s) is mapped to i + (s-1)*N. [Note that we can define a mapping between
            %   a multilayer partition S_m stored as an N by T matrix and the corresponding
            %   flattened partition S stored as an NT by 1 vector. In particular
            %   S_m = reshape(S,N,T) and S = S_m(:).]    
            %
            %   Notes:
            %     The matrices in the cell array A are assumed to be symmetric, square,
            %     and of equal size.  These assumptions are not checked here.
            %
            %     For smaller systems, it is potentially more efficient (and easier) to
            %     directly use the sparse quality/modularity matrix B, as in MULTICAT.
            %
            %     This code serves as a template and can be modified for situations
            %     with other wrinkles (e.g., different intralayer null models,
            %     different numbers of nodes from layer-to-layer, or systems which are
            %     both multiplex and longitudinal).  That is, this code is only a
            %     starting point; it is by no means exhaustive.
            %
            %     By using this code, the user implicitly acknowledges that the authors
            %     accept no liability associated with that use.  (What are you doing
            %     with it anyway that might cause there to be a potential liability?!?)       
            
            if nargin < 2 || isempty(gamma)
                gamma = 1;
            end
            
            if nargin < 3 || isempty(omega)
                omega = 1;
            end
            
            if length(gamma) == 1
                gamma = repmat(gamma, T, 1);
            end
            
            ii = []; jj = []; vv = [];
            ki = []; kj = []; kv = [];
            twom = 0;
            for s=1:T
                indx = [1:N]' + (s-1)*N;
                [i, j, v] = find(A{s});
                ii = [ii; indx(i)]; 
                jj = [jj; indx(j)]; 
                vv = [vv; v];
                k = sum(A{s});
                mm = sum(k);
                ki = [ki; indx];
                kj = [kj; ones(N,1)*s];
                kv = [kv; k(:)./mm];
                twom = twom + sum(k);  
            end
            AA = sparse(ii,jj,vv,N*T,N*T);
            K=sparse(ki,kj,kv,N*T,T);
            clear ii jj vv ki kj kv
            kvec = full(sum(AA));
            all2all = N*[(-T+1):-1,1:(T-1)];
            AA = AA + omega*spdiags(ones(N*T, 2*T-2), all2all, N*T, N*T);
            B = @(i) AA(:,i) - gamma(ceil(i/(N+eps)))*K(:, ceil(i/(N+eps)))*kvec(i);
            twom = twom + 2*N*(T-1)*T*omega;
        end
        function [B, twom] = multicat_directed(m, A, gamma, omega, N, T)
            % MULTICATDIRECTED returns the multilayer modularity matrix for unordered directed networks
            %
            % [B, twom] = MULTICATDIRECTED(A, GAMMA, OMEGA, N, T) returns the multilayer 
            % Leicht-Newman modularity matrix for unordered directed networks.
            %
            %   Input: A: Cell array of NxN adjacency matrices for each layer of a
            %          categorical directed multilayer network
            %          gamma: intralayer resolution parameter
            %          omega: interlayer coupling strength
            %
            %   Output: B: function handle where B(i) returns the ith column of
            %          [NxT]x[NxT] flattened modularity tensor for the
            %           multilayer network with uniform ordinal coupling (T is
            %           the number of layers of the network)
            %           twom: normalisation constant
            %
            %   Example of usage: [B,twom]=multicatdir_f(A,gamma,omega);
            %          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
            %          postprocess_categorical_multilayer.m for how to improve output
            %          multilayer partition
            %          Q=Q/twom;
            %          S=reshape(S,N,T);
            %
            %   [B,twom] = MULTICATDIR_F(A,GAMMA, OMEGA) with A a cell array of square
            %   matrices of equal size each representing an directed network "layer"
            %   computes the Leicht-Newman multilayer modularity matrix B using the
            %   quality function described in Mucha et al. 2010, with intralayer
            %   resolution parameter GAMMA, and with interlayer coupling OMEGA
            %   connecting all-to-all categorical layers. Once the mulilayer modularity
            %   matrix is computed, optimization can be performed by the generalized
            %   Louvain code GENLOUVAIN or ITERATED_GENLOUVAIN. The output B can be used
            %   with other heuristics, provided the same mapping is used to go from the
            %   multilayer tensor to the multilayer flattened matrix. That is, the
            %   node-layer tuple (i,s) is mapped to i + (s-1)*N. [Note that we can
            %   define a mapping between a multilayer partition S_m stored as an N by T
            %   matrix and the corresponding flattened partition S stored as an NT by 1
            %   vector. In particular S_m = reshape(S,N,T) and S = S_m(:).]
            %
            %   Notes:
            %     The matrices in the cell array A are assumed to be square,
            %     and of equal size.  These assumptions are not checked here.
            %
            %     For smaller systems, it is potentially more efficient (and easier) to
            %     directly use the sparse quality/modularity matrix B in MULTICAT. For
            %     large systems with undirected layer networks, use MULTICAT_F.
            %
            %     This code serves as a template and can be modified for situations
            %     with other wrinkles (e.g., different intralayer null models,
            %     different numbers of nodes from layer-to-layer, or systems which are
            %     both multiplex and longitudinal).  That is, this code is only a
            %     starting point; it is by no means exhaustive.
            %
            %     By using this code, the user implicitly acknowledges that the authors
            %     accept no liability associated with that use.  (What are you doing
            %     with it anyway that might cause there to be a potential liability?!?)
                     
            if nargin < 2 || isempty(gamma)
                gamma = 1;
            end
            
            if nargin < 3 || isempty(omega)
                omega = 1;
            end
            
            if length(gamma) == 1
                gamma = repmat(gamma, T, 1);
            end
            
            m = zeros(T, 1);
            for i=1:T
                m(i) = sum(A{i}(:));
            end
            A = blkdiag(A{:});
            kout = sum(A,1);
            koutmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kout);
            kin = sum(A,2);
            kinmat = sparse(1:(N*T), kron(1:T, ones(1,N)), kin);
            A = (A+A')./2;
            all2all = N*[(-T+1):-1,1:(T-1)];
            A = A + omega*spdiags(ones(N*T, 2*T-2), all2all, N*T, N*T);
            
            B = @(i) A(:,i) - gamma(ceil(i./(N+eps))).*(kout(i).*kinmat(:,ceil(i./(N+eps))) + kin(i).*koutmat(:, ceil(i./(N+eps))))./(2*m(ceil(i./(N+eps)))); 
            twom = sum(m) + omega*2*N*(T-1);
        end
        function M = metanetwork(m, J, S)
            % METANETWORK returns the new aggregated network (communities --> nodes)
            %
            % [B, twom] = METANETWORK(J, S) returns the new aggregated
            % network (communities --> nodes)
            
            PP = sparse(1:length(S), S, 1);
            M = PP'*J*PP;
        end
        function Mi = metanetwork_i(m, J, i)
            % METANETWORKI returns the ith column of the metanetwork
            %
            % [B, twom] = METANETWORKI(J, S) returns the ith column of 
            % the metanetwork. J is a function handle
            
            ind = metanetwork_reduce('nodes',i);
            for j=ind(:)'
                metanetwork_reduce('reduce',J(j));
            end
            Mi = metanetwork_reduce('return');
        end 
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multilayer community structure measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'MultilayerCommunityStructure';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the multilayer community structure measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Multilayer Community Structure';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the multilayer community structure description
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % multilayer community structure measure.
            %
            % See also getClass, getName.
        
            description = [ ...
                'The multilayer community structure of a multilayer graph is a' ...
                'subdivision of the network into non-overlapping' ...
                'groups of nodes which maximizes the number' ...
                'of whitin group edges, and minimizes the number' ...
                'of between group edges.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to MultilayerCommunityStructure
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to MultilayerCommunityStructure. Empty Array in this case.
            
            available_settings = {
                'MultilayerCommunityStructureGamma', BRAPH2.NUMERIC, 1, {}; ...
                'MultilayerCommunityStructureOmega', BRAPH2.NUMERIC, 1, {}; ...
                'MultilayerCommunityStructureLimit', BRAPH2.NUMERIC, 10000, {}; ...
                'MultilayerCommunityStructureVerbose', BRAPH2.LOGICAL, 1, {1, 0}; ...
                'MultilayerCommunityStructureRandord', BRAPH2.LOGICAL, 1, {1, 0}; ...
                'MultilayerCommunityStructureRandmove', BRAPH2.LOGICAL, 1, {1, 0}; ...
                'MultilayerCommunityStructureS0', BRAPH2.NUMERIC, [], {}; ...
                'MultilayerCommunityStructureB', BRAPH2.NUMERIC, [], {}; ...
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of 
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of multilayer community structure measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of MultilayerCommunityStructure
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of multilayer community structure measure (UNILAYER).
            %
            % See also getMeasureFormat.
           
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of MultilayerCommunityStructure
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the parametricity
            % of multilayer community structure measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with MultilayerCommunityStructure
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to multilayer community structure. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
   
            list = { ...
                'MultiplexGraphBU', ...
                'MultiplexGraphBD', ...
                'MultiplexGraphWU', ...
                'MultiplexGraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with MultilayerCommunityStructure
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to multilayer community structure.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('MultilayerCommunityStructure');
        end
    end
    methods
        function quality_function = getQualityFunction(m)
            % GETQUALITYFUNCTION returns the quality function value 
            %
            % VALUES = GETQUALITYFUNCTION() returns the quality function
            % value.
            
            quality_function = m.quality_function;
        end
    end
end