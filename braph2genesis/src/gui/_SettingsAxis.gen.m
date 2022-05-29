%% ¡header!
SettingsAxis < Element (st, axis settings) contains the axis settings.

%%% ¡description!
% % %

%%% ¡seealso!
PanelFig, GUIFig

%% ¡props!

%%% ¡prop!
ID (data, string) is a few-letter code for the axis settings.

%%% ¡prop!
LABEL (metadata, string) is an extended label of the axis settings.

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the axis settings.

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