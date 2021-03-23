classdef Participation < Measure
    % Participation Participation measure
    % Participation provides the participation coefficient of a node for 
    % binary undirected (BU), binary directed (BD), weighted undirected (WU) 
    % and weighted directed (WD) graphs in a given community. 
    %    
    % The participation coefficient shows the node connectivity through the
    % availible communities. It is calculated as the ratio of the edges that
    % a node forms within a single layer community to the total number of edges the node
    % forms whithin the whole graph within a single layer.
    % 
    % Participation methods:
    %   Participation               - constructor
    % 
    % Participation descriptive methods (Static)
    %   getClass                    - returns the participation class
    %   getName                     - returns the name of participation measure
    %   getDescription              - returns the description of participation measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure  
    %   getMeasure                  - returns the participation class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % Participation methods 
    %   getCI                       - returns the given community structure
    %
    % See also Measure, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
  
    properties (GetAccess=protected, SetAccess=protected)
        Ci  % given community structure 
    end
    methods
        function m = Participation(g, varargin)
            % PARTICIPATION(G) creates participation with default properties.
            % G is a graph (e.g, an instance of GraphBU, GraphBD, GraphWU,
            % GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU
            % or MultiplexGraphWD). 
            %  
            % See also Measure, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function participation = calculate(m)
            % CALCULATE calculates the participation value of a graph
            %
            % PARTICIPATION = CALCULATE(M) returns the value of the participation of a
            % binary undirected (BU) or weighted undirected (WU) graph or multiplex.
            %
            % See also Measure, GraphBU, GraphBD, GraphWU, GraphWD, MultiplexGraphBU, MultiplexGraphBD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjacency matrix (for graph) or 2D-cell array (for multiplex)
            L = g.layernumber();
            N = g.nodenumber();
            
            participation = cell(L, 1);        
            directionality_type =  g.getDirectionalityType(L);
            connectivity_type =  g.getConnectivityType(L);
            for li = 1:1:L
                
                if g.is_graph(g)
                    Aii = A;
                    directionality_layer = directionality_type;
                    connectivity_layer = connectivity_type;
                    
                    if g.is_measure_calculated('CommunityStructure')
                        S = g.getMeasureValue('CommunityStructure');
                    else
                        S = CommunityStructure(g, g.getSettings()).getValue();
                    end
                    m.Ci = S;
                
                else
                    Aii = A{li, li};
                    directionality_layer = directionality_type(li, li);
                    connectivity_layer = connectivity_type(li, li);
                    
                    if g.is_measure_calculated('MultilayerCommunityStructure')
                        S = g.getMeasureValue('MultilayerCommunityStructure');
                    else
                        S = MultilayerCommunityStructure(g, g.getSettings()).getValue();
                    end
                    m.Ci = S;
                end
                if connectivity_layer == Graph.WEIGHTED  % weighted graphs
                    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                        
                        if g.is_measure_calculated('Strength')
                            ko = g.getMeasureValue('Strength');
                        else
                            ko = Strength(g, g.getSettings()).getValue();
                        end
                        
                    else  % directed graphs
                        
                        directed_participation_rule = get_from_varargin('out', 'DirectedParticipationRule', m.getSettings());
                        switch lower(directed_participation_rule)
                            case {'in'}  % in-degree rule
                                
                                if g.is_measure_calculated('InStrength')
                                    ko = g.getMeasureValue('InStrength');
                                else
                                    ko = InStrength(g, g.getSettings()).getValue();
                                end
                                
                            otherwise  % {'out'}  % out-degree rule
                                
                                if g.is_measure_calculated('OutStrength')
                                    ko = g.getMeasureValue('OutStrength');
                                else
                                    ko = OutStrength(g, g.getSettings()).getValue();
                                end
                        end
                        
                    end
                else  % binary graphs
                    if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                        
                        if g.is_measure_calculated('Degree')
                            ko = g.getMeasureValue('Degree');
                        else
                            ko = Degree(g, g.getSettings()).getValue();
                        end
                        
                    else  % directed graphs
                        
                        directed_participation_rule = get_from_varargin('out', 'DirectedParticipationRule', m.getSettings());
                        switch lower(directed_participation_rule)
                            case {'in'}  % in-degree rule
                                
                                if g.is_measure_calculated('InDegree')
                                    ko = g.getMeasureValue('InDegree');
                                else
                                    ko = InDegree(g, g.getSettings()).getValue();
                                end
                                
                            otherwise  % {'out'}  % out-degree rule
                                
                                if g.is_measure_calculated('OutDegree')
                                    ko = g.getMeasureValue('OutDegree');
                                else
                                    ko = OutDegree(g, g.getSettings()).getValue();
                                end
                        end
                        
                    end
                end
                
                Gc = (Aii~=0)*diag(S{li});  % neighbor community affiliation
                Kc2 = zeros(N(1), 1);  % community-specific neighbors
                
                for i=1:max(S{li})
                    Kc2 = Kc2 + (sum(Aii.*(Gc==i), 2).^2);
                end
                
                participation_layer = ones(N(1), 1) - Kc2./(ko{li}.^2);
                participation_layer(~ko{li}) = 0;  % participation = 0 if for nodes with no (out)neighbors
                participation(li) = {participation_layer};
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the participation measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'Participation';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the participation measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Participation';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the participation description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % participation measure.
            %
            % See also getList, getCompatibleGraphList.
            
            description = [ ...
                'The participation of a node is the ratio of ' ...
                'edges that a node forms within a single layer community to the total '...
                'number of edges that forms within the whole single layer graph.' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to Participation
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to Participation.
            % DIRECTEDPARTICIPATIONRULE = 'out' (default) - calculates PARTICIPATION 
            %                    of a node using the out-degree for directed graphs.
            %                    'in' - calculates PARTICIPATION of a node
            %                    using the in-degree for  directed graphs.
            % 
            % See also getCompatibleGraphList.
            
            available_settings = {
                'DirectedParticipationRule', BRAPH2.STRING, 'out', {'out', 'in'};
                };
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of Participation
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of participation measure (NODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.NODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of Participation
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of participation measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of Participation
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of participation measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with Participation 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to participation. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
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
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with Participation 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to participation.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('Participation');
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