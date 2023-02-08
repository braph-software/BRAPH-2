%% ¡header!
SettingsFill < Settings (st, line settings) contains the line settings.

%%% ¡description!
SettingsFill provides the settings for a fill area

%%% ¡seealso!
PanelFig, GUIFig, patch

%% ¡props!

%%% ¡prop!
VISIBLE (figure, logical) determines whether the symbol is visible.
%%%% ¡default!
true
%%%% ¡postprocessing!
h = st.h(); % patch
if check_graphics(h, 'patch') && prop == st.getPropProp('VISIBLE')
    if st.get('VISIBLE')
        current_axes = h.Parent;
        x_data = st.get('X');
        y1_data = st.get('Y_LOWER');
        y2_data = st.get('Y_UPPER');
        
        % because it does not get cleared
        if ~isequal(get(h, 'FaceAlpha'), st.get('FACEALPHA'))
            set(h, 'FaceAlpha', st.get('FACEALPHA'));

        else % create new one
            delete(h);
            h = fill(current_axes, ...
                [x_data, fliplr(x_data)], ...
                [y1_data, fliplr(y2_data)], ...
                st.get('FACECOLOR'), ...
                'FaceAlpha', st.get('FACEALPHA'), ...
                'tag', 'h_area_ci', 'visible', 'on');
        end

        % put the new handle
        st.h(h);
        
    else
        set(h, 'VISIBLE', false)
    end
end

%%% ¡prop!
X (figure, rvector) is the x-coordinate.
%%%% ¡conditioning!
value = value(:)';

%%% ¡prop!
Y_UPPER (figure, rvector) is the y-coordinate.
%%%% ¡conditioning!
value = value(:)';

%%% ¡prop!
Y_LOWER (figure, rvector) is the z-coordinate.
%%%% ¡conditioning!
value = value(:)';

%%% ¡prop!
FACECOLOR (figure, color) is the symbol RGB face color.
%%%% ¡default!
BRAPH2.COL

%%% ¡prop!
FACEALPHA (figure, scalar) is the symbol RGB face color.
%%%% ¡default!
0.5