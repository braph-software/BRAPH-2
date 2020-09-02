function [X,Y,Z] = arrow3d(x1,y1,z1,x2,y2,z2,varargin)
% ARROW3D   Draw a line with an arrowhead in 3D
%
% [X,Y,Z] = ARROW3D(X1,Y1,Z1,X2,Y2,Z2) returns the vectors or matrices X, Y and 
%   Z that define the x, y and z components of a surface representing an arrow 
%   from (X1,Y1,Z1) to (X2,Y2,Z2).
%   X1,Y1,Z1,X2,Y2,Z2 must be real matrices with the same dimensions.
%
% [X,Y,Z] = ARROW3D(X1,Y1,Z1,X2,Y2,Z2,'PropertyName',PropertyValue) sets the property
%   PropertyName to PropertyValue. All standard plot properties of surf can
%   be used and also the ARROW3D properties listed below.
%
% ARROW3D properties:
%       StemWidth   -   Arrow stem width [default = .1]
%       HeadLength  -   Arrow head length [default = 1]
%       HeadWidth   -   Arrow head width [default = 1]
%       HeadNode    -   Arrow head intersection with the arrow stem [default = .5]
%       N           -   Number of radial sections [default = 32]
%
% See also CYLINDER, SURF.

%   Author: Mite Mijalkov & Giovanni Volpe
%   Date: 2016/01/01

% Arrow properties
swidth = .1;  % stem width
hlength = 1;  % head length
hwidth = 1;  % head width
hnode = .5;  % head intersection with the arrow stem
N = 32;  % number of equally spaced points around the arrow
for n = 1:2:length(varargin)
    switch lower(varargin{n})
        case 'stemwidth'
            swidth = varargin{n+1};
        case 'headlength'
            hlength = varargin{n+1};
        case 'headwidth'
            hwidth = varargin{n+1};
        case 'headnode'
            hnode = varargin{n+1};
        case 'n'
            N = varargin{n+1};
    end
end
swidth = swidth.*ones(size(x1));
hlength = hlength.*ones(size(x1));
hwidth = hwidth.*ones(size(x1));
hnode = hnode.*ones(size(x1));
N = N.*ones(size(x1));

% Check input
assert(isequal(size(x1), size(y1)) && isequal(size(x1), size(x2)) && isequal(size(x1), size(z1)) && isequal(size(x1), size(y2)) && isequal(size(x1), size(z2)))
assert(isreal(x1) && isreal(x2) && isreal(z1) && isreal(y1) && isreal(y2) && isreal(z2))
assert(isa(N, 'double'))

% Prepares coordiantes in a standard format
L = sqrt((x2-x1).^2+(y2-y1).^2+(z2-z1).^2); % length
theta = acos((z2-z1)./L) ; % polar angle 
phi = atan2(y2-y1,x2-x1); % azimuthal angle

ht = zeros(size(L));

for n = 1:1:numel(L)
        % Calculates the coordinates of the arrow in a standard reference frame
        r = [ 0; swidth(n); swidth(n); hwidth(n); 0 ];
        [X,Y] = cylinder(r,N(n));
        Z = [ 0; 0; L(n)-hnode(n); L(n)-hlength(n); L(n) ] * ones(1,N(n)+1);
                
        % y-rotation
        Xt = X.*cos(theta(n)) + Z.*sin(theta(n));
        Zt = -X.*sin(theta(n)) + Z.*cos(theta(n));
        X = Xt;
        Z = Zt;
        
        % z-rotation
        Xt = X.*cos(phi(n)) - Y.*sin(phi(n));
        Yt = X.*sin(phi(n)) + Y.*cos(phi(n));
        X = Xt;
        Y = Yt;
        
        % translation
        X = X + x1;        
        Y = Y + y1;
        Z = Z + z1;
        
end

if numel(X)==1
    X = cell2mat(X);
    Y = cell2mat(Y);
    Z = cell2mat(Z);
end