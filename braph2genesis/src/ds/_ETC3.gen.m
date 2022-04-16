%% ¡header!
ETC3 < ETC2 (et, test Element C3) tests conditioning inheritance.

%%% ¡description!
ETC3 tests conditioning inheritance.

%%% ¡seealso!
Element, Category, Format, ETC1, ETC3

%% ¡props_update!

%%% ¡prop!
CM (metadata, cvector) is a cvector, metadata.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:2:10]

%%% ¡prop!
CP (parameter, cvector) is a cvector, parameter.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:2:20]

%%% ¡prop!
CD (data, cvector) is a cvector, data.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:2:30]

%%% ¡prop!
CG (gui, cvector) is a cvector, gui.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:2:40]

%%% ¡prop!
CF (figure, cvector) is a cvector, figure.
%%%% ¡conditioning!
value = value';
%%%% ¡default!
[0:2:50]

%%% ¡prop!
CR (result, cvector) is a cvector, result.
%%%% ¡conditioning!
if ~isa(value, 'NoValue')
    value = value';
end
%%%% ¡default!
[0:2:60]

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Conditioning
%%%% ¡probability!
.01
%%%% ¡code!
et = ETC3();

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

assert(isequal(et.get(ETC2.CM), [0:2:10]'))
assert(isequal(et.get(ETC2.CP), [0:2:20]'))
assert(isequal(et.get(ETC2.CD), [0:2:30]'))
assert(isequal(et.get(ETC2.CG), [0:2:40]'))
assert(isequal(et.get(ETC2.CF), [0:2:50]'))
assert(isequal(et.get(ETC2.CR), [0:2:60]'))

assert(isequal(et.get(ETC2.RM), [0:1:10]))
assert(isequal(et.get(ETC2.RP), [0:1:20]))
assert(isequal(et.get(ETC2.RD), [0:1:30]))
assert(isequal(et.get(ETC2.RG), [0:1:40]))
assert(isequal(et.get(ETC2.RF), [0:1:50]))
assert(isequal(et.get(ETC2.RR), [0:1:60]))