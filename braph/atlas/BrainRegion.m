classdef BrainRegion < handle
    properties (GetAccess=protected, SetAccess=protected)
        label  % few-letter code (unique for each brain region)
        name  % extended name
        x  % x-coordinate
        y  % y-coordinate
        z  % z-coordinate
    end
    methods
        function br = BrainRegion(label, name, x, y, z)
            
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