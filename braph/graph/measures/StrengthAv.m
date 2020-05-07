classdef StrengthAv < Strength
    % StrengthAv < Strength: Average strength measure
    % StrengthAv provides the average strength of a graph for weighted
    % undirected (WU) graphs. It is calculated as the average of the sum of
    % the weights of all edges connected to the node.
    % 
    % StrengthAv methods:
    %   StrengthAv                  - constructor with Strength properties.
    %
    % StrengthAv methods (Access=protected):
    %   calculate                   - calculates the average strength of a graph.
    %
    % StrengthAv methods (Static)
    %   getClass                    - returns the average strength class.
    %   getName                     - returns the name of average strength measure.
    %   getDescription              - returns the description of average strength measure.
    %   getAvailableSettings        - returns the settings available to the class.
    %   is_global                   - boolean, checks if average strength measure is global.
    %   is_nodal                    - boolean, checks if average strength measure is nodal.
    %   is_binodal                  - boolean, checks if average strength measure if binodal.
    %   getMeasure                  - returns the average strength class.
    %   getCompatibleGraphList      - returns a list of compatible graphs.
    %   getCompatibleGraphNumber    - returns the number of compatible graphs.
    %
    % See also Strength, Measure, Graph, Degree, Distance, Efficiency.
    
    methods
        function m = StrengthAv(g, varargin)
            % STRENGTHAV(G) creates average strength with default strength properties.
            % G is a graph (e.g, an instance of Graph WU).
            %
            % STRENGTHAV(G, 'VALUE', VALUE) creates average strength, and sets the 
            % value to VALUE. G is a graph (e.g, an instance of Graph WU).
            %
            % See also Strength, Measure, Graph, Degree, Distance, Efficiency.

            m = m@Strength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function strength_av = calculate(m)
            % CALCULATE calculates the average strength of a node
            %
            % STRENGTHAV = CALCULATE(M) returns the value of the average strength 
            % of a node.
            
            g = m.getGraph();
            
            if g.is_measure_calculated('Strength')
                strength = g.getMeasureValue('Strength');
            else
                strength = calculate@Strength(m);
            end
            
            strength_av = mean(strength);
        end
    end
    methods(Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the average 
            % strength measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'StrengthAv';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the average strength measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Average Strength';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the average strength  description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average strength measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The average strength of a graph is ' ...
                'the average of the sum of the weights ' ...
                'of all edges connected to the node. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETDESCRIPTION returns the average strength description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % average strength measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            available_settings = {};
        end
        function bool = is_global()
            % IS_GLOBAL checks if strength average strength is global (true)
            %
            % BOOL = IS_GLOBAL() returns true.
            %
            % See also is_nodal, is_binodal.
                   
            bool = true;
        end
        function bool = is_nodal()
            % IS_NODAL checks if strength average strength is nodal (false)
            %
            % BOOL = IS_NODAL() returns false.
            %
            % See also is_global, is_binodal. 
             
            bool = false;
        end
        function bool = is_binodal()
            % IS_BINODAL checks if strength average strength is binodal (false)
            %
            % BOOL = IS_BINODAL() returns false.
            %
            % See also is_global, is_nodal.
               
            bool = false;
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % to StrengthAv
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to StrengthAv. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphWU', ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs to StrengthAv
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to StrengthAv.
            % 
            % See also getCompatibleGraphList().
                 
            n = Measure.getCompatibleGraphNumber('StrengthAv');
        end
    end
end