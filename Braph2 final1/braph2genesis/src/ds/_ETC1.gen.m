%% ¡header!
ETC1 < Element (et, test Element C) tests conditioning.

%%% ¡description!
ETC1 tests conditioning.

%%% ¡seealso!
Element, Category, Format, ETC2, ETC3

%% ¡props!

%%% ¡prop!
NM (metadata, scalar) is a scalar, metadata.
%%%% ¡conditioning!
value = value(2);
%%%% ¡default!
[0:1:10]

%%% ¡prop!
NP (parameter, scalar) is a scalar, parameter.
%%%% ¡conditioning!
value = value(3);
%%%% ¡default!
[0:1:10]

%%% ¡prop!
ND (data, scalar) is a scalar, data.
%%%% ¡conditioning!
value = value(4);
%%%% ¡default!
[0:1:10]

%%% ¡prop!
NG (gui, scalar) is a scalar, gui.
%%%% ¡conditioning!
value = value(5);
%%%% ¡default!
[0:1:10]

%%% ¡prop!
NF (figure, scalar) is a scalar, figure.
%%%% ¡conditioning!
value = value(6);
%%%% ¡default!
[0:1:10]

%%% ¡prop!
NR (result, scalar) is a scalar, result.
%%%% ¡conditioning!
if ~isa(value, 'NoValue')
    value = value(7);
end
%%%% ¡default!
[0:1:10]

%%% ¡prop!
SM (metadata, string) is a scalar, metadata.
%%%% ¡conditioning!
value = 'SM1';

%%% ¡prop!
SP (parameter, string) is a scalar, parameter.
%%%% ¡conditioning!
value = 'SP1';

%%% ¡prop!
SD (data, string) is a scalar, data.
%%%% ¡conditioning!
value = 'SD1';

%%% ¡prop!
SG (gui, string) is a scalar, gui.
%%%% ¡conditioning!
value = 'SG1';

%%% ¡prop!
SF (figure, string) is a scalar, figure.
%%%% ¡conditioning!
value = 'SF1';

%%% ¡prop!
SR (result, string) is a scalar, result.
%%%% ¡conditioning!
value = 'SR1';

%%% ¡prop!
CM (metadata, cvector) is a cvector, metadata.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:1:10]

%%% ¡prop!
CP (parameter, cvector) is a cvector, parameter.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:1:20]

%%% ¡prop!
CD (data, cvector) is a cvector, data.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:1:30]

%%% ¡prop!
CG (gui, cvector) is a cvector, gui.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:1:40]

%%% ¡prop!
CF (figure, cvector) is a cvector, figure.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:1:50]

%%% ¡prop!
CR (result, cvector) is a cvector, result.
%%%% ¡conditioning!
if ~isa(value, 'NoValue')
    value = value';
end
%%%% ¡default!
[0:1:60]

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Conditioning
%%%% ¡code!
et = ETC1();

assert(et.get(ETC1.NM) == 1)
assert(et.get(ETC1.NP) == 2)
assert(et.get(ETC1.ND) == 3)
assert(et.get(ETC1.NG) == 4)
assert(et.get(ETC1.NF) == 5)
assert(et.get(ETC1.NR) == 6)

assert(strcmp(et.get(ETC1.SM), 'SM1'))
assert(strcmp(et.get(ETC1.SP), 'SP1'))
assert(strcmp(et.get(ETC1.SD), 'SD1'))
assert(strcmp(et.get(ETC1.SG), 'SG1'))
assert(strcmp(et.get(ETC1.SF), 'SF1'))
assert(strcmp(et.get(ETC1.SR), 'SR1'))

assert(isequal(et.get(ETC1.CM), [0:1:10]'))
assert(isequal(et.get(ETC1.CP), [0:1:20]'))
assert(isequal(et.get(ETC1.CD), [0:1:30]'))
assert(isequal(et.get(ETC1.CG), [0:1:40]'))
assert(isequal(et.get(ETC1.CF), [0:1:50]'))
assert(isequal(et.get(ETC1.CR), [0:1:60]'))
