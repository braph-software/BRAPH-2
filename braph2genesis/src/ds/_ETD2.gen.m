%% ¡header!
ETD2 < ETD1 (et, test Element D2) tests postprocessing.

%%% ¡description!
ETD2 tests postprocessing.

%%% ¡seealso!
Element, Category, Format, ETD1

%% ¡props_update!

%%% ¡prop!
UNO (data, scalar) is a data synchronized with DUE and TRE.
%%%% ¡postprocessing!
if ~isa(et.getr('UNO'), 'NoValue') && isa(et.getr('DUE'), 'NoValue') && isa(et.getr('TRE'), 'NoValue')
    et.set('DUE', et.get('UNO'), 'TRE', et.get('UNO'))
end

%%% ¡prop!
DUE (data, scalar) is a data synchronized with UNO and TRE.
%%%% ¡postprocessing!
if isa(et.getr('UNO'), 'NoValue') && ~isa(et.getr('DUE'), 'NoValue') && isa(et.getr('TRE'), 'NoValue')
    et.set('UNO', et.get('DUE'), 'TRE', et.get('DUE'))
end

%%% ¡prop!
TRE (data, scalar) is a data synchronized with UNO and DUE.
%%%% ¡postprocessing!
if isa(et.getr('UNO'), 'NoValue') && isa(et.getr('DUE'), 'NoValue') && ~isa(et.getr('TRE'), 'NoValue')
    et.set('UNO', et.get('TRE'), 'DUE', et.get('TRE'))
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Multiple values
%%%% ¡code!
et1 = ETD2();
et1.set('UNO', 1)
assert_with_error("varargin{1}.set('DUE', 2)", ...
    [BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT], ...
    et1)
assert_with_error("varargin{1}.set('TRE', 3)", ...
    [BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT], ...
    et1)

et2 = ETD2();
et2.set('DUE', 2)
assert_with_error("varargin{1}.set('UNO', 1)", ...
    [BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT], ...
    et2)
assert_with_error("varargin{1}.set('TRE', 3)", ...
    [BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT], ...
    et2)

et3 = ETD2();
et3.set('TRE', 3)
assert_with_error("varargin{1}.set('UNO', 1)", ...
    [BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT], ...
    et3)
assert_with_error("varargin{1}.set('DUE', 2)", ...
    [BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT], ...
    et3)

et = ETD2();
assert_with_error("varargin{1}.set('UNO', 1, 'DUE', 2, 'TRE', 3)", ...
    [BRAPH2.STR ':ETD2:' BRAPH2.WRONG_INPUT], ...
    et)
et.set('UNO', 3.14, 'DUE', 3.14, 'TRE', 3.14)