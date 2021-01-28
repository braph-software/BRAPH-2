%% ¡header!
BrainAtlas < Element (ba, brain atlas) is a brain atlas.

%%% ¡description!
BrainAtlas represents a brain atlas, 
constituted by a collection of brain regions.

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the brain atlas.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the brain atlas.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the brain atlas.

%%% ¡prop!
BR_DICT (data, idict) contains the brain regions of the brain atlas.
%%%% ¡settings!
'BrainRegion'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_KEY', 1)