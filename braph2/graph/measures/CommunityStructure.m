classdef CommunityStructure < Measure
    % CommunityStructure Community structure measure
    % CommunityStructure provides the Louvain or Newman multilayer 
    % community structure of a node for binary undirected (BU), binary
    % directed (BD), weighted undirected (WU), and weighted directed (WD) 
    % graphs. 
    % 
    % CommunityStructure methods:
    %   CommunityStructure          - constructor
    %
    % CommunityStructure methods (Static)
    %   getClass                    - returns the community structure class
    %   getName                     - returns the name of community structure measure
    %   getDescription              - returns the description of community structure measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure
    %   getMeasure                  - returns the community structure class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBD, GraphBU, GraphWD, GraphWU.
    
    properties (GetAccess=protected, SetAccess=protected)
        quality_function  % normalized quality function
    end
    methods
        function m  = CommunityStructure(g, varargin)
            % COMMUNITYSTRUCTURE(G) creates community structure with default measure properties.
            % G is a graph (i.e., an instance of GraphBD,
            % GraphBU, GraphWD, GraphWU). 
            %
            % See also Measure, GraphBD, GraphBU, GraphWD, GraphWU.
            
            m = m@Measure(g,  varargin{:});
        end
    end
    methods (Access=protected)
        function community_structure = calculate(m)
            % CALCULATE calculates the Louvain or Newman community structure value of a graph
            %
            % COMMUNITYSTRUCTURE = CALCULATE(M) returns the value of the 
            % Louvain or Newman community structure of a graph.
            %
            % See also Measure, GraphBD, GraphBU, GraphWD, GraphWU.
    
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjacency matrix
            N = g.nodenumber();  % number of nodes in each layer
            
            gamma = get_from_varargin(1, 'CommunityStructureGamma', m.getSettings());  % resolution parameter
            M0 = get_from_varargin([], 'CommunityStructureM0', m.getSettings());  % initial community affiliation vector
            B = get_from_varargin([], 'CommunityStructureB', m.getSettings());  % custom objective matrix
            type_B = get_from_varargin('modularity', 'CommunityStructureBtype', m.getSettings());  % objective-function type
            
            community_structure_algorithm = get_from_varargin('Louvain', 'CommunityStructureAlgorithm', m.getSettings());
            switch lower(community_structure_algorithm)
                case {'Newman'}  % Newman algorithm

                
                otherwise  % {'Louvain'}  % Louvain algorithm  
                    W = double(A);  % convert to double format
                    s = sum(sum(W));  % get sum of edges
                    
                    if isempty(M0)
                        M0 = 1:N;
                    else
                        assert(isequal(size(M0, 2), size(1:N, 2)), ...
                            [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
                            ['M0 initial community affiliation vector must have the same length than the number of nodes' ...
                            '(' tostring(size(1:N, 2)) ') while its length is ' tostring(size(M0, 2))])
                    end
                    [~,~,Mb] = unique(M0);
                    M = Mb;
                        
                    if isempty(B)
                        % calculaye B according to type_B

                        switch lower(type_B)
                            case {'potts'}
                                assert(all(all(W == logical(W))), ...
                                    [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
                                    ['Potts-model Hamiltonian requires a binary adjacency matrix' ...
                                    'while it is ' tostring(W)])
                                B =  W - gamma*(~W);
                            otherwise  % {'modularity'} default 
                                B = W - gamma*(sum(W, 2)*sum(W, 1))/s;
                        end
                    else  % B matrix exists      
                        assert(isequal(size(W), size(B)), ...
                            [BRAPH2.STR ':CommunityStructure:' BRAPH2.WRONG_INPUT], ...
                            ['B matrix must have the same size than the adjacency matrix' ...
                            '(' tostring(size(W)) ') while its size is ' tostring(size(B))])
                    end
                    
                    B = (B+B.')/2;  % symmetrize modularity matrix
                    Hnm = zeros(N, N);  % node-to-module degree
                    for m = 1:max(Mb)  % loop over modules
                        Hnm(:, m) = sum(B(:, Mb== m), 2);
                    end
                    H = sum(Hnm, 2);  % node degree
                    Hm = sum(Hnm, 1);  % module degree 
                    
                    Q0 = -inf;
                    Q = sum(B(bsxfun(@eq, M0, M0.')))/s;  % compute modularity
                    first_iteration = true;
                    while Q-Q0 > 1e-10
                        flag = true;  % flag for within-hierarchy search
                        while flag
                            flag = false;
                            for u = randperm(N)  % loop over all nodes in random order
                                ma = Mb(u);  % current module of u
                                dQ = Hnm(u, :)- Hnm(u,ma) + B(u, u);
                                dQ(ma) = 0;  % (line above) algorithm condition
                                
                                [max_dQ, mb] = max(dQ);  % maximal increase in modularity and corresponding module
                                if max_dQ > 1e-10  % if maximal increase is positive
                                    flag = true;
                                    Mb(u) = mb;  % reassign module
                                    
                                    Hnm(:,mb) = Hnm(:,mb) + B(:,u);  % change node-to-module strengths
                                    Hnm(:,ma) = Hnm(:,ma) - B(:,u);
                                    Hm(mb) = Hm(mb) + H(u);  % change module strengths
                                    Hm(ma) = Hm(ma) - H(u);
                                end
                            end
                        end
                        [~,~,Mb] = unique(Mb);  % new module assignments
                        
                        M0 = M;
                        if first_iteration
                            M = Mb;
                            first_iteration = false;
                        else
                            for u = 1:N  % loop through initial module assignments
                                M(M0==u) = Mb(u);  % assign new modules
                            end
                        end
                        
                        n = max(Mb);  % new number of modules
                        B1 = zeros(n);  % new weighted matrix
                        for u = 1:n
                            for v = u:n
                                bm = sum(sum(B(Mb==u,Mb==v)));  % pool weights of nodes in same module
                                B1(u,v) = bm;
                                B1(v,u) = bm;
                            end
                        end
                        B = B1;
                        
                        Mb = 1:n;  % initial module assignments
                        Hnm = B;  % node-to-module strength
                        H = sum(B);  % node strength
                        Hm = H;  % module strength
                        
                        Q0 = Q;
                        Q = trace(B)/s;  % compute modularity
                    end
                    m.quality_function = Q;  % save normalized quality function/modularity
                    community_structure = M';
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the community structure measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'CommunityStructure';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the community structure measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Community Structure';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the community structure description
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % community structure measure.
            %
            % See also getClass, getName.
        
            description = [ ...
                'The community structure of a graph is a' ...
                'subdivision of the network into non-overlapping' ...
                'groups of nodes which maximizes the number' ...
                'of whitin group edges, and minimizes the number' ...
                'of between group edges.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to CommunityStructure
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to CommunityStructure. Empty Array in this case.
            
            available_settings = {
                'CommunityStructureAlgorithm', BRAPH2.STRING, 'Louvain', {'Louvain', 'Newman'}; ...
                'CommunityStructureGamma', BRAPH2.NUMERIC, 1, {}; ...
                'CommunityStructureM0', BRAPH2.NUMERIC, [], {}; ... 
                'CommunityStructureB', BRAPH2.NUMERIC, [], {}; ...
                'CommunityStructureBtype', BRAPH2.STRING, 'modularity', {'modularity', 'potts', 'negative_sym', 'negative_asym'}; ...             
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of CommunityStructure
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of community structure measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of CommunityStructure
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of community structure measure (UNILAYER).
            %
            % See also getMeasureFormat.
           
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of CommunityStructure
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the parametricity
            % of community structure measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with CommunityStructure
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to community structure. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
   
            list = { ...
                'GraphBU', ...
                'GraphBD', ...
                'GraphWU', ...
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with CommunityStructure
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to community structure.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('CommunityStructure');
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