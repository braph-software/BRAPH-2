classdef CategoricalPersistence < Measure
    % CategoricalPersistence Categorical Persistence measure
    % CategoricalPersistence provides the categorical persistence of a node for 
    % binary undirected (BU), binary directed (BD), weighted undirected (WU) 
    % and weighted directed (WD) multilayer graphs in a given community. 
    %    
    % The categorical persistence shows the "persistence" of multilayer 
    % partitions for a multilayer network with unordered layers. It is  
    % calculated as the sum over all pairs of layers of the number of nodes 
    % that do not change community assignments.
    % 
    % CategoricalPersistence methods:
    %   CategoricalPersistence      - constructor
    % 
    % CategoricalPersistence descriptive methods (Static)
    %   getClass                    - returns the categorical persistence class
    %   getName                     - returns the name of categorical persistence measure
    %   getDescription              - returns the description of categorical persistence measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the categorical persistence class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % CategoricalPersistence methods 
    %   getCI                       - returns the given community structure
    %
    % See also Measure, MultilayerCommunityStructure, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
  
    properties (GetAccess=protected, SetAccess=protected)
        Ci  % given community structure 
    end
    methods
        function m = CategoricalPersistence(g, varargin)
            % CATEGORICALPERSISTENCE(G) creates categorical persistence with default properties.
            % G is a graph (e.g, an instance of MultiplexGraphBU, 
            % MultiplexGraphBD, MultiplexGraphWU or MultiplexGraphWD). 
            %  
            % See also Measure, MultilayerCommunityStructure, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function categorical_persistence = calculate(m)
            % CALCULATE calculates the categorical persistence value of a graph
            %
            % CATEGORICALPERSISTENCE = CALCULATE(M) returns the value of the 
            % categorical persistence of a multiplex.
            %
            % See also Measure, MultilayerCommunityStructure, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD
            
            g = m.getGraph();  % graph from measure class
            L = g.layernumber();
            N = g.nodenumber();
            N = N(1);
 
            if g.is_measure_calculated('MultilayerCommunityStructure')
                S = g.getMeasureValue('MultilayerCommunityStructure');
            else
                S = MultilayerCommunityStructure(g, g.getSettings()).getValue();
            end
            S = cell2mat(S');
            m.Ci = S;
            
            S = {S};
            all2all = N*[(-L+1):-1,1:(L-1)];
            A = spdiags(ones(N*L, 2*L-2), all2all, N*L, N*L);
            categorical_persistence = cell(1, L-1);
            for i = 1:length(S)
                G = sparse(1:length(S{i}(:)), S{i}(:), 1);
                categorical_persistence_l = trace(G'*A*G)/(N*L*(L-1));
                categorical_persistence(i) = {categorical_persistence_l};
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the categorical persistence measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'CategoricalPersistence';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the categorical persistence measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Categorical Persistence';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the categorical persistence description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % categorical persistence measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The categorical persistence of an unordered multilayer network is the ' ...
                'sum over all pairs of layers of the number of nodes that '...
                'do not change community assignments. It varies between 0 and 1.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to CategoricalPersistence
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to CategoricalPersistence. Empty Array in this case.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of CategoricalPersistence
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of categorical persistence measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of CategoricalPersistence
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of categorical persistence measure (BILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.BILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of CategoricalPersistence
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of categorical persistence measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with CategoricalPersistence 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to categorical persistence. 
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
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with CategoricalPersistence 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to categorical persistence.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('CategoricalPersistence');
        end
    end
    methods
        function ci = getCi(m)
            % GETCI returns the given community structure
            %
            % CI = GETCI() returns the community structure used (Ci).
            
            ci = m.Ci;
        end
    end
end