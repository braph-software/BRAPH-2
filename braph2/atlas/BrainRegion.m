classdef BrainRegion < handle & matlab.mixin.Copyable
    % BrainRegion A brain region.
    % BrainRegion contains the information of a brain region. It provides
    % the methods necessary to handle the brain regions data.
    % It is a subclass of handle and matlab.mixin.Copyable.
    %
    % BrainRegion contains and manages the id, label, x coordinate, y 
    % coordinate, z coordinate and the position array of a brain region, 
    %
    % BrainRegion methods:
    %   BrainRegion  - Constructor.
    %   tostring     - returns a string representing the brain region.
    %   disp         - displays the brain region.
    %   setID        - sets the id.
    %   setLabel     - sets the label
    %   setNotes     - sets the notes.
    %   setX         - sets the x coordinate.
    %   setY         - sets the y coordinate.
    %   setZ         - sets the z coordinate.
    %   setPosition  - sets an array with the x, y, z coordinates.
    %   getID        - returns the id.
    %   getLabel     - returns the label.
    %   getNotes     - returns the notes
    %   getX         - returns the x coordinate.
    %   getY         - returns the y coordinate.
    %   getZ         - returns the z coordinate.
    %   getPosition  - returns an array with the x, y, z coordinates. 
    %
    % See also BrainAtlas, handle, matlab.mixin.Copyable
    
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
            % BRAINREGION(ID, LABEL, NOTES, X, Y, Z) creates a brain region with
            % the corresponding arguments: id, label, notes, x, y, z. 
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
            % STR = TOSTRING(BR) returns string with the brain class, id, 
            % label, position, and notes.
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
            % SETID sets the id of the brain region.
            %
            % SETID(BR, ID) sets the id of the brain region.
            %
            % See also setLabel(), setX(), setY(), setZ(), setPosition().
            
            assert(ischar(id), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'ID must be a string.')
            
            br.id = id;
        end        
        function setLabel(br, label)
            % SETLABEL sets the label of the brain region.
            %
            % SETLABEL(BR, LABEL) sets the label of the brain region.
            %
            % See also setID(), setX(), setY(), setZ(), setPosition().

            assert(ischar(label), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'Label must be a string.')
            
            br.label = label;
        end        
        function setNotes(br, notes)
            % SETNOTES sets the notes of the brain region.
            %
            % SETNOTES(BR, NOTES) sets the notes of the brain region.
            %
            % See also setID(), setX(), setY(), setZ(), setPosition().

            assert(ischar(notes), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'Notes must be a string.')
            
            br.notes = notes;
        end        
        function setX(br, x)
            % SETX sets the x coordinate of the brain region.
            %
            % SETX(BR, X) sets the x coordinate of the brain region.
            %
            % See also setID(), setLabel(), setY(), setZ(), setPosition().
            
            assert(isnumeric(x), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'X must be a number.')
            
            br.x = x;
        end        
        function setY(br, y)
            % SETY sets the y coordinate of the brain region.
            %
            % SETY(BR, Y) sets the y coordinate of the brain region.
            %
            % See also setID(), setLabel(), setX(), setZ(), setPosition().

            assert(isnumeric(y), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'Y must be a number.')
            
            br.y = y;
        end        
        function setZ(br, z)
            % SETZ sets the zcoordinate of the brain region.
            %
            % SETZ(BR, Z) sets the z coordinate of the brain region.
            %
            % See also setID(), setLabel(), setX(), setY(), setPosition().
            assert(isnumeric(z), ...
                [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
                'Z must be a number.')
            
            br.z = z;
        end
        function setPosition(br, position)
            % SETPOSITION sets an array containing x, y, z coordinates.
            %
            % SETPOSITION(BR, POSITION) sets an array containing the x, y,
            % z coordinates of the brain region.
            %
            % See also setID(), setLabel(), setX(), setY(), setZ().
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
            % GETID returns the id of the brain region.
            %
            % ID = GETID(BR) returns the id of the brain region.
            %
            % See also getLabel(), getX(), getY(), getZ(), getPosition().
            
            id = br.id;
        end
        function label = getLabel(br)
            % GETLABEL returns the label of the brain region.
            %
            % LABEL = GETLABEL(BR) returns the label of the brain region.
            %
            % See also getID(), getX(), getY(), getZ(), getPosition().
            label = br.label;
        end
        function notes = getNotes(br)
            % GETNOTES returns the notes of the brain region.
            %
            % NOTES = GETNOTES(BR) returns the notes of the brain region.
            %
            % See also getLabel(), getX(), getY(), getZ(), getPosition().
            
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