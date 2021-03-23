classdef Modularity < CommunityStructure
    % Modularity modularity measure
    % Modularity provides the modularity for binary undirected (BU), binary
    % directed (BD), weighted undirected (WU), and weighted directed (WD) graphs. 
    % 
    % Modularity methods:
    %   Modularity                  - constructor
    %
    % Modularity descriptive methods (Static)
    %   getClass                    - returns the modularity class
    %   getName                     - returns the name of modularity measure
    %   getDescription              - returns the description of modularity measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure
    %   getMeasure                  - returns the modularity class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, CommunityStructure, GraphBD, GraphBU, GraphWD, GraphWU.
    
    methods
        function m  = Modularity(g, varargin)
            % MODULARITY(G) creates modularity with default measure properties.
            % G is a graph (i.e., an instance of GraphBD,
            % GraphBU, GraphWD, GraphWU). 
            %
            % See also Measure, CommunityStructure, GraphBD, GraphBU, GraphWD, GraphWU.
            
            m = m@CommunityStructure(g,  varargin{:});
        end
    end
    methods (Access=protected)
        function modularity = calculate(m)
            % CALCULATE calculates the modularity value of a graph
            %
            % MODULARITY = CALCULATE(M) returns the value of the 
            % modularity of a graph.
            %
            % See also Measure, CommunityStructure, GraphBD, GraphBU, GraphWD, GraphWU.
    
            g = m.getGraph();  % graph from measure class
                       
            community_structure = g.getMeasure('CommunityStructure');
            community_structure.getValue();
            Q = community_structure.getQualityFunction(); 
            modularity = {Q};  % assign normalized quality function
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the modularity measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'Modularity';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the modularity measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Modularity';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the modularity description
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % modularity measure.
            %
            % See also getClass, getName.
        
            description = [ ...
                'The modularity of a graph is the quality' ...
                'of the resulting partition of the network. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Modularity
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Modularity. Empty Array in this case.
            
            available_settings = getAvailableSettings@CommunityStructure();
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of Modularity
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of modularity measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Modularity
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of modularity measure (UNILAYER). 
            %
            % See also getMeasureFormat.
           
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of Modularity
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the parametricity
            % of modularity measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with Modularity
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to modularity. 
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
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with Modularity
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to modularity.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('Modularity');
        end
    end
end