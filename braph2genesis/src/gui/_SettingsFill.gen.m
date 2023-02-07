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
if check_graphics(h, 'patch') && ( ...
        get(h, 'Visible') ~= st.get('VISIBLE') || ...        
        ~isequal(get(h, 'FaceColor'), st.get('FACECOLOR')) || ...
        ~isequal(get(h, 'FaceAlpha'), st.get('FACEALPHA')) ...
        )
    if st.get('VISIBLE')
        h = [];
        x_data = st.get('X');
        y1_data = st.get('Y_LOWER');
        y2_data = st.get('Y_UPPER');
        
        set(h, ...
            [x_data, fliplr(x_data)], ...
            [y1_data, fliplr(y2_data)], ...
            st.get('FACECOLOR'));
        set(h, 'FACEALPHA', st.get('FACEALPHA'))
        
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