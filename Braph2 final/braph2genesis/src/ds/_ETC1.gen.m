%% ¡header!
ETC1 < Element (et, test Element C) tests props.

%%% ¡description!
ETC1 tests conditioning.

%%% ¡seealso!
Element, Category, Format, ETC2

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
value = tostring(value);

%%% ¡prop!
SP (parameter, string) is a scalar, parameter.
%%%% ¡conditioning!
value = tostring(value);

%%% ¡prop!
SD (data, string) is a scalar, data.
%%%% ¡conditioning!
value = tostring(value);

%%% ¡prop!
SG (gui, string) is a scalar, gui.
%%%% ¡conditioning!
value = tostring(value);

%%% ¡prop!
SF (figure, string) is a scalar, figure.
%%%% ¡conditioning!
value = tostring(value);

%%% ¡prop!
SR (result, string) is a scalar, result.
%%%% ¡conditioning!
value = ['conditioned *' tostring(value) '*'];
