%% ¡header!
BrainRegion < Element (br, brain region) is a brain region.

%%% ¡description!
BrainRegion contains the information of a brain region. 
It provides the methods necessary to handle the brain regions data.
It is a subclass of Element.

%%% ¡seealso!
Element, BrainAtlas

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the brain region.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain region.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain region.

%%% ¡prop!
X (data, scalar) is the x-coordinate of the brain region.

%%% ¡prop!
Y (data, scalar) is the y-coordinate of the brain region.

%%% ¡prop!
Z (data, scalar) is the z-coordinate of the brain region.

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basic functions
%%%% ¡code!
br = BrainRegion('ID', 'BR1', 'LABEL', 'brain region', 'Notes', 'Notes on brain region.', 'X', -1, 'Y', -2, 'Z', -3);
assert(ischar(br.tostring()), ...
	[BRAPH2.STR ':BrainRegion:' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.tostring() must return a string.')

