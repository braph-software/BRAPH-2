classdef Measure < handle
    % Measure < handle (Abstract) : Creates and implements measure
    %   Measure provides the methods necessary for all measures of a graph. 
    %   Instances of this class cannot be created. Use one of the
    %   subclasses (e.g., Degree, Strength, Distance, Efficency).
    % 
    % Measure properties (GetAccess=protected, SetAccess=protected):
    %   g        -   graph.
    %   settings -   structure with the constructor settings.
    %   value    -   graph measure value, the value is:
    %                   scalar for global measures.
    %                   column vector for nodal measures.
    %                   square matrix for binodal measures.
    % 
    % Measure methods (Access=protected):
    %   Measure  -   constructor.
    %
    % Measure methods:
    %   tostring    -   returns a string representing the measure.
    %   disp        -   displays the measure.
    %   getGraph    -   returns the graph associated with the measure.
    %   getSettings -   returns the settings of the measure.
    %   is_value_calculated  -   boolean, checks if the measure has been
    %                            calculated.
    %   getValue    -   returns the value of the measure.
    %   
    % Measure methods (Abstract, Access=protected):
    %   calculate   -   abstract function, inheriting classes must
    %                   implement this function.
    %
    % Measure methods (Static)
    %   getList     -   return a list with subclasses of measure.
    %   getClass    -   return the class type of the measure.
    %   getName     -   return the name of the measure.
    %   getDescription   -   return the description of the measure.
    %   is_global   -   boolean, checks if the measure is global.
    %   is_nodal    -   boolean, checks if the measure is nodal.
    %   is_binodal  -   boolean, checks if the measure if binodal.
    %   getMeasure  -   returns the measure class.
    %   getCompatibleGraphList  -  returns a list of compatible measures.
    %   getCompatibleGraphNumber  -  returns the number of compatible
    %                                measures.
    %
    % See also Graph, handle, Degree, Strength, Distance, Efficency.
    
    % Author: Emiliano Gomez & Giovanni Volpe
    % Date: 2020/02/03
    
    
    properties (GetAccess=protected, SetAccess=protected)
        g  % graph
        settings  % structure with the constructor settings
        value  % graph measure value
               % scalar for global measures
               % column vector for nodal measures
               % square matrix for binodal measures
    end
    methods (Access=protected)
        function m = Measure(g, varargin)
            % MEASURE(G) creates a measure with default properties.
            %   G is a generic graph (e.g, an instance of GraphBD, GraphBU,
            %   GraphWD, Graph WU). This method is only accessible by the
            %   subclasses of Measure.
            %
            % MEASURE(G, PROPERTY1, VALUE1, PROPERTY2, VALUE2, ... )
            %   ceates a measure with properties and values.  It initializes
            %   the property settings with the properties and values.
            %   
            % See also Graph, Degree, Strength, Distance, Efficency. 

            if ~are_compatible(g, m)  % checks wheter the graph and the measure are compatible.
                error( ...
                    'BRAPH:Measure:IncompatibleGM', ...
                    [class(g) ' is not compatible with ' class(m)] ...
                    )
            end
            
            if length(varargin) == 1
                varargin = varargin{:};
            end
            
            settings = get_from_varargin(varargin, 'Settings', varargin{:});  % returns varargin if no key 'Settings'
            value = get_from_varargin([], 'Value', varargin{:});
            
            m.g = g;  % initialize the property g
            m.settings = settings;  % initialize the property settings
            m.value = value;  % initialize the property value
        end
    end
    methods
        function str = tostring(m)
            % TOSTRING displays information about the measure
            %
            % STR = TOSTRING(M) returns string with the measure class and size.
            %
            % See also disp(). 
            
            str = [Measure.getClass(m) ' size:'  int2str(size(m.getValue(), 1)) ' x '  int2str(size(m.getValue(), 2))];
        end
        function disp(m)
            % DISP displays information about the measure
            %
            % DISP(M) displays the information about the measure. 
            %   It provides information about measure class, measure size,
            %   value, associated graph, measure settings.
            %
            % See also tostring().  
            
            disp(['<a href="matlab:help ' Measure.getClass(m) '">' Measure.getClass(m) '</a>'])
            if m.is_value_calculated()
                disp([' value: ' int2str(size(m.getValue(), 1))  ' x ' int2str(size(m.getValue(), 2))])
            else
                disp(' value: not calculated yet')
            end
            disp(['graph: ' m.getGraph().tostring()]);
            disp([' settings']); %#ok<NBRAK>
            settings = m.getSettings(); %#ok<PROP>
            for i = 1:2:length(settings) %#ok<PROP>
                disp(['  ' settings{i} ' = ' tostring(settings{i+1})]); %#ok<PROP>
            end
        end
        function g = getGraph(m)
            % GETGRAPH returns the property graph associated to the measure
            %
            % G = GETGRAPH(M) returns the graph associated to the measure M.
            %
            % See also getSettings().  
            
            g = m.g;
        end
        function res = getSettings(m, setting_code)
            % GETSETTINGS returns the settings
            %
            % SETTINGS = GETSETTINGS(M) returns the settings of the measure
            %
            % SETTING = GETSETTINGS(M, SETTING_CODE) returns the settings of the 
            %	measure SETING_CODE.
            %
            % See also getGraph().
            
            if nargin<2
                res = m.settings;
            else
                res = get_from_varargin([], setting_code, m.settings{:});
            end
        end
        function bool = is_value_calculated(m)
            % IS_VALUE_CALCULATED checks if values is calculated
            %
            % BOOL = IS_VALUE_CALCULATED(M) returns true  if value has been
            %   already calculated.
            %
            % See also getValue().
            
            bool = ~isempty(m.value);
        end
        function value = getValue(m)
            % GETVALUE returns the value
            %
            % VALUE = GETVALUE(M) returns the value if already calculated,
            %   otherwise it will call calculate function.
            %
            % See also is_value_calculated().
            
            if ~m.is_value_calculated()
                m.value = m.calculate();
            end
            
            value = m.value;
        end
    end
    methods (Abstract, Access=protected)
        calculate(m)  % calculates the value of the measure
    end
    methods (Static)
        function measure_list = getList()
            % GETLIST returns the list of measures
            %
            % MEASURE_LIST = GETLIST() returns the list of measures (cell array)
            %   that are subclasses of Measure.
            %
            % See also getClass(), getCompatibleGraphList().
            
            measure_list = subclasses( ...
                'Measure', ...
                [fileparts(which('Measure')) filesep 'measures'] ...
                );
        end
        function measure_class = getClass(m)
            % GETCLASS returns the list of measures
            %
            % CLASS = GETCLASS() returns the class of the measure M.
            %
            % See also getList(), getCompatibleGraphList().
            
            if isa(m, 'Measure')
                measure_class = class(m);
            else % g should be a string with the measure class
                measure_class = m;
            end
        end
        function name = getName(m)
            % GETNAME returns the name of the measure
            %
            % STRING = GETNAME() returns the name of the measure M.
            %
            % See also getList(), getCompatibleGraphList().
            
            name = eval([Measure.getClass(m) '.getName()']);
        end
        function description = getDescription(m)
            % GETDESCRIPTION returns the description of the measure
            %
            % STRINGS = GETDESCRIPTION() returns the description of the measure M.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = eval([Measure.getClass(m) '.getDescription()']);
        end
        function bool = is_global(m)
            % IS_GLOBAL checks if measure is global
            %
            % BOOL = IS_GLOBAL(M) returns true if measure M is global
            %   and false otherwise.
            %
            % See also is_nodal, is_binodal.
            
            bool = eval([Measure.getClass(m) '.is_global()']);
        end        
        function bool = is_nodal(m)
            % IS_NODAL checks if measure is nodal
            %
            % BOOL = IS_NODAL(M) returns true if measure M is nodal
            %   and false otherwise.
            %
            % See also is_global, is_binodal.
            
            bool = eval([Measure.getClass(m) '.is_nodal()']);
        end
        function bool = is_binodal(m)
            % IS_BINODAL checks if measure is bi-nodal
            %
            % BOOL = IS_BINODAL(M) returns true if measure M is binodal
            %   and false otherwise.
            %
            % See also is_global, is_nodal.
            
            bool = eval([Measure.getClass(m) '.is_binodal()']);
        end
        function m = getMeasure(measure_code, g, varargin) %#ok<INUSD>
            % GETMEASURE returns a measure
            %
            % M = GETMEASURE(MEASURE_CODE, G, VARARGIN{:}) returns a instance
            %   of the class MEASURE_CODE.
            %
            % See also getList(), getCompatibleGraphList().
            
            m = eval([measure_code '(g, varargin{:})']);
        end
        function list = getCompatibleGraphList(m)
            % GETCOMPATIBLEGRAPHLIST returns the list of graphs
            %
            % CELL ARRAY = GETCOMPATIBLEGRAPHLIST(M) returns a cell array of
            %   compatible graphs to the measure M. Measure will not work if
            %   the graph is not compatible.
            %
            % See also getList(), getCompatibleGraphNumber().
            
            list = eval([Measure.getClass(m) '.getCompatibleGraphList()']);
        end
        function n = getCompatibleGraphNumber(m)
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs
            %
            % N = GETCOMPATIBLEGRAPHNUMBER(M) returns the number of
            %   compatible graphs to the measure M.
            %
            % See also getList(), getCompatibleGraphList().
            
            list = Measure.getCompatibleGraphList(m);
            n = numel(list);
        end
    end
end
