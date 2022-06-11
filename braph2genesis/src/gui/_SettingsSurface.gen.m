%% ¡header!
SettingsSurface < Settings (st, surface settings) contains the surface settings.

%%% ¡description!
SettingsSurface provides the settings for a surface, 
including face color, face alpha, edge color, and edge alpha.

%%% ¡seealso!
PanelFig, GUIFig, patch, surface

%% ¡props!

%%% ¡prop!
EDGECOLOR (figure, color) is the RGB edge color.
%%%% ¡default!
[0 0 0]
%%%% ¡postprocessing!
h = st.h(); % patch
if check_graphics(h, 'patch') || check_graphics(h, 'surface')
    set(h, 'EdgeColor', st.get('EDGECOLOR'))
end

%%% ¡prop!
EDGEALPHA (figure, alpha) is the edge transparency.
%%%% ¡default!
0
%%%% ¡postprocessing!
h = st.h(); % patch
if check_graphics(h, 'patch') || check_graphics(h, 'surface')
    set(h, 'EdgeAlpha', st.get('EDGEALPHA'))
end

%%% ¡prop!
FACECOLOR (figure, color) is the RGB face color.
%%%% ¡default!
[.5 .5 .5]
%%%% ¡postprocessing!
h = st.h(); % patch
if check_graphics(h, 'patch') || check_graphics(h, 'surface')
    set(h, 'FaceColor', st.get('FACECOLOR'))
end

%%% ¡prop!
FACEALPHA (figure, alpha) is the face transparency.
%%%% ¡default!
.5
%%%% ¡postprocessing!
h = st.h(); % patch
if check_graphics(h, 'patch') || check_graphics(h, 'surface')
    set(h, 'FaceAlpha', st.get('FACEALPHA'))
end