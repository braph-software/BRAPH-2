%% ¡header!
SettingsAmbient < Element (st, ambient settings) contains the ambient settings.

%%% ¡description!
SettingsAmbient provides the settings for the ambient lightning and material, 
including lighting, material, camlight, shading, and colormap.

%%% ¡seealso!
PanelFig, GUIFig, uiaxes

%% ¡props!

%%% ¡prop!
LIGHTING (figure, option) is the lighting value.
%%%% ¡settings!
{'none' 'phong' 'flat' 'gouraud'}
%%%% ¡default!
'gouraud'

%%% ¡prop!
MATERIAL (figure, option) is the material value.
%%%% ¡settings!
{'shiny' 'dull' 'metal'}
%%%% ¡default!
'shiny'

%%% ¡prop!
CAMLIGHT (figure, option) is the camlight value.
%%%% ¡settings!
{'none' 'headlight' 'right' 'left'}
%%%% ¡default!
'headlight'

%%% ¡prop!
SHADING (figure, option) is the shading value.
%%%% ¡settings!
{'none' 'interp' 'flat' 'faceted'}
%%%% ¡default!
'interp'

%%% ¡prop!
COLORMAP (figure, option) is the colormap.
%%%% ¡settings!
{'white', 'parula', 'jet', 'hsv', 'hot', 'cool', 'spring', 'summer', 'autumn', 'winter', 'gray', 'bone', 'copper', 'pink', 'lines', 'colorcube', 'prism', 'flag'}