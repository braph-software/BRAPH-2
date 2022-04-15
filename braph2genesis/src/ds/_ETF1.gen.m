%% ¡header!
ETF1 < Element (et, test Element F1) tests use of settings and default.

%%% ¡description!
ETF1 tests use of settings and default.

%%% ¡seealso!
Element, Category, Format, ETF2, ETF3

%% ¡props!

%%% ¡prop!
IT11 (data, item) is an item.
%%%% ¡settings!
'ETC1'
%%%% ¡default!
ETC1()

%%% ¡prop!
IT12 (data, item) is an item.
%%%% ¡settings!
'ETC1'
%%%% ¡default!
ETC2()

%%% ¡prop!
IT13 (data, item) is an item.
%%%% ¡settings!
'ETC1'
%%%% ¡default!
ETC3()

%%% ¡prop!
IT22 (data, item) is an item.
%%%% ¡settings!
'ETC2'
%%%% ¡default!
ETC2()

%%% ¡prop!
IT23 (data, item) is an item.
%%%% ¡settings!
'ETC2'
%%%% ¡default!
ETC3()

%%% ¡prop!
IT33 (data, item) is an item.
%%%% ¡settings!
'ETC3'
%%%% ¡default!
ETC3()

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
