function [X,Y,Z] = cylinder3d(x1,y1,z1,x2,y2,z2,varargin)
% CYLINDER3D Draw a cylinder in 3D
%
% [X,Y,Z] = CYLINDER3D(X1,Y1,Z1,X2,Y2,Z2) returns the vectors or matrices X, 
%   Y and Z that define the x, y and z components of a surface representing 
%   a cylinder from (X1,Y1,Z1) to (X2,Y2,Z2). 
%   X1,Y1,Z1,X2,Y2,Z2 must be real matrices with the same dimensions.
%
% [X,Y,Z] = CYLINDER3D(X1,Y1,Z1,X2,Y2,Z2,'PropertyName',PropertyValue) sets 
%   the property PropertyName to PropertyValue. All standard plot properties 
%   of surf can be used.
%   Additional CYLINDER3D properties:
%       Color   -   Cylinder color both edges and faces [default = 'k']
%       R       -   Cylinder radius [default = .1]
%       N       -   Number of radial sections [default = 32]
%
% See also CYLINDER, SURF.

%   Author: Mite Mijalkov & Giovanni Volpe
%   Date: 2016/01/01

% Cylinder properties
R = .1;  % radius
N = 32;  % number of equally spaced points around the cylinder
for n = 1:2:length(varargin)
    switch lower(varargin{n})
        case 'r'
            R = varargin{n+1};
        case 'n'
            N = varargin{n+1};
    end
end
R = R.*ones(size(x1));
N = N.*ones(size(x1));

% Check input
assert(isequal(size(x1), size(y1)) && isequal(size(x1), size(x2)) && isequal(size(x1), size(z1)) && isequal(size(x1), size(y2)) && isequal(size(x1), size(z2)))
assert(isreal(x1) && isreal(x2) && isreal(z1) && isreal(y1) && isreal(y2) && isreal(z2) && isreal(R))
assert(isa(N, 'double'))

% Prepares coordinates in a standard format
L = sqrt((x2-x1).^2+(y2-y1).^2+(z2-z1).^2);  % length
theta = acos((z2-z1)./L) ;  % polar angle 
phi = atan2(y2-y1,x2-x1);  % azimuthal angle

ht = zeros(size(L));

for n = 1:1:numel(L)
    
    % Calculates the coordinates of the cylinder in a standard reference frame
    [X,Y] = cylinder([ 0; R(n); R(n); 0 ],N(n));
	Z = [ 0; 0; L(n); L(n) ] * ones(1,N(n)+1);

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
    X = X + x1(n);
    Y = Y + y1(n);
    Z = Z + z1(n);
    
end

if numel(X)==1
    X = cell2mat(X);
    Y = cell2mat(Y);
    Z = cell2mat(Z);
end
