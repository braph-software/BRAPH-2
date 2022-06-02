%% ¡header!
SettingsSymbol < Settings (st, surface settings) contains the surface settings.

%%% ¡description!
SettingsSymbol provides the settings for a surface, 
including face color, face alpha, edge color, and edge alpha.

%%% ¡seealso!
PanelFig, GUIFig, patch

%% ¡props!

%%% ¡prop!
VISIBLE (figure, logical) determines whether the symbol is visible.
%%%% ¡defaul!
false

%%% ¡prop!
X (figure, scalar) is the x-coordinate

%%% ¡prop!
Y (figure, scalar) is the y-coordinate

%%% ¡prop!
Z (figure, scalar) is the z-coordinate

%%% ¡prop!
SYMBOL (figure, marker) is the symbol.

%%% ¡prop!
SYMBOLSIZE (figure, size) is the symbol size.
%%%% ¡default!
5

%%% ¡prop!
EDGECOLOR (figure, color) is the symbol RGB edge color.
%%%% ¡default!
[0 0 0]

%%% ¡prop!
EDGEALPHA (figure, alpha) is the symbol edge transparency.
%%%% ¡default!
1

%%% ¡prop!
FACECOLOR (figure, color) is the symbol RGB face color.
%%%% ¡default!
[.5 .5 .5]

%%% ¡prop!
FACEALPHA (figure, alpha) is the symbol face transparency.
%%%% ¡default!
1