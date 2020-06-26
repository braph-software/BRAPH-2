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
                    error(sprintf(err_string))              %#ok<SPERR>
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
                if ~exist('M0','var') || isempty(M0)
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
        function available_settings = available_settings()
            available_settings = {
                {'CommunityStructureAlgorithm', BRAPH2.STRING, 'louvain_bct', ...
                {'louvain_bct', 'louvain_general'}}, ...
                {'CommunityStructureLBCTGamma', BRAPH2.NUMERIC, 1, {}}, ...
                {'CommunityStructureLBCTM0', BRAPH2.NUMERIC, 0, {}}, ...
                {'CommunityStructureLBCTB', BRAPH2.STRING, 'modularity', ...
                {'modularity', 'potts', 'negative_sym', 'negative_asym'}}, ...
                {'CommunityStructureLGLimit', BRAPH2.NUMERIC, 1000, {}}, ...
                {'CommunityStructureLGVerbose', BRAPH2.LOGICAL, 1, {1, 0}}, ...
                {'CommunityStructureLGRandord', BRAPH2.LOGICAL, 1, {1, 0}}, ...
                {'CommunityStructureLGRandmove', BRAPH2.LOGICL, 1, {1, 0}}
                };
        end
        function measure_format = getMeasureFormat()
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            measure_scope = Measure.MULTILAYER;
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
    end
end