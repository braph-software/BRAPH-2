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
VERTEX_NUMBER (data, cvector) is the number of triangles vertices.

%%% ¡prop!
COORDINATES (data, cvector) is the coordinates of the triangles vertices.

%%% ¡prop!
TRIANGLES_NUMBER (data, cvector) is the number of triangles.

%%% ¡prop!
TRIANGLES (data, cvector) is the triad of vertex identifiers to create a triangle.
