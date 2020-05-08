classdef OutLocalEfficiency < Measure
    % OutLocalEfficiency < Measure: Out-Local Efficiency measure
    % OutLocalEfficiency provides the out-local efficiency of a node for binary directed   
    % (BD) and weighted directed (WD) graphs. It is calculated as average 
    % inverse shortest path length with local nodes. 
    % 
    % OutLocalEfficiency methods:
    %   OutLocalEfficiency          - constructor with Measure properties.
    %
    % OutLocalEfficiency methods (Access=protected):
    %   calculate                   - calculates the out-local efficiency of a node.
    % 
    % OutLocalEfficiency methods (Static)
    %   getClass                    - returns the out-local efficiency class.
    %   getName                     - returns the name of out-local efficiency measure.
    %   getDescription              - returns the description of out-local efficiency measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if out-local efficiency measure is global.
    %   is_nodal                    - boolean, checks if out-local efficiency measure is nodal.
    %   is_binodal                  - boolean, checks if out-local efficiency measure if binodal.
    %   getMeasure                  - returns the out-local efficiency class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Measure, Graph, PathLength, InLocalEfficiency, LocalEfficiency, GlobalEfficiency.
    
    methods
        function m = OutLocalEfficiency(g, varargin)
            % OUTLOCALEFFICIENCY(G) creates out-local efficiency with default measure properties.
            % G is a graph (e.g, an instance of GraphBU, Graph WU). 
            %
            % OUTLOCALEFFICIENCY(G, 'VALUE', VALUE) creates out-local efficiency, and sets the value
            % to VALUE. G is a graph (e.g, an instance of  GraphBU, Graph WU).
            %   
            % See also Measure, Graph, PathLength, InLocalEfficiency, LocalEfficiency, GlobalEfficiency.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access = protected)
        function out_local_efficiency = calculate(m)
            % CALCULATE calculates the out-local efficiency value of a node
            %
            % OUTLOCALEFFICIENCY = CALCULATE(M) returns the value of the out-local efficiency of a
            % node.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix of the graph
            n = g.nodenumber();
            
            out_local_efficiency = zeros(n,1);
            for i = 1:1:n
                nodes = find(A(i, :)  | A(:, i).');  % neighbours of u
                if numel(nodes) > 1
                    sub_graph = g.subgraph(nodes);
                    out_local_efficiency(i) = mean(OutGlobalEfficiency(sub_graph, g.getSettings()).getValue());
                end
            end
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the out-local efficiency measure.
            %
            % See also getName(), getDescription().
            
            measure_class = 'OutLocalEfficiency';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the out-local efficiency measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Out-Local-Efficiency';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the out-local efficiency description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % out-local efficiency measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The out local efficiency is the average inverse ' ...
                'shortest out path length with local nodes.' ...
                ];
        end
        function available_settings = getAvailableSettings()   
            % GETAVAILABLESETTINGS returns the setting available to OutLocalEfficiency.
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to OutLocalEfficiency. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
       function bool = is_global()
            % IS_GLOBAL checks if out-local efficiency measure is global (false)
            %
            % BOOL = IS_GLOBAL() returns false.
            %
            % See also is_nodal, is_binodal.
            
            bool = false;
        end
        function bool = is_nodal()
            % IS_NODAL checks if out-local efficiency measure is nodal (true)
            %
            % BOOL = IS_NODAL() returns true.
            %
            % See also is_global, is_binodal. 
            
            bool = true;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if out-local efficiency measure is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
            
            bool = false;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to OutLocalEfficiency
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to OutLocalEfficiency. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...               
                'GraphBD', ...           
                'GraphWD' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to OutLocalEfficiency
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to OutLocalEfficiency.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('OutLocalEfficiency');
        end
    end
end