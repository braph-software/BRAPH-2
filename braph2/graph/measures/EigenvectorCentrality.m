classdef EigenvectorCentrality < Measure
    % EigenvectorCentrality Eigenvector centrality measure
    % EigenvectorCentrality provides the eigenvector centrality of a node for 
    % binary undirected (BU) and weighted undirected (WU) graphs. 
    %
    % It is calculated as the ith element in the eigenvector corresponding
    % to the largest eigenvalue of the largest eigenvalue of the graph's
    % adjacency matrix.
    % 
    % EigenvectorCentrality methods:
    %   EigenvectorCentrality       - constructor 
    % 
    % EigenvectorCentrality descriptive methods (Static)
    %   getClass                    - returns the eigenvector centrality class
    %   getName                     - returns the name of eigenvector centrality measure
    %   getDescription              - returns the description of eigenvector centrality measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the eigenvector centrality class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
    
    methods
        function m = EigenvectorCentrality(g, varargin)
            % EIGENVECTORCENTRALITY(G) creates eigenvector centrality with default properties.
            % G is a graph (e.g, an instance of GraphBU, GraphWU,
            % MultiplexGraphBU or MultiplexGraphBU). 
            %
            % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function eigenvector_centrality = calculate(m)
            % CALCULATE calculates the eigenvector centrality value of a
            % node.
            %
            % EIGENVECTORCENTRALITY = CALCULATE(M) returns the value of the eigenvector centrality 
            % of a node.
            %
            % See also Measure, GraphBU, GraphWU, MultiplexGraphBU, MultiplexGraphWU.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjacency matrix of the graph
            N = g.nodenumber(); 
            
            eigenvector_centrality = cell(g.layernumber(), 1);
            for li = 1:1:g.layernumber()
                
                if g.is_graph(g)
                    Aii = A;
                else
                    Aii = A{li, li};
                end
                
                if N(li) < 1000
                    [V, D] = eig(Aii);
                else
                    [V, D] = eigs(sparse(Aii));
                end
                
                [~, idx] = max(diag(D));
                ec = abs(V(:, idx));
                eigenvector_centrality(li) = {reshape(ec, length(ec), 1)};
            end               
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the eigenvector centrality measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'EigenvectorCentrality';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the eigenvector centrality measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Eigenvector centrality';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the eigenvector centrality description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % eigenvector centrality measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The eigenvector centrality of a node is ' ...
                'the ith element in the eigenvector corresponding ' ...
                'to the largest eigenvalue of the largest eigenvalue ' ...
                'of the graphs adjacency matrix ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to EigenvectorCentrality
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to EigenvectorCentrality. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of EigenvectorCentrality
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of eigenvector centrality measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of EigenvectorCentrality
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of eigenvector centrality measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of EigenvectorCentrality
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of eigenvector centrality measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with EigenvectorCentrality 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to eigenvector centrality. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBU', ...
                'GraphWU', .....
                'MultiplexGraphBU', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with EigenvectorCentrality 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to eigenvector centrality.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('EigenvectorCentrality');
        end
    end
end