classdef Measure < handle & matlab.mixin.Copyable
    properties (GetAccess=public, SetAccess=protected)
        g  % graph
        value  % graph measure value
               % scalar for global measures
               % column vector for nodal measures
    end
    methods (Access=protected)
        function m = Measure(g, varargin)
            
            if ~are_compatible(m, g)
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
        function measure_code = getMeasureCode(m)
            % measure code (same as the measure object name)
            
            measure_code = class(m);
        end
    end
    methods (Abstract, Access=protected)
        calculate(m)  % calculates the value of the measure
    end
    methods (Static)
        function m = getMeasure(measure_code, g, varargin)
            eval(['m = ' measure_code '(g, varargin{:});'])
        end
    end
    methods (Static, Abstract)
        getName()  % measure name
        getDescription()  % measure description
        is_global()  % whether is global measure
        is_nodal()  % whether is global measure
        compatible_graph_list()  % list of graphs with which measure works
    end
end