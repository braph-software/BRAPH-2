%% ¡header!
ETD1 < Element (et, test Element D1) tests multiple values with checks.

%%% ¡description!
ETD1 tests multiple values with checks.

%%% ¡seealso!
Element, Category, Format, ETD2

%% ¡props!

%%% ¡prop!
UNO (data, scalar) is a data synchronized with DUE and TRE.
%%%% ¡check_value!
check = value == et.get('DUE') && value == et.get('TRE');
if ~check
    msg = 'UNO, DUE and TRE must have the same values';
else
    msg = 'ok';
end

%%% ¡prop!
DUE (data, scalar) is a data synchronized with UNO and TRE.
%%%% ¡check_value!
check = value == et.get('UNO') && value == et.get('TRE');
if ~check
    msg = 'UNO, DUE and TRE must have the same values';
else
    msg = 'ok';
end

%%% ¡prop!
TRE (data, scalar) is a data synchronized with UNO and DUE.
%%%% ¡check_value!
check = value == et.get('UNO') && value == et.get('DUE');
if ~check
    msg = 'UNO, DUE and TRE must have the same values';
else
    msg = 'ok';
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Multiple values
%%%% ¡code!
et = ETD1();

assert_with_error("varargin{1}.set('UNO', 1)", ...
    [BRAPH2.STR ':ETD1:' BRAPH2.WRONG_INPUT], ...
    et)

assert_with_error("varargin{1}.set('DUE', 2)", ...
    [BRAPH2.STR ':ETD1:' BRAPH2.WRONG_INPUT], ...
    et)

assert_with_error("varargin{1}.set('TRE', 3)", ...
    [BRAPH2.STR ':ETD1:' BRAPH2.WRONG_INPUT], ...
    et)

assert_with_error("varargin{1}.set('UNO', 1, 'DUE', 2, 'TRE', 3)", ...
    [BRAPH2.STR ':ETD1:' BRAPH2.WRONG_INPUT], ...
    et)

et.set('UNO', 3.14, 'DUE', 3.14, 'TRE', 3.14)