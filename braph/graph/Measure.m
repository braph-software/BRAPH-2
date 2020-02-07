classdef Measure < handle & matlab.mixin.Copyable
    properties (GetAccess=public, SetAccess=protected)
        g  % graph
        value  % graph measure value
               % scalar for global measures
               % column vector for nodal measures
    end
    methods (Access=protected)
        function m = Measure(g, varargin)
            
            if ~m.is_compatible_graph(g)
                error([class(g) ' is not compatible with ' class(m)])
            end
            
            m.g = g;
        end
        function setValue(m, value)
            m.value = value;
        end
    end
    methods
        function g = getGraph(m)
            g = m.g;
        end
        function value = getValue(m)
            
            if isempty(m.value)
                m.calculate();
            end
            
            value = m.value;
        end
    end
    methods (Abstract, Access=protected)
        calculate(m)  % calculates the value of the measure
    end
    methods (Static)
        function bool = is_nodal()
            bool = ~Measure.is_global();
        end
    end
    methods (Static, Abstract)
        is_global()  % whether is global measure
        is_nodal()  % whether is nodal measure
        is_compatible_graph(g)  % whether measure works for a graph
        compatible_graph_list()  % list of graphs with which measure works
    end
end