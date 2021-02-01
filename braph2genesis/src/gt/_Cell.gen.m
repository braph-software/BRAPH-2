%% ¡header!
Cell < Element (c, cell) is a numeric cell array.

%%% ¡description!
Cell is a numeric cell array. It is an element that wraps a single cell property.
It permits to efficiently perform (symbolic) operations on numeric cell arrays.
It is typically used to represent adjacency matrices and graph measure.

%%% ¡seealso!
Element

%% ¡props!

%%% ¡prop!
C (data, cell) is a numeric cell array.

%% ¡methods!
function bool = isEqualCell(c1, c2)
    %ISEQUALCELL check whether cells are equal.
    %
    % BOOL = ISEQUALCELL(C1, C2) checks whether C1 and C2 are equal.

    bool = all(all(cellfun(@(x, y) isequal(x, y), c1.get('C'), c2.get('C'))));
end
function cp = uplus(c)
    % UPLUS performs unitary plus.
    %
    % CP = UPLUS(C) performs unitary plus of C (CP = +C).

    cp = Cell('C', c.get('C'));
end
function cm = uminus(c)
    % UMINUS performs unitary minus.
    %
    % CM = UMINUS(C) performs unitary minus of C (CM = -C).

    cm = Cell('C', cellfun(@(x) -x, c.get('C'), 'UniformOutput', false));
end
function c = plus(c1, c2)
    %PLUS (+) performs binary addition.
    %
    % C = PLUS(C1, C2) performs binary addition of C1 and C2 (C = C1 + C2).

    c = Cell('C', cellfun(@(x, y) x + y, c1.get('C'), c2.get('C'), 'UniformOutput', false));
end
function c = minus(c1, c2)
    % MINUS (-) performs binary subtraction.
    %
    % C = MINUS(C1, C2) performs binary subtraction of C1 and C2 (C = C1 - C2).

    c = Cell('C', cellfun(@(x, y) x - y, c1.get('C'), c2.get('C'), 'UniformOutput', false));
end
function c = times(a, b)
    % TIMES performs product.
    %
    % C = TIMES(C1, C2) performs the product of C1 and C2 (C = C1 .* C2).
    %
    % C = TIMES(A, C2) performs the product of A and C2 (C = A .* C2),
    %  where A is a scalar.
    %
    % C = TIMES(C1, B) performs the product of C1 and B (C = C1 .* B),
    %  where B is a scalar.

    if isa(a,'Cell') && isa(b,'Cell')
        c1 = a;
        c2 = b;
        c = Cell('C', cellfun(@(x, y) x .* y, c1.get('C'), c2.get('C'), 'UniformOutput', false));
    elseif isa(a, 'Cell') && isscalar(b)
        c1 = a;
        c = Cell('C', cellfun(@(x) x .* b, c1.get('C'), 'UniformOutput', false));
    elseif isscalar(a) && isa(b, 'Cell')
        c2 = b;
        c = Cell('C', cellfun(@(y) a .* y, c2.get('C'), 'UniformOutput', false));
    end
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
isEqualCell
%%%% ¡code!
c0 = Cell('C', {zeros(2), 0; 0, zeros(2)});
cp = Cell('C', {[1 2; 3 4], 1; -1, [-1 -2; -3 -4]});
cm = Cell('C', {[-1 -2; -3 -4], -1; 1, [1 2; 3 4]});

assert(isEqualCell(cp, cp), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.isEqualCell() does not work.')
assert(isEqualCell(cm, cm), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.isEqualCell() does not work.')
assert(~isEqualCell(cp, cm), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.isEqualCell() does not work.')

%%% ¡test!
%%%% ¡name!
uplus
%%%% ¡code!
c0 = Cell('C', {zeros(2), 0; 0, zeros(2)});
cp = Cell('C', {[1 2; 3 4], 1; -1, [-1 -2; -3 -4]});
cm = Cell('C', {[-1 -2; -3 -4], -1; 1, [1 2; 3 4]});

assert(isEqualCell(+c0, c0), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.uplus() does not work.')
assert(isEqualCell(+cp, cp), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.uplus() does not work.')
assert(isEqualCell(+cm, cm), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.uplus() does not work.')

%%% ¡test!
%%%% ¡name!
uminus
%%%% ¡code!
c0 = Cell('C', {zeros(2), 0; 0, zeros(2)});
cp = Cell('C', {[1 2; 3 4], 1; -1, [-1 -2; -3 -4]});
cm = Cell('C', {[-1 -2; -3 -4], -1; 1, [1 2; 3 4]});

assert(isEqualCell(-c0, c0), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.uminus() does not work.')
assert(isEqualCell(-cp, cm), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.uminus() does not work.')
assert(isEqualCell(-cm, cp), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.uminus() does not work.')

%%% ¡test!
%%%% ¡name!
plus
%%%% ¡code!
c0 = Cell('C', {zeros(2), 0; 0, zeros(2)});
cp = Cell('C', {[1 2; 3 4], 1; -1, [-1 -2; -3 -4]});
cm = Cell('C', {[-1 -2; -3 -4], -1; 1, [1 2; 3 4]});

assert(isEqualCell(cp + cm, c0), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.plus() does not work.')

%%% ¡test!
%%%% ¡name!
minus
%%%% ¡code!
c0 = Cell('C', {zeros(2), 0; 0, zeros(2)});
cp = Cell('C', {[1 2; 3 4], 1; -1, [-1 -2; -3 -4]});
cm = Cell('C', {[-1 -2; -3 -4], -1; 1, [1 2; 3 4]});

assert(isEqualCell(c0 - cp, cm), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.minus() does not work.')

%%% ¡test!
%%%% ¡name!
times
%%%% ¡code!
c0 = Cell('C', {zeros(2), 0; 0, zeros(2)});
cp = Cell('C', {[1 2; 3 4], 1; -1, [-1 -2; -3 -4]});
cm = Cell('C', {[-1 -2; -3 -4], -1; 1, [1 2; 3 4]});

assert(isEqualCell(0 .* cp, c0), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.times() does not work.')
assert(isEqualCell(0 .* cm, c0), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.times() does not work.')

assert(isEqualCell(cp .* 0, c0), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.times() does not work.')
assert(isEqualCell(cm .* 0, c0), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.times() does not work.')

assert(isEqualCell(c0 .* cp, c0), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.times() does not work.')
assert(isEqualCell(c0 .* cm, c0), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.times() does not work.')
assert(isEqualCell(cp .* c0, c0), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.times() does not work.')
assert(isEqualCell(cm .* c0, c0), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.times() does not work.')

assert(isEqualCell(2 .* cm, cm + cm), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.times() does not work.')
assert(isEqualCell(-2 .* cp, -cp - cp), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell.times() does not work.')

%%% ¡test!
%%%% ¡name!
3D
%%%% ¡code!
c = Cell('C', {rand(2,2,2), 1; -1, [-1 -2; -3 -4]});

assert(isEqualCell(2 .* c, c + c), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell does not work with higher dimensions.')
assert(isEqualCell(c .* -2, -c - c), ...
	[BRAPH2.STR ':Cell:' BRAPH2.BUG_FUNC], ...
    'Cell does not work with higher dimensions.')
