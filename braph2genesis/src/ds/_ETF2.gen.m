%% ¡header!
ETF2 < ETF1 (et, test Element F2) tests use of settings and default.

%%% ¡description!
ETF2 tests use of settings and default.

%%% ¡seealso!
Element, Category, Format, ETF1, ETF3

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Test settings and defaults.
%%%% ¡probability!
.01
%%%% ¡code!
et1 = ETF1();
assert(isa(et1.get('IT11'), 'ETC1'))
assert(isa(et1.get('IT12'), 'ETC2'))
assert(isa(et1.get('IT13'), 'ETC3'))
assert(isa(et1.get('IT22'), 'ETC2'))
assert(isa(et1.get('IT23'), 'ETC3'))
assert(isa(et1.get('IT33'), 'ETC3'))

et2 = ETF1();
assert(isa(et2.get('IT11'), 'ETC1'))
assert(isa(et2.get('IT12'), 'ETC2'))
assert(isa(et2.get('IT13'), 'ETC3'))
assert(isa(et2.get('IT22'), 'ETC2'))
assert(isa(et2.get('IT23'), 'ETC3'))
assert(isa(et2.get('IT33'), 'ETC3'))
