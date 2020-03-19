classdef BrainRegion < handle & matlab.mixin.Copyable
    % BrainRegion < handle & matlab.mixin.Copyable: A brain region.
    % BrainRegion contains the information of a brain region.
    %
    % BrainRegion properties (GetAccess=protected, SetAccess=protected):
    %   label        - unique identifier for the brain region. 
    %   name         - extended name of the brain region.
    %   x            - x-coordinate of the brain region.
    %   y            - y-coordinate of the brain region.
    %   z            - z-coordinate of the brain region.
    %
    % BrainRegion methods
    %   Graph        - constructor.
    %   copyElement  - deep copy community structure.
    %
    % Graph methods:
    %   BrainRegion  - Constructor.
    %   tostring     - returns a string representing the brain region.
    %   disp         - displays the brain region.
    %   getLabel     - returns the label.
    %   getName      - returns the name.
    %   getX         - returns the x coordinate.
    %   getY         - returns the y coordinate.
    %   getZ         - returns the z coordinate.
    %   getPosition  - retuns an array with the x, y, z coordinates. 
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
            % BrainRegion() creates a brain region with
            % default properties.
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
            
            % initialization of brain region properties.
            br.label = label;  
            br.name = name;
            br.x = x;
            br.y = y;
            br.z = z;
        end
        function str = tostring(br)
            % TOSTRING string with information about the brain region.
            %
            % STR = TOSTRING(BR) returns string with the brain class, label,
            % name and position.
            %
            % See also disp().
            
            str = [class(br) ' '  br.getLabel() ' ' br.getName() ' ' mat2str(br.getPosition())];
        end
        function disp(br)
            % DISP displays information about the brain region.
            %
            % DISP(BR) displays information about the brain region.
            % It provides information about brain region class, label,
            % name, and position.
            %
            % See also tostring().
            
            disp(['<a href="matlab:help ' class(br) '">' class(br) '</a>'])
            disp([' label: ' br.getLabel()])
            disp([' name: ' br.getName()])
            disp([' position: ' mat2str(br.getPosition())])            
        end
        function label = getLabel(br)
            % GETLABEL returns the label of the brain region.
            %
            % LABEL = GETLABEL(BR) returns the label of the brain region.
            %
            % See also getName(), getX(), getY(), getZ(), getPosition().
            
            label = br.label;
        end
        function name = getName(br)
            % GETNAME returns the name of the brain region.
            %
            % STRING = GETNAME(BR) returns the extendend name of the brain
            % region.
            %
            % See also getLabel(), getX(), getY(), getZ(), getPosition().
            
            name = br.name;
        end
        function x = getX(br)
            % GETX returns the x coordinate.
            %
            % DOUBLE = GETX(BR) returns the x coordinate of the brain
            % region.
            %
            % See also getLabel(), getY(), getZ(), getPosition().
            
            x = br.x;
        end
        function y = getY(br)
            % GETY returns the y coordinate.
            %
            % DOUBLE = GETY(BR) returns the y coordinate of the brain
            % region.
            %
            % See also getLabel(), getX(), getZ(), getPosition().
            
            y = br.y;
        end
        function z = getZ(br)
            % GETZ returns the z coordinate.
            %
            % DOUBLE = GETZ(BR) returns the z coordinate of the brain
            % region.
            %
            % See also getLabel(), getX(), getY(), getPosition().
            
            z = br.z;
        end
        function r = getPosition(br)
            % GETPOSITION returns the x,y,z coordinates.
            %
            % ARRAY = GETZ(BR) returns the x, y, z coordinates of the brain
            % region in an array.
            %
            % See also getLabel(), getX(), getY(), getZ().
            r = [br.getX() br.getY() br.getZ()];
        end
    end
end