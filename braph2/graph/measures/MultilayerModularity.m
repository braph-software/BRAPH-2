classdef MultilayerModularity < MultilayerCommunityStructure
    % MultilayerModularity Multilayer modularity measure
    % MultilayerModularity provides the multilayer modularity for binary
    % undirected (BU), binary directed (BD), weighted undirected (WU), 
    % and weighted directed (WD) multiplex and multilayer graphs. 
    % 
    % MultilayerModularity methods:
    %   MultilayerModularity        - constructor
    %
    % MultilayerModularity methods (Static)
    %   getClass                    - returns the multilayer modularity class
    %   getName                     - returns the name of multilayer modularity measure
    %   getDescription              - returns the description of multilayer modularity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure
    %   getMeasure                  - returns the multilayer modularity class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, MultilayerCommunityStructure, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
    
    methods
        function m  = MultilayerModularity(g, varargin)
            % MULTILAYERCOMMUNITYSTRUCTURE(G) creates multilayer modularity with default measure properties.
            % G is a multilayer (i.e., an instance of MultiplexGraphBD,
            % MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU). 
            %
            % See also Measure, MultilayerCommunityStructure, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
            
            m = m@MultilayerCommunityStructure(g,  varargin{:});
        end
    end
    methods (Access=protected)
        function multilayer_community_structure = calculate(m)
            % CALCULATE calculates the  Louvain-like multilayer community structure value of a multiplex
            %
            % MULTILAYERCOMMUNITYSTRUCTURE = CALCULATE(M) returns the value of the 
            %  Louvain-like multilayer community structure of a multilayer graph.
            %
            % See also Measure, MultilayerCommunityStructure, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
    
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % 2D-cell array 
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
            
          
            multilayer_community_structure = {S};  % assign partition to the result
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the multilayer modularity measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'MultilayerModularity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the multilayer modularity measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Multilayer Modularity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the multilayer modularity description
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % multilayer modularity measure.
            %
            % See also getClass, getName.
        
            description = [ ...
                'The multilayer modularity of a multilayer graph is ' ...
                'the quality of the resulting partition of the multilayer network. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to MultilayerModularity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to MultilayerModularity. Empty Array in this case.
            
            available_settings = getAvailableSettings@MultilayerCommunityStructure();
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of MultilayerModularity
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of multilayer modularity measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of MultilayerModularity
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of multilayer modularity measure (SUPERGLOBAL). 
            %
            % See also getMeasureFormat.
           
            measure_scope = Measure.SUPERGLOBAL;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of MultilayerModularity
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the parametricity
            % of multilayer modularity measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with MultilayerModularity
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to multilayer modularity. 
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
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with MultilayerModularity
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to multilayer modularity.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('MultilayerModularity');
        end
    end
end