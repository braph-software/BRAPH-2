%% ¡header!
ETC < Element (et, test Element C) tests props.

%%% ¡description!
Tests conditioning, postprocessing, and checking multiple propos at once.

%%% ¡seealso!
Element, Category, Format

%% ¡props!

%%% ¡prop!
NM (metadata, scalar) is a scalar, metadata.
%%%% ¡conditioning!
value = value(2);
%%%% ¡default!
[0:1:10]

%%% ¡prop!
SM (metadata, string) is a scalar, metadata.
%%%% ¡conditioning!
value = tostring(value);

% % % %%% ¡prop!
% % % NP (parameter, scalar) is a scalar, parameter.
% % % 
% % % 
% % % 
% % % 
% % % 
% % % 
% % % %%% ¡prop!
% % % ND (data, scalar) is a scalar, data.
% % % 
% % % %%% ¡prop!
% % % NG (gui, scalar) is a scalar, gui.
% % % 
% % % %%% ¡prop!
% % % NF (figure, scalar) is a scalar, figure.
% % % 
% % % %%% ¡prop!
% % % NR (result, scalar) is a scalar, result.
% % % 
% % % %%% ¡prop!
% % % SP (parameter, string) is a scalar, parameter.
% % % 
% % % %%% ¡prop!
% % % SD (data, string) is a scalar, data.
% % % 
% % % %%% ¡prop!
% % % SR (result, string) is a scalar, result.
% % % 
% % % %%% ¡prop!
% % % SG (gui, string) is a scalar, gui.
% % % 
% % % %%% ¡prop!
% % % SF (figure, string) is a scalar, figure.