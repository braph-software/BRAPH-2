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

%% ¡methods!
function r = getPosition(br)
% GETPOSITION returns the x, y, z coordinates
%
% POSITION = GET(BR) returns the x, y, z coordinates of the brain
% region BR in an array.
%
% See also setPosition.

r = [br.get('X') br.get('Y') br.get('Z')];
end
function setPosition(br, position)
% SETPOSITION sets an array containing x, y, z coordinates
%
% SETPOSITION(BR, POSITION) sets an array [X Y Z] where X, Y, Z
% are coordinates (numbers) of the brain region.
%
% See also getPosition.

assert(isnumeric(position) && isequal(size(position), [1, 3]), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_INPUT], ...
    'Position must be a row vector 1x3.')

br.set('X', position(1))
br.set('Y', position(2))
br.set('Z', position(3))
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Basic functions
%%%% ¡code!
br = BrainRegion('ID', 'BR1', 'LABEL', 'brain region', 'Notes', 'Notes on brain region.', 'X', -1, 'Y', -2, 'Z', -3);
assert(ischar(br.tostring()), ...
    [BRAPH2.STR ':BrainRegion:' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.tostring() must return a string.')

%%% ¡test!
%%%% ¡name!
Get methods
%%%% ¡code!
id = 'BR1';
label = 'brain region 1';
notes = 'Notes on brain region 1.';
x = 1;
y = 2;
z = 3;
br = BrainRegion('ID', id, 'LABEL', label, 'NOTES', notes, 'X', x, 'Y', y, 'Z', z);

assert(isequal(br.get('ID'), id), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.get() does not work.')
assert(isequal(br.get('LABEL'), label), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.get() does not work.')
assert(isequal(br.get('NOTES'), notes), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.get() does not work.')
assert(isequal(br.get('X'), x), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.get() does not work.')
assert(isequal(br.get('Y'), y), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.get() does not work.')
assert(isequal(br.get('Z'), z), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.get() does not work.')
assert(isequal(br.getPosition(), [x, y, z]), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.getPosition() does not work.')

%%% ¡test!
%%%% ¡name!
Set methods
%%%% ¡code!
br = BrainRegion();
br.set('ID', 'br2');
br.set('LABEL', 'lab2');
br.set('NOTES', 'notes2');
br.set('X', 1);
br.set('Y', 2);
br.set('Z', 3);

assert(isequal(br.get('ID'), 'br2'), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.set() does not work.')
assert(isequal(br.get('LABEL'), 'lab2'), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.set() does not work.')
assert(isequal(br.get('NOTES'), 'notes2'), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.set() does not work.')
assert(isequal(br.get('X'), 1), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.set() does not work.')
assert(isequal(br.get('Y'), 2), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.set() does not work.')
assert(isequal(br.get('Z'), 3), ...
    [BRAPH2.STR ':' class(br) ':' BRAPH2.WRONG_OUTPUT], ...
    'BrainRegion.set() does not work.')
