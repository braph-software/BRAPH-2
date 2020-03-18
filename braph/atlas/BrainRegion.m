classdef BrainRegion < handle & matlab.mixin.Copyable
    % BrainRegion < handle & matlab.mixin.Copyable: A brain region.
    % BrainRegion contains the information of a brain region.
    %
    % BrainRegion properties (GetAccess=protected, SetAccess=protected):
    %   label       -    unique identifier for the brain region. 
    %   name        -    extended name of the brain region.
    %   x           -    x-coordinate of the brain region.
    %   y           -    y-coordinate of the brain region.
    %   z           -    z-coordinate of the brain region.
    %
    % BrainRegion methods
    %   Graph       - constructor.
    %   copyElement - deep copy community structure.
    %
    % Graph methods:
    %   BrainRegion    -    Constructor.
    %   tostring       -    returns a string representing the brain region.
    %   disp           -    displays the brain region.
    %   getLabel       -    returns the label.
    %   getName        -    returns the name.
    %   getX           -    returns the x coordinate.
    %   getY           -    returns the y coordinate.
    %   getZ           -    returns the z coordinate.
    %   getPosition    -    retuns an array with the x, y, z coordinates. 
    %
    % See also BrainAtlas.
    
    properties (GetAccess=protected, SetAccess=protected)
        label  % few-letter code (unique for each brain region)
        name  % extended name
        x  % x-coordinate
        y  % y-coordinate
        z  % z-coordinate
    end
    methods
        function br = BrainRegion(label, name, x, y, z)
            % BrainRegion(varargin) creates a barin region with
            % default properties for each missing argument.
            %
            % BrainRegion(label, name, x, y, z) creates a brain region with
            % the corresponding arguments: label, name, x, y, z. 
            %
            % See also BrainAtlas.
            
            % default arguments check
            if nargin < 5
                z = 0;
            end
            
            if nargin < 4
                y = 0;
            end
                
            if nargin < 3
                x = 0;
            end
            
            if nargin < 2
                name = 'br name';
            end
            
            if nargin < 1
                label = 'BR';
            end
            
            % initialization of brain region propeties.
            br.label = label;  
            br.name = name;
            br.x = x;
            br.y = y;
            br.z = z;
        end
        function str = tostring(br)
            str = [class(br) ' '  br.getLabel() ' ' br.getName() ' ' mat2str(br.getPosition())];
        end
        function disp(br)
            disp(['<a href="matlab:help ' class(br) '">' class(br) '</a>'])
            disp([' label: ' br.getLabel()])
            disp([' name: ' br.getName()])
            disp([' position: ' mat2str(br.getPosition())])            
        end
        function label = getLabel(br)
            label = br.label;
        end
        function name = getName(br)
            name = br.name;
        end
        function x = getX(br)
            x = br.x;
        end
        function y = getY(br)
            y = br.y;
        end
        function z = getZ(br)
            z = br.z;
        end
        function r = getPosition(br)
            r = [br.getX() br.getY() br.getZ()];
        end
    end
end