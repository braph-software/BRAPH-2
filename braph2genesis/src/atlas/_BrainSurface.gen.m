%% ¡header!
BrainSurface < Element (bs, brain surface) is a brain surface.

%%% ¡description!
BrainSurface contains the information of a brain surface.
It provides the methods necessary to handle the brain surface data.
BrainSurface contains and manages the vertex_number, coordinates, triangles_number, and 
triangles of a brain surface. 
    
%%% ¡seealso!
Element, BrainAtlas, BrainRegion.

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the brain surface.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain surface.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain surface.

%%% ¡prop!
VERTEX_NUMBER (data, scalar) is the number of triangles vertices.
%%%% ¡check_prop!
check = value > 0 && isnumeric(value)
%%%% ¡default!
1

%%% ¡prop!
COORDINATES (data, matrix) is the coordinates of the triangles vertices.
%%%% ¡check_prop!
check = all(all(value >= 0)) && isnumeric(value)
%%%% ¡check_value!
check = isequal(bs.get('VERTEX_NUMBER'), size(value, 1)) 
if check 
    msg = 'All ok!';
else
    msg = ['''COORDINATES'' must have ' num2str(bs.get('VERTEX_NUMBER')) ' rows while it has ' num2str(size(bs.get('COORDINATES'), 1)) '.'];
end
%%%% ¡default!
zeros(1, 3)

%%% ¡prop!
TRIANGLES_NUMBER (data, scalar) is the number of triangles.
%%%% ¡check_prop!
check = value > 0 && isnumeric(value)
%%%% ¡default!
1

%%% ¡prop!
TRIANGLES (data, matrix) is the triad of coordinates identifiers to create a triangle.
%%%% ¡check_prop!
check = all(all(value > 0)) && isnumeric(value)
%%%% ¡check_value!
check = isequal(bs.get('TRIANGLES_NUMBER'), size(value, 1)) && all(all(value <= bs.get('VERTEX_NUMBER'))) && all(all(value > 0))
if check 
    msg = 'All ok!';
else
    msg = [ ...
        '''TRIANGLES'' must have ' num2str(bs.get('TRIANGLES_NUMBER')) ' rows while it has ' num2str(size(bs.get('TRIANGLES'), 1)) '.' ...
        'The identifiers in ''TRIANGLES'' must be greater than 0 and smaller or equal to the "VERTEX_NUMBER" (' num2str(bs.get('VERTEX_NUMBER')) ') ' ...
        'while they are ' num2str(bs.get('TRIANGLES')) '.' ...
        ];
end
%%%% ¡default!
ones(1, 3)