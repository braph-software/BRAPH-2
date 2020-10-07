classdef MultilayerCommunityStructure < Measure
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
            % CALCULATE calculates the multilayer community structure value of a multiplex
            %
            % MULTIPLEXPARTICIPATION = CALCULATE(M) returns the value of the 
            % multilayer community structure of a multilayer graph.
            %
            % See also Measure,  MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
    
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % 2D-cell array 
            N = g.nodenumber();  % number of nodes in each layer
            N = N(1);  %  same number of nodes in all layers
            L = g.layernumber();  % number of layers
            T = L;
               
            limit = get_from_varargin(1000, 'MultilayerCommunityStructureLGLimit', m.getSettings());
            verbose = get_from_varargin(1, 'MultilayerCommunityStructureLGVerbose', m.getSettings());
            randord = get_from_varargin(1, 'MultilayerCommunityStructureLGRandord', m.getSettings());
            randmove = get_from_varargin(1, 'MultilayerCommunityStructureLGRandmove', m.getSettings());
            
            if g.is_multiplex || g.is_multilayer
                [B, ~] = multicat(A, gamma, omega);
            elseif g.is_ordered_multiplex || g.is_ordered_multilayer
                [B, ~] = multiord(A, gamma, omega);
            end
           
                
            multilayer_community_structure = 0;
        end
        function [B,twom] = multiord(A,gamma,omega)
            % MULTIORD  returns multilayer Newman-Girvan modularity matrix for ordered layers, matrix version
            % Works for directed or undirected networks
            %
            % Version: 2.2.0
            % Date: Thu 11 Jul 2019 12:25:42 CEST
            %
            %   Input: A: Cell array of NxN adjacency matrices for each layer of an
            %          ordered multilayer (directed or undirected) network
            %          gamma: intralayer resolution parameter
            %          omega: interlayer coupling strength
            %
            %   Output: B: [NxT]x[NxT] flattened modularity tensor for the
            %           multilayer network with uniform ordinal coupling (T is
            %           the number of layers of the network)
            %           mm: normalisation constant
            %
            %   Example of usage: [B,mm]=multiord(A,gamma,omega);
            %          [S,Q]= genlouvain(B); % see iterated_genlouvain.m and
            %          postprocess_temporal_multilayer.m for how to improve output
            %          multilayer partition
            %          Q=Q/mm;
            %          S=reshape(S,N,T);
            %
            %   [B,mm] = MULTIORD(A,GAMMA, OMEGA) with A a cell array of square
            %   (symmetric or assymetric) matrices of equal size each representing a
            %   directed or undirected network "layer" computes the Newman Girvan multilayer
            %   modularity matrix using the quality function described in Mucha et al.
            %   2010, with intralayer resolution parameter GAMMA, and with interlayer
            %   coupling OMEGA connecting nearest-neighbor ordered layers.  The null
            %   model used for the quality function is the Newman-Girvan null model
            %   (see e.g. Bazzi et al. for other possible null models). Once the
            %   mulilayer modularity matrix is computed, optimization can be performed
            %   by the generalized Louvain code GENLOUVAIN or ITERATED_GENLOUVAIN. The
            %   sparse output matrix B can be used with other heuristics, provided the
            %   same mapping is used to go from the multilayer tensor to the multilayer
            %   flattened matrix. That is, the node-layer tuple (i,s) is mapped to
            %   i + (s-1)*N. [Note that we can define a mapping between a multilayer
            %   partition S_m stored as an N by T matrix and the corresponding flattened
            %   partition S stored as an NT by 1 vector. In particular S_m = reshape(S,N,T)
            %   and S = S_m(:).]
 
            if nargin<2
                gamma=1;
            end
            
            if nargin<3
                omega=1;
            end
            
            N = g.nodenumber();  % number of nodes in each layer
            N = N(1);  %  same number of nodes in all layers
            L = g.layernumber();  % number of layers
            T = L;
            
            if length(gamma)==1
                gamma = repmat(gamma, T, 1);
            end
            
            B = spalloc(N*T, N*T, N*N*T+2*N*T);
            twom = 0;
            for s=1:T
                kout = sum(A{s},1);
                kin = sum(A{s},2);
                mm = sum(kout);
                twom = twom+mm;
                indx = [1:N]+(s-1)*N;
                B(indx,indx) = (A{s}+A{s}')/2-gamma(s)/2.*((kin*kout+kout'*kin')/mm);
            end
            B = B + omega*spdiags(ones(N*T,2),[-N,N],N*T,N*T);
            twom = twom + 2*N*(T-1)*omega;
        end  
        function [B,twom] = multicat(A,gamma,omega)
            % MULTICAT  returns multilayer Newman-Girvan modularity matrix for unordered layers, matrix version
            %
            % Version: 2.2.0
            % Date: Thu 11 Jul 2019 12:25:42 CEST
            %
            %   Input: A: Cell array of NxN adjacency matrices for each layer of an
            %          unordered multilayer undirected network
            %          gamma: intralayer resolution parameter
            %          omega: interlayer coupling strength
            %
            %   Output: B: [NxT]x[NxT] flattened modularity tensor for the
            %           multilayer network with uniform categorical coupling (T is
            %           the number of layers of the network)
            %           twom: normalisation constant
            %
            %   Example of usage: [B,twom]=multicat(A,gamma,omega);
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
            %   GENLOUVAIN or ITERATED_GENLOUVAIN. The sparse output matrix B can be used
            %   with other heuristics, provided the same mapping is used to go from the
            %   multilayer tensor to the multilayer flattened matrix. That is, the
            %   node-layer tuple (i,s) is mapped to i + (s-1)*N. [Note that we can define
            %   a mapping between a multilayer partition S_m stored as an N by T matrix
            %   and the corresponding flattened partition S stored as an NT by 1 vector.
            %   In particular S_m = reshape(S,N,T) and S = S_m(:).]       
            
            if nargin<2||isempty(gamma)
                gamma=1;
            end
            
            if nargin<3
                omega=1;
            end
            
            N = g.nodenumber();  % number of nodes in each layer
            N = N(1);  %  same number of nodes in all layers
            L = g.layernumber();  % number of layers
            T = L;
            
            if length(gamma)==1
                gamma=repmat(gamma,T,1);
            end
            
            B = spalloc(N*T, N*T, N*N*T+2*N*T);
            twom = 0;
            for s = 1:T
                kout = sum(A{s},1);
                kin = sum(A{s},2);
                mm = sum(kout);
                twom = twom+mm;
                indx = [1:N]+(s-1)*N;
                B(indx,indx) = (A{s}+A{s}')/2-gamma(s)/2.*((kin*kout+kout'*kin')/mm);
            end
            all2all = N*[(-T+1):-1,1:(T-1)];
            B = B + omega*spdiags(ones(N*T,2*T-2),all2all,N*T,N*T);
            twom = twom + (N*T*(T-1)*omega);
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
%                 'CommunityStructureAlgorithm', BRAPH2.STRING, 'louvain_bct', {'louvain_bct', 'louvain_general'}; ...
                'MultilayerCommunityStructureLBCTGamma', BRAPH2.NUMERIC, 1, {}; ...
                'MultilayerCommunityStructureLBCTM0', BRAPH2.NUMERIC, 0, {}; ...
                'MultilayerCommunityStructureLBCTB', BRAPH2.STRING, 'modularity', {'modularity', 'potts', 'negative_sym', 'negative_asym'}; ...
                'MultilayerCommunityStructureLGLimit', BRAPH2.NUMERIC, 1000, {}; ...
                'MultilayerCommunityStructureLGVerbose', BRAPH2.LOGICAL, 1, {1, 0}; ...
                'MultilayerCommunityStructureLGRandord', BRAPH2.LOGICAL, 1, {1, 0}; ...
                'MultilayerCommunityStructureLGRandmove', BRAPH2.LOGICAL, 1, {1, 0}; ...
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of MultilayerCommunityStructure
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
            % measure scope of multilayer community structure measure (BILAYER).
            %
            % See also getMeasureFormat.
           
            measure_scope = Measure.BILAYER;
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
end