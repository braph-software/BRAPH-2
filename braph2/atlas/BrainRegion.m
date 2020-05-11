classdef BrainRegion < handle & matlab.mixin.Copyable
    % BrainRegion < handle & matlab.mixin.Copyable: A brain region.
    % BrainRegion contains the information of a brain region.
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
    %   getPosition  - returns an array with the x, y, z coordinates. 
    %
    % See also BrainAtlas.
    
    properties (GetAccess=protected, SetAccess=protected)
        id  % few-letter code (unique for each brain region)
        label  % extended name of the brain region
        notes  % notes about the brain region
        x  % x-coordinate of the brain region
        y  % y-coordinate of the brain region
        z  % z-coordinate of the brain region
    end
    methods  % Basic functions
        function br = BrainRegion(id, label, notes, x, y, z)
            % BrainRegion() creates a brain region with
            % default properties.
            %
            % BrainRegion(label, name, x, y, z) creates a brain region with
            % the corresponding arguments: label, name, x, y, z. 
            %
            % See also BrainAtlas.

            br.setID(id)
            br.setLabel(label)
            br.setNotes(notes)
            br.setX(x)
            br.setY(y)
            br.setZ(z)
        end
        function str = tostring(br)
            % TOSTRING string with information about the brain region.
            %
            % STR = TOSTRING(BR) returns string with the brain class, label,
            % name and position.
            %
            % See also disp().
            
            str = [class(br) ' '  br.getID() ' ' br.getLabel() ' ' tostring(br.getPosition()) ' ' br.getNotes()];
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
            disp([' id: ' br.getID()])
            disp([' name: ' br.getLabel()])
            disp([' notes: ' br.getNotes()])
            disp([' position: ' mat2str(br.getPosition())])            
        end
    end
    methods  % Set functions
        function setID(br, id)
            
            assert(ischar(id), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')
            
            br.id = id;
        end        
        function setLabel(br, label)

            assert(ischar(label), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')
            
            br.label = label;
        end        
        function setNotes(br, notes)

            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')
            
            br.notes = notes;
        end        
        function setX(br, x)
            
            assert(isnumeric(x), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'X must be a number.')
            
            br.x = x;
        end        
        function setY(br, y)

            assert(isnumeric(y), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'Y must be a number.')
            
            br.y = y;
        end        
        function setZ(br, z)
            
            assert(isnumeric(z), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'Z must be a number.')
            
            br.z = z;
        end
        function setPosition(br, position)
            
            assert(isnumeric(position) && isequal(size(position), [1, 3]), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'Position must be a row vector 1x3.')

            br.setX(position(1))
            br.setY(position(2))
            br.setZ(position(3))
        end
    end
    methods  % Get functions
        function id = getID(br)
            % GETLABEL returns the label of the brain region.
            %
            % LABEL = GETLABEL(BR) returns the label of the brain region.
            %
            % See also getName(), getX(), getY(), getZ(), getPosition().
            
            id = br.id;
        end
        function label = getLabel(br)
            % GETNAME returns the name of the brain region.
            %
            % NAME = GETNAME(BR) returns the extendend name of the brain
            % region.
            %
            % See also getLabel(), getX(), getY(), getZ(), getPosition().
            
            label = br.label;
        end
        function notes = getNotes(br)
            
            notes = br.notes;
        end
        function x = getX(br)
            % GETX returns the x coordinate.
            %
            % X = GETX(BR) returns the x coordinate of the brain
            % region.
            %
            % See also getLabel(), getY(), getZ(), getPosition().
            
            x = br.x;
        end
        function y = getY(br)
            % GETY returns the y coordinate.
            %
            % Y = GETY(BR) returns the y coordinate of the brain
            % region.
            %
            % See also getLabel(), getX(), getZ(), getPosition().
            
            y = br.y;
        end
        function z = getZ(br)
            % GETZ returns the z coordinate.
            %
            % Z = GETZ(BR) returns the z coordinate of the brain
            % region.
            %
            % See also getLabel(), getX(), getY(), getPosition().
            
            z = br.z;
        end
        function r = getPosition(br)
            % GETPOSITION returns the x,y,z coordinates.
            %
            % POSITION = GETZ(BR) returns the x, y, z coordinates of the brain
            % region in an array.
            %
            % See also getLabel(), getX(), getY(), getZ().
            
            r = [br.getX() br.getY() br.getZ()];
        end
    end
end