classdef Measure < handle & matlab.mixin.Copyable
    properties (GetAccess=public, SetAccess=protected)
        g  % graph
        settings  % structure with the constructor varagin
        value  % graph measure value
               % scalar for global measures
               % column vector for nodal measures
    end
    methods (Access=protected)
        function m = Measure(g, varargin)
            
            if ~Measure.is_compatible_with_graph(m, g)
                error([class(g) ' is not compatible with ' class(m)])
            end
                        
            % 'Value' (input from varargin)
            value = [];
            for n = 1:1:length(varargin)-1
                if strcmpi(varargin{n}, 'Value')
                    value = varargin{n+1};
                end
            end
            
            % 'Settings' (input from varargin)
            settings = varargin;
            for n = 1:1:length(varargin)-1
                if strcmpi(varargin{n}, 'Value')
                    settings = varargin{n+1};
                end
            end

            m.g = g;
            m.value = value;
            m.settings = settings;
        end
        function setValue(m, value)
            m.value = value;
        end
    end
    methods
        function measure_code = getMeasureCode(m)
            % measure code (same as the measure object name)
            
            measure_code = class(m);
        end
        function g = getGraph(m)
            g = m.g;
        end
        function settings = getSettings(m)
            settings = m.settings;
        end
        function bool = is_value_calculated(m)
            bool = ~isempty(m.value);
        end
        function value = getValue(m)
            
            if ~is_value_calculated(m)
                m.calculate();
            end
            
            value = m.value;
        end
    end
    methods (Abstract, Access=protected)
        calculate(m)  % calculates the value of the measure
    end
    methods (Static)
        function measure_list = getMeasureList()
            measure_list = subclasses( ...
                'Measure', ...
                [fileparts(which('Measure')) filesep 'measures'] ...
                );
        end
        function m = getMeasure(measure_code, g, varargin) %#ok<INUSD>
            m = eval([measure_code '(g, varargin{:})']);
        end
        function bool = is_compatible_with_graph(m, g)
            bool = Graph.is_compatible_with_measure(g, m);
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