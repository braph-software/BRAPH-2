%% ¡header!
ETC2 < ETC1 (et, test Element C2) tests conditioning inheritance.

%%% ¡description!
ETC2 tests conditioning inheritance.

%%% ¡seealso!
Element, Category, Format, ETC1, ETC3

%% ¡props_update!

%%% ¡prop!
NM (metadata, scalar) is a scalar, metadata.
%%%% ¡conditioning!
value = value(2);
%%%% ¡default!
-[0:1:10]

%%% ¡prop!
NP (parameter, scalar) is a scalar, parameter.
%%%% ¡conditioning!
value = value(3);
%%%% ¡default!
-[0:1:10]

%%% ¡prop!
ND (data, scalar) is a scalar, data.
%%%% ¡conditioning!
value = value(4);
%%%% ¡default!
-[0:1:10]

%%% ¡prop!
NG (gui, scalar) is a scalar, gui.
%%%% ¡conditioning!
value = value(5);
%%%% ¡default!
-[0:1:10]

%%% ¡prop!
NF (figure, scalar) is a scalar, figure.
%%%% ¡conditioning!
value = value(6);
%%%% ¡default!
-[0:1:10]

%%% ¡prop!
NR (result, scalar) is a scalar, result.
%%%% ¡conditioning!
if ~isa(value, 'NoValue')
    value = value(7);
end
%%%% ¡default!
-[0:1:10]

%%% ¡prop!
SM (metadata, string) is a scalar, metadata.
%%%% ¡conditioning!
value = 'SM2';

%%% ¡prop!
SP (parameter, string) is a scalar, parameter.
%%%% ¡conditioning!
value = 'SP2';

%%% ¡prop!
SD (data, string) is a scalar, data.
%%%% ¡conditioning!
value = 'SD2';

%%% ¡prop!
SG (gui, string) is a scalar, gui.
%%%% ¡conditioning!
value = 'SG2';

%%% ¡prop!
SF (figure, string) is a scalar, figure.
%%%% ¡conditioning!
value = 'SF2';

%%% ¡prop!
SR (result, string) is a scalar, result.
%%%% ¡conditioning!
value = 'SR2';

%% ¡props!

%%% ¡prop!
RM (metadata, rvector) is a rvector, metadata.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:1:10]'

%%% ¡prop!
RP (parameter, rvector) is a rvector, parameter.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:1:20]'

%%% ¡prop!
RD (data, rvector) is a rvector, data.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:1:30]'

%%% ¡prop!
RG (gui, rvector) is a rvector, gui.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:1:40]'

%%% ¡prop!
RF (figure, rvector) is a rvector, figure.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:1:50]'

%%% ¡prop!
RR (result, rvector) is a rvector, result.
%%%% ¡conditioning!
if ~isa(value, 'NoValue')
    value = value';
end
%%%% ¡default!
[0:1:60]'

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Conditioning
%%%% ¡probability!
.01
%%%% ¡code!
et = ETC2();

assert(et.get(ETC2.NM) == -1)
assert(et.get(ETC2.NP) == -2)
assert(et.get(ETC2.ND) == -3)
assert(et.get(ETC2.NG) == -4)
assert(et.get(ETC2.NF) == -5)
assert(et.get(ETC2.NR) == -6)

assert(strcmp(et.get(ETC2.SM), 'SM2'))
assert(strcmp(et.get(ETC2.SP), 'SP2'))
assert(strcmp(et.get(ETC2.SD), 'SD2'))
assert(strcmp(et.get(ETC2.SG), 'SG2'))
assert(strcmp(et.get(ETC2.SF), 'SF2'))
assert(strcmp(et.get(ETC2.SR), 'SR2'))

assert(isequal(et.get(ETC2.CM), [0:1:10]'))
assert(isequal(et.get(ETC2.CP), [0:1:20]'))
assert(isequal(et.get(ETC2.CD), [0:1:30]'))
assert(isequal(et.get(ETC2.CG), [0:1:40]'))
assert(isequal(et.get(ETC2.CF), [0:1:50]'))
assert(isequal(et.get(ETC2.CR), [0:1:60]'))

assert(isequal(et.get(ETC2.RM), [0:1:10]))
assert(isequal(et.get(ETC2.RP), [0:1:20]))
assert(isequal(et.get(ETC2.RD), [0:1:30]))
assert(isequal(et.get(ETC2.RG), [0:1:40]))
assert(isequal(et.get(ETC2.RF), [0:1:50]))
assert(isequal(et.get(ETC2.RR), [0:1:60]))