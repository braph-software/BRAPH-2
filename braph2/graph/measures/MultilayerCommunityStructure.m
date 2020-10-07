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
            L = g.layernumber();  % number of layers
           
                
            multilayer_community_structure = 0;
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
                'CommunityStructureLBCTGamma', BRAPH2.NUMERIC, 1, {}; ...
                'CommunityStructureLBCTM0', BRAPH2.NUMERIC, 0, {}; ...
                'CommunityStructureLBCTB', BRAPH2.STRING, 'modularity', {'modularity', 'potts', 'negative_sym', 'negative_asym'}; ...
                'CommunityStructureLGLimit', BRAPH2.NUMERIC, 1000, {}; ...
                'CommunityStructureLGVerbose', BRAPH2.LOGICAL, 1, {1, 0}; ...
                'CommunityStructureLGRandord', BRAPH2.LOGICAL, 1, {1, 0}; ...
                'CommunityStructureLGRandmove', BRAPH2.LOGICAL, 1, {1, 0}; ...
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