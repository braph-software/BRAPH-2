%% ¡header!
BrainROISurface < Element (bs, brain surface) is a brain ROI surface.

%%% ¡description!
BrainROISurface contains the information of a brain surface.
It provides the methods necessary to handle the brain surface data.
BrainROISurface contains and manages the vertex_number, coordinates, triangles_number, and 
triangles of a brain surface. 
    
%%% ¡seealso!
Element, BrainAtlas, BrainRegion

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the brain surface.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain surface.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain surface.

%%% ¡prop!
FACES (data, matrix) are the coordinates of the isosurfaces faces.
%%%% ¡check_prop!
check = isempty(value) || size(value, 2) == 3;

%%% ¡prop!
VERTICES (data, matrix) are the triads of coordinates identifiers to create a isosurface.
%%%% ¡check_prop!
check = isempty(value) || size(value, 2) == 3;
