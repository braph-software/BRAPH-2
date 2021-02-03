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

%%% ¡prop!
COORDINATES (data, matrix) is the coordinates of the triangles vertices.
%%%% ¡check_value!
check = isequal(bs.get('VERTEX_NUMBER'), size(value, 1)) 
if check 
    msg = 'All ok!';
else
    msg = ['''COORDINATES'' must have ' num2str(bs.get('VERTEX_NUMBER')) ' rows while it has ' num2str(size(bs.get('COORDINATES'), 1)) '.'];
end

%%% ¡prop!
TRIANGLES_NUMBER (data, scalar) is the number of triangles.

%%% ¡prop!
TRIANGLES (data, matrix) is the triad of vertex identifiers to create a triangle.
%%%% ¡check_value!
check = isequal(bs.get('TRIANGLES_NUMBER'), size(value, 1)) && size(value, 1)*size(value, 2) >= bs.get('VERTEX_NUMBER') 
if check 
    msg = 'All ok!';
else
    msg = [ ...
        '''TRIANGLES'' must have ' num2str(bs.get('TRIANGLES_NUMBER')) ' rows while it has ' num2str(size(bs.get('TRIANGLES'), 1)) '.' ...
        '''TRIANGLES'' must have more or the same number of vertex than "VERTEX_NUMBER" (' num2str(bs.get('VERTEX_NUMBER')) ') ' ...
        'while it has ' num2str(size(bs.get('TRIANGLES'), 1)*size(bs.get('TRIANGLES'), 2)) '.' ...
        ];
end
