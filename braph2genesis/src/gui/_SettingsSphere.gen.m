%% ¡header!
SettingsSphere < SettingsSurface (st, sphere settings) contains the spheresettings.

%%% ¡description!
SettingsSphere provides the settings for a sphere, 
including visibility, x, y, z, radius, face color and alpha, edge color and alpha.

%%% ¡seealso!
PanelFig, GUIFig, patch

%% ¡props!

%%% ¡prop!
VISIBLE (figure, logical) determines whether the sphere is visible.
%%%% ¡defaul!
false
%%%% ¡postprocessing!
persistent sx sy sz
if isempty(sx) || isempty(sy) || isempty(sz)
    [sx, sy, sz] = sphere();
end

h = st.h(); % patch
if check_graphics(h, 'surface') && (get(h, 'Visible') ~= st.get('VISIBLE') ...
        || ~isequal(get(h, 'XData'), st.get('X') + st.get('SPHERESIZE') * sx) ...
        || ~isequal(get(h, 'YData'), st.get('Y') + st.get('SPHERESIZE') * sy) ...
        || ~isequal(get(h, 'ZData'), st.get('Z') + st.get('SPHERESIZE') * sz) ...
        )
    if st.get('VISIBLE')
        set(h, ...
            'XData', st.get('X') + st.get('SPHERESIZE') * sx, ...
            'YData', st.get('Y') + st.get('SPHERESIZE') * sy, ...
            'ZData', st.get('Z') + st.get('SPHERESIZE') * sz, ...
            'Visible', true ...
            )
    else
        set(h, 'Visible', false)
    end
end

%%% ¡prop!
X (figure, scalar) is the x-coordinate.

%%% ¡prop!
Y (figure, scalar) is the y-coordinate.

%%% ¡prop!
Z (figure, scalar) is the z-coordinate.

%%% ¡prop!
SPHERESIZE (figure, size) is the sphere size.
%%%% ¡default!
5