%% ¡header!
ETF3 < ETF1 (et, test Element F3) tests use of settings and default.

%%% ¡description!
ETF3 tests use of settings and default.

%%% ¡seealso!
Element, Category, Format, ETF1, ETF2

%% ¡props_update!

%%% ¡prop!
IT11 (data, item) is an item.
%%%% ¡settings!
'ETC3'

%%% ¡prop!
IT12 (data, item) is an item.
%%%% ¡settings!
'ETC3'

%%% ¡prop!
IT13 (data, item) is an item.
%%%% ¡settings!
'ETC3'

%%% ¡prop!
IT22 (data, item) is an item.
%%%% ¡settings!
'ETC3'

%%% ¡prop!
IT23 (data, item) is an item.
%%%% ¡settings!
'ETC3'

%%% ¡prop!
IT33 (data, item) is an item.
%%%% ¡settings!
'ETC3'

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

et2 = ETF2();
assert(isa(et2.get('IT11'), 'ETC1'))
assert(isa(et2.get('IT12'), 'ETC2'))
assert(isa(et2.get('IT13'), 'ETC3'))
assert(isa(et2.get('IT22'), 'ETC2'))
assert(isa(et2.get('IT23'), 'ETC3'))
assert(isa(et2.get('IT33'), 'ETC3'))

et3 = ETF3();
assert(isa(et3.get('IT11'), 'ETC3'))
assert(isa(et3.get('IT12'), 'ETC3'))
assert(isa(et3.get('IT13'), 'ETC3'))
assert(isa(et3.get('IT22'), 'ETC3'))
assert(isa(et3.get('IT23'), 'ETC3'))
assert(isa(et3.get('IT33'), 'ETC3'))
