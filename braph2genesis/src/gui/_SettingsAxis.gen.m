%% ¡header!
SettingsAxis < Element (st, axis settings) contains the axis settings.

%%% ¡description!
SettingsAxis provides the settings for an axis, 
including axis color, hold on/off, axis on/off, equal on/off, and tight on/off.

%%% ¡seealso!
PanelFig, GUIFig, uiaxes

%% ¡props!

%%% ¡prop!
AXISCOLOR (figure, color) is the axis background color.
%%%% ¡default!
[1 1 1]

%%% ¡prop!
HOLD (figure, logical) determines whether hold is on or off.
%%%% ¡default!
true

%%% ¡prop!
GRID (figure, logical) determines whether the grid is shown.
%%%% ¡default!
false

%%% ¡prop!
AXIS (figure, logical) determines whether the axis is shown.
%%%% ¡default!
false

%%% ¡prop!
EQUAL (figure, logical) determines whether the axis are equal.
%%%% ¡default!
true

%%% ¡prop!
TIGHT (figure, logical) determines whether the axis are tight.
%%%% ¡default!
false